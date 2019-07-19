
# Common Command

准备工作：

- [安装 `Ruby` 版本管理工具 RVM](https://rvm.io/)
- [安装 `Ruby`](https://ruby-china.org/wiki/install_ruby_guide)
- [安装 `Ruby On Rails`](https://ruby-china.org/wiki/install_ruby_guide)

参考资料：

- [RVM实用指南](https://ruby-china.org/wiki/rvm-guide)
- [RVM常用命令](https://xrlin.github.io/RVM%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4/)
- [rvm rake rails gem命令](https://www.jianshu.com/p/77c27e450508)
- [The Rails Command Line](https://guides.rubyonrails.org/command_line.html)

## RVM Related Command

### 1. 配置ruby

- 列出可以使用rvm安装的软件包

  `rvm list known`

- 安装指定版本的ruby

  `rvm install 2.5.1`

- 设置默认的ruby版本

  `rvm --default use 2.5.1`

- 使用指定版本的Ruby

  `rvm use 2.5.5`

- 使用系统的ruby版本
  `rvm use system`

- 列举所有安装的ruby版本

  `rvm list`

### 2. 配置Gemsets

RVM 不仅可以提供一个多 Ruby 版本共存的环境，还可以根据项目管理不同的 Gemsets.可以使得每个项目的gem环境相隔离，避免影响依赖关系

Gemsets 可以理解为是一个独立的虚拟 Gem 环境，每一个 Gemsets 都是相互独立的。

比如你有两个项目，一个是 Rails 2.3 一个是 rails3. Gemsets 可以帮你便捷的建立两套 Gem 开发环境，并且方便的切换。

Gemsets 是附加在 Ruby 语言版本下面的，例如你用了 2.5.1, 建立了一个叫 rails5 的 gemset,当切换到 2.5.5的时候，rails5 这个 gemset 并不存在

- 创建Gemset

  ```bash
  # 创建两个gem set
  rvm gemset create rails5 rails4
  ```

- 使用指定Gemset

  ```bash
  # 使用ruby2.5.1和rails5这个Gemset
  rvm 2.5.1@rails5
  ```

- 删除指定gemset

  ```bash
  # 删除当前ruby版本下的teddy这个gemset
  rvm gemset delete teddy
  # 删除ruby 2.0.0版本下的teddy这个gemset
  rvm 2.0.0 do rvm gemset delete teddy
  ```

- 清空 gemset 中的 Gem

  ```bash
  # 如果你想清空一个 gemset 的所有 Gem
  rvm gemset empty 2.5.1@rails5
  ```

- 获取当前的gemset名称

  ```bash
  rvm gemset name
  ```

- 获取gemset列表

  ```bash
  # 获取当前ruby版本下的gemset
  rvm gemset list
  # 获取所有的gemset(不分ruby版本)
  rvm gemset list_all
  ```

- 为指定项目配置rvm

  ```bash
  # 配置.ruby-version文件
  rvm --ruby-version use 1.9.3
  # 配置.ruby_version、.ruby-gemset文件
  rvm --ruby-version user 1.9.3@my_app
  ```

### 3. 使用 RVM 快速部署 Nginx + Passenger

- 首先安装 Passenger

  ```bash
  gem install passenger
  ```

- 使用 `passenger-install-nginx-module` 来安装 `Nginx` 和部署。

  这一步需要 root 权限（因为要编译 Nginx）可以用 rvmsudo 。

  ```bash
  rvmsudo passenger-install-nginx-module
  ```

  然后会让你选择是下载 Nginx 源码自动编译安装，还是自己选择 Nginx 源码位置。

  选择 Nginx 手动安装的可以添加别的编译参数，方便自定义编译 Nginx。

  默认的安装位置为 /opt/nginx.

- 查看 `nginx.conf`，都给你配置好了，加上 root 位置（yourapp/public）。

## Ruby Related Command

- 查看 `Ruby` 版本

  `ruby -v`

- 进入 `ruby` 交互命令行

  `irb`

## Gem Related Command

- 列出所有已安裝的模块

  `gem list`

- 列出所有已安装的 `Rails`

  `gem list rails`

- 升級RubyGems到最新版本

  `gem update --system`

- 更新指定模块到最新版本

  `gem update gem_name`

- 安裝指定模块

  `gem install gem_name`

  指定模块版本

  `gem install rails --version 3.2.2`
- 卸载裝模块

  `gem uninstall gem_name`

## Rails Related Command

- 创建一个`Rails`应用程序

  ```bash
  rails new app_name
  ```
