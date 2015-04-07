require "minitest/autorun"
require 'net/http'
require 'json'
require File.expand_path('../DB/database_mysql',__FILE__)

class TestBlog < Minitest::Test
  def get_json uri
  	res = Net::HTTP.get(URI("http://localhost/" + uri))
    result = JSON.parse(res)
  end

  def send_post uri, params
  	Net::HTTP.post_form(URI("http://localhost/" + uri), params)
  end

  def test_index
    result = get_json("articles.json")
    articles = Article.all
    result.each_with_index do |article,index|
      assert_equal article['title'], articles[index]["title"]
      assert_equal article['body'], articles[index]["body"]
    end
  end
  
  def test_show
  	article = Article.first
  	result = get_json("articles/#{article.id}.json")
  	assert_equal result["title"], article.title
  end

  def test_edit
  	articles = Article.limit(5000)
  	ids = []
  	articles.each{|article| ids << article.id}
  	id = ids[rand(ids.length)]
  	time_now = Time.now.to_s
  	params = {"article[title]" => time_now, "article[body]" => time_now, "_method" => "patch"}
    send_post "articles/" + id.to_s + ".json", params
    article = Article.find id
    assert_equal time_now, article.title
    assert_equal time_now, article.body
  end

  def test_create
  	time_now = Time.now.to_s
  	params = {"article[title]" => time_now, "article[body]" => time_now}
  	send_post "articles.json", params
  	article = Article.where(title: time_now).first
  	assert_equal time_now, article.title
  	assert_equal time_now, article.body
  end

  def test_destroy
  	articles = Article.limit(5000)
  	ids = []
  	articles.each{|article| ids << article.id}
  	id = ids[rand(ids.length)]
  	article = Article.find(id)
  	article.destroy
  	assert_equal true,Article.where(id: id).empty?
  end
end  	