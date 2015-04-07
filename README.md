# speed-test-for-api

speed test for api是一个使用ruby开发进行接口测试的框架，基于ruby的minitest，一些测试用例
中公用的方法可以放到common目录下，DB目录下存放和数据库库相关的代码，speed test for api使用activerecord作为ORM，使代码更加清晰易懂

test.rb是一个样例，可以对 https://github.com/redvoilin/blog 这个项目进行测试

如果需要连接mysql，需要通过下面命令安装相应gem 
    
    gem install mysql2
    gem install activerecord 

如果连的是sqlserver，需要通过下面命令安装相应gem
    
    gem install tiny_tds
    gem install activerecord-sqlserver-adapter

相关的资料
    
    minitest：http://docs.seattlerb.org/minitest/

    active record: http://guides.rubyonrails.org/association_basics.html
