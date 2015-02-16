![lina logo](lina.png)

Rails 开发者零成本上手的 Restful API 框架.

Lina 是基于 `Ruby on Rails`, [JSON Schema](http://json-schema.org), `jbuilder` 的 API 框架, 通过定制 `ActionController` 实现了自动生成文档, 自动校验入口, 自动校验返回值参数.

几乎与 `Ruby on Rails` 开发体验一致, 与 `grape` 相比, 更加易于上手.

```ruby
# Gemfile
gem 'lina'
```

```shell
$ bundle install
$ rails g lina:install
# 生成对应的 API
$ rails g lina:api posts index
```

启动 Rails 后, 访问 http://localhost:3000/apidoc 得到你的 API 文档.

[![Build Status](https://travis-ci.org/windy/lina.png?branch=master)](https://travis-ci.org/windy/lina)

## 功能特性

### 参数校验

### API 文档

##  使用方法

### 控制器

```ruby
class UsersController < Lina::ApplicationController
  define_action :show, {
    name: '显示某个用户的信息',
    description: '传入一个ID, 显示这个用户的信息',
    params: {
      required: [ 'id' ],
      id: {
        type: 'integer',
        description: '用户ID',
      }
    },
    return: {
      type: 'object',
      name: {
        type: 'string',
      },
      id: {
        type: 'integer',
      }
    }
  } do
    @user = User.find(params[:id])
    render json: { name: @uesr.name, id: @user.id }
  end
end
```

### 路由与版本

### 认证

### 定制 APIDOC

## TODO

* Schema Form ( TODO )
* ActiveRecord Validator Helper ( TODO )


## 贡献者

[windy](http://yafeilee.me)

## License

MIT.
