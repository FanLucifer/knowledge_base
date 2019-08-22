# How To Use Raect With Rails

参考链接
- [3 ways to use React with Ruby on Rails 5](https://learnetto.com/blog/3-ways-to-use-react-with-ruby-on-rails-5)
- [在 Rails 中使用 react 教程](https://www.qiuzhi99.com/articles/zai-rails-zhong-shi-yong-react-jiao-cheng)
- [react-rails](https://github.com/reactjs/react-rails)

- [gems react-rails](https://rubygems.org/gems/react-rails)


## Get started with Webpacker
`Webpacker` 为 `Rails` 提供了流行的JS工具以下是集成 `Webpacker`, ` Rails-React` 和 `Rails` 的步骤：

1. 新建一个`Rails` 应用:
 
    ```shell
    $ rails new my-app
    $ cd my-app
    ```

2.  添加 `webpacker` 和  `react-rails` 到 `gemfile`:

    ```ruby
    gem 'webpacker'
    gem 'react-rails'
    ```

3. 开始安装:
    ``` shell
    $ bundle install
    $ rails webpacker:install # OR (on rails version < 5.0) rake webpacker:install
    $ rails webpacker:install:react # OR (on rails version < 5.0) rake webpacker:install:react
    $ rails generate react:install
    ```
    文件目录
    - React组件的目录  app/javascript/components/ 
    - [ReactRailsUJS](https://github.com/reactjs/react-rails#ujs) 设置 app/javascript/packs/application.js
    - [服务器端渲染](https://github.com/reactjs/react-rails#server-side-rendering) app/javascript/packs/server_rendering.js

4. 在Rails视图中 使用`javascript_pack_tag` 链接JavaScript包：
    ```erb
    <!-- application.html.erb in Head tag below turbolinks -->
    <％= javascript_pack_tag '应用' ％>
    ```

5. 生成第一个组件：
    ```shell
    $ rails g react:component HelloWorld greeting:string
    ```

6. 也可以在子目录中生成组件：
    ```shell
    $ rails g react:component my_subdirectory/HelloWorld greeting:string
    ```

    注意：app/javascript/components/默认情况下会添加您的组件。

7. 在Rails视图中渲染组件：
    ```erb
    <!-- erb: paste this in view -->
    <%= react_component("HelloWorld", { greeting: "Hello from react-rails." }) %>
    ```
8. 启动 `Rails` app 查看

## Component name
组件名称会告诉`react-rails`加载组件的位置。 例如：
| react_component call | component require |
| ---- | ---- |
| react_component("Item") | require("Item") |
| react_component("items/index") | require("items/index") |
| react_component("items.Index") | require("items").Index |
| react_component("items.Index.Header")| require("items").Index.Header |

在require.context插入packs/application.js用于加载组件。如果要从其他目录加载组件，请通过调用ReactRailsUJS.useContext以下方法覆盖它：
```javascript
var myCustomContext = require.context("custom_components", true)
var ReactRailsUJS = require("react_ujs")
// use `custom_components/` for <%= react_component(...) %> calls
ReactRailsUJS.useContext(myCustomContext)
```
如果`require`无法找到您的组件，`ReactRailsUJS`将返回到在`Asset Pipeline`中描述过的全局命名空间

## File naming
React-Rails支持许多文件扩展名，比如:.js、.jsx。js . js。jsx、.es6.js、.coffee等等。有时这将导致在搜索文件名时出错。

| Component File Name | react_component call require |
| ---- | ---- |
| app/javascript/components/samplecomponent.js | react_component("samplecomponent") |
| app/javascript/components/sample_component.js | react_component("sample_component") |
| app/javascript/components/SampleComponent.js | react_component("SampleComponent") |
| app/javascript/components/SampleComponent.js.jsx| Has to be renamed to SampleComponent.jsx, then use react_component("SampleComponent") |
