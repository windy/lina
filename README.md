# Lina ( 0.0.1 )

一个快速的, 迷人的, 自文档化的 API 开发工具, 它直接基于 Ruby on Rails 实现.

如果你是 Rails 熟手, 对于 Lina, 基本上是零学习成本.

以前, 写 API 如下:

```ruby
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render json: { name: @uesr.name, id: @user.id }
  end
end
```

现在, 利用 Lina, 这样写:

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

现在, 你不仅立刻得到了 APIDOC( http://yourserver/lina ), 可以非常轻松的告与你的队友.

而且, Lina 将自动帮你校验 API 的 params, return 是否正确, 并根据你的配置抛出异常或者简单的日志记录.

最为重要的是, Rails 中原有的 route, jbuilder 都完全不受影响, 学习曲线是零成本.

在接下来, 还有一个更酷的特性: Schema Form. 这些 API 规范信息也会形成一个 API, 发给给客户端, 客户端可以据此创建自己的 Form 及校验方案, 就类似于客户端 Simple Form 的机制.

## Why

我很喜欢 Rails, 但市面上已有的基于 Rails API 开发项目, grape 坑多, 学习成本也不低, 是我不喜欢的. RailsAPI 项目又只是一些规范介绍, 没有什么意思.

我很喜欢 Rails 开发 Web 网站的时候的高效与强大, 并且开发 API 时利用 jbuilder 依然强大. 但是,

我们知道, 编写 API 必须要有 API 文档, API 入口必须做服务端校验, 这是一个硬需求. 但 Rails 本身并没有为我们提供.

又在偶然间, 我发现了 [JSON Schema](http://json-schema.org) 项目, 这是一个声明 JSON 数据规范的标准, 利用它和 Rails 本身, 就能达到既高效开发 API, 又对 Rails 开发者几无学习成本的一个 API 编写方案.

于是, Lina 项目就诞生了:

1. 几乎与 Rails 一样的 API 开发方式( route, controller, jbuilder 都与 Rails 完全一致 )
2. 通过扩展 ActionController, 支持 JSON Schema 约束, Lina 根据这些信息自动提供 API 入口与返回值校验, 更酷的是, APIDOC 也自动提供.
3. 更可提供某个 API 的 Schema 信息, 方便客户端( 例如 AngularJS/React )构建对应的 Form 使用, 比如, 某个 API 是用来构建一个表单的, 有了 Schema 信息, AngularJS/React 就能自动生一个高度体验的 Form 表单.

## How

TODO

## Feature and TODO

1. APIDOC ( OK )
2. Schema Validator( OK )
3. API Generator ( TODO )
4. Schema Form ( TODO )
5. ActiveRecord Validator to Schema ( TODO )
6. Test ( TODO )
7. Configuration, Mount, Lina Command ( TODO )


## 贡献

TODO

## License

MIT.
