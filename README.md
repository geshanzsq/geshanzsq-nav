[腾讯云服务器低价大优惠，推荐购买](https://cloud.tencent.com/act/cps/redirect?redirect=2446&cps_key=16aea3100cc0223300300021e15a760b&from=console)

[阿里云服务器全面降价，限时优惠中](https://www.aliyun.com/product/ecs?userCode=tox0h0tg)

# 格姗导航网站

一个基于 Spring Boot、MyBatis Plus、Vue3、Element Plus 前后端分离的导航网站系统，在线演示地址：[https://gesdh.cn](https://gesdh.cn)。由于工作和个人能力原因，部分技术都是边学习边开发，特别是前端（工作中是后端开发），基本上不熟悉，代码质量和设计，请大家多多指教

欢迎加群一起学习交流技术。

QQ 群交流：673465233

微信群：添加我微信：geshanintell，备注：格姗导航

码云下载地址（国内推荐）：[https://gitee.com/geshanzsq/geshanzsq-nav](https://gitee.com/geshanzsq/geshanzsq-nav)

Github 下载地址：[https://github.com/geshanzsq/geshanzsq-nav](https://github.com/geshanzsq/geshanzsq-nav)

## 简介

本项目是一个网站导航，网站内容均由[小格子](https://geshanzsq.com/)本人收集并整理。前端基于 Vue3，后端使用 Spring Boot。目前只是基础版，没有开源自定义导航，大家可以根据此开源项目进行自定义导航开发。如果对自定义导航感兴趣，可联系小格子购买自定义导航源码

- 前端采用 Vue3、Element Plus。
- 后端采用 Spring Boot、MyBatis Plus、Spring Security、Redis。
- 后台管理支持加载动态权限菜单，权限修改立即生效，不用再退出重新登录。
- 高效率开发，只需要简单的 @Query 注解即可实现分页和列表接口。

## 内置功能

1. 用户管理：用户是整个系统操作人，主要完成系统用户配置
2. 角色管理：配置角色菜单、分配用户角色等。
3. 菜单管理：配置系统菜单、按钮权限标识、关联 API 等。
4. 数据字典：系统中经常使用的一些较为固定的数据进行维护。
5. API 管理：后端所有接口地址、请求方式等。
6. 参数配置：系统动态配置常用参数。
7. 登录日志：系统登录日志记录查询。
8. 操作日志：系统操作日志记录和查询。
9. 导航管理：分类管理、网站管理、评论管理

## 运行

前端：需要搭建 Vue 脚手架环境，如：安装 Node.js、Vue-cli 。

后端：需要搭建 Java 开发环境。此外，还需要安装 MySQL 数据库（推荐 MySQL 8）、Redis。

#### 相关环境版本：

| 软件名称 | 版本号    |
| -------- | --------- |
| Node     | 16.16.0   |
| NPM      | 6.14.15   |
| JDK      | 1.8.0_202 |
| MySQL    | 8.0.17    |
| Redis    | 5.0.9     |
| Nginx    | 1.9.9     |

### 项目目录结构说明

```yml
geshanzsq-nav-admin: 后台管理模块
    geshanzsq-nav-admin-application: 后台管理应用启动和导航业务
    geshanzsq-nav-admin-system: 后台管理的系统管理模块
geshanzsq-nav-common: 通用模块
    geshanzsq-nav-common-core: 核心通用模块，包含一些通用工具类
    geshanzsq-nav-common-framework: 通用框架模块
    geshanzsq-nav-common-rate-limiter: 通用限流模块
    geshanzsq-nav-common-log: 通用日志模块
    geshanzsq-nav-common-redis: 通用缓存模块
    geshanzsq-nav-common-security: 通用安全框架模块
    geshanzsq-nav-common-swagger: 通用接口文档模块
vue-geshanzsq-nav: 前端模块
```

#### 前端运行

```bash
# 进入项目目录
cd vue-geshanzsq-nav

# 安装依赖
npm install

# 建议不要直接使用 cnpm 安装依赖，会有各种诡异的 bug。可以通过如下操作解决 npm 下载速度慢的问题
npm install --registry=https://registry.npm.taobao.org

# 启动服务
npm run serve
```

浏览器访问 [http://127.0.0.1:8023](http://127.0.0.1:8023)

#### 后端运行

新建数据库，导入 `sql/geshanzsq_nav.sql ` 数据库脚本

在 `geshanzsq-nav/geshanzsq-nav-admin/geshanzsq-nav-admin-application`应用启动模块下，有三个配置文件：

| application.yml            | application-dev.yml                               | application-prod.yml                              |
| -------------------------- | ------------------------------------------------- | ------------------------------------------------- |
| 主要配置文件，配置公共信息 | 开发环境，配置 MySQL 数据库、Redis 缓存、文件路径 | 生产环境，配置 MySQL 数据库、Redis 缓存、文件路径 |

上述配置完成后，启动后台管理 `geshanzsq-nav-admin-application` 应用

在开发环境的 application-dev.yml 配置文件中，配置 MySQL 数据库连接信息、Redis 缓存、网站初始化图片。

![导航网站-数据库配置信息](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/02de4f3e-7e5c-4370-acea-3701c243759d.png)

![导航网站-文件上传配置信息](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/a514cec3-084d-41b2-ab64-1585c962a8ba.png)

**注：** 需要把目录【网站图片】下的 profile.zip 解压到配置文件的文件路径中，否则内置的网站数据加载不出图片。比如我的是：`D:/data/geshanzsq-nav/profile`，解压后的文件路径如图所示，如果网站图片加载失败，请检查图片路径是否正确。

![导航网站-图片路径](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/cd09da46-c2a8-476e-908c-ae75998c7ef9.png)

##### 生产环境

在 application.yml 配置文件中，把 dev 改为 prod；并在 application-prod.yml 配置对应的 MySQL 数据库、Redis 环境、文件路径。

### 后端技术

| 技术            | 说明                       | 官网链接                                                     |
| --------------- | -------------------------- | ------------------------------------------------------------ |
| Spring Boot     | MVC 框架                   | [https://spring.io/projects/spring-boot](https://spring.io/projects/spring-boot) |
| Spring Security | 认证和授权安全框架         | [https://spring.io/projects/spring-security](https://spring.io/projects/spring-security) |
| MyBatis Plus    | ORM 框架                   | [https://mp.baomidou.com](https://mp.baomidou.com)           |
| Knife4j         | 接口文档管理框架           | [https://doc.xiaominfo.com](https://doc.xiaominfo.com)       |
| Redis           | 缓存框架                   | [https://redis.io](https://redis.io)                         |
| Lombok          | 对象封装工具               | [https://github.com/projectlombok/lombok](https://github.com/projectlombok/lombok) |
| Nginx           | Http 和反向代理 Web 服务器 | [http://nginx.org](http://nginx.org)                         |

### 前端技术

| 说明                   | 官网                                                         |
| ---------------------- | ------------------------------------------------------------ |
| 前端框架               | [https://vuejs.org](https://vuejs.org)                       |
| 路由框架               | [https://router.vuejs.org](https://router.vuejs.org)         |
| 全局状态管理框架       | [https://vuex.vuejs.org](https://vuex.vuejs.org)             |
| 前端 Element Plus 框架 | [https://element-plus.gitee.io](https://element-plus.gitee.io) |
| 前端 Http 框架         | [https://github.com/axios/axios](https://github.com/axios/axios) |
| 富文本编辑器           | [https://www.wangeditor.com](https://www.wangeditor.com)     |
| 代码语法高亮插件       | [https://github.com/highlightjs/highlight.js](https://github.com/highlightjs/highlight.js) |

## 使用

导航首页：[http://127.0.0.1:8023](http://127.0.0.1:8023)

登录地址：[http://127.0.0.1:8023/login](http://127.0.0.1:8023.login)

默认用户：admin

默认密码：123456

## 演示图

![导航网站-首页.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/32f77495-f788-4889-acb1-417760f89f4c.png)

![导航网站-首页-格式转换.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/558ab7c3-3703-43c9-af3b-fd7ab00b57aa.png)

![导航网站-分类管理.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/84a02a68-5b1e-4429-9f5f-f09d8c4f00bc.png)

![导航网站-网站管理.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/d9f336e5-1454-459e-9431-3d50fa582e13.png)

![导航网站-网站配置.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/3efd39b9-6cc5-453e-9a64-e07e6f8ad1de.png)

![导航网站-接口文档.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/05/22/b001cf3c-b053-45b0-b84f-d6dac1ae878b.png)

## 项目部署

最近有挺多小伙伴不知道如何部署到服务器，小格子给大家简单的介绍一下。

### 安装相关环境

首先需要有一台服务器（建议 Linux 系统），安装 JDK1.8、MySQL 数据库、Redis 缓存、Nginx 代理。不会安装的请看这几篇文章。

[Linux 安装 MySQL 8 数据库](https://geshanzsq.com/article/34)

[Linux 安装 Nginx 代理](https://geshanzsq.com/article/65)

前端打包后会生成 dist，上传到服务器对应目录。打包命令：

```shell
npm run build
```

后端打包为 Jar 包，上传到服务器对应目录并执行下面命令：

```shell
nohup java -jar geshanzsq-nav-admin.jar &
```

### Nginx 代理配置

为了保证前端和后端不存在跨域问题，需要部署在 Nginx 进行配置：

```nginx
server {
    listen       80;
    server_name  localhost;
    
    # 前端项目配置
    location / {
        # root 后面为项目存在目录
        root /data/project/geshanzsq-nav/dist;
        index index.html index.htm;
        try_files $uri $uri/ /index.html;
   }
    
   # 后端项目配置
   location /geshanzsq-nav-api/ {
        # 项目 IP 地址和端口，如果不在一台服务器，请填写对应的 IP；如果后端端口修改后，请填写修改后的端口
        proxy_pass http://127.0.0.1:8083//geshanzsq-nav-api/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header REMOTE-HOST $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  } 
}

```

## License

Copyright © 2020-2023 **[格姗导航](https://gesdh.cn)** Released under the **Apache-2.0**.

> 注：本导航开源的目的是大家能够在本站的基础之上有所启发，做出更多新的东西，比如自定义导航。并不是让大家照搬所有代码。 如果你使用这个开源项目，请**注明**本项目开源地址。

## 自定义导航

自定义导航源码限时优惠中，功能强大，支持自定义导航、分享、第三方账号登录、自定义顶部链接、主题配置、简约版、访问记录、评论管理、分享管理、友情链接、网站配置、登录配置等功能，有需要的可联系小格子，下面是部分页面截图。

![自定义导航-首页.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/07/12/531a07f7-5590-4f15-bf33-d2236d6c5e41.png)

![自定义导航-主题设置.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/07/12/387ab999-8af1-44f3-b6a8-04c640444bb7.png)

![自定义导航-后台首页.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/07/12/9fd1c241-903c-450d-8d32-7da3f7a8898c.png)

![自定义导航-访问统计.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/07/12/9db24b35-293d-4d80-8ca4-b940bb182b7b.png)

![自定义导航-分享管理.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/07/12/4c87c459-c267-4899-a8a7-d356af6e91af.png)

![自定义导航-顶部配置.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/07/12/bb3f5616-05d1-4fd1-a86e-d736b5750829.png)

![自定义导航-登录配置.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/07/12/41c053a7-d25f-4d07-ae24-9f664a1c464c.png)

![自定义导航-网站配置.png](https://geshanzsq.com/geshanzsq-file/profile/image/2023/07/12/aad69891-5744-4f3e-8dd4-87a904d71135.png)

## 感谢

若依后台管理系统：[RuoYi-Vue](https://gitee.com/y_project/RuoYi-Vue)

蘑菇博客：[mogu_blog](https://gitee.com/moxi159753/mogu_blog_v2)
