![lina logo](lina-logo.png)

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

##  使用方法

### APIDOC

### 控制器

继承 `Lina::ApplicationController`, 使用 `define_action(action_name, api_spec, &block)` 定义 API.

* `action_name`: 方法名

* `api_spec`: API 描述信息, 如下代码所示. 它有两个用途:
  * 参数及返回值校验
  * 自动生成 APIDOC

* `&block`: 控制器实际代码

```ruby
class UsersController < Lina::ApplicationController
  define_action :show, {
    # API 名称
    name: '显示某个用户的信息',
    description: '传入一个ID, 显示这个用户的信息',
    # 通过 json-schema( 将在下面详细介绍 ) 描述参数约束
    params: {
      type: 'object',
      required: [ 'id' ],
      properties: {
        id: {
          type: 'string',
          description: '用户ID',
        }
      }
    },
    return: {
      type: 'object',
      required: [ 'name', 'id' ],
      properties: {
        name: {
          type: 'string',
        },
        id: {
          type: 'integer',
        }
      }
    }
  } do
    # 像 Rails 一样获取 params
    @user = User.find(params[:id])
    render json: { name: @uesr.name, id: @user.id }
  end
end
```

### 参数声明

TODO

### JSON 生成

TODO

### 路由与版本

TODO

### 认证

TODO

### 测试

TODO

## 技术核心

1. `define_action` 实际上会将 API 信息存入类实例变量中, APIDOC 是依据这些信息显示的.

## TODO

* Schema Form ( TODO )
* ActiveRecord Validator Helper ( TODO )


## 贡献者

[windy](http://yafeilee.me)

## License

MIT.
