![lina logo](lina-logo.png)

[![Gem Version](https://badge.fury.io/rb/lina.svg)](http://badge.fury.io/rb/lina)
[![license](http://img.shields.io/badge/license-MIT-red.svg?style=flat)](MIT-LICENSE)
[![Build Status](https://travis-ci.org/windy/lina.png?branch=master)](https://travis-ci.org/windy/lina)
[![Dependency Status](https://gemnasium.com/windy/lina.svg)](https://gemnasium.com/windy/lina)

Rails 开发者零成本上手的 RESTful API 框架.

Lina 是基于 `Ruby on Rails`, [JSON Schema](http://json-schema.org), `jbuilder` 的 RESTful API 开发框架, 整合 Ruby on Rails 开发 API 的最佳实践, 并添加 API 文档, 校验等必备功能.

它的特点:

* Rails 开发者零成本上手
* 自动生成 API 文档
* 自动校验入口参数
* 自动校验返回值参数

与 `Ruby on Rails` 几乎体验一致, 与 `grape` 相比, 更加易于上手.

在 Rails 项目的 Gemfile 中添加

```ruby
#  Gemfile
gem 'lina'
```
`bundle install` 之后, 安装

```shell
$ rails g lina:install
```

```shell
# 生成对应的 API
$ rails g lina:api posts index
```

启动 Rails 后, 访问 `http://localhost:3000/apidoc` 得到你的 API 文档.

ps: 目前仅支持 `Rails 4.1`, `Rails4.2`, 如果你有更低版本的支持需求, 请告诉我.

Rails 新手 Lina 使用说明: [Rails 新手?( TODO )](https://github.com/windy/lina/wiki)

目前 Lina 最新版 0.0.2 已经基本完善.

##  使用方法

### 自动 APIDOC

`Lina` 会遍历所有 API 控制器, 自动生成项目的 APIDOC, 供前端或客户端 APP 使用.

APIDOC 中包括:

* 路径
* API 名称与描述
* 参数说明
* 返回值说明

无须重启服务, APIDOC 会自行更新.

默认情况下, 访问 `http://localhost:3000/apidoc` 即可.

挂载点可以在 `config/routes.rb` 中调整:

```ruby
api_for '/apidoc'
```

### 控制器

1. 继承 `Lina::ApplicationController`.
2. 使用 `define_action(action_name, api_spec, &block)` 定义 API.

	* `action_name`: 方法名

	* `api_spec`: API 描述信息, 如下代码所示. 它有两个用途:
	  * 参数及返回值校验
	  * 自动生成 APIDOC

	* `&block`: 控制器实际代码

你可以使用 Lina API 生成器 `rails g lina:api posts index show` 来快速生成代码.

`Lina` 控制器逻辑代码完全兼容 `Rails` 的控制器, `filter`, `render`, `params` 都与 `Rails` 完全一致.

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

`params` 与 `return` 都是使用 `json-schema` 来描述参数的约束条件.

`Lina` 会在参数传入控制器之前, 进行 `params` 参数检查, 失败时抛出 `Lina::ParamsCheckError`. `return` 在返回的JSON同样进行检查, 对应抛出 `Lina::ReturnCheckError`. 这些行为可以在 `config/initializers/lina.rb` 中调整.

`json-schema` 是一个声明 JSON 格式规范的标准. 假如我们要定义一个 API, 参数要求:

```
name: 必填, string 类型, 不少于 3 个字符, 不超过 10 个字符.
city: 必填, string 类型, 只能在 [ '深圳', '上海', '北京' ] 中选取其一.
roles: 必填, array 类型, 在 [ '老师', '学生', '浏览者' ] 至少选一个.
gender: 非必填, boolean 类型.
bio: 非必填, string 类型.
```

`json-schema` 写法如下:

```
{
  type: 'object',
  required: [ 'name', 'city', 'roles' ],
  properties: {
    name: {
      type: 'string',
      description: '用户名, 3-10个字符',
      maxLength: 10,
      minLength: 3,
    },
    city: {
    	type: 'string',
    	description: '城市',
    	enum: [ '深圳', '上海', '北京' ],
    },
    roles: {
    	type: 'array',
    	description: '角色',
    	minItems: 1,
    	items: {
    		type: 'string',
    		enum: [ '老师', '学生', '浏览者' ],
    	}
    },
    gender: {
    	type: 'boolean',
    	description: '性别',
    },
    bio: {
    	type: 'string',
    	description: '个人介绍',
    }
  }
}
```

`description` 是为了 APIDOC 使用, 可选.

`Lina` 会在入口参数进行校验, 这份约束会同时展示到 APIDOC 里.

`return` 的写法与 `params` 一致.

`json-schema` 非常强大与简洁, 可以很容易地写出既优雅又安全的代码, 更全面的例子参考 [json-schema 官方例子](http://json-schema.org/examples.html)

### JSON 生成

缺省情况下, `Lina` 的控制器会尝试渲染对应的 `action` 的 `action.json.jbuilder`, 例如: `PostsController#index` 将会渲染 `app/views/posts/index.json.jbuilder`.

一个例子:

```ruby
#index.json.jbuilder
json.array! @posts do |post|
  json.extract! post, :name, :content, :created_at
end
```

`Lina` 整合了 `jbuilder`, 请到这里查看更多写法: [Jbuilder README](https://github.com/rails/jbuilder)

### 路由与版本

`Lina` 沿用了 `Rails` 的路由系统, 建议使用 `Rails RESTful Route` 写法:

```ruby
Rails.application.routes.draw do
  resources :posts, only: [:index, :show]

  resources :labels, only: [:index] do
    member do
      post :approve
    end
  end
end
```

对外的 API 一定要用版本号隔开, 如下:

```ruby
scope 'api/v1' do
  # get 'api/v1/posts', controller: 'PostsController'
  resources :posts, only: [:index]
end

scope 'api' do
  namespace 'v2' do
    # get 'api/v2/posts', controller: 'V2::PostsController'
    resource :posts, only: [:index]
  end
end
```

更复杂的版本号需求, 可参考 [stack overflow 讨论](http://stackoverflow.com/questions/9627546/api-versioning-for-rails-routes/9627796)

### 权限与认证

`Lina` 为了保持简洁, 并不提供这部分的支持, 但整合非常容易.

* 权限管理, 推荐使用 [`cancancan`](https://github.com/CanCanCommunity/cancancan)
* 认证, 推荐 `JWT`, 看看这里: [`ruby-jwt`](https://github.com/progrium/ruby-jwt)

你可以像 `Rails` 一样使用 `Lina`.

### CORS 跨域

推荐使用 [`rake-cors`](https://github.com/cyu/rack-cors) 整合.

### 测试

`Lina` 控制器的测试与 `Rails` 完全一致(事实上, lina:api 生成器会自动生成对应的测试代码 ), 在 Test::Unit 中, 一个例子如下

```ruby
class DesksControllerTest < ActionController::TestCase
  test "#index" do
    get :index
    assert_equal [ {'name'=> 'name1'}, {'name'=> 'name2'} ], JSON.parse(response.body)
  end

  test "#show validate failed" do
    assert_raise(Lina::ParamsCheckError) { get :show, id: 1, filter_name: 'x' * 6 }
  end

  test "#update return validate failed" do
    assert_raise(Lina::ReturnCheckError) { put :update, id: 1 }
  end
end
```

## 贡献指南

Lina 做了以下几件事情:

1. `define_action` 实际上会将 API 信息存入类实例变量中, APIDOC 通过 `Lina::ApplicationController` 的子类遍历, 依据这些信息显示的.
2. 覆写 `send_action`, 提供入口检测与返回参数检测.
3. 提供生成器 `lina:install`, `lina:api`.
4. 添加 `api_for` 路由项.
5. 一个强大的 APIDOC

`lina` 使用了 [appraisals](https://github.com/thoughtbot/appraisal) 测试不同版本 Rails 的支持情况.

首次开发时, 请使用 `bundle install` 和 `appraisal install` 来安装各版本 Rails 的依赖.

提交 PR 时, 请确保本地 `appraisal rake` 通过.

## 常见问题

### 访问 APIDOC 时 出现 Lina::ApiSpecError in Lina::ApidocController

* `Lina::ApiSpecError` 说明某处的 API 定义出现了问题, 不符合约定, API 声明时, 必须有 `name`, `params`, `return`.

* `Lina::ApiSpecParamsError` 说明 API 定义时 `params` 不符合 JSON Schema 的格式, 请检查.

* `Lina::ApiSpecReturnError` 说明 API 定义时 `return` 不符合 JSON Schema 的格式, 请检查.

## TODOLIST

* Schema Form ( TODO )
* ActiveRecord Validator Helper ( TODO )
* I18N Support( TODO )


## 贡献者

[windy](https://github.com/windy)

## License

MIT.
