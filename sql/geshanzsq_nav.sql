/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80017 (8.0.17)
 Source Host           : localhost:3306
 Source Schema         : geshanzsq_nav

 Target Server Type    : MySQL
 Target Server Version : 80017 (8.0.17)
 File Encoding         : 65001

 Date: 22/05/2023 20:09:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for log_login
-- ----------------------------
DROP TABLE IF EXISTS `log_login`;
CREATE TABLE `log_login`  (
  `id` bigint(20) NOT NULL COMMENT '登录日志 id',
  `username` varchar(50) NULL DEFAULT '' COMMENT '登录用户名',
  `fk_user_id` bigint(20) NOT NULL COMMENT '用户 id',
  `ip_address` varchar(200) NULL DEFAULT NULL COMMENT '登录 ip 地址',
  `login_location` varchar(255) NULL DEFAULT '' COMMENT '登录位置',
  `browser_type` varchar(50) NULL DEFAULT '' COMMENT '浏览器类型',
  `operate_system` varchar(50) NULL DEFAULT '' COMMENT '操作系统',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '登录状态（1 成功，2 失败）',
  `hint_message` varchar(255) NULL DEFAULT '' COMMENT '提示消息',
  `gmt_login` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '登录日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log_login
-- ----------------------------

-- ----------------------------
-- Table structure for log_operation
-- ----------------------------
DROP TABLE IF EXISTS `log_operation`;
CREATE TABLE `log_operation`  (
  `id` bigint(20) NOT NULL COMMENT '操作日志 id',
  `module_name` varchar(50) NULL DEFAULT '' COMMENT '模块名称',
  `business_type` tinyint(1) NULL DEFAULT 1 COMMENT '业务类型（1 其它，2 新增，3 修改，4 删除）',
  `operate_type` tinyint(1) NULL DEFAULT 1 COMMENT '操作类型（1 其它，2 后台用户，3 手机端用户，4 博客用户）',
  `fk_user_id` bigint(20) NOT NULL COMMENT '操作用户 id',
  `request_method` varchar(10) NULL DEFAULT '' COMMENT '请求方式',
  `class_method` varchar(255) NULL DEFAULT '' COMMENT '类方法',
  `request_url` varchar(255) NULL DEFAULT '' COMMENT '请求地址',
  `ip_address` varchar(200) NULL DEFAULT '' COMMENT '操作 ip 地址',
  `operate_location` varchar(255) NULL DEFAULT '' COMMENT '操作位置',
  `request_param` longtext NULL COMMENT '请求参数',
  `return_result` longtext NULL COMMENT '返回结果',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '登录状态（1 成功，2 异常）',
  `gmt_operate` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `error_message` longtext NULL COMMENT '错误消息',
  `browser_type` varchar(50) NULL DEFAULT '' COMMENT '浏览器类型',
  `operate_system` varchar(50) NULL DEFAULT '' COMMENT '操作系统',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '操作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log_operation
-- ----------------------------

-- ----------------------------
-- Table structure for nav_category
-- ----------------------------
DROP TABLE IF EXISTS `nav_category`;
CREATE TABLE `nav_category`  (
  `id` bigint(20) NOT NULL COMMENT '分类 id',
  `parent_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '父级id',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `category_name` varchar(50) NULL DEFAULT '' COMMENT '分类名称',
  `category_icon` varchar(20) NULL DEFAULT '' COMMENT '分类图标',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '导航分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nav_category
-- ----------------------------
INSERT INTO `nav_category` VALUES (150725316141100103, 0, 30, '资源搜索', 'search', '2020-07-10 23:58:54', '2021-03-27 00:27:58', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141100104, 0, 40, '在线工具', 'cogs', '2020-07-25 19:39:39', '2021-03-27 00:27:49', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141100105, 0, 60, '学习教程', 'study', '2020-07-25 19:39:39', '2021-03-27 00:27:30', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141100106, 0, 60, '软件下载', 'software', '2020-07-25 19:39:39', '2021-03-27 00:27:24', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141100107, 0, 70, '休闲娱乐', 'music', '2020-07-25 19:39:39', '2021-03-27 00:27:21', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141100108, 0, 80, '灵感采集', 'Light-Bulb', '2020-07-25 21:41:31', '2021-03-27 00:27:17', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141100109, 0, 90, '素材资源', 'international', '2020-07-25 21:41:31', '2021-03-27 00:27:13', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101001, 150725316141100103, 1, '网盘搜索', 'chart', '2020-07-11 00:02:09', '2020-07-11 11:35:42', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101002, 150725316141100103, 2, '电子书搜索', 'code', '2020-07-11 10:46:40', '2020-07-11 11:35:46', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101004, 0, 1, '格式转换', 'lock', '2020-07-25 21:30:22', '2021-03-27 00:22:23', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101005, 150725316141100104, 2, '语言翻译', 'component', '2020-07-25 21:30:22', '2020-07-25 21:31:18', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101006, 0, 3, '图标素材', 'component', '2020-07-25 21:30:22', '2021-03-27 00:28:42', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101007, 150725316141100105, 1, '博客网站', 'wechat', '2020-07-25 21:43:34', NULL, 1, NULL, 1);
INSERT INTO `nav_category` VALUES (150725316141101008, 150725316141100106, 1, 'Windows', 'tool', '2020-07-25 21:44:10', NULL, 1, NULL, 1);
INSERT INTO `nav_category` VALUES (150725316141101009, 150725316141100106, 2, 'Android', 'upload', '2020-07-25 21:44:36', NULL, 1, NULL, 1);
INSERT INTO `nav_category` VALUES (150725316141101010, 150725316141100106, 3, 'Apple|Mac', 'time', '2020-07-25 21:44:52', '2020-08-18 22:46:22', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101011, 150725316141100107, 1, '影视', 'icon', '2020-07-25 21:45:44', NULL, 1, NULL, 1);
INSERT INTO `nav_category` VALUES (150725316141101012, 150725316141100107, 2, '音乐', 'people', '2020-07-25 21:45:58', NULL, 1, NULL, 1);
INSERT INTO `nav_category` VALUES (150725316141101013, 150725316141100104, 3, '图形创意', 'dict', '2020-08-01 15:06:54', NULL, 1, NULL, 1);
INSERT INTO `nav_category` VALUES (150725316141101014, 150725316141100104, 4, '界面设计', 'select', '2020-08-01 15:08:33', '2023-05-07 18:24:41', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101015, 150725316141100104, 5, '交互动效', 'tool', '2020-08-01 15:13:19', '2023-05-07 18:24:51', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101016, 150725316141100104, 6, '在线配色', 'time', '2020-08-01 15:15:46', '2023-05-07 18:25:00', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101017, 150725316141100104, 7, '其他工具', 'tag', '2020-08-01 15:15:58', '2023-05-07 18:25:09', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101018, 150725316141100104, 8, 'Chrome插件', 'clipboard', '2020-08-01 15:16:14', '2023-05-07 18:25:19', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101019, 150725316141100108, 1, '发现产品', 'build', '2020-08-01 15:23:57', '2023-05-07 18:28:31', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101020, 150725316141100108, 2, '界面灵感', 'clipboard', '2020-08-01 15:24:11', '2023-05-07 18:28:40', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101021, 150725316141100108, 3, '网页灵感', 'druid', '2020-08-01 15:24:34', '2023-05-07 18:28:48', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101022, 150725316141100109, 2, 'LOGO设计', 'clipboard', '2020-08-01 15:35:28', '2023-05-07 18:29:10', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101023, 150725316141100109, 3, '平面素材', 'drag', '2020-08-01 15:35:55', '2023-05-07 18:29:19', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101024, 150725316141100109, 4, 'UI资源', 'example', '2020-08-01 15:36:05', '2023-05-07 18:29:26', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101025, 150725316141100109, 5, 'Sketch资源', 'form', '2020-08-01 15:36:17', '2023-05-07 18:29:31', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101026, 150725316141100109, 6, '字体资源', 'international', '2020-08-01 15:36:40', '2023-05-07 18:29:36', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101027, 150725316141100109, 7, 'Mockup', 'monitor', '2020-08-01 15:37:03', '2023-05-07 18:29:44', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101028, 150725316141100109, 8, '摄影图库', 'post', '2020-08-01 15:37:24', '2023-05-07 18:29:50', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101029, 0, 10, 'PPT资源', 'theme', '2020-08-01 15:37:35', '2021-03-27 00:28:21', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101030, 150725316141100105, 4, '后端学习', 'textarea', '2020-08-08 15:06:09', '2023-05-07 18:26:50', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101031, 150725316141100105, 3, '前端学习', 'rate', '2020-08-08 15:07:26', '2023-05-07 18:27:03', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101032, 150725316141100105, 2, '个人博客', 'Light-Bulb', '2020-08-08 15:19:13', '2023-05-07 18:27:13', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101034, 0, 100, '自媒体', 'select', '2020-08-11 17:44:07', '2021-03-27 00:27:08', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101035, 150725316141101034, 1, '运营平台', 'theme', '2020-08-11 17:44:31', '2023-05-07 18:30:22', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101036, 0, 2, '图片素材', 'clipboard', '2020-08-11 20:12:23', '2021-03-27 00:30:29', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101037, 0, 12, '桌面壁纸', 'computer', '2020-08-19 19:39:19', '2021-03-27 00:29:55', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101039, 150725316141101034, 2, '排版工具', 'shopping', '2020-08-20 11:02:52', '2023-05-07 18:30:31', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101040, 150725316141100104, 9, 'Github加速下载', 'chart', '2020-08-31 22:51:30', '2023-05-07 18:25:28', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101042, 150725316141100105, 5, '开源项目', 'article', '2020-09-16 14:37:04', '2023-05-07 18:27:22', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101043, 150725316141100104, 11, '电视直播', 'online', '2020-09-20 14:54:03', '2023-05-07 18:25:45', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101046, 150725316141100106, 0, '软件博客', 'software', '2020-10-16 21:41:47', '2023-05-07 18:22:23', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101047, 150725316141100107, 3, '游戏资源', 'menu', '2020-10-16 22:59:20', '2023-05-07 18:28:20', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101048, 150725316141101034, 4, '视频制作', 'movie', '2021-01-07 19:56:03', '2023-05-07 18:30:39', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101049, 150725316141100104, 12, '免费图床', 'excel', '2021-01-12 16:28:22', '2023-05-07 18:26:00', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101050, 150725316141100104, 13, '办公协作', 'swagger', '2021-01-18 10:27:16', '2023-05-07 18:26:22', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101051, 150725316141101034, 5, '数据分析', 'dict', '2021-02-01 14:34:50', '2023-05-07 18:30:45', 1, 1, 1);
INSERT INTO `nav_category` VALUES (150725316141101052, 0, 0, '热门导航', 'cc-thumbs-up', '2021-03-27 00:34:10', NULL, 1, NULL, 1);

-- ----------------------------
-- Table structure for nav_comment
-- ----------------------------
DROP TABLE IF EXISTS `nav_comment`;
CREATE TABLE `nav_comment`  (
  `id` bigint(20) NOT NULL COMMENT '评论 id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '上级 id',
  `has_sticky` tinyint(1) NULL DEFAULT 2 COMMENT '是否置顶（1 是，2 否） ',
  `comment_content` longtext NOT NULL COMMENT '评论内容',
  `nick_name` varchar(30) NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(50) NULL DEFAULT '' COMMENT '邮箱',
  `remark` varchar(255) NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 待审核，2 通过，3 驳回）',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nav_comment
-- ----------------------------

-- ----------------------------
-- Table structure for nav_picture
-- ----------------------------
DROP TABLE IF EXISTS `nav_picture`;
CREATE TABLE `nav_picture`  (
  `id` bigint(20) NOT NULL COMMENT '图片 id',
  `picture_original_name` varchar(200) NULL DEFAULT '' COMMENT '图片原名称',
  `picture_path` varchar(500) NULL DEFAULT '' COMMENT '图片路径',
  `picture_md5` varchar(100) NULL DEFAULT '' COMMENT '图片 md5',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '导航图片' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nav_picture
-- ----------------------------

-- ----------------------------
-- Table structure for nav_site
-- ----------------------------
DROP TABLE IF EXISTS `nav_site`;
CREATE TABLE `nav_site`  (
  `id` bigint(20) NOT NULL COMMENT '网站 id',
  `fk_category_id` bigint(20) NULL DEFAULT NULL COMMENT '分类 id',
  `site_name` varchar(50) NULL DEFAULT NULL COMMENT '网站名称',
  `site_path` varchar(100) NULL DEFAULT NULL COMMENT '网站图片路径',
  `site_description` varchar(300) NULL DEFAULT NULL COMMENT '网站描述',
  `site_url` varchar(300) NULL DEFAULT NULL COMMENT '网站地址',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `click_count` int(11) NULL DEFAULT 0 COMMENT '点击量',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '用户导航网站信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nav_site
-- ----------------------------
INSERT INTO `nav_site` VALUES (150725316141100003, 150725316141101001, '小昭来啦', '/profile/site/system/b27e89c97230454302cbb24a115c3577.ico', '网盘搜索', 'https://www.xiaozhaolaila.com', 2, 0, '2020-07-30 22:18:26', NULL, NULL, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100004, 150725316141101001, '小猪快盘', '/profile/site/system/16ad1dd9-810c-44e0-b553-5ee7a155aa35.png', '有你更方便', 'https://www.xiaokesoso.com/', 3, 0, '2020-07-30 22:18:26', '2022-11-07 19:46:34', NULL, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100006, 150725316141101001, '小不点搜索', '/profile/site/system/7f0c4a571333ea397c688b7fc0ba7191.jpg', '好资源一网打尽', 'https://www.xiaoso.net', 5, 0, '2020-07-30 22:18:26', '2020-07-30 23:16:32', NULL, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100007, 150725316141101001, '56网盘搜索', '/profile/site/system/7dc0f592b6ac032ca20e3d29c2daf2dd.ico', '网盘搜索', 'https://www.56wangpan.com', 6, 0, '2020-07-30 22:18:26', '2020-07-30 23:17:37', NULL, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100008, 150725316141101001, '大圣盘', '/profile/site/system/b054e2e190eb787aedcef330c4a78e1e.png', '网盘搜索，就用大圣盘 - 最好用的百度网盘搜索引擎', 'https://www.dashengpan.com', 7, 0, '2020-07-30 22:18:26', '2020-07-30 23:20:10', NULL, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100016, 150725316141101002, '点点文档搜索', '/profile/site/system/a35d2046-f0c9-4a94-b007-79322b05c5a7.jpg', '专注专业文档搜索', 'https://www.torrent.org.cn/bd', 1, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100017, 150725316141101002, 'Telegram书籍搜索', '/profile/site/system/d51adf1b-6baa-4aaf-90e7-d444309ce737.png', '免费电子书搜索', 'https://bks.thefuture.top/', 2, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100019, 150725316141101002, '鸠摩搜索', '/profile/site/system/69d815f7-ff4f-49ba-b294-535fd1f5ddbf.png', '强大的电子书搜索', 'https://www.jiumodiary.com/', 4, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100020, 150725316141101002, 'kindle 漫画', '/profile/site/system/9ff2df64-77bd-4c12-8e6d-92d28ae264df.ico', '漫画', 'https://volmoe.com/', 5, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100021, 150725316141101002, '中华珍宝馆', '/profile/site/system/857063b3-ea38-4eb8-8c29-d372ba2740a6.png', '中华珍宝馆', 'https://ltfc.net/', 6, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100022, 150725316141101002, '国图文津', '/profile/site/system/c356a6b5-f8f4-4857-9142-732d5defd004.png', '文津搜索', 'http://find.nlc.cn', 7, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100023, 150725316141101002, '书格', '/profile/site/system/a60e1981c4c4a14e5469b9c2e8a16cac.png', '搜索资源集', 'https://new.shuge.org/', 8, 0, '2020-08-01 14:24:18', '2020-08-08 14:50:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100024, 150725316141101002, '古籍馆', '/profile/site/system/5350f9dd-1818-4b8b-84b3-cf926d5c7cc2.ico', '中國最大的古籍圖書館，在线搜索', 'https://www.gujiguan.com', 9, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100025, 150725316141101002, 'Gutenberg', '/profile/site/system/5b2c64cb-a793-4bd9-a69a-e6535cdd36bc.png', ' 无版权书籍在线搜索与下载，外文版', 'http://www.gutenberg.org', 10, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100028, 150725316141101002, '书栈网', '/profile/site/system/2e2d77a6-3c44-4de0-a5eb-a6d2b754a731.png', '程序员IT互联网开源编程书籍免费阅读与下载，取之于猿用之于猿', 'https://www.bookstack.cn', 13, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100029, 150725316141101002, '码农之家', '/profile/site/system/54f8a778eaaa63550b63e8a051484d43.ico', '计算机电子书下载网-编程pdf电子书下载', 'https://www.xz577.com', 14, 0, '2020-08-01 14:24:18', '2020-08-06 13:53:33', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100030, 150725316141101002, '书享家', '/profile/site/system/6737d6da-43f3-4b67-b528-5aa58e77e86d.png', '电子书下载导航', 'http://shuxiangjia.cn', 15, 0, '2020-08-01 14:24:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100031, 150725316141101005, '有道翻译', '/profile/site/system/316e6dde-d4a6-4590-9d0a-e082b40a4876.ico', '免费、及时的多语种在线翻译', 'http://fanyi.youdao.com/', 1, 0, '2020-08-01 14:41:43', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100032, 150725316141101005, 'Google 翻译', '/profile/site/system/c9f49602-6db2-488c-994c-45524e499090.ico', 'Google 在线翻译', 'https://translate.google.cn/', 2, 0, '2020-08-01 14:41:43', '2021-01-13 15:29:39', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100033, 150725316141101005, '百度翻译', '/profile/site/system/b4354f2c-a638-4e25-9269-f572af38318c.jpg', '百度在线翻译', 'https://fanyi.baidu.com/translate', 3, 0, '2020-08-01 14:41:43', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100034, 150725316141101005, '必应翻译', '/profile/site/system/e877f478-17d8-4549-9858-cb5edd5ab4f2.ico', '微软在线翻译', 'https://cn.bing.com/translator', 4, 0, '2020-08-01 14:41:43', '2021-01-13 15:29:46', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100035, 150725316141101008, '腾讯软件中心', '/profile/site/system/3d244575922fd6f3f251cf2326901817.ico', '不错的软件商店', 'https://pc.qq.com/', 1, 0, '2020-08-01 14:48:15', '2020-08-06 13:43:40', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100036, 150725316141101008, 'MSDN', '/profile/site/system/e377b1038d9b1de65faa974cd0f1697d.ico', '原版系统镜像下载', 'https://msdn.itellyou.cn', 2, 0, '2020-08-01 14:48:15', '2020-08-06 13:44:22', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100037, 150725316141101008, '致美化', '/profile/site/system/095e81f7aabe0a02d59e260b5a006181.ico', '桌面美化交流平台', 'https://zhutix.com', 3, 0, '2020-08-01 14:48:15', '2020-08-06 13:45:11', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100038, 150725316141101046, '大眼仔旭', '/profile/site/system/e9b2f20ae9880fb20b98a07a309b96c1.ico', '专注视频剪辑、解压、录屏、思维导图等办公软件分享', 'http://www.dayanzai.me', 2, 0, '2020-08-01 14:48:15', '2020-10-16 21:45:14', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100039, 150725316141101046, '爱绿软', '/profile/site/system/161d313406154438d4319655b0892cd8.png', '收集分享各类有趣好玩的绿色软件', 'https://ilvruan.com', 3, 0, '2020-08-01 14:48:15', '2020-10-16 21:45:18', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100040, 150725316141101046, '异次元软件站', '/profile/site/system/5edb929d595ea22f900244e4985e4cb2.ico', '异次元软件世界 - 软件改变生活', 'https://www.iplaysoft.com', 4, 0, '2020-08-01 14:48:15', '2020-10-16 21:45:22', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100041, 150725316141101046, '吾爱破解', '/profile/site/system/25ef62ba415682c09a4a0a2dea4cbf67.ico', '软件交流社区', 'https://www.52pojie.cn', 0, 0, '2020-08-01 14:48:15', '2020-10-16 21:45:05', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100042, 150725316141101009, '魔趣 ROM', '/profile/site/system/46363edb-dafa-451a-bb0b-74030679e0e1.png', '可能是中国最好的安卓开源系统', 'https://www.mokeedev.com', 1, 0, '2020-08-01 14:49:28', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100043, 150725316141101009, 'Xposed框架中文站', '/profile/site/system/29575a8c-5830-4310-b04c-1ddb978dcb3f.png', '超多Xposed框架模块介绍与下载', 'http://xposed.appkg.com', 2, 0, '2020-08-01 14:49:28', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100044, 150725316141101009, '观道', '/profile/site/system/1b3a7fddd824ac8f01e5c0d400875808.ico', '国外App下载_App下载界的一股清流', 'http://www.guandao.cc', 3, 0, '2020-08-01 14:49:28', '2020-08-06 13:51:36', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100045, 150725316141101009, '豌豆荚', '/profile/site/system/e0ccaa1741577bac575a049479df805e.ico', '海量安卓APP应用与游戏免费下载', 'https://www.wandoujia.com', 4, 0, '2020-08-01 14:49:28', '2020-08-06 13:50:56', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100046, 150725316141101009, 'TapTap', '/profile/site/system/0f03874c92974facb1706e69c54f94d4.png', '发现好游戏', 'https://www.taptap.com', 5, 0, '2020-08-01 14:49:28', '2020-08-06 13:52:24', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100047, 150725316141101010, '腾讯柠檬精选', '/profile/site/system/25206276f20af4103ea56a75be6c0802.png', '收录免费、正版、好用的Mac应用及产品', 'https://lemon.qq.com/lab/', 1, 0, '2020-08-01 14:50:21', '2020-08-06 13:49:34', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100048, 150725316141101010, '每日限免', '/profile/site/system/5d4d23c3-7135-4f82-b946-6c10f3a11f84.png', '每日精品限免_促销应用', 'https://app.so/xianmian', 2, 0, '2020-08-01 14:50:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100052, 150725316141101011, '腾讯视频', '/profile/site/system/fe2b466d9fe6bed552c0adcaac1c2813.ico', '中国领先的在线视频媒体平台,海量高清视频在线观看', 'https://v.qq.com', 4, 0, '2020-08-01 14:51:38', '2020-08-06 13:42:24', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100053, 150725316141101011, '爱奇艺', '/profile/site/system/b9555fb5-e19c-4547-a542-eb55e4a6bd72.png', '在线视频网站-海量正版高清视频在线观看', 'https://www.iqiyi.com', 5, 0, '2020-08-01 14:51:38', '2021-01-13 15:21:57', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100054, 150725316141101011, '优酷', '/profile/site/system/e4e0ee80c4466950ae51cecdd28080e1.png', '这世界很酷', 'https://www.youku.com', 6, 0, '2020-08-01 14:51:38', '2020-08-06 13:39:48', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100055, 150725316141101012, '疯狂音乐', '/profile/site/system/e1ace6a5-b279-49a9-8f1e-afb98ab97956.ico', '音乐聚集平台，支持国内大部分音乐平台', 'http://music.ifkdy.com', 1, 0, '2020-08-01 14:52:55', '2021-01-13 15:26:30', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100059, 150725316141101012, 'QQ音乐', '/profile/site/system/6dfcb9895c4d834dac1bc7256a54a9b8.ico', '千万正版音乐海量无损曲库新歌热歌天天畅听的高品质音乐平台', 'https://y.qq.com', 5, 0, '2020-08-01 14:52:55', '2020-08-04 14:48:12', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100060, 150725316141101012, '网易云音乐', '/profile/site/system/21f3ff494c85b7adbd62f6308651e4cf.png', '专注于发现与分享的音乐产品，依托专业音乐人、DJ、好友推荐及社交功能，为用户打造全新的音乐生活', 'https://music.163.com', 6, 0, '2020-08-01 14:52:55', '2020-08-04 14:49:42', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100061, 150725316141101012, '酷狗音乐', '/profile/site/system/0e8a8d31be0727fcd077c9df5e6a9ba9.ico', '就是歌多', 'https://www.kugou.com', 7, 0, '2020-08-01 14:52:55', '2020-08-04 14:52:05', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100062, 150725316141101012, '虾米音乐', '/profile/site/system/3d4c138efe8f0c64cf3a94c17c3344b7.png', '发现音乐新世界', 'https://www.xiami.com', 8, 0, '2020-08-01 14:52:55', '2020-08-05 00:19:33', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100063, 150725316141101004, '在线格式转换', '/profile/site/system/95ed0b48-8dbc-4407-a52a-2541bc16f054.jpg', '万能且免费的格式转换，支持各种格式。', 'https://www.alltoall.net', 1, 0, '2020-08-01 14:54:25', '2020-08-11 23:28:53', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100064, 150725316141101032, '良许', '/profile/site/system/0fcd5b42-a5c6-4023-86e3-97448d7f20a2.ico', 'Linux系统常用命令教学,shell脚本入门学习', 'https://www.lxlinux.net', 9, 0, '2020-08-01 14:56:49', '2021-01-13 15:33:05', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100065, 150725316141101032, '程序猿圈', '/profile/site/system/a198ddc1-8b73-4900-93b4-87fda77fb50f.jpg', '程序员在线学习站点', 'https://www.cxyquan.com/', 2, 0, '2020-08-01 14:56:49', '2020-08-08 15:19:47', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100066, 150725316141101032, '纯洁的微笑', '/profile/site/system/bee2f3c7-4fb8-4b06-8ba3-c678585d5b54.jpg', '分享技术，品味人生', 'http://ityouknow.com/', 3, 0, '2020-08-01 14:56:49', '2020-08-08 15:19:56', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100067, 150725316141101032, '江南一点雨', '/profile/site/system/063a8d1d-1e81-4c0d-9c43-53cc8a873d7a.jpg', '技术文章分享', 'http://www.javaboy.org', 4, 0, '2020-08-01 14:56:49', '2020-08-08 15:20:07', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100068, 150725316141101032, '程序猿DD', '/profile/site/system/9625e95b-8a7b-4548-8e57-5a191b306f2f.jpg', 'Java Spring Boot Spring Cloud 最新干货分享', 'http://blog.didispace.com', 5, 0, '2020-08-01 14:56:49', '2020-08-08 15:20:11', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100069, 150725316141101006, 'Iconfinder', '/profile/site/system/e3325f68179436ccfc25b9f0ffff5a39.png', '2,100,000+个免费和高级矢量图标。', 'https://www.iconfinder.com', 1, 0, '2020-08-01 14:58:10', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100070, 150725316141101006, 'iconfont', '/profile/site/system/e1f63337915f79f8bcad1952adb9f6e1.png', '阿里巴巴矢量图标库。', 'http://www.iconfont.cn/', 2, 0, '2020-08-01 14:58:10', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100071, 150725316141101006, 'iconmonstr', '/profile/site/system/afd4885651455f12dcac4f214460dd99.png', '您的下一个项目的免费简单图标。', 'https://iconmonstr.com/', 3, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100072, 150725316141101006, 'FindIcons', '/profile/site/system/0171a46b0f643752aa90aa314a22a546.png', '搜索300,000个免费图标。', 'https://findicons.com/', 4, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100073, 150725316141101006, 'Icon Archive', '/profile/site/system/40c43a8932f24370cf456789b2ab51db.png', '搜索590,912个免费图标。', 'http://www.iconarchive.com/', 5, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100074, 150725316141101006, 'IcoMoonApp', '/profile/site/system/d19c97ead3760f1b70efa4ee9ad6859c.png', '图标字体，SVG，PDF和PNG生成器。', 'https://icomoon.io/app/', 6, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100075, 150725316141101006, 'easyicon', '/profile/site/system/34b4382075e047c6d1456f8fe591a1ef.png', 'PNG、ICO、ICNS格式图标搜索、图标下载服务。', 'http://www.easyicon.net/', 7, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100076, 150725316141101006, 'flaticon', '/profile/site/system/582cf7361a0b4f444628c68b98e5cfc7.png', '634,000+免费矢量图标为SVG，PSD，PNG，EPS格式或图标字体。', 'https://www.flaticon.com/', 8, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100077, 150725316141101006, 'UICloud', '/profile/site/system/f9840e127d500449da1c5c721f3634c3.png', '世界上最大的用户界面设计数据库。', 'http://ui-cloud.com/', 9, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100078, 150725316141101006, 'Material icons', '/profile/site/system/32a037ffbdd2f97f6f6e62e56321c519.png', '可访问900多种材质系统图标，这些图标以各种大小和密度提供，并且可以作为网络字体使用。', 'https://material.io/icons/', 10, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100079, 150725316141101006, 'Font Awesome Icon', '/profile/site/system/88440b8b0d5dc43a3f766670e2d11746.png', '惊人的675个图标的完整集合。', 'https://fontawesome.com/', 11, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100080, 150725316141101006, 'ion icons', '/profile/site/system/6d0fd0bf35549f6d61037bd86e2ca242.png', 'Ionic Framework的高级图标字体。', 'http://ionicons.com/', 12, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100081, 150725316141101006, 'Simpleline Icons', '/profile/site/system/acf446f1af754f863260cc10dd8d546e.png', '简单的线条图标包。', 'http://simplelineicons.com/', 13, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100082, 150725316141101013, 'photoshop', '/profile/site/system/e7117e80fdb340589bc8969900e2af61.png', 'Photoshop不需要解释', 'https://www.adobe.com/cn/products/photoshop.html', 1, 0, '2020-08-01 15:07:48', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100083, 150725316141101013, 'Affinity Designer', '/profile/site/system/290add1cdb3cdb80e6e30af137d48525.png', '专业创意软件', 'https://affinity.serif.com/', 2, 0, '2020-08-01 15:07:48', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100084, 150725316141101013, 'Illustrator', '/profile/site/system/6882fdb094820bae95054ea1c38a3baf.png', '矢量图形和插图。', 'https://www.adobe.com/cn/products/illustrator/', 3, 0, '2020-08-01 15:07:48', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100085, 150725316141101013, 'indesign', '/profile/site/system/4db54894b6751e253212a690dada0df8.png', '页面设计、布局和出版。', 'http://www.adobe.com/cn/products/indesign.html', 4, 0, '2020-08-01 15:07:48', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100086, 150725316141101013, 'cinema-4d', '/profile/site/system/ac0344f03fc1e59b4144fef92a12e211.png', 'Cinema 4D是所有想要快速，轻松地获得惊人效果的3D艺术家的理想选择。', 'https://www.maxon.net/en/products/cinema-4d/overview/', 5, 0, '2020-08-01 15:07:49', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100087, 150725316141101013, '3ds-max', '/profile/site/system/3aacac5d23583cdc250a970a0e30a9aa.png', '3D建模，动画和渲染软件', 'https://www.autodesk.com/products/3ds-max/overview', 6, 0, '2020-08-01 15:07:49', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100088, 150725316141101013, 'Blender', '/profile/site/system/5d61addac4350caee364f0a3e850a3f7.png', 'Blender是免费的开源3D创建套件。', 'https://www.blender.org/', 7, 0, '2020-08-01 15:07:49', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100089, 150725316141101014, 'Sketch', '/profile/site/system/75cc5b5775361d5f0b471b706a115403.png', '数字设计工具包', 'https://sketchapp.com/', 1, 0, '2020-08-01 15:09:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100090, 150725316141101014, 'Adobe XD', '/profile/site/system/9eda46042e2ad058951fa4e4bb3a9957.png', '引入Adobe XD。 设计。 原型。 经验。', 'http://www.adobe.com/products/xd.html', 2, 0, '2020-08-01 15:09:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100091, 150725316141101014, 'invisionapp', '/profile/site/system/7d5620f1b4fd85c4a7ea4733deed8823.png', '强大的设计原型工具', 'https://www.invisionapp.com/', 3, 0, '2020-08-01 15:09:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100092, 150725316141101014, 'marvelapp', '/profile/site/system/28ec81158c67d9783afccf8fcd1bbee6.png', '简单的设计，原型制作和协作', 'https://marvelapp.com/', 4, 0, '2020-08-01 15:09:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100093, 150725316141101014, 'Muse CC', '/profile/site/system/612cf530fe80b5f28dc826c4384087bf.png', '无需利用编码即可进行网站设计。', 'https://creative.adobe.com/zh-cn/products/download/muse', 5, 0, '2020-08-01 15:09:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100094, 150725316141101014, 'figma', '/profile/site/system/0623aab0bc72437206deca9d4c55df1c.png', '使用Figma一站式设计，制作原型并收集反馈。', 'https://www.figma.com/', 6, 0, '2020-08-01 15:09:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100095, 150725316141101015, 'Adobe After Effects CC', '/profile/site/system/01306292e590f37b934785ed67288f80.png', '电影般的视觉效果和动态图形。', 'https://www.adobe.com/cn/products/aftereffects/', 1, 0, '2020-08-01 15:14:56', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100096, 150725316141101015, 'principle', '/profile/site/system/485a410f2076ad20856199caa300f548.png', '激发您的想法，设计更好的应用程序', 'http://principleformac.com/', 2, 0, '2020-08-01 15:14:56', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100097, 150725316141101015, 'flinto', '/profile/site/system/f655d57c7d752c429510e0f649d69666.png', 'Flinto是Mac应用程序，世界各地的顶级设计师都使用它来创建其应用程序设计的交互式动画原型。', 'https://www.flinto.com/', 3, 0, '2020-08-01 15:14:56', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100098, 150725316141101015, 'framer', '/profile/site/system/e64c3cd0283a3bf6a75c9c4ba821049d.png', '从详细的图标到高保真的交互，一切都设计在一个地方。', 'https://framer.com/', 4, 0, '2020-08-01 15:14:56', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100099, 150725316141101015, 'ProtoPie', '/profile/site/system/bdbb0e0485d816b88c75c9276d273873.png', '高保真交互原型设计', 'http://www.protopie.cn/', 5, 0, '2020-08-01 15:14:56', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100100, 150725316141101016, 'khroma', '/profile/site/system/8b158c18b49f0160100086bfcdbe158d.png', 'Khroma是发现，搜索和保存要使用的颜色组合的最快方法。', 'http://khroma.co/generator/', 1, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100101, 150725316141101016, 'uigradients', '/profile/site/system/9842ff5c221d6411444d3c13660ba097.png', '美丽的彩色渐变', 'https://uigradients.com', 2, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100102, 150725316141101016, 'gradients', '/profile/site/system/64d0ac5dc78b65d83ba500df5b1eab30.png', '为设计师和开发人员设计的渐变色', 'http://gradients.io/', 3, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100103, 150725316141101016, 'Coolest', '/profile/site/system/9b77eaad5ef27823b9feb3f765b9d593.png', '最酷的精选渐变色为您的下一个超级⚡惊人的东西', 'https://webkul.github.io/coolhue/', 4, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100104, 150725316141101016, 'webgradients', '/profile/site/system/49bfc25c217107d7209eea098ad0307c.png', 'WebGradients是180个线性渐变的免费集合，您可以将其用作网站任何部分的内容背景。', 'https://webgradients.com/', 5, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100105, 150725316141101016, 'grabient', '/profile/site/system/8ab1a1044ef9bc5c306c60b81d83b0a2.png', '2017 Grabient展开', 'https://www.grabient.com/', 6, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100106, 150725316141101016, 'thedayscolor', '/profile/site/system/6e63366cb896fa19e204cf6b95691062.png', '日常色彩摘要', 'http://www.thedayscolor.com/', 7, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100107, 150725316141101016, 'flatuicolors', '/profile/site/system/0b6e14ae22ff962a96ad66de4fc86aff.png', '从平面UI主题复制粘贴调色板', 'http://flatuicolors.com/', 8, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100108, 150725316141101016, 'coolors', '/profile/site/system/9176968478c5c42ed20bce8b69f25bf6.png', '超快速配色方案生成器！', 'https://coolors.co/', 9, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100109, 150725316141101016, 'Adobe Color CC', '/profile/site/system/ff4d69bedb642bd132297ed22018369b.png', '使用色轮创建配色方案或浏览“颜色”社区中的数千种颜色组合。', 'https://color.adobe.com/zh/create/color-wheel', 10, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100110, 150725316141101016, 'flatuicolorpicker', '/profile/site/system/2faf82318597d846e9522c5f52500031.png', 'UI设计的最佳平面颜色', 'http://www.flatuicolorpicker.com/', 11, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100111, 150725316141101016, 'trianglify', '/profile/site/system/88261a86b35e5b015bbe35ab9141bc8f.png', '三角生成器', 'http://qrohlf.com/trianglify-generator/', 12, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100112, 150725316141101016, 'klart', '/profile/site/system/c51065aaec56c7c65aafd40f4797dba0.png', '每周都会为您的收件箱提供漂亮的颜色和设计', 'https://klart.co/colors/', 13, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100113, 150725316141101016, 'vanschneider', '/profile/site/system/4690e9281c23d5fc9df0e2cfbe018edd.png', '“颜色声明”由Tobias van Schneider于2012年创建，目标是为我的未来项目收集和组合独特的颜色。', 'http://www.vanschneider.com/colors', 14, 0, '2020-08-01 15:16:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100114, 150725316141101017, 'tinypng', '/profile/site/system/9344c4d9769745c1e63d8f1e7b2f3f25.png', '通过质量和文件大小的完美平衡来优化图像。', 'https://tinypng.com/', 1, 0, '2020-08-01 15:17:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100115, 150725316141101017, 'Android 9 patch', '/profile/site/system/dc5b75e3455673384a8f738429789d4b.png', 'Android 9补丁阴影生成器完全可自定义阴影', 'http://inloop.github.io/shadow4android/', 2, 0, '2020-08-01 15:17:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100116, 150725316141101017, 'screen sizes', '/profile/site/system/d79583290bc400c0e8a2629d0e7f9f63.png', '流行设备的视口大小和像素密度', 'http://screensiz.es/', 3, 0, '2020-08-01 15:17:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100117, 150725316141101017, 'svgomg', '/profile/site/system/f573dc81e4689cb9ce482f35a6fb82f1.png', 'SVG在线压缩平台', 'https://jakearchibald.github.io/svgomg/', 4, 0, '2020-08-01 15:17:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100118, 150725316141101017, '稿定抠图', '/profile/site/system/0a6b1b1ea1d5ca5cb49e8cf95470a3b5.png', '免费在线抠图软件,图片快速换背景-抠白底图', 'https://www.gaoding.com', 5, 0, '2020-08-01 15:17:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100119, 150725316141101017, '中文转换英文首字母', '/profile/site/system/0fcf02f7a6dc850af65961ce29e4b4cd.png', '在线中文转换英文首字母', 'http://tool.geshanzsq.com/chinese', 6, 0, '2020-08-01 15:17:33', '2020-08-07 10:54:12', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100120, 150725316141101017, 'php数组转Json', '/profile/site/system/9a1139692d3d565d5bb15c816548f13b.png', '在线php数组转Json', 'http://tool.geshanzsq.com/phpToJson', 7, 0, '2020-08-01 15:17:33', '2020-08-07 10:53:01', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100121, 150725316141101017, '在线工具', '/profile/site/system/a2143416-fe6d-4cd5-8a58-bc9ab3911a6a.jpg', '程序员的工具箱', 'https://tool.lu', 8, 0, '2020-08-01 15:17:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100122, 150725316141101018, 'wappalyzer', '/profile/site/system/60696fcbba523de88eca68121dee7be7.png', '识别网站上的技术', 'https://www.wappalyzer.com/', 1, 0, '2020-08-01 15:19:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100123, 150725316141101018, 'Panda', '/profile/site/system/35e1bbf29c1116cb1dbb703b52ea2ae9.png', '专为提高生产力而打造的智能新闻阅读器。', 'http://usepanda.com/', 2, 0, '2020-08-01 15:19:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100124, 150725316141101018, 'sizzy', '/profile/site/system/5ca0b65bcc3606640ba1b4aadd25c7df.png', '快速开发响应式网站的工具', 'https://sizzy.co/', 3, 0, '2020-08-01 15:19:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100125, 150725316141101018, 'csspeeper', '/profile/site/system/84fedbd61bf8c93726b713bae36a88ae.png', '专为设计师量身定制的智能CSS查看器。', 'https://csspeeper.com/', 4, 0, '2020-08-01 15:19:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100126, 150725316141101018, 'insight', '/profile/site/system/fc5a318293079a2674f1d92f3dce7650.png', '云端上类似IDE的代码搜索和导航', 'http://insight.io/', 5, 0, '2020-08-01 15:19:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100127, 150725316141101018, 'mustsee', '/profile/site/system/709ff744a41559fa06b8e8dc199206a3.png', '在每个打开的标签页中发现世界上最美丽的地方。', 'http://mustsee.earth/', 6, 0, '2020-08-01 15:19:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100128, 150725316141101019, 'Producthunt', '/profile/site/system/a1cc88fa0a3bf74349ba9c08a67abdc7.png', '发现新鲜有趣的产品。', 'https://www.producthunt.com/', 1, 0, '2020-08-01 15:25:50', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100129, 150725316141101019, 'NEXT', '/profile/site/system/0e2b6c9a5afd4f83d2e22632b08f56ef.png', '不错过任何一个新产品。', 'http://next.36kr.com/posts', 2, 0, '2020-08-01 15:25:50', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100130, 150725316141101019, '少数派', '/profile/site/system/2d01ac82bb496b607c43e7b2b29cd069.png', '高品质数字消费指南。', 'https://sspai.com/', 3, 0, '2020-08-01 15:25:51', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100131, 150725316141101019, '利器', '/profile/site/system/98e2ee62a90b6243630f4aa479b4b47b.png', '创造者和他们的工具。', 'http://liqi.io/', 4, 0, '2020-08-01 15:25:51', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100132, 150725316141101019, 'Today', '/profile/site/system/1726189292537c3a2733ebc673b7f1d6.png', '为身边的新产品喝彩。', 'http://today.itjuzi.com/', 5, 0, '2020-08-01 15:25:51', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100133, 150725316141101019, '小众软件', '/profile/site/system/76b49053ce87ab3c7419c7cdf6fa4f07.png', '在这里发现更多有趣的应用。', 'https://faxian.appinn.com', 6, 0, '2020-08-01 15:25:51', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100134, 150725316141101020, 'Pttrns', '/profile/site/system/1c759dc53774e5758a31fee0401e213a.png', '查看最佳的设计模式，资源，移动应用程序和灵感集合', 'https://www.pttrns.com/', 1, 0, '2020-08-01 15:26:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100135, 150725316141101020, 'Collect UI', '/profile/site/system/7e802c77c7bb6c85c1e2bb608a4a13cd.png', '从每日ui档案库及其他收集的每日灵感。', 'http://collectui.com/', 2, 0, '2020-08-01 15:26:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100136, 150725316141101020, 'UI uigreat', '/profile/site/system/d140fe4bd548f273ddd00f35e1ad5ff5.png', 'APP界面截图参考。', 'http://ui.uigreat.com/', 3, 0, '2020-08-01 15:26:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100137, 150725316141101020, 'Android Niceties', '/profile/site/system/8b6e0af7df3a5d77a14e41a0f5f36dc5.png', '屏幕快照集合，其中包含一些最漂亮的Android应用程序。', 'http://androidniceties.tumblr.com/', 4, 0, '2020-08-01 15:26:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100138, 150725316141101021, 'Awwwards', '/profile/site/system/bdd6c88417790c97de2c2d0643cc602c.png', '互联网设计、创意和创新奖', 'https://www.awwwards.com/', 1, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100139, 150725316141101021, 'CSS Design Awards', '/profile/site/system/481219fe4285f1f4ec1311acce7deb06.png', '网站奖项与灵感-CSS Gallery', 'https://www.cssdesignawards.com/', 2, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100140, 150725316141101021, 'The FWA', '/profile/site/system/8fe5280ff7dc3012fb88781dd9ff4b93.png', 'FWA-自2000年以来每天都在展示创新', 'https://thefwa.com/', 3, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100141, 150725316141101021, 'Ecommercefolio', '/profile/site/system/950d52c71e28f1c9ed964732d6ed18fd.png', '只有最佳电子商务设计灵感。', 'http://www.ecommercefolio.com/', 4, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100142, 150725316141101021, 'Lapa', '/profile/site/system/1824678ec13d01b76df47fc5975178fa.png', '最佳登陆页面设计灵感来自网络。', 'http://www.lapa.ninja/', 5, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100143, 150725316141101021, 'Reeoo', '/profile/site/system/5205b768b9b640bfada244ce9d15318d.png', '网页设计灵感和网站库。', 'http://reeoo.com/', 6, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100144, 150725316141101021, 'Designmunk', '/profile/site/system/31de409b71235b76d605e98293d68cb3.png', '最佳首页设计灵感。', 'https://designmunk.com/', 7, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100145, 150725316141101021, 'Best Websites Gallery', '/profile/site/system/862823249aa701d8bc8af16ae98f1e3a.png', '网站展示灵感| 最佳网站画廊。', 'https://bestwebsite.gallery/', 8, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100146, 150725316141101021, 'Pages', '/profile/site/system/90fd20bd3e7ae7c7fe37ea689dcca32c.png', '最佳网页的精选目录。', 'http://www.pages.xyz/', 9, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100147, 150725316141101021, 'SiteSee', '/profile/site/system/da24d08a597456be98191b4a08eff4d6.png', '精选的精美，现代网站集的画廊。', 'https://sitesee.co/', 10, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100148, 150725316141101021, 'Site Inspire', '/profile/site/system/c15c9017ad6874faae0df64bd969115b.png', '一个CSS画廊和最佳网页设计灵感的展示。', 'https://www.siteinspire.com/', 11, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100149, 150725316141101021, 'WebInspiration', '/profile/site/system/f8fe63594e2083755086ee294b036108.png', '网页设计欣赏,全球顶级网页设计。', 'http://web.uedna.com/', 12, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100150, 150725316141101021, 'navnav', '/profile/site/system/86b9e596068f2a71d2a2444733a4094e.png', '来自网络的大量CSS，jQuery和JavaScript响应式导航示例，演示和教程。', 'http://navnav.co/', 13, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100151, 150725316141101021, 'Really Good UX', '/profile/site/system/948b0f5b62e59ef0a97edf4b9a51c404.png', '屏幕截图库和非常好的UX示例。 带给你的。', 'https://www.reallygoodux.io/', 14, 0, '2020-08-01 15:27:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100152, 150725316141101022, 'Dribbble', '/profile/site/system/7db1257f40b9b04482744387a00b359d.png', '全球UI设计师作品分享平台。', 'https://dribbble.com/', 1, 0, '2020-08-01 15:38:39', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100153, 150725316141101022, 'Iconsfeed', '/profile/site/system/aee21da67d9771c2ebf3f6779afc9649.png', 'iOS图标库。', 'http://www.iconsfeed.com/', 2, 0, '2020-08-01 15:38:39', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100154, 150725316141101022, 'iOS Icon Gallery', '/profile/site/system/98c9f52ede06a56532d5d16afda9d570.png', '展示来自iOS App Store的精美图标设计。', 'http://iosicongallery.com/', 3, 0, '2020-08-01 15:38:39', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100155, 150725316141101022, 'World Vector Logo', '/profile/site/system/c8da40d11f726d974293efc40c9acfb5.png', '免费下载品牌徽标。', 'https://worldvectorlogo.com/', 4, 0, '2020-08-01 15:38:40', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100156, 150725316141101022, 'Instant Logo Search', '/profile/site/system/907f35950eae72526a314306cc59efa7.png', '立即搜索和下载数千个徽标。', 'http://instantlogosearch.com/', 5, 0, '2020-08-01 15:38:40', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100157, 150725316141101023, 'freepik', '/profile/site/system/6a96564b2d100bad3674db5e56794a97.png', '超过一百万的免费矢量，PSD，照片和免费图标。', 'https://www.freepik.com/', 1, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100158, 150725316141101023, 'wallhalla', '/profile/site/system/9354f99621e8530d0f996fe4b96ad2c3.png', '在一处找到用于台式机和手机的超酷优质壁纸。', 'https://wallhalla.com/', 2, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100159, 150725316141101023, '365PSD', '/profile/site/system/13b10a2f9388e83101d7a35b83ff28bc.png', '免费PSD和图形，插图。', 'https://365psd.com/', 3, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100160, 150725316141101023, 'Medialoot', '/profile/site/system/b117eb768a44d662ded91d1f0a9cb1c2.png', '免费和高级设计资源-Medialoot。', 'https://medialoot.com/', 4, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100161, 150725316141101023, '千图网', '/profile/site/system/9a24027c0e9d498efb4ad88a330882f8.png', '专注免费设计素材下载的网站。', 'http://www.58pic.com/', 5, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100162, 150725316141101023, '千库网', '/profile/site/system/15ffa7b3a5cab15c7d23d402be12cc4c.png', '免费png图片背景素材下载。', 'http://588ku.com/', 6, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100163, 150725316141101023, '我图网', '/profile/site/system/a887a255bbe7fe994e0479ae988372c7.png', '我图网,提供图片素材及模板下载,专注正版设计作品交易。', 'http://www.ooopic.com/', 7, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100164, 150725316141101023, '90设计', '/profile/site/system/c510c1946d6191a98c6fd3b08ca720ec.png', '电商设计（淘宝美工）千图免费淘宝素材库。', 'http://90sheji.com/', 8, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100165, 150725316141101023, '昵图网', '/profile/site/system/d4fba2a16c7a1692ea21f4f0a8ae7672.png', '原创素材共享平台。', 'http://www.nipic.com/', 9, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100166, 150725316141101023, '懒人图库', '/profile/site/system/a7e5f98173ea111df83da146a86436a1.png', '懒人图库专注于提供网页素材下载。', 'http://www.lanrentuku.com/', 10, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100167, 150725316141101023, '素材搜索', '/profile/site/system/cbca7fabfd7c6d1b117547466bc564ad.png', '设计素材搜索聚合。', 'http://so.ui001.com/', 11, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100168, 150725316141101023, 'PS饭团网', '/profile/site/system/7ffad2eac8cbad395d33914344d3aa0a.png', '不一样的设计素材库！让自己的设计与众不同！', 'http://psefan.com/', 12, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100169, 150725316141101023, '素材中国', '/profile/site/system/ced6b2a53069c7d360ba78706244081f.png', '免费素材共享平台。', 'http://www.sccnn.com/', 13, 0, '2020-08-01 15:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100170, 150725316141101024, 'UI中国', '/profile/site/system/9458ececbfeea651b5e871179f245ce5.png', '图形交互与界面设计交流、作品展示、学习平台。', 'http://www.ui.cn/', 1, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100171, 150725316141101024, 'Freebiesbug', '/profile/site/system/4288052485ced84952e206a4acfb92ad.png', '网页设计人员和开发人员的精选资源不断更新。', 'https://freebiesbug.com/', 2, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100172, 150725316141101024, 'Freebie Supply', '/profile/site/system/2ae393ad916a108ba20d21a8b907477e.png', '设计师的免费资源。', 'https://freebiesupply.com/', 3, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100173, 150725316141101024, '云瑞', '/profile/site/system/528f9304b0dab49f5fe2426d4d9d047c.png', '优秀设计资源的分享网站。', 'https://www.yrucd.com/', 4, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100174, 150725316141101024, 'Designmodo', '/profile/site/system/2061e0ccebfbb1a94a28d86237589b23.png', '网页设计博客和商店。', 'https://designmodo.com/', 5, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100175, 150725316141101024, '稀土区', '/profile/site/system/4f5171443ad0ec6b13b7f96b8cead4bd.png', '优质设计开发资源分享。', 'https://xituqu.com/', 6, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100176, 150725316141101024, 'ui8', '/profile/site/system/b815917aad63f449a96900979a16eb4e.png', 'UI套件，线框套件，模板，图标等。', 'https://ui8.net/', 7, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100177, 150725316141101024, 'uplabs', '/profile/site/system/42d3d29c62a19e8d4ca6395586d79ee7.png', '产品设计师和开发人员的日常资源。', 'https://www.uplabs.com/', 8, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100178, 150725316141101024, 'UIkit.me', '/profile/site/system/13b4ac8efdc9f92e52e7f271b8034b24.png', '最便捷新鲜的uikit资源下载网站。', 'http://www.uikit.me/', 9, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100179, 150725316141101024, 'Fribbble', '/profile/site/system/04c1b51de97ceac330358fa7d1685034.png', 'Dribbblers提供了免费的PSD文件和其他免费设计资源。', 'http://www.fribbble.com/', 10, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100180, 150725316141101024, 'PrincipleRepo', '/profile/site/system/e3e93f407dcc94461bea06979e89e4a2.png', '免费的高质量原则资源。', 'http://principlerepo.com/', 11, 0, '2020-08-01 15:39:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100181, 150725316141101025, 'Sketch', '/profile/site/system/ff6a2f8afaeb91004416c96788f9da95.png', '数字设计工具包。', 'https://sketchapp.com/', 1, 0, '2020-08-01 15:40:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100182, 150725316141101025, 'Sketch Measure', '/profile/site/system/69bf814d311d932ea13b746ffc1f9f54.png', '友好的用户界面为您提供了一种更直观的标记方式。', 'http://utom.design/measure/', 2, 0, '2020-08-01 15:40:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100183, 150725316141101025, 'Sketch App Sources', '/profile/site/system/ccf82c5a27a285ba63cf3c4ff8964a25.png', '免费的设计资源和插件-图标，UI套件，线框，iOS，Android草图模板', 'https://www.sketchappsources.com/', 3, 0, '2020-08-01 15:40:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100184, 150725316141101025, 'Sketch.im', '/profile/site/system/6055276a55b62db423c2b060d3f6b044.png', 'Sketch 相关资源汇聚。', 'http://www.sketch.im/', 4, 0, '2020-08-01 15:40:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100185, 150725316141101025, 'Sketch Hunt', '/profile/site/system/c4bf007a61d761db1f895672a2519cd0.png', 'Sketch Hunt是一个独立的博客，为Sketch应用程序的爱好者分享学习，插件和设计工具方面的瑰宝。', 'http://sketchhunt.com/', 5, 0, '2020-08-01 15:40:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100186, 150725316141101025, 'Sketch中文网', '/profile/site/system/a26a90da0d304cd3502cdb53e85995b9.png', '分享最新的Sketch中文手册。', 'http://www.sketchcn.com/', 6, 0, '2020-08-01 15:40:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100187, 150725316141101025, 'Awesome Sketch Plugins', '/profile/site/system/255cf49affef2fbaba8cd15c3e7329b5.png', '真正有用的Sketch插件的集合。', 'https://awesome-sket.ch/', 7, 0, '2020-08-01 15:40:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100188, 150725316141101025, 'Sketchcasts', '/profile/site/system/fa8c8b179ab48ad61e61a18d1720e019.png', '学习素描通过每周的视频教程来训练您的设计技能', 'https://www.sketchcasts.net/', 8, 0, '2020-08-01 15:40:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100189, 150725316141101026, 'Google Font', '/profile/site/system/91c604a4ca98b1bb5719e04c80043419.png', '通过出色的排版，使网络更加美观，快速和开放。', 'https://fonts.google.com/', 1, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100190, 150725316141101026, 'Typekit', '/profile/site/system/7dbc17741d30274995615612dc1d075f.png', '来自世界上最好的铸造厂的高质量字体。', 'https://typekit.com/', 2, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100191, 150725316141101026, '方正字库', '/profile/site/system/8ffeec1d3ad96a39dd4ede9794756b87.png', '方正字库官方网站。', 'http://www.foundertype.com/', 3, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100192, 150725316141101026, '字体传奇网', '/profile/site/system/d5fc1ea541fe215ae449a0ae27a09a76.png', '中国首个字体品牌设计师交流网。', 'http://ziticq.com/', 4, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100193, 150725316141101026, '私藏字体', '/profile/site/system/125e538efd8b3ea68d3655cb81ccc06f.png', '优质字体免费下载站。', 'http://sicangziti.com/', 5, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100194, 150725316141101026, 'Fontsquirrel', '/profile/site/system/94684e5203623eb5540a4b5a0e0b70b0.png', '图形设计师的免费字体。', 'https://www.fontsquirrel.com/', 6, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100195, 150725316141101026, 'Urban Fonts', '/profile/site/system/40139afeda032d1a3cd54459d065b31b.png', '下载免费字体和免费Dingbats。', 'https://www.urbanfonts.com/', 7, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100196, 150725316141101026, 'Lost Type', '/profile/site/system/cfe0904ec3e37914be51687a2b15f5cf.png', '失物招领是一个协作数字类型代工厂。', 'http://www.losttype.com/', 8, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100197, 150725316141101026, 'FONTS2U', '/profile/site/system/19bd844dc123066620d1f6fda7287e48.png', '为Windows和Macintosh下载免费字体。', 'https://fonts2u.com/', 9, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100198, 150725316141101026, 'Fontex', '/profile/site/system/1576a7303fb2fa3839016a599418203b.png', '免费字体下载+高级字体。', 'http://www.fontex.org/', 10, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100199, 150725316141101026, 'FontM', '/profile/site/system/5ee459b3c52027eb8dcd9c8c6e9266a0.png', '免费字体。', 'http://fontm.com/', 11, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100200, 150725316141101026, 'My Fonts', '/profile/site/system/22572b2d9b38ea02f173074d59acf334.png', '用于印刷，产品和屏幕的字体。', 'http://www.myfonts.com/', 12, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100201, 150725316141101026, 'Da Font', '/profile/site/system/d0478f80b89bff215437714e62c6d997.png', '可免费下载的字体的存档。', 'https://www.dafont.com/', 13, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100202, 150725316141101026, 'OnlineWebFonts', '/profile/site/system/bccc59c04f6f283a63430700273ffdee.png', '适用于Windows和Mac的WEB免费字体/免费下载字体。', 'https://www.onlinewebfonts.com/', 14, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100203, 150725316141101026, 'Abstract Fonts', '/profile/site/system/fbedc66f865056e650a036f042625057.png', '抽象字体（13,866个免费字体）。', 'http://www.abstractfonts.com/', 15, 0, '2020-08-01 15:40:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100204, 150725316141101027, 'MockupZone', '/profile/site/system/75e599ff2f061dc25fa272de94045ca9.png', 'Mockup Zone是一个在线商店，您可以在其中找到免费的高级PSD样机文件，以专业的方式展示您的设计。', 'https://mockup.zone/', 1, 0, '2020-08-01 15:41:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100205, 150725316141101027, 'Dunnnk', '/profile/site/system/7949d12743b95779412dd8673c324164.png', '免费生成产品模型。', 'http://dunnnk.com/', 2, 0, '2020-08-01 15:41:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100206, 150725316141101027, 'Graphberry', '/profile/site/system/1216f3642b463e7e9d493e4d00506566.png', '免费设计资源，样机，PSD Web模板，图标。', 'http://www.graphberry.com/', 3, 0, '2020-08-01 15:41:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100207, 150725316141101027, 'Threed', '/profile/site/system/252114418dc086100cd58d10035a9436.png', '直接在浏览器中生成3D模型', 'http://threed.io/', 4, 0, '2020-08-01 15:41:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100208, 150725316141101027, 'Mockup World', '/profile/site/system/c94ee98e4ada29c0916888820da31744.png', '网上最好的免费模型', 'https://free.lstore.graphics/', 5, 0, '2020-08-01 15:41:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100209, 150725316141101027, 'Lstore', '/profile/site/system/965f25d08ae3cd33fab21d764a514967.png', '面向设计师和开发人员的独家令人兴奋的免费赠品。', 'https://free.lstore.graphics/', 6, 0, '2020-08-01 15:41:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100210, 150725316141101027, 'pixeden', '/profile/site/system/f8b5261bc1d5e5189b9c1216a6de8b3b.png', '免费的网络资源和图形设计模板。', 'https://www.pixeden.com/', 7, 0, '2020-08-01 15:41:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100211, 150725316141101027, 'For Graphic TM', '/profile/site/system/20fceec1b9dd6c1183ad73a90becce7f.png', '适用于图形设计师的高质量PSD样机。', 'http://forgraphictm.com/', 8, 0, '2020-08-01 15:41:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100212, 150725316141101028, 'Unsplash', '/profile/site/system/72880b02dbea40fd84472abc05e6d23b.png', '漂亮的免费照片。', 'https://unsplash.com/', 1, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100213, 150725316141101028, 'visualhunt', '/profile/site/system/b2a1a1e4c043858ac2411f02b9236ff3.png', '100％免费的高质量照片。', 'https://visualhunt.com/', 2, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100214, 150725316141101028, 'librestock', '/profile/site/system/94c5305f78dfadb241f9edcf3d9b870d.png', '65,084高品质的照片，随您想要。', 'https://librestock.com/', 3, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100215, 150725316141101028, 'pixabay', '/profile/site/system/310cb7b52774323c7fdffe67aa0f12aa.png', '可在任何地方使用的免费图片和视频。', 'https://pixabay.com/', 4, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100216, 150725316141101028, 'SplitShire', '/profile/site/system/0e9933021af7cc4714e900c247010b30.png', '免费图片和视频供商业使用。', 'https://www.splitshire.com/', 5, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100217, 150725316141101028, 'StockSnap', '/profile/site/system/fabf86558eb3a7c943c124f7f62f3542.png', '美丽的免费图片素材。', 'https://stocksnap.io/', 6, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100218, 150725316141101028, 'albumarium', '/profile/site/system/de8b7f26a21ea0b781f93a3163341731.png', '查找和分享精美图像的最佳场所。', 'http://albumarium.com/', 7, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100219, 150725316141101028, 'myphotopack', '/profile/site/system/80d85ea59d293bd43731a890f63c5dc9.png', '专门为您提供的免费照片包。 每个月。', 'https://myphotopack.com/', 8, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100220, 150725316141101028, 'Notaselfie', '/profile/site/system/eb5f9a9661e582883c9d3128bb9b4482.png', '一路上发生的照片。 您可以随时使用图像。 玩得开心！', 'http://notaselfie.com/', 9, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100221, 150725316141101028, 'papers', '/profile/site/system/3a6396ba24d253502f40432751a11b07.png', '每小时都有墙纸！手工收集', 'http://papers.co/', 10, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100222, 150725316141101028, 'stokpic', '/profile/site/system/9dce238279b24893eaa20a99fba802ea.png', '免费图片供商业使用。', 'http://stokpic.com/', 11, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100223, 150725316141101028, '55mm', '/profile/site/system/dd8adcbc65cc20e8fb6d6335fd57814a.png', '使用我们的免费照片讲述您的故事！', 'https://55mm.co/visuals', 12, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100224, 150725316141101028, 'thestocks', '/profile/site/system/2be533b5b00139b9022f09604f3bd136.png', '使用我们的免费照片讲述您的故事！', 'http://thestocks.im/', 13, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100225, 150725316141101028, 'freenaturestock', '/profile/site/system/85c87259ac26b4f48b084066b9e3ec8e.png', '面向设计师和开发人员的独家令人兴奋的免费赠品。', 'http://freenaturestock.com/', 14, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100226, 150725316141101028, 'negativespace', '/profile/site/system/9b470b26c5e7e6604f3f17d2fe518af7.png', '美丽，高分辨率免费图片素材。', 'https://negativespace.co/', 15, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100227, 150725316141101028, 'gratisography', '/profile/site/system/37a9bff7f4d756e7b227ef295aa5ff82.png', '免费的高分辨率图片，可用于您的个人和商业项目，不受版权限制。', 'https://gratisography.com/', 16, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100228, 150725316141101028, 'imcreator', '/profile/site/system/568ae371ba49ce83463d5833af6a8e88.png', '精选的免费网页设计资源集合，全部用于商业用途。', 'http://imcreator.com/free', 17, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100229, 150725316141101028, 'lifeofpix', '/profile/site/system/94bf5d51c1367552f337610dbc6aa44b.png', '免费高分辨率摄影', 'http://www.lifeofpix.com/', 18, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100230, 150725316141101028, 'skitterphoto', '/profile/site/system/23663c43cb7025f3bf36e9733bea6171.png', '创意专业人士的免费图片素材', 'https://skitterphoto.com/', 19, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100231, 150725316141101028, 'mmtstock', '/profile/site/system/d8d5768d2dc63763480478ae25aa176a.png', '免费商业照片', 'https://mmtstock.com/', 20, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100232, 150725316141101028, 'magdeleine', '/profile/site/system/12ca6edef00d1d897eb28c4a8e2f8915.png', '精选免费照片供您启发', 'https://magdeleine.co/browse/', 21, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100233, 150725316141101028, 'jeshoots', '/profile/site/system/a016e8d2ae3ee88f0ec136440e92fca8.png', '新的免费照片和样机进入您的收件箱！', 'http://jeshoots.com/', 22, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100234, 150725316141101028, 'hdwallpapers', '/profile/site/system/74db036ddf1bbfc49a22a5a6dcd392ab.png', '高清壁纸和桌面背景', 'https://www.hdwallpapers.net', 23, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100235, 150725316141101028, 'publicdomainarchive', '/profile/site/system/3c7427a4bab6bb40c12a77014f809a2a.png', '新的100％免费图片。 每一个 单。 周。', 'http://publicdomainarchive.com/', 24, 0, '2020-08-01 15:42:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100236, 150725316141101029, 'OfficePLUS', '/profile/site/system/4773ef0cfcf8c9fd158fc7db0bc2cf0b.png', 'OfficePLUS，微软Office官方在线模板网站！', 'http://www.officeplus.cn/Template/Home.shtml', 1, 0, '2020-08-01 15:43:15', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100237, 150725316141101029, '优品PPT', '/profile/site/system/b1d803179735ea628d1d914c63c0b9f7.png', '高质量的模版，而且还有PPT图表，PPT背景图等资源', 'http://www.ypppt.com/', 2, 0, '2020-08-01 15:43:15', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100239, 150725316141101029, 'PPTMind', '/profile/site/system/857bb0f6927c2a8c246653cb41136ce7.png', '分享高端ppt模板与keynote模板的数字作品交易平台', 'http://www.pptmind.com/', 4, 0, '2020-08-01 15:43:15', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100240, 150725316141101029, 'tretars', '/profile/site/system/14a77db5ab4af0ba947b1e1707295c5d.png', '网上最好的免费模型', 'http://www.tretars.com/ppt-templates', 5, 0, '2020-08-01 15:43:15', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100241, 150725316141101029, '5百丁', '/profile/site/system/3f735ae4b6e18cd6cff3965661289aac.png', '中国领先的PPT模板共享平台', 'http://ppt.500d.me/', 6, 0, '2020-08-01 15:43:15', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100276, 150725316141101004, 'PDF Candy', '/profile/site/system/0b897cff5f1f2d98efd8dc7ea69b38ae.ico', '一个免费在线的PDF编辑网站。包含了几十种PDF小工具，可以Word与PDF互转、Excel表格与PDF互转、图片与PDF互转等各种实用功能。', 'https://pdfcandy.com/cn/', 2, 0, '2020-08-05 13:28:17', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100277, 150725316141101004, 'LightPDF', '/profile/site/system/6281eb27f1a6c6f07d56588e5e4849ae.png', '一个只需要一步，即可解决PDF所有问题的免费PDF工具!', 'https://lightpdf.com/zh/', 3, 0, '2020-08-05 13:30:31', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100278, 150725316141101004, 'SmallPDF', '/profile/site/system/341475474199e2cf28ce10308fcad860.png', '轻松玩转PDF，功能一应俱全、简单好用的线上 PDF 工具', 'https://smallpdf.com/cn', 4, 0, '2020-08-05 13:31:49', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100279, 150725316141101004, 'HiPDF', '/profile/site/system/3cac096ab252280f24a70ca5550a0287.ico', '一站式在线PDF解决方案的网站。', 'https://www.hipdf.cn/', 5, 0, '2020-08-05 13:33:37', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100280, 150725316141101004, 'iLovePDF', '/profile/site/system/cc239ae8c064a5bbb65318fb40e02cdf.png', '完全免费、易于使用、丰富的PDF处理工具，包括：合并、拆分、压缩、转换、旋转和解锁PDF文件，以及给PDF文件添加水印的工具等。仅需几秒钟即可完成。', 'https://www.ilovepdf.com/zh-cn', 6, 0, '2020-08-05 13:35:10', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100281, 150725316141101007, 'CSDN', '/profile/site/system/0b91790e27fe8cd3941fc6e6ee57ee4a.jpg', '专业开发者社区', 'https://www.csdn.net/', 2, 0, '2020-08-08 15:12:00', '2020-08-08 15:20:24', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100282, 150725316141101007, '博客园', '/profile/site/system/2ec8affefca78704574f1ba17fe070f2.png', '开发者的网上家园', 'https://www.cnblogs.com/', 1, 0, '2020-08-08 15:13:36', '2020-08-08 15:20:20', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100283, 150725316141101007, '思否', '/profile/site/system/570d66cff03484e48b05d6f02db9dfe4.ico', ' 在 SegmentFault，学习技能、解决问题。', 'https://segmentfault.com/', 4, 0, '2020-08-08 15:16:50', '2020-08-08 15:20:39', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100284, 150725316141101007, '掘金', '/profile/site/system/dcc82ea8e38e1bd994cabb18b8eb4e32.ico', '一个帮助开发者成长的社区。', 'https://juejin.im/', 3, 0, '2020-08-08 15:18:11', '2020-08-08 15:20:35', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100285, 150725316141101031, 'Vue', '/profile/site/system/5ebfa247ff3e3cbcb1ada1c5a9b2506b.png', '渐进式 JavaScript 框架。', 'https://cn.vuejs.org/', 1, 0, '2020-08-08 15:21:55', '2020-08-08 15:23:40', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100286, 150725316141101031, 'React', '/profile/site/system/9e76a67ae80210b18e4db37b45a2574a.ico', '用于构建用户界面的 JavaScript 库。', 'https://react.docschina.org/', 5, 0, '2020-08-08 15:23:35', '2022-06-11 17:30:58', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100287, 150725316141101031, 'Angular', '/profile/site/system/ed0f155ed1b6acc4e6f307543883aa7e.ico', '一套框架，多种平台 移动端 &amp; 桌面端。', 'https://angular.cn/', 6, 0, '2020-08-08 15:25:11', '2022-06-11 17:31:14', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100289, 150725316141101031, 'Element', '/profile/site/system/d636a118f9f69184a730ffa3082fdb80.ico', '一套为开发者、设计师和产品经理准备的基于 Vue 2.0 的桌面端组件库', 'https://element.eleme.cn/', 2, 0, '2020-08-08 15:30:27', '2022-06-11 17:30:38', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100290, 150725316141101031, 'vue-element-admin', '/profile/site/system/d91882f77429ded326a30bda549c329d.png', '一个后台前端解决方案，它基于 vue 和 element-ui 实现。', 'https://panjiachen.gitee.io/vue-element-admin-site/zh/', 4, 0, '2020-08-08 15:32:01', '2022-06-11 17:31:05', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100291, 150725316141101007, '知乎', '/profile/site/system/02090c1f2ff7d580395b7dfe44ba066c.ico', '有问题，上知乎。知乎，可信赖的问答社区，以让每个人高效获得可信赖的解答为使命。', 'https://www.zhihu.com', 5, 0, '2020-08-08 15:34:36', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100292, 150725316141101030, 'Spring', '/profile/site/system/39caf5180b7d84ff2f277b25ca10f6ce.png', 'Spring 框架是一个开源的 Java 平台，它为容易而快速的开发出耐用的 Java 应用程序提供了全面的基础设施。', 'https://spring.io/', 1, 0, '2020-08-08 15:37:04', '2020-08-08 15:38:49', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100293, 150725316141101030, 'MyBatis-Plus', '/profile/site/system/4eb015ca9291887d648fc075f76303ac.png', '为简化开发而生。', 'https://mp.baomidou.com/', 2, 0, '2020-08-08 15:40:12', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100294, 150725316141101030, '力扣 LeetCode', '/profile/site/system/3b0dcb135f4c9a960b385170ce5f3946.png', '全球极客挚爱的技术成长平台。海量技术面试题库,拥有算法、数据结构、系统设计等 1000+题目,帮助你高效提升编程技能,轻松拿下世界 IT 名企 Dream Offer。', 'https://leetcode-cn.com/', 3, 0, '2020-08-08 15:44:12', '2021-01-15 10:49:27', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100295, 150725316141101004, 'Convertio 文件转换器', '/profile/site/system/b5d554962ba1cc493607a32f5328787d.png', '超级强大的文件格式转化器，视频、图片、字体、音频通通都可以。', 'https://convertio.co/zh/', 7, 0, '2020-08-09 13:01:13', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100296, 150725316141101007, '菜鸟教程', '/profile/site/system/b66656c08273c4761073eab6ae59b1ca.ico', '学的不仅是技术，更是梦想！', 'https://www.runoob.com/', 6, 0, '2020-08-09 13:08:03', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100297, 150725316141101031, 'Bootstrap', '/profile/site/system/5285612ea8533aa78c30bfa382171077.ico', '简洁、直观、强悍的前端开发框架，让web开发更迅速、简单。', 'https://www.bootcss.com/', 6, 0, '2020-08-09 13:09:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100298, 150725316141101007, 'W3School', '/profile/site/system/4d2b466766140ef66ab6e4e92f73383d.png', '在 W3School，你可以找到你所需要的所有的网站建设教程。', 'https://www.w3school.com.cn/', 7, 0, '2020-08-09 13:14:17', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100299, 150725316141101032, '五分钟学算法', '/profile/site/system/4356bd8feb9ae4b14a75fa81b79a6d2a.png', '一个不错的算法网站！', 'https://www.cxyxiaowu.com/', 6, 0, '2020-08-09 13:15:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100300, 150725316141101001, '凌风云搜索', '/profile/site/system/ed2c1e745ad694bbe206dd93c0ff8ea1.jpg', '专注于互联网免费资源的大数据搜索，网盘搜索，云盘资源等', 'https://www.lingfengyun.com/', 9, 0, '2020-08-09 21:53:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100303, 150725316141101001, '罗马盘', '/profile/site/system/69d01f6bbf50666a7f5bb36c8e59fcbc.ico', '百度网盘搜索引擎 自动更新网络共享资源', 'https://www.luomapan.com/', 11, 0, '2020-08-09 22:03:54', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100304, 150725316141101001, 'bdyso', '/profile/site/system/b6494b1345e86d25a090af4e96e084b2.ico', '百度网盘资源搜索与分享', 'http://www.bdyso.com/', 12, 0, '2020-08-09 22:05:30', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100306, 150725316141101035, '微信公众号', '/profile/site/system/eb7f53364e44272c8a2ec83d0e83df43.png', '再小的个体，也有自己的品牌。', 'https://mp.weixin.qq.com/', 1, 0, '2020-08-11 17:47:03', '2020-08-11 17:52:22', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100307, 150725316141101035, '头条号', '/profile/site/system/0db580c9e8afe1e543c120a8e026be05.png', '今日头条推出的开放的内容创作与分发平台。', 'https://mp.toutiao.com', 2, 0, '2020-08-11 17:49:28', '2020-08-11 17:51:26', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100308, 150725316141101035, '知乎', '/profile/site/system/02090c1f2ff7d580395b7dfe44ba066c.ico', '有问题，上知乎。知乎，可信赖的问答社区，以让每个人高效获得可信赖的解答为使命。', 'https://www.zhihu.com', 5, 0, '2020-08-11 19:58:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100309, 150725316141101035, 'CSDN', '/profile/site/system/eb7c0916-0c5f-4aad-ba1e-6eb7a076ce41.ico', '专业开发者社区', 'https://www.csdn.net/', 6, 0, '2020-08-08 15:12:00', '2021-01-13 15:37:46', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100310, 150725316141101035, '博客园', '/profile/site/system/2ec8affefca78704574f1ba17fe070f2.png', '开发者的网上家园', 'https://www.cnblogs.com/', 7, 0, '2020-08-08 15:13:36', '2020-08-08 15:20:20', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100311, 150725316141101035, '思否', '/profile/site/system/570d66cff03484e48b05d6f02db9dfe4.ico', ' 在 SegmentFault，学习技能、解决问题。', 'https://segmentfault.com/', 8, 0, '2020-08-08 15:16:50', '2020-08-08 15:20:39', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100312, 150725316141101035, '掘金', '/profile/site/system/dcc82ea8e38e1bd994cabb18b8eb4e32.ico', '一个帮助开发者成长的社区。', 'https://juejin.im/', 9, 0, '2020-08-08 15:18:11', '2020-08-08 15:20:35', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100313, 150725316141101035, '企鹅号', '/profile/site/system/7c7b65475eddc144e90e6e9e059b75a7.png', '让世界看到你', 'https://om.qq.com/', 4, 0, '2020-08-11 20:03:20', '2020-08-11 20:07:10', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100314, 150725316141101035, '微博号', '/profile/site/system/0457b6128c225591f7b04dd23eaf4445.ico', '为创作者提供更优质的创作环境，帮助原创作者打造专属的个人品牌。', 'https://me.weibo.com/', 4, 0, '2020-08-11 20:05:49', '2020-08-11 20:06:30', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100315, 150725316141101035, '简书', '/profile/site/system/f8e210bc-a44e-49ad-a177-c9a8e2dcc409.ico', '一个优质的创作社区，在这里，你可以任性地创作。', 'https://www.jianshu.com/', 10, 0, '2020-08-11 20:08:35', '2021-01-13 15:37:33', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100316, 150725316141101035, '百家号', '/profile/site/system/ebb9886c7983ded7a1867941643de37f.png', '从这里影响世界。', 'https://baijiahao.baidu.com/', 4, 0, '2020-08-11 20:11:07', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100317, 150725316141101036, 'Unsplash', '/profile/site/system/09b7b39944a6893fbffa2842c0951468.png', '美丽的免费图片图片', 'https://unsplash.com/', 2, 0, '2020-08-11 20:15:40', '2021-04-22 21:36:24', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100318, 150725316141101036, 'Pexels', '/profile/site/system/5116557ff603b6d0cc4ba5270588684e.png', '免费图片', 'https://www.pexels.com/', 2, 0, '2020-08-11 20:17:44', '2020-08-11 20:23:35', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100319, 150725316141101036, 'UnDraw', '/profile/site/system/fb631125f144e2a6fe14120c2f4bd53f.png', '带有开源插图的设计项目，可满足您可以想象和创建的任何想法。', 'https://undraw.co/illustrations', 3, 0, '2020-08-11 20:25:06', '2021-03-27 12:49:55', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100320, 150725316141101036, 'Pixabay', '/profile/site/system/3846a4474d17612128f18f51f3487fd9.png', '我们的才华横溢的社区分享了超过210万张免版税的图片。', 'https://pixabay.com', 4, 0, '2020-08-11 20:28:06', '2021-03-15 23:35:03', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100321, 150725316141101036, 'Iconfinder', '/profile/site/system/e3325f68179436ccfc25b9f0ffff5a39.png', '2,100,000+个免费和高级矢量图标。', 'https://www.iconfinder.com', 5, 0, '2020-08-01 14:58:10', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100322, 150725316141101036, 'iconfont', '/profile/site/system/e1f63337915f79f8bcad1952adb9f6e1.png', '阿里巴巴矢量图标库。', 'http://www.iconfont.cn/', 6, 0, '2020-08-01 14:58:10', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100323, 150725316141101036, 'iconmonstr', '/profile/site/system/afd4885651455f12dcac4f214460dd99.png', '您的下一个项目的免费简单图标。', 'https://iconmonstr.com/', 7, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100324, 150725316141101036, 'FindIcons', '/profile/site/system/0171a46b0f643752aa90aa314a22a546.png', '搜索300,000个免费图标。', 'https://findicons.com/', 8, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100325, 150725316141101036, 'Icon Archive', '/profile/site/system/40c43a8932f24370cf456789b2ab51db.png', '搜索590,912个免费图标。', 'http://www.iconarchive.com/', 9, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100326, 150725316141101036, 'IcoMoonApp', '/profile/site/system/d19c97ead3760f1b70efa4ee9ad6859c.png', '图标字体，SVG，PDF, PNG生成器。', 'https://icomoon.io/app/', 10, 0, '2020-08-01 14:58:11', '2020-08-11 20:36:42', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100327, 150725316141101036, 'easyicon', '/profile/site/system/34b4382075e047c6d1456f8fe591a1ef.png', 'PNG、ICO、ICNS格式图标搜索、图标下载服务。', 'http://www.easyicon.net/', 11, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100328, 150725316141101036, 'flaticon', '/profile/site/system/582cf7361a0b4f444628c68b98e5cfc7.png', '634,000+免费矢量图标为SVG，PSD，PNG，EPS格式或图标字体。', 'https://www.flaticon.com/', 12, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100329, 150725316141101036, 'UICloud', '/profile/site/system/f9840e127d500449da1c5c721f3634c3.png', '世界上最大的用户界面设计数据库。', 'http://ui-cloud.com/', 13, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100330, 150725316141101036, 'Font Awesome Icon', '/profile/site/system/88440b8b0d5dc43a3f766670e2d11746.png', '惊人的675个图标的完整集合。', 'https://fontawesome.com/', 14, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100331, 150725316141101036, 'ion icons', '/profile/site/system/6d0fd0bf35549f6d61037bd86e2ca242.png', 'Ionic Framework的高级图标字体。', 'http://ionicons.com/', 15, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100332, 150725316141101036, 'Simpleline Icons', '/profile/site/system/acf446f1af754f863260cc10dd8d546e.png', '简单的线条图标包。', 'http://simplelineicons.com/', 16, 0, '2020-08-01 14:58:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100334, 150725316141101032, 'Java知音', '/profile/site/system/bbe364f9-0c94-4f88-a4ad-2b590064d624.jpeg', '一个专注于Java技术分享的网站', 'https://www.javazhiyin.com/', 7, 0, '2020-08-18 21:50:19', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100335, 150725316141101010, 'MacWk', '/profile/site/system/17a92b31-c9da-4dee-a04c-4ecf9cd92933.jpeg', '无广告，无后门，安全！', 'https://macwk.com/', 3, 0, '2020-08-18 21:54:00', '2020-08-18 21:54:34', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100340, 150725316141101002, '知轩藏书', '/profile/site/system/2e3e22f2-cd93-45b3-8278-604c483ed70e.jpeg', '玄幻小说排行榜精校-校对全本TXT小说下载网', 'http://zxcs.info/', 20, 0, '2020-08-19 00:20:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100341, 150725316141101037, 'WallHaven', '/profile/site/system/ff5238ff-e030-4f55-a6fb-ba49fd772ea8.jpeg', '种类多，壁纸好看！', 'https://wallhaven.cc/', 1, 0, '2020-08-19 19:42:33', '2020-09-20 20:28:40', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100342, 150725316141101037, 'Wallls', '/profile/site/system/3267d11e-db69-4dde-80fb-e3fef5d7ae6f.jpeg', '您从未见过的壁纸。', 'http://wallls.com/', 2, 0, '2020-08-19 19:44:48', '2020-09-20 20:28:47', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100344, 150725316141101037, 'SimpleDesktops', '/profile/site/system/1687352f-29f4-4eea-a61e-a0eeded626f1.jpeg', '简单', 'http://simpledesktops.com/', 4, 0, '2020-08-19 19:52:00', '2020-09-20 20:29:03', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100345, 150725316141101037, '彼岸桌面', '/profile/site/system/bd5b21c3-3bf1-47cc-b25f-36b4aa38180d.jpeg', '美丽精致的壁纸，免费提供风景、日历、美女、动漫、汽车、花卉、节日、动物、游戏、qq、阿狸等唯美、可爱、好看的壁纸，下载您所需要的壁纸', 'http://www.netbian.com/', 1, 0, '2020-08-19 19:57:41', '2020-12-03 13:37:09', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100346, 150725316141101001, '猪猪盘', '/profile/site/system/04e0b7e4-2569-49bf-8629-b7a503dd8fe2.png', '索引1亿+网盘资源', 'http://www.zhuzhupan.com/', 15, 0, '2020-08-19 20:13:29', '2020-09-20 20:25:48', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100348, 150725316141101001, '小白盘', '/profile/site/system/f04b12a5-3a1d-4af2-9672-08a0e5458bf2.jpeg', '网盘搜索', 'https://www.xiaobaipan.com/', 17, 0, '2020-08-19 20:16:51', '2020-08-19 20:18:03', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100352, 150725316141101004, '快用工具', '/profile/site/system/c5a1b819-a2ac-40a5-8aba-4b2204b8e115.jpeg', '提供各种优质、快捷、易用的在线工具，无需下载安装即可使用。', 'https://fastools.cn/', 1, 0, '2020-08-20 10:43:46', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100353, 150725316141101037, '极简壁纸', '/profile/site/system/7dcc6100-d451-4d78-915e-ea68c166d5cd.jpeg', '超高清电脑桌面壁纸美图；每天更新海量 4K 电脑壁纸，9012年最潮的壁纸网站，壁纸包括美女、二次元、自然风景。', 'https://bz.zzzmh.cn/', 1, 0, '2020-08-20 10:50:21', '2020-12-03 13:37:05', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100354, 150725316141101039, '135编辑器', '/profile/site/system/37ddd142-39c9-447c-b116-06f2e25878a0.jpeg', '提供丰富的样式库，支持插入排版、秒刷排版、一键排版等。', 'http://www.135editor.com/', 1, 0, '2020-08-20 11:05:19', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100355, 150725316141101039, '秀米', '/profile/site/system/db7eb18d-abdc-4979-bad3-2df745827332.jpeg', '素材顺应时下的审美，质量高，以布局的概念来进行不同组件的排版。', 'https://xiumi.us', 2, 0, '2020-08-20 11:12:34', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100356, 150725316141101039, '96微信编辑器', '/profile/site/system/849bb7d5-0616-478a-bada-40c3ad70a35f.jpeg', '大量精选素材、可以制作动态二维码、超多色值推荐、表情符号等。', 'https://bj.96weixin.com/', 3, 0, '2020-08-20 11:13:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100357, 150725316141101039, 'i排版', '/profile/site/system/1f8b4cd3-f277-42e8-b84e-2236c1a5aa82.ico', '偏清新文艺风，编辑界面较干净，容易上手，支持各种文本格式样式。', 'http://ipaiban.com/', 4, 0, '2020-08-20 11:18:13', '2021-01-13 15:40:07', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100358, 150725316141101039, '新榜编辑器', '/profile/site/system/61ed7aaf-2edd-4877-9d2a-4635a22b49e1.jpeg', '海量在线图片搜索、一键同步多平台，大量爆文可供参考。', 'https://edit.newrank.cn/', 5, 0, '2020-08-20 11:19:12', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100359, 150725316141101039, 'Markdown Nice', '/profile/site/system/a4db5eb7-7b52-4278-8a03-d147c817e494.jpeg', '一款在线，支持自定义样式的微信 Markdown 排版工具；现支持微信公众号、知乎、开源中国、稀土掘金、博客园和 CSDN 等一系列平台。另外，支持变更不同主题风格、格式化（微信外链转脚注、中英文间带空格）等。', 'https://www.mdnice.com/', 0, 0, '2020-08-20 11:22:19', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100360, 150725316141101039, '壹伴', '/profile/site/system/2632d2f2-c7bc-4278-90c4-ae75221e167a.jpeg', '更好用的微信编辑器，但不止于此。你可以使用壹伴小插件来高效地排版、修图、找素材、回消息和导出数据，50万公众号运营者的共同选择', 'https://yiban.io/invitation?invite_code=YE1H00', 6, 0, '2020-08-22 10:29:29', '2021-02-24 22:32:42', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100361, 150725316141101036, '创客贴', '/profile/site/system/3808ba9d-c655-42c9-b56f-cbdc04169be2.jpeg', '提供了15万+精品设计模板，120万+图片素材，涵盖营销海报、新媒体配图、印刷物料、PPT、简历等办公文档、电商设计、定制设计等百余种设计场景，选择喜爱的模板，AI智能生成设计，设计不求人。', 'https://www.chuangkit.com/', 1, 0, '2020-08-22 10:33:27', '2021-04-22 21:36:17', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100362, 150725316141101036, '懒设计', '/profile/site/system/bb76267f-1f2f-47c5-8c63-b4c136d58386.jpeg', '全球最受欢迎的平面设计工具和在线平面设计软件之一,提供海量海报、邀请函、贺卡、banner、logo、名片等免费设计素材和模板,可在线一键稿定设计印刷', 'https://www.fotor.com.cn/', 1, 0, '2020-08-22 10:39:01', '2021-04-22 21:36:12', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100363, 150725316141101011, '磁力熊', '/profile/site/system/75babf0b-ac99-4b61-8de0-b500f06398ff.jpeg', '1080P高清电影磁力迅雷下载,豆瓣Top250及豆瓣高分电影1080P高清磁力下载。', 'https://www.cilixiong.com/', 7, 0, '2020-08-22 18:25:13', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100366, 150725316141101011, '神马影院', '/profile/site/system/8ecdec9c-7802-4007-a30c-078fa7977a27.jpeg', '资源丰富，播放流畅缓冲快！', 'https://www.shenma4480.com/', 10, 0, '2020-08-22 18:29:46', '2020-08-22 18:37:47', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100367, 150725316141101011, '哔嘀影视', '/profile/site/system/f32be96e-14c9-41cb-9217-ea8a28948c65.jpeg', '在线观看，支持百度云，电驴，磁力链接下载', 'https://bde4.com/', 11, 0, '2020-08-22 18:31:14', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100368, 150725316141101011, 'NO视频', '/profile/site/system/bf08096d-7cb2-45e2-a00c-3efe03f0e84b.jpeg', '欧美、日韩、港台影视', 'https://www.novipnoad.com/', 12, 0, '2020-08-22 18:32:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100371, 150725316141101011, '南柯电影', '/profile/site/system/1687352f-29f4-4eea-a61e-a0eeded626f1.jpeg', '无广告，速度快！', 'https://www.nkdyw.com/', 15, 0, '2020-08-22 18:36:51', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100376, 150725316141101012, 'MyFree MP3', '/profile/site/system/3267d11e-db69-4dde-80fb-e3fef5d7ae6f.jpeg', '支持音乐在线试听、下载，以及无损音质的下载！', 'http://tool.liumingye.cn/music/', 9, 0, '2020-08-22 18:46:10', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100378, 150725316141101031, 'Ant Design', '/profile/site/system/6df56693-ffd1-4470-b905-0986f1236deb.jpeg', '一套企业级 UI 设计语言和 React 组件库', 'https://ant.design/index-cn', 7, 0, '2020-08-24 21:44:54', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100379, 150725316141101030, 'knife4j', '/profile/site/system/c74470de-7f78-4894-a475-522fa6774170.jpeg', '为Java MVC框架集成Swagger生成Api文档的增强解决方案 ', 'https://doc.xiaominfo.com/', 4, 0, '2020-08-25 19:39:38', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100380, 150725316141101040, 'GitHub 加速下载', '/profile/site/system/github.png', '一个对于 GitHub.com 的镜像加速器。我们使用开放资源为 GitHub 加速。', 'http://toolwa.com/github/', 1, 0, '2020-08-31 22:52:30', '2020-09-25 08:42:27', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100381, 150725316141101040, '下载', '/profile/site/system/github.png', '不需要购买，直接下载！', 'https://d.serctl.com/', 2, 0, '2020-08-31 23:01:16', '2020-09-25 08:43:52', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100382, 150725316141101040, 'GitHub 文件加速', '/profile/site/system/github.png', '直接走本服务器 CN2 GIA 线路 . 大多数情况下体验更佳！', 'https://g.ioiox.com/', 3, 0, '2020-08-31 23:01:46', '2020-09-25 08:44:40', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100383, 150725316141101040, 'GitHub代下', '/profile/site/system/github.png', '代下服务，永久免费！', 'http://gitd.cc/', 4, 0, '2020-08-31 23:03:00', '2020-09-25 08:45:21', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100384, 150725316141101040, 'GitHub加速链接生成工具', '/profile/site/system/github.png', '利用ucloud提供的GlobalSSH功能，对ssh协议数据进行加速！', 'https://github.zhlh6.cn/', 5, 0, '2020-08-31 23:04:04', '2020-09-25 08:46:18', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100385, 150725316141101017, 'SQL转Java', '/profile/site/system/3804cbf8-bb0e-437f-890e-7db6f6f778e0.jpeg', 'SQL转Java JPA、MYBATIS实现类代码生成平台。', 'https://java.bejson.com/generator/', 9, 0, '2020-09-07 10:12:34', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100386, 150725316141101011, 'M3U8播放器', '/profile/site/system/8b13f949-cc19-4882-aa8c-f236fbc04b84.jpeg', '电影、美剧、韩剧、漫画的直链', 'https://www.m3u8play.com/', 20, 0, '2020-09-08 20:33:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100387, 150725316141101017, '免费在线语音转文字', '/profile/site/system/bb15ab1d-410b-4242-ab81-50c1b6f1a81b.jpeg', '语音转文字，做纪录或者文字稿等', 'https://beecut.cn/speech-to-text-online', 10, 0, '2020-09-09 15:50:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100388, 150725316141101037, 'Wallpaper', '/profile/site/system/f32be96e-14c9-41cb-9217-ea8a28948c65.jpeg', '设计，室内设计，建筑，时尚，艺术', 'https://wall.alphacoders.com/?lang=Chinese', 7, 0, '2020-09-09 23:40:13', '2020-12-11 09:07:39', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100389, 150725316141101035, '视频号助手', '/profile/site/system/wxshipinghao.ico', '微信视频号助手', 'https://channels.weixin.qq.com/', 11, 0, '2020-09-11 20:52:11', '2020-09-11 20:55:03', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100390, 150725316141101005, 'DeepL翻译', '/profile/site/system/1cba9c99-73ef-422f-87ef-2e541bf82d1b.png', '将一段文字翻译到尽可能的通顺和便于理解，甚至是俚语、方言、名言名句、古诗词等内容都可以几乎没有任何语病的翻译出来。', 'https://www.deepl.com/translator', 5, 0, '2020-09-12 15:58:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100391, 150725316141101002, '搬书匠', '/profile/site/system/a7e8a0e2-ffe5-417c-bddf-43921d07554b.png', '编程书籍的好网站', 'http://www.banshujiang.cn/', 21, 0, '2020-09-13 14:43:50', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100392, 150725316141101035, '网易见外', '/profile/site/system/c6348b72-41e6-4237-9122-33b4c52cdf3e.png', '由人工智能事业部研发,是一个集视频听翻、直播听翻、语音转写、文档直翻功能为一体的AI智能语音转写听翻平台。', 'https://jianwai.youdao.com/', 10, 0, '2020-09-15 00:24:00', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100394, 150725316141101042, '若依 / RuoYi-Vue', '/profile/site/system/35196237-8319-4204-a844-bc06b4409a39.png', '基于SpringBoot，Spring Security，JWT，Vue & Element 的前后端分离权限管理系统 ', 'https://gitee.com/y_project/RuoYi-Vue', 1, 0, '2020-09-16 14:39:29', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100395, 150725316141101042, '若依 / RuoYi-Cloud', '/profile/site/system/35196237-8319-4204-a844-bc06b4409a39.png', '基于Spring Boot、Spring Cloud & Alibaba、OAuth2的分布式微服务架构权限管理系统 ', 'https://gitee.com/y_project/RuoYi-Cloud', 2, 0, '2020-09-16 14:41:32', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100396, 150725316141101042, '陌溪 / 蘑菇博客', '/profile/site/system/3247f776-f5a8-452a-998a-ebf411948607.png', '一个基于微服务架构的前后端分离博客系统。', 'https://gitee.com/moxi159753/mogu_blog_v2', 3, 0, '2020-09-16 14:43:45', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100397, 150725316141101042, 'FEBS-Cloud', '/profile/site/system/35fcf5e6-8980-4b4d-9da4-564b3bd3f333.png', '基于Spring Cloud Hoxton.RELEASE、Spring Cloud OAuth2 & Spring Cloud Alibaba & Element 微服务权限系统，开箱即用。', 'https://github.com/febsteam/FEBS-Cloud', 4, 0, '2020-09-16 14:46:37', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100398, 150725316141101042, '慕容若冰 / spring-microservice-exam', '/profile/site/system/15afba18-f1c2-4313-b664-ba8943a333a4.png', '硕果云，基于Spring Cloud搭建的新一代微服务教学管理平台，提供多租户、权限管理、考试、练习等功能，题型支持单选题、多选题、不定项选择题、判断题、简答题，二维码分享，移动端答题等 ', 'https://gitee.com/wells2333/spring-microservice-exam', 5, 0, '2020-09-16 14:48:27', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100399, 150725316141101032, '蘑菇博客', '/profile/site/system/3247f776-f5a8-452a-998a-ebf411948607.png', '专注于技术分享的博客平台', 'http://www.moguit.cn', 8, 0, '2020-09-16 14:54:32', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100400, 150725316141101035, 'QQ公众平台', '/profile/site/system/7424959f-6ada-48f9-9077-a7e0477e6e3d.png', 'QQ公众平台，为解决个人，企业，组织在QQ平台上的业务服务与用户管理提供实用的服务工具平台。', 'https://mp.qq.com', 14, 0, '2020-09-18 09:52:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100401, 150725316141101035, '抖音短视频', '/profile/site/system/b5541655-6a6f-47b9-8698-9bab021fa846.ico', '抖音短视频，一个旨在帮助大众用户表达自我，记录美好生活的短视频分享平台。为用户创造丰富多样的玩法，让用户在生活中轻松快速产出优质短视频。', 'https://www.douyin.com/', 15, 0, '2020-09-18 09:54:01', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100402, 150725316141101017, 'GitMind', '/profile/site/system/d3799599-6413-4944-a6f4-241e5c54c51c.png', '免费在线思维导图软件，简化逻辑梳理，集思广益，释放创造力在线脑图、思维导图、流程图、工业设计、工程管理，一图涵千面 ', 'https://gitmind.cn/', 11, 0, '2020-09-20 14:33:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100403, 150725316141101004, 'DocSmall', '/profile/site/system/380cb37a-370d-40df-8807-5c318e5310f2.png', '免费在线图片压缩、GIF压缩工具、PDF压缩工具、PDF合并工具、PDF分割工具', 'https://docsmall.com/', 8, 0, '2020-09-20 14:36:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100404, 150725316141101017, 'Dimmy', '/profile/site/system/12d7985a-2fc7-49b7-b6e6-55312ac1c550.png', '手机电脑等设备的展示模型，可以让你的图片放在电脑、手机、ipad等模型中展示，图片档次大大提升。', 'https://dimmy.club/', 12, 0, '2020-09-20 14:38:10', '2020-09-20 14:42:26', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100405, 150725316141101017, 'BrowserFrame', '/profile/site/system/251a15a3-811e-4359-98e2-f03b3319240e.ico', '浏览器展示模型工具', 'http://browserframe.com/', 13, 0, '2020-09-20 14:39:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100406, 150725316141101017, 'Flourish', '/profile/site/system/3416f7ae-1e74-45ef-b03d-4dfa730f1105.png', ' 数据可视化工具，快速地把表格数据转换为各种各样好看的图表，并且还支持动态可视化。', 'https://flourish.studio/', 14, 0, '2020-09-20 14:41:21', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100407, 150725316141101017, 'RemoveBg', '/profile/site/system/b2377b53-291b-4129-bdbe-68cb3a1fa7c3.png', '抠图神器，消除图片中的背景。', 'https://www.remove.bg/zh', 15, 0, '2020-09-20 14:44:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100408, 150725316141101018, 'Crx4Chrome', '/profile/site/system/af48b33f-ab08-4e71-a4de-32af6b930860.ico', ' Chrome浏览器插件站', 'https://www.crx4chrome.com/', 7, 0, '2020-09-20 14:46:03', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100409, 150725316141101043, '易视网', '/profile/site/system/e393d0d3-5a07-4c3a-a648-b5fa63b55fea.ico', '直播网络电视直播在线观看', 'https://www.cietv.com/', 1, 0, '2020-09-20 14:55:21', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100410, 150725316141101043, '好趣网', '/profile/site/system/f6ce09df-432f-4903-b308-99f65ab9504b.png', '2000套高清网络电视直播在线观看', 'http://tv.haoqu99.com/', 2, 0, '2020-09-20 14:56:41', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100411, 150725316141101042, 'EasyCaptcha', '/profile/site/system/c85348a4-7b34-488c-bd95-8b7b106f793d.png', 'Java图形验证码，支持gif、中文、算术等类型，可用于Java Web、JavaSE等项目。', 'https://gitee.com/ele-admin/EasyCaptcha', 6, 0, '2020-09-20 15:59:37', '2022-05-25 23:25:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100412, 150725316141101017, '短视频解析', '/profile/site/system/b0ffc6e6-6b42-4f5a-a221-44d9ff2c3ee7.png', '支持解析快手、抖音、Youtube、Tiktok、火山、今日头条、西瓜视频、皮皮虾、小咖秀、趣多拍、微视、美拍、秒拍、网易云、TikTok、哔哩哔哩、陌陌、映客、迅雷、阳光宽频、全民 K 歌、刷宝、WIDE 短视频、小红书、等平台的视频，而且解析出来的网站视频没有水印。', 'http://www.dspjx.com/', 16, 0, '2020-09-23 23:57:07', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100413, 150725316141101008, '微 PE 工具箱', '/profile/site/system/93975589-a3c2-4540-9893-69a0149d6435.png', '微 PE 工具箱 就是一款常用的 Windows PE 工具包，支持 Windows 10，提供了 32/64 位版本，并且支持 NVME 硬盘。', 'http://www.wepe.com.cn/', 8, 0, '2020-09-23 23:59:35', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100414, 150725316141101017, 'GeoGebra', '/profile/site/system/68292c53-cd3e-4a4a-9a4e-7d67359fb1e6.png', '一款结合几何、代数与微积分的免费动态数学软件，也支持在线直接绘图 /计算。', 'https://www.geogebra.org', 17, 0, '2020-09-24 00:01:36', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100416, 150725316141101017, 'Maven 仓库', '/profile/site/system/4242630d-0216-4950-9646-d3ee647ba8e3.png', 'Jar 下载，Jar 依赖引用', 'https://mvnrepository.com/', 19, 0, '2020-09-24 08:41:01', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100418, 150725316141101004, '萝卜工坊', '/profile/site/system/a970e871-9f79-4caa-a09e-df2fb7c9ddc2.png', '快速转换模拟手写字体文档，让打印出的字看起来像手写的 一个软件在线解决文字抄写烦恼', 'http://www.beautifulcarrot.com/', 9, 0, '2020-09-24 08:52:18', '2020-09-24 08:53:58', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100419, 150725316141101004, '二维码解码器', '/profile/site/system/989df62a-e0e5-468f-8fc7-f4b766d27ddd.png', '在线二维码解析和生成', 'https://jiema.wwei.cn/', 10, 0, '2020-09-24 08:57:01', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100420, 150725316141101004, 'PickFrom', '/profile/site/system/12736188-5677-410f-a628-1bab12ab00d9.ico', '一站式视频剪辑平台，让工作更简单。', 'https://zh.pickfrom.net/', 11, 0, '2020-09-24 08:59:06', '2020-09-24 08:59:32', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100421, 150725316141101004, '转字体', '/profile/site/system/89d9be4b-cb72-45ac-a30d-def2c1e30e1c.ico', '简体字繁体字互转', 'https://www.aies.cn/', 12, 0, '2020-09-24 09:02:38', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100422, 150725316141101040, 'GitHub 文件加速', '/profile/site/system/github.png', '利用 Cloudflare Workers 对 github release 、archive 以及项目文件进行加速，部署无需服务器且自带CDN。', 'https://gh.api.99988866.xyz/', 6, 0, '2020-09-25 08:41:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100427, 150725316141101037, '美桌网', '/profile/site/system/7510faa4-8159-49be-ae55-02629202fbe3.ico', '陪你下载生活的美！', 'http://www.win4000.com/', 8, 0, '2020-09-29 14:43:48', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100428, 150725316141101037, '回车桌面', '/profile/site/system/d40daccb-e4d7-4f34-a909-0341e49cd238.ico', '动画、漫画、卡通、锁屏图片、高清手机壁纸！', 'https://www.enterdesk.com/', 9, 0, '2020-09-29 14:45:43', '2020-09-29 14:47:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100429, 150725316141101037, '全面屏壁纸', '/profile/site/system/1ab3ecc5-ebc6-474a-814e-fa57b3781edb.ico', '专为全面屏和刘海屏手机适配的2K超高清壁纸网站！', 'http://m.bcoderss.com/', 10, 0, '2020-09-29 14:48:48', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100430, 150725316141101011, '无限影视网', '/profile/site/system/2c0a0e63-e07a-4344-aa11-e461e9616fee.png', '百万影片任你搜索！', 'https://www.wxtv.net/', 21, 0, '2020-09-30 14:36:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100432, 150725316141101008, '不忘初心', '/profile/site/system/9b57a3c2-adc0-4dc9-a3d4-8d573be1fce0.png', '精简版系统官网。从心出发，专注精简系统！', 'https://www.pc521.net/', 10, 0, '2020-10-09 16:56:49', '2021-01-27 10:09:41', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100433, 150725316141101036, '免费版权图片', '/profile/site/system/19e0d9d2-cf36-4046-a2d3-80a028b789a3.jpg', '一键搜索多家免版权图库，再也不用担心商用图片侵权了 ！', 'https://www.logosc.cn/so/', 17, 0, '2020-10-09 17:25:56', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100434, 150725316141101036, 'ColorHub', '/profile/site/system/a51c8e1f-bc7b-4b91-8fcb-9511cc234682.png', '高清无版权图片，个人和商业用途免费！', 'https://colorhub.me/', 18, 0, '2020-10-09 17:28:50', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100435, 150725316141101036, 'Hippopx', '/profile/site/system/c44b31d2-6a73-4879-84da-6a2e909d8a8f.ico', '基于CC0协议的免版权图库！', 'https://www.hippopx.com/zh/', 19, 0, '2020-10-09 17:30:41', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100436, 150725316141101036, 'FreePik', '/profile/site/system/45c6ebba-1fa4-4728-8210-9f9218ecc6cd.jpg', '查找免费矢量，图库照片，PSD和图标！', 'https://www.freepik.com/', 20, 0, '2020-10-09 17:34:34', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100438, 150725316141101011, '云播TV', '/profile/site/system/e7d75bda-6468-48f9-9dee-84a7b304b420.png', '一个单纯不做作的电影站！', 'https://www.yunbtv.net/', 24, 0, '2020-10-09 23:47:22', '2022-05-07 23:30:12', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100440, 150725316141101011, '音范丝', '/profile/site/system/e8eb094d-efb6-40b9-886e-3ab03871950d.ico', '高清无水印，影音集、精选4K蓝光原盘下载，顶级收藏！', 'http://www.yinfans.me/', 26, 0, '2020-10-12 14:14:54', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100441, 150725316141101011, '腾讯视频WeTV', '/profile/site/system/fe2b466d9fe6bed552c0adcaac1c2813.ico', '腾讯视频海外版，无广告，而且可以免费观看1080P！', 'https://wetv.vip/zh-cn', 4, 0, '2020-10-12 20:45:11', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100442, 150725316141101017, '千千秀字', '/profile/site/system/fbdf9a0d-88d9-4fcc-88cc-c63a49ea1eab.png', '提供文字翻译、字体转换、字效生成等在线服务的同时，也关注着文字的历史和文字的各行应用。', 'https://www.qqxiuzi.cn/', 20, 0, '2020-10-12 23:10:47', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100443, 150725316141101002, '搜韵', '/profile/site/system/6b06e347-bfe9-4230-92e4-d4caba9b6747.png', '诗词门户网站，可检索，分经史子集和四库之外等，图像清晰，速度快，非常便捷', 'https://sou-yun.cn/', 22, 0, '2020-10-16 19:08:14', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100445, 150725316141101046, '老殁', '/profile/site/system/22a74e7f-c58c-4914-86d6-4f557f572df9.png', '免费推荐优秀软件', 'https://www.mpyit.com', 1, 0, '2020-10-16 21:43:27', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100446, 150725316141101046, '果核剥壳', '/profile/site/system/1796f330-4e4f-49e6-819b-9810fca40735.png', '还原软件的本质，纯净软件分享，守住互联网最后的一片净土', 'https://www.ghpym.com', 5, 0, '2020-10-16 21:49:17', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100447, 150725316141101046, '423Down', '/profile/site/system/e005555a-a43c-423a-b74d-375b3867e442.ico', '有品质的电脑软件、Android软件分享博客', 'https://www.423down.com', 6, 0, '2020-10-16 21:51:13', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100448, 150725316141101046, '心海e站', '/profile/site/system/69c513c7-6150-4f58-bbf6-f866718b9238.jpg', '发布由烈火汉化的一些实用的软件，全部免费，杜绝广告！', 'https://hrtsea.com', 7, 0, '2020-10-16 21:53:50', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100449, 150725316141101046, '落尘之木', '/profile/site/system/292ba100-2d1a-4f63-acde-9c0f2c02bfe1.png', '分享互联网优秀软件、电脑经验、技术交流、IT类', 'https://www.luochenzhimu.com', 8, 0, '2020-10-16 21:55:28', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100450, 150725316141101046, '易破解', '/profile/site/system/ef2b424c-cd7a-43fd-95dd-b6093cdf8854.ico', '给你所需要的内容', 'https://www.ypojie.com', 9, 0, '2020-10-16 21:56:42', '2021-01-13 15:34:19', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100451, 150725316141101046, 'QQ前线乐园', '/profile/site/system/1cef9d6a-2f6d-42a3-b133-a59ccea947eb.png', '专注于分享，分享好资源。', 'https://www.yijingying.com', 10, 0, '2020-10-16 21:58:21', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100452, 150725316141101046, '风刑软件站', '/profile/site/system/17597510-396f-41a5-abf2-41c847c0fa62.png', '一个满载优秀、严谨、开放的软件下载平台', 'https://www.wsf1234.com', 11, 0, '2020-10-16 22:01:28', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100453, 150725316141101046, '软件缘', '/profile/site/system/172e5128-b12a-45b9-8de2-cbf906d53164.png', '软件缘 - 精品绿软，品鉴独特', 'https://www.appcgn.com', 12, 0, '2020-10-16 22:03:19', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100454, 150725316141101010, 'XClient', '/profile/site/system/12f29237-4138-4c75-815e-58e660c4a8c0.ico', '精品MAC应用分享', 'https://xclient.info', 4, 0, '2020-10-16 22:05:32', '2021-01-13 15:35:24', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100455, 150725316141101046, '孤独求软', '/profile/site/system/41f3a0c6-f433-45db-8a55-4c8a00b28e8a.ico', '常用软件一站齐全', 'http://www.dugubest.com', 13, 0, '2020-10-16 22:06:56', '2021-01-13 15:34:39', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100456, 150725316141101010, '史蒂芬周的博客', '/profile/site/system/8b57d624-b4e1-48e3-8307-0c10b393ccb9.ico', '软硬兼施，娱乐共享。', 'http://www.sdifen.com', 5, 0, '2020-10-16 22:08:45', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100457, 150725316141101010, '苹果软件盒子', '/profile/site/system/2799a66d-646d-445f-87b8-b7335826b812.png', '分享优质 Mac', 'https://www.macappbox.com', 6, 0, '2020-10-16 22:10:15', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100458, 150725316141101046, 'Extfans 扩展迷', '/profile/site/system/bc0605a7-3a50-4840-b37e-d1ac8386ae84.ico', '好用的浏览器插件推荐', 'https://www.extfans.com', 14, 0, '2020-10-16 22:57:50', '2021-01-13 15:34:45', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100459, 150725316141101047, 'Golink加速器', '/profile/site/system/1432bb7a-5e20-446e-9ba7-72856d445abb.ico', '国内首款免费游戏加速器', 'https://www.golink.com', 1, 0, '2020-10-16 23:01:15', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100460, 150725316141101047, '流星游戏加速器', '/profile/site/system/c4597214-2353-414c-b9a2-af8d0ce250d2.ico', '真免费,为痛快!', 'https://www.liuxing.com', 2, 0, '2020-10-16 23:02:15', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100461, 150725316141101047, '奇妙网游加速器', '/profile/site/system/f00c3d4a-e411-42d5-9b26-fda14cc9dd68.png', '真正免费，低延时，真专线，真稳定，真好用', 'https://www.qimiao.com', 3, 0, '2020-10-16 23:03:41', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100463, 150725316141101047, '小霸王', '/profile/site/system/65fcca63-5610-4e2d-8ab9-9084c8b68e58.png', '找回童年的快乐 ', 'https://www.yikm.net', 5, 0, '2020-10-16 23:08:38', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100464, 150725316141101047, '侠聚网', '/profile/site/system/6b430ae2-c72b-45ac-829d-ea3ecd5551ee.png', '免费的Android游戏修改神器，内置海量游戏下载', 'http://www.huluxia.com', 6, 0, '2020-10-16 23:09:48', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100465, 150725316141101047, '骑士下载', '/profile/site/system/193635d3-0fff-4886-ac47-e801ec314ed1.png', '好玩的安卓游戏免费下载', 'https://www.vqs.com', 7, 0, '2020-10-16 23:11:23', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100466, 150725316141101047, 'TapTap', '/profile/site/system/6558f840-b408-4ee1-a019-9514d107c7f8.ico', '推荐高质量好玩的手机游戏', 'https://www.taptap.com', 8, 0, '2020-10-16 23:12:31', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100471, 150725316141101011, '思古影视', '/profile/site/system/5c8372f4-bd97-4f95-a927-665675f1b8e1.ico', '高清免费VIP视频在线解析', 'https://www.sigu.cc/', 28, 0, '2020-10-20 21:32:59', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100472, 150725316141101017, '文档免费下载', '/profile/site/system/7c70855c-a7c2-4377-8e4b-8837a688b43b.ico', '从此,下载百度文库文档变得简单', 'https://doc.chaney.top/', 21, 0, '2020-10-25 11:23:39', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100473, 150725316141101009, 'ROM乐园', '/profile/site/system/34cfc67c-7490-4f5f-b7fb-a0b1f3d812a7.jpeg', '专注于打造全网优质特色ROM刷机包下载官方网站', 'http://www.romleyuan.com', 6, 0, '2020-10-27 23:23:28', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100477, 150725316141101032, '格姗知识圈', '/profile/site/system/logo.jpg', '我的博客网站，专注于技术分享、实用工具与技巧的博客平台！', 'https://geshanzsq.com', 1, 0, '2020-11-29 17:13:06', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100478, 150725316141101037, '人工桌面', '/profile/site/system/3982b997-0e85-4573-bb8c-ccf4db4bf83d.ico', '简洁又可爱的萌妹桌面软件。绝对是美女帅哥、宅男宅女的喜爱。', 'https://lumi.mihoyo.com/#/', 0, 0, '2020-12-03 13:39:48', '2020-12-03 13:39:55', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100479, 150725316141101037, '故宫壁纸', '/profile/site/system/6dd9f9cc-d49e-4b32-abcd-5eba13580739.ico', '将历史的精彩收集到自己的手中', 'https://www.dpm.org.cn/lights/royal.html', 11, 0, '2020-12-11 09:10:22', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100480, 150725316141101037, 'CGWallpapers', '/profile/site/system/0e5e058c-bf93-4c40-b327-b4064a023560.ico', ' 游戏CG壁纸站，超细腻，真假难分', 'https://www.cgwallpapers.com/', 12, 0, '2020-12-11 09:12:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100481, 150725316141101042, '格姗导航 / geshanzsq-nav', '/profile/site/system/logo.jpg', '一个基于 Spring Boot + Vue 前后端分离的导航网站！', 'https://gitee.com/geshanzsq/geshanzsq-nav', 0, 0, '2021-01-05 17:15:46', '2022-11-03 21:45:09', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100483, 150725316141101048, '剪映', '/profile/site/system/3bcc9224-2291-4f5c-8675-e10c1c0f570d.jpeg', '轻而易剪，上演大幕。', 'https://lv.ulikecam.com/', 1, 0, '2021-01-07 20:05:59', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100484, 150725316141101048, 'InShot', '/profile/site/system/9cdf91f4-530d-49b2-bdf1-1d4b4af68c8a.ico', '专业视频剪辑工具，风靡全球。', 'http://inshotapp.com/', 2, 0, '2021-01-07 20:06:02', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100485, 150725316141101048, '来画', '/profile/site/system/544f582c-1fa5-41e4-a5c5-65a1b1d9503d.ico', '像做PPT一样做视频', 'https://www.laihua.com/', 3, 0, '2021-01-07 20:06:05', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100486, 150725316141101048, 'VUE VLOG', '/profile/site/system/d725ef43-e3c5-42a9-9289-b8b6cc91137d.ico', '用 Vlog 记录生活', 'https://vuevideo.net/', 4, 0, '2021-01-07 20:06:07', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100487, 150725316141101048, '字说', '/profile/site/system/410577d5-312c-4674-8bf1-ef5177b194b3.ico', '字说  文字动画视频制作神器', 'https://h5.zishuovideo.com/', 5, 0, '2021-01-07 20:06:10', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100488, 150725316141101048, '轻剪辑', '/profile/site/system/e394ad53-a0a7-4929-b20c-c0134f4d436d.ico', '在线视频剪辑神器 无需软件下载 1分钟轻松制作精彩视频', 'https://e.chuanying520.com/', 6, 0, '2021-01-07 20:06:12', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100489, 150725316141101048, '万兴喵影', '/profile/site/system/62f04881-b9fc-42fb-bf75-c14eaba90672.png', '风靡全球的国产剪辑神器 用心剪辑美好生活', 'https://miao.wondershare.cn/', 7, 0, '2021-01-07 20:06:14', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100490, 150725316141101048, 'Animaker', '/profile/site/system/24044bfd-1173-49de-aede-11e2d5592a77.jpeg', '超好用的动画短视频工具', 'https://www.animaker.com/', 8, 0, '2021-01-07 20:06:16', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100491, 150725316141101048, '飞推', '/profile/site/system/3a1d5950-9e7a-49ef-a68c-a304f0a450f1.png', '创意视频制作神器 视频制作从未如此简单!', 'https://www.qutui360.com/', 9, 0, '2021-01-07 20:06:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100492, 150725316141101048, 'Premiere', '/profile/site/system/17f4dcb9-4881-4e4b-83d9-9da269d0af2e.ico', '始终更胜一筹的视频编辑', 'https://www.adobe.com/cn/products/premiere.html', 10, 0, '2021-01-07 20:06:20', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100493, 150725316141101048, 'After Effects', '/profile/site/system/17f4dcb9-4881-4e4b-83d9-9da269d0af2e.ico', '制作气势恢宏的大场面', 'https://www.adobe.com/cn/products/aftereffects.html', 11, 0, '2021-01-07 20:06:22', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100494, 150725316141101048, '爱剪辑', '/profile/site/system/910ecf63-8077-427b-987b-98a1f206cc62.ico', '全民流行的视频剪辑软件', 'http://www.ijianji.com/', 12, 0, '2021-01-07 20:06:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100495, 150725316141101048, '快剪辑', '/profile/site/system/929c3691-b128-4561-b836-2664bcee50a3.ico', '一触即发，分享你的创意灵感', 'https://kuai.360.cn/home.html', 13, 0, '2021-01-07 20:06:27', '2021-01-07 20:06:50', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100496, 150725316141101035, '知识星球', '/profile/site/system/b5fa8f88-5312-4fb6-8183-af53a748f0a1.ico', '深度连接铁杆粉丝，运营高品质社群，知识变现的工具。', 'https://www.zsxq.com', 17, 0, '2021-01-11 17:54:25', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100497, 150725316141101049, '公益图床', '/profile/site/system/a9532e0c-b22c-4c15-9441-b3293465a7a8.png', '国内图床，速度飞快，快人一步。', 'https://sbimg.cn', 1, 0, '2021-01-12 16:32:07', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100498, 150725316141101049, 'SM.MS图床', '/profile/site/system/de98806e-8b41-4351-a8c5-9f307a4ad1d3.ico', '免费用户无香港节点，速度较慢', 'https://sm.ms', 2, 0, '2021-01-12 16:40:09', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100499, 150725316141101049, '路过图床', '/profile/site/system/13322f82-052a-496e-8d14-39d678745466.png', '免费图片上传，高速稳定的图片上传和外链服务。', 'https://imgchr.com/', 3, 0, '2021-01-12 16:41:10', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100500, 150725316141101030, '极客时间', '/profile/site/system/5ab40821-6da7-4c81-8c56-62ba2598a9ab.jpg', '轻松学习，高效学习！', 'https://time.geekbang.org', 5, 0, '2021-01-13 11:16:54', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100501, 150725316141101031, '极客时间', '/profile/site/system/5ab40821-6da7-4c81-8c56-62ba2598a9ab.jpg', '轻松学习，高效学习', 'https://time.geekbang.org', 8, 0, '2021-01-13 11:17:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100502, 150725316141101011, '芒果TV', '/profile/site/system/ef97cc86-01f6-4109-a23c-5613099d0d67.ico', '天生青春', 'https://www.mgtv.com', 6, 0, '2021-01-13 15:25:40', '2021-01-13 15:25:55', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100504, 150725316141101030, '码云 Gitee', '/profile/site/system/ec70a38c-e700-4181-a368-c1b9a12d09b9.ico', '基于 Git 的代码托管和研发协作平台。帮助开发者/团队/企业更好地管理代码，让软件研发更高效', 'https://gitee.com/', 7, 0, '2021-01-15 10:52:50', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100505, 150725316141101030, 'Github', '/profile/site/system/a81a692b-999c-4018-ba1b-9e0156b30af9.svg', '数以百万计的开发人员和公司在github上构建、发布和维护他们的软件，github是世界上最大、最先进的开发平台。', 'https://github.com', 8, 0, '2021-01-15 10:54:32', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100506, 150725316141101035, '网易号', '/profile/site/system/5956e442-9f8b-4516-9dcc-19ddcf06f7af.png', '媒体开放平台。', 'http://mp.163.com', 18, 0, '2021-01-18 10:16:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100507, 150725316141101035, '大鱼号', '/profile/site/system/6469fa53-6822-4f50-aca2-a23c7d41acce.ico', '一点接入，多点分发。移动世界，无所不达', 'https://mp.dayu.com', 19, 0, '2021-01-18 10:19:32', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100508, 150725316141101035, '一点资讯', '/profile/site/system/7bccd2ec-e385-497d-a1f8-655a7a8a0197.ico', '阅不同，更有趣', 'http://www.yidianzixun.com', 20, 0, '2021-01-18 10:20:54', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100509, 150725316141101035, '搜狐号', '/profile/site/system/b6021b69-2035-4f9c-8e1e-ea54c1d74817.ico', '再小的个体，也能获取影响力', 'https://mp.sohu.com/mpfe/v3/login', 21, 0, '2021-01-18 10:22:30', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100510, 150725316141101050, '印象笔记', '/profile/site/system/4e5ed731-1d90-4586-baff-c3bb89d4be8b.ico', '工作必备效率应用', 'https://www.yinxiang.com/', 1, 0, '2021-01-18 10:28:44', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100511, 150725316141101050, '有道云笔记', '/profile/site/system/43f327f6-631b-4280-a7af-a01ed8c505b6.ico', '5000万用户的选择', 'http://note.youdao.com', 2, 0, '2021-01-18 10:29:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100512, 150725316141101050, 'Tower', '/profile/site/system/136c7f93-cbc7-4daa-9edc-73840b2c2b6e.ico', '提升协作效率，打造高效团队', 'https://tower.im', 3, 0, '2021-01-18 10:29:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100513, 150725316141101050, '为知笔记', '/profile/site/system/09f19706-7536-4cdd-aeaa-97d64c89a9b4.ico', '一键收藏、全端全文检索、多级目录、Markdown', 'http://www.wiz.cn', 4, 0, '2021-01-18 10:31:26', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100514, 150725316141101050, '石墨文档', '/profile/site/system/9412b0ba-72eb-4751-a1ab-1517c9678eb9.ico', '企业在线协同办公系统平台,支持云端多人在线协作编辑文档和表格', 'https://shimo.im', 5, 0, '2021-01-18 10:32:00', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100515, 150725316141101050, '锤子便签', '/profile/site/system/e6cc2bbc-e2fb-4cd5-a3cd-b828715fb834.ico', '可能是史上最漂亮的便签应用，你或许会因它重新喜欢上记录和表达', 'https://www.smartisan.com/apps/#/notes', 6, 0, '2021-01-18 10:32:34', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100516, 150725316141101050, '腾讯文档', '/profile/site/system/d9222fdb-cd48-43bf-bc1e-b40a79bc8eb2.ico', '支持多人在线编辑Word、Excel和PPT文档', 'https://docs.qq.com', 7, 0, '2021-01-18 10:33:28', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100517, 150725316141101050, 'Teambition', '/profile/site/system/cd0cb55f-c569-40cf-831e-a4a3f73c6dff.ico', '一套聪明好用的日常工具，包含项目、待办、网盘、文档、日历等丰富应用，帮助你把想法变成现实，使用起来爱不释手。', 'https://www.teambition.com', 8, 0, '2021-01-18 10:34:08', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100518, 150725316141101050, 'Google Docs', '/profile/site/system/1a7be2d2-a468-4ce1-8cd9-9243f265b598.jpeg', '谷歌在线文档', 'https://docs.google.com', 9, 0, '2021-01-18 10:37:08', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100519, 150725316141101050, 'WPS云文档', '/profile/site/system/28edf917-58d1-4739-922f-27f9f9c889f0.ico', '多人实时协作的在线Office', 'https://www.kdocs.cn', 10, 0, '2021-01-18 10:38:17', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100520, 150725316141101030, 'JustAuth', '/profile/site/system/4473999c-1dee-4b47-bbff-155b1785085e.png', '史上最全的整合第三方登录的开源库', 'https://www.justauth.cn/', 9, 0, '2021-01-18 17:03:08', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100521, 150725316141101029, 'PPT超级市场', '/profile/site/system/334c508a-a599-4a25-8e2b-e037de63dba6.ico', '完全免费的PPT模板下载网站。量都是极高，并且非常精美。', 'http://ppt.sotary.com/web/wxapp/index.html', 7, 0, '2021-01-20 11:02:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100522, 150725316141101046, '原版系统', '/profile/site/system/3d2a5e29-be0a-4cdb-826d-e063e051a79a.ico', '提供可靠的原版软件。十二年的专注和积累，初心未改，打造下一个里程碑。 ', 'https://next.itellyou.cn/', 0, 0, '2021-01-22 11:02:37', '2021-01-22 11:03:29', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100523, 150725316141101012, 'HiFiNi - 音乐磁场', '/profile/site/system/fdd671e9-b241-462f-a259-d8d7d5a2596e.png', '一个由音乐爱好者维护的分享平台', 'https://www.hifini.com/', 11, 0, '2021-01-25 16:01:45', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100524, 150725316141101037, '必应壁纸', '/profile/site/system/ac326879-5ed4-4ef7-9476-00793db5a0a3.png', '超高质量的必应壁纸4K无水印下载', 'https://www.todaybing.com/', 13, 0, '2021-01-29 14:36:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100525, 150725316141101051, '火烧云数据', '/profile/site/system/25f491c8-2164-4d18-aeca-c6aa2ccbc8a7.png', '专业的B站第三方大数据分析平台，助力UP主/MCN 快速涨粉，商业变现；助力品牌方/广告公司洞察竞品投放情报，匹配优质UP主，投放更精准出效', 'http://www.hsydata.com/home/index', 1, 0, '2021-02-01 14:35:32', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100526, 150725316141101035, 'B站创作中心', '/profile/site/system/179f1fce-c229-465c-83b8-0bb2caa9eb2c.ico', '国内知名的视频弹幕网站，这里有最及时的动漫新番，最棒的ACG氛围，最有创意的Up主。大家可以在这里找到许多欢乐。', 'https://member.bilibili.com/', 16, 0, '2021-02-01 15:03:18', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100527, 150725316141101035, '大风号', '/profile/site/system/839113b2-755e-422c-9130-ae6544bc1cb7.png', '好内容随风直达', 'https://fhh.ifeng.com/', 22, 0, '2021-02-01 15:09:36', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100528, 150725316141101029, '第一PPT', '/profile/site/system/a6c796a7-9341-4103-b033-49e99db328f7.png', 'PPT模版免费下载', 'http://www.1ppt.com/', 8, 0, '2021-02-02 09:12:17', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100529, 150725316141101029, '51PPT', '/profile/site/system/bb66b865-a667-46b1-acf2-8b8c6da6ec87.png', '幻灯片演示模板及素材下载', 'http://www.51pptmoban.com/', 9, 0, '2021-02-02 09:14:05', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100530, 150725316141101029, '叮当设计', '/profile/site/system/3c5526a5-70fc-4f67-9ad5-65e301991399.png', '分享优秀设计资源，全部免费下载', 'https://www.dingdangsheji.com/', 10, 0, '2021-02-02 09:15:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100531, 150725316141101048, 'SubPlayer', '/profile/site/system/6cee691b-9b0d-4a14-b755-ed9540e92bc0.ico', '字幕在线调整，小巧实用性非常强的网站', 'https://subplayer.js.org/', 14, 0, '2021-03-02 15:53:46', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100532, 150725316141101012, '在线音乐播放', '/profile/site/system/87ace2f3-0c6f-455f-97bc-789f0b00f846.png', '可以在线听，可以直接下载。麻雀虽小，五脏俱全。', 'https://www.binye.xyz/Music/', 12, 0, '2021-03-05 17:54:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100534, 150725316141101051, 'Versus', '/profile/site/system/a43adc92-08cd-4b2b-af7e-667e216efa08.png', '万物皆可对比。移动电话、城市、显示卡、大学及及其他', 'https://versus.com/cn', 2, 0, '2021-03-21 19:23:36', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100535, 150725316141101012, '52无损音乐', '/profile/site/system/2cb30771-c5bc-4519-a772-b47abb64c085.png', '无损音乐下载_FLAC_WAV_高品质格式无损音乐免费下载', 'http://www.52flac.com/', 13, 0, '2021-03-23 23:48:01', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100536, 150725316141101012, '炫音音乐论坛', '/profile/site/system/325b7386-aefc-41ee-be4a-63a228de00fc.png', '总有一种声音能打动你', 'https://bbs.musicool.cn/', 14, 0, '2021-03-23 23:49:54', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100538, 150725316141101052, '搜图导航', '/profile/site/system/09fbdff3-6b8e-4c39-ac01-d3356098529b.png', '解决您的搜图需求，包含大量图片网站', 'https://gesdh.cn/share/st', 2, 0, '2021-03-27 00:38:11', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100539, 150725316141101052, '自媒体导航', '/profile/site/system/3a9c73f6-0656-40b8-9789-f5f0f55be1f5.png', '自媒体专业导航，包含运营平台、排版工具、图片素材等', 'https://gesdh.cn/share/S8F3C', 3, 0, '2021-03-27 00:41:37', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100540, 150725316141101052, '视频号导航', '/profile/site/system/12448992-5513-4826-836c-afa86cb16d3e.png', '视频号相关网站，包括玩家必备、数据分析等', 'https://gesdh.cn/share/shipinhao', 4, 0, '2021-03-27 00:44:04', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100541, 150725316141101052, '视频创作导航', '/profile/site/system/dbbe4e57-13aa-4d16-b863-d4c0e74a83c5.png', '好用又专业的视频制作导航网站', 'https://gesdh.cn/share/sp', 5, 0, '2021-03-27 00:45:42', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100542, 150725316141101052, '创业神器导航', '/profile/site/system/801ef7f2-28af-4f99-8f52-db7d138d4235.png', '分享创业资源和互联网工具', 'https://gesdh.cn/share/cysq', 7, 0, '2021-03-27 00:51:44', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100543, 150725316141101052, '排行榜导航', '/profile/site/system/69a024f8-cada-46c4-9150-fecb932115d0.png', '各类榜单排名大全，包括热搜榜、热议榜等', 'https://gesdh.cn/share/phb', 6, 1, '2021-03-27 00:55:01', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100544, 150725316141101052, '运营辅助工具导航', '/profile/site/system/46e442b9-e4cc-43f5-8997-89bccd50b803.png', '分享运营相关网站', 'https://gesdh.cn/share/yyfzgj', 8, 0, '2021-03-27 00:56:26', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100545, 150725316141101052, '程序员导航', '/profile/site/system/f741cece-de4a-4e46-a237-07a0ad90c303.png', '程序员自用网站，包括常用推荐、学习教程等', 'https://gesdh.cn/share/6hMpM', 9, 0, '2021-03-27 00:58:32', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100546, 150725316141101004, 'PDF 派', '/profile/site/system/2ececa01-18ea-45f5-a168-8421def8ff3d.ico', '几十个强大的PDF在线工具，永久免费，没有注册入口，人人都是VIP！', 'https://www.pdfpai.com/', 8, 0, '2021-04-20 11:42:52', '2021-04-20 11:43:17', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100547, 150725316141101029, '微软 PPT', '/profile/site/system/2bd1b9b8-e0be-4107-8fe5-3550a619fe1d.ico', 'Office 模板和主题，使用 Microsoft 模板创建更多内容', 'https://templates.office.com/', 11, 0, '2021-04-20 11:45:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100548, 150725316141101029, 'Slidesgo', '/profile/site/system/24475701-da5f-4aa3-852e-033f55668ed9.png', '免费的谷歌幻灯片和PowerPoint模板，让你的演讲更精彩', 'https://slidesgo.com/', 12, 0, '2021-04-20 11:47:41', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100549, 150725316141101029, 'Hislide', '/profile/site/system/13f71e2b-7687-47ea-861a-ccf4caf2f60b.png', '免费的PowerPoint，谷歌幻灯片，Keynote模板', 'https://hislide.io/', 13, 0, '2021-04-20 11:48:58', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100550, 150725316141101029, 'Rrslide', '/profile/site/system/efad445e-1b5c-4e4c-9afc-0b6b21972b05.png', '下载免费的ppt模板，基调，主题和更多_ RRSlide _最畅销的演示模板市场', 'https://rrslide.com/', 14, 0, '2021-04-20 11:51:32', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100553, 150725316141101036, '图司机', '/profile/site/system/0478f006-ff16-4504-963f-8b28fd24af6d.png', '免费图片在线PS编辑器，10秒搞定平面设计！', 'https://www.tusij.com/', 0, 0, '2021-04-22 21:32:27', '2021-04-22 21:32:35', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100554, 150725316141101050, 'ProcessOn免费在线作图', '/profile/site/system/25fc6979-4a05-49ab-a9dc-3cc0daa76e0c.ico', '在线作图工具的聚合平台， 它可以在线画流程图、思维导图、UI原型图、UML、网络拓扑图、组织结构图等等， 您无需担心下载和更新的问题，不管Mac还是Windows，一个浏览器就可以随时随地的发挥创意，规划工作', 'https://processon.com', 11, 0, '2021-05-13 23:22:40', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100555, 150725316141101042, 'JustAuth', '/profile/site/system/fdf62f71-41e8-4454-8dbd-f1272ed9eac5.png', '小而全而美的第三方登录开源组件。目前已支持Github、Gitee、微博、钉钉、百度、Coding、腾讯云开发者平台、OSChina、支付宝、QQ、微信、淘宝、Google、Facebook、抖音、领英、小米、微软、今日头条、Teambition、StackOverflow、Pinterest、人人、华为、企业微信、酷家乐、Gitlab、美团、饿了么、推特、飞书、京东、阿里云、喜马拉雅、Amazon、Slack和 Line 等第三方平台的授权登录。', 'https://gitee.com/yadong.zhang/JustAuth', 8, 0, '2021-05-31 23:11:03', '2021-05-31 23:11:52', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100556, 150725316141101050, '语雀', '/profile/site/system/6da5aba9-a474-4fb4-82b0-880cfc32237e.png', '专业的云端知识库，个人笔记与知识创作，团队协同与知识沉淀。', 'https://www.yuque.com/', 12, 0, '2021-06-05 10:20:20', '2021-06-12 14:32:16', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100557, 150725316141101048, '爱给网', '/profile/site/system/fec4eb53-e5d2-4cb5-a16e-5ed41e4cc1d4.ico', '音效配乐_3D模型_视频素材_游戏素材。中国最大的数字娱乐免费素材下载网站,免费提供免费的音效配乐|3D模型|视频|游戏素材资源下载。', 'https://www.aigei.com/', 15, 0, '2021-07-25 11:42:08', '2021-07-25 11:44:39', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100558, 150725316141101017, 'IT工具网', '/profile/site/system/a3ccbeef-5ba8-46d3-bf9b-07cc90aa202c.ico', '在线实用工具_代码工具_写作辅助工具', 'https://www.coder.work', 23, 0, '2021-08-02 21:45:14', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100559, 150725316141101037, '电脑壁纸', '/profile/site/system/25fd04c8-3419-4919-ac66-8c6dd822898e.png', '一个自采集壁纸站', 'http://lab.mkblog.cn/wallpaper/', 14, 0, '2021-08-11 22:57:13', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100560, 150725316141101037, '3G壁纸', '/profile/site/system/628bf055-387d-49a5-b403-5292f79354be.png', '电脑壁纸专家', 'https://desk.3gbizhi.com/', 15, 0, '2021-08-11 23:02:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100562, 150725316141101048, '混剪侠 预告片世界', '/profile/site/system/e9b3cfca-739b-427b-b52b-bdb6899b2945.png', '最新电影预告片免费下载', 'https://www.yugaopian.cn/', 16, 0, '2021-09-07 00:05:24', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100563, 150725316141101042, 'vue-admin-beautiful', '/profile/site/system/4864e82c-69e2-4868-8501-0c9a06ff56c6.png', '国内首个基于vue3.0的开源admin项目，同时支持电脑，手机，平板', 'https://gitee.com/chu1204505056/vue-admin-beautiful', 9, 0, '2021-09-27 07:55:13', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100566, 150725316141101001, '奈斯搜索', '/profile/site/system/2c3be62e-9584-4db0-9940-509f13f9d0fc.png', '资源超丰富的阿里云盘资源搜索引擎', 'https://www.niceso.fun/', 21, 0, '2021-12-10 22:10:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100567, 150725316141101004, 'PDF24 Tools', '/profile/site/system/0d8de034-7e9e-4e7b-8f87-1679cc5cdc55.svg', '免费且易于使用的在线PDF工具，不限制文件大小。', 'https://tools.pdf24.org/zh/', 13, 0, '2022-01-16 20:31:31', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100568, 150725316141101011, '视中心影院', '/profile/site/system/84734031-d40d-40d1-b30c-c13fa29a65f1.png', '全新电视剧,全新动漫,全新综艺节目排行榜,免费在线观看全网电影,动作片,喜剧片,爱情片,搞笑片等全新电影,更多电影高清在线观看尽在视中心影院', 'https://www.mhz8.com/', 30, 0, '2022-03-13 15:03:21', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100569, 150725316141101042, 'vue-admin-better', '/profile/site/system/4864e82c-69e2-4868-8501-0c9a06ff56c6.png', '国内首个基于vue3.0的开源admin项目，同时支持电脑，手机，平板', 'https://github.com/chuzhixin/vue-admin-better', 10, 0, '2022-03-14 23:26:42', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100570, 150725316141101031, 'Element Plus', '/profile/site/system/6a17c0cb-36ad-4029-9570-0b272a07055d.svg', '基于 Vue 3，面向设计师和开发者的组件库', 'https://element-plus.gitee.io/zh-CN/', 3, 0, '2022-06-11 17:30:09', '2022-06-11 17:30:44', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100571, 150725316141101042, '格姗知识圈 / geshanzsq-blog', '/profile/site/system/logo.jpg', '一个基于 Spring Boot、Spring Security、Vue3、Element Plus 的前后端分离的博客网站！', 'https://gitee.com/geshanzsq/geshanzsq-blog', 0, 0, '2022-11-03 21:43:34', '2022-11-03 21:44:25', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100572, 150725316141101017, 'Wormhole', '/profile/site/system/4bef67c6-4105-48ea-8974-b5e565cb6179.png', '一个没有任何限制的文件传输网站，打开就可以选择上传需要临时保存的文件或文件夹，一次可以免费上传10GB以内的大小文件。', 'https://wormhole.app', 24, 0, '2023-01-09 20:26:45', '2023-01-09 20:27:23', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100573, 150725316141101048, 'Hotbox', '/profile/site/system/c4fc3995-0b5d-44f2-8220-8e40db0324e7.png', '一个完全免费的视频下载网站，能够下载多个平台的视频文件，并且还支持自定义选择视频清晰度以及单独的音频下载。', 'https://www.hotbox.fun', 17, 0, '2023-01-09 20:29:53', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100574, 150725316141101048, 'DeepL', '/profile/site/system/4117453c-4615-4245-a59f-f9e03b38b1d6.png', '一个非常好用的在线文字、文档翻译网站，下载的文档文献资料都能一键翻译成需要的语种，支持翻译上百种语种', 'https://www.deepl.com/translator', 18, 0, '2023-01-09 20:31:55', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100575, 150725316141101004, '贴图士', '/profile/site/system/3a981b05-bd12-426a-8094-91eeff7e6e49.png', '一个免费的视频格式转换以及图片压缩网站。打开页面会看到多种图片压缩格式、视频转GIF、GIF合并、GIF裁剪等功能。', 'https://www.tutieshi.com/video/', 14, 0, '2023-01-09 20:33:36', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100576, 150725316141101008, 'Latest10', '/profile/site/system/804cc2a0-afcc-4984-b3b4-dfd6154e527b.png', '获取最新的系统镜像', 'https://latest10.win/', 11, 0, '2023-02-18 19:47:07', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100577, 150725316141101008, '极简系统', '/profile/site/system/67a5a719-0b09-4807-9185-535b7b4ce107.ico', '最纯净的系统下载平台', 'https://www.sysmini.com/', 12, 0, '2023-02-18 19:48:03', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100578, 150725316141101008, '微软官方系统', '/profile/site/system/b066263b-a469-4fa1-a1dc-df8f86869eb8.png', '正版官方下载', 'https://www.microsoft.com/zh-cn/software-download/', 13, 1, '2023-02-18 19:49:50', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100579, 150725316141101048, 'VideoFk', '/profile/site/system/7adb50a1-6511-438f-b713-2662bc747155.png', '在线视频下载，下载视频转换为 MP4 最佳网站以从All在线下载视频', 'https://www.videofk.com/', 19, 0, '2023-02-27 23:23:09', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (150725316141100580, 150725316141101052, 'AI 导航', '/profile/site/system/65da39e3-2d3b-4e7c-8590-73ac52b2fbeb.png', '超全的国内外 AI 应用', 'https://gesdh.cn/share/ai', 1, 0, '2023-03-31 00:40:32', '2023-05-19 21:05:00', 1, 1, 1);
INSERT INTO `nav_site` VALUES (150725316141100581, 150725316141101035, '抖音创作服务平台', '/profile/site/system/da278792-b8ec-4073-8cd4-660fc24acb7b.ico', '抖音创作服务平台', 'https://creator.douyin.com/', 23, 0, '2023-04-05 22:21:33', NULL, 1, NULL, 1);
INSERT INTO `nav_site` VALUES (301450632282221536, 150725316141101050, '飞书文档', '/profile/site/system/2023/05/15/8877512b-ad2c-4690-800b-fc5121dda9d6.jpeg', '新一代高效协作工具,融合了在线文档和协同文档的所有功能,不仅能插入在线表格,将数据表转换成看板,还能用思维笔记,将思考路径可视化,更有丰富模板满足多场景创作需求。', 'https://bqfeun1dwu8.feishu.cn', 13, 0, '2023-05-15 22:08:36', NULL, 1, NULL, 1);

-- ----------------------------
-- Table structure for nav_site_config
-- ----------------------------
DROP TABLE IF EXISTS `nav_site_config`;
CREATE TABLE `nav_site_config`  (
  `id` bigint(20) NOT NULL COMMENT '配置 id',
  `about_site_description` varchar(500) NULL DEFAULT '' COMMENT '关于本站描述',
  `about_site_email` varchar(50) NULL DEFAULT '' COMMENT '关于本站邮箱',
  `about_site_content` longtext NULL COMMENT '关于本站内容',
  `about_site_visit_count` int(11) NULL DEFAULT 0 COMMENT '关于本站访问量',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '网站配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nav_site_config
-- ----------------------------
INSERT INTO `nav_site_config` VALUES (152819881111191552, '这个导航网站来源于格姗导航的开源项目。如果你有更好的想法，可以通过左边的邮箱与我联系。如果喜欢本站，可以分享给其他人，或者设置为主页，这是对我最大的支持！\'', '497301391@qq.com', '<p>这是一个导航网站,收入了大部分常用的网站，希望能够解决到你频繁收藏网站的烦恼！</p><p>显然，这是一个开源项目，主要放一些自己经常用到的网站。</p><p>开源项目来源：<a href=\"\\\" target=\"\\\">https://gitee.com/geshanzsq/geshanzsq-nav</a></p>', 10, 43728307660783616, '2023-05-21 16:51:39', 43728307660783616, '2023-05-21 16:58:51');

-- ----------------------------
-- Table structure for sys_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_api`;
CREATE TABLE `sys_api`  (
  `id` bigint(20) NOT NULL COMMENT '接口 id',
  `api_name` varchar(50) NULL DEFAULT '' COMMENT '接口名称',
  `api_url` varchar(255) NULL DEFAULT '' COMMENT '接口地址',
  `api_method` varchar(10) NULL DEFAULT '' COMMENT '接口请求方式（如：get，post）',
  `fk_api_category_id` varchar(25) NULL DEFAULT '' COMMENT '所属分类 id',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  `remark` varchar(500) NULL DEFAULT '' COMMENT '备注',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '系统接口' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_api
-- ----------------------------
INSERT INTO `sys_api` VALUES (43759552742555648, '分页列表', '/system/user/page', 'GET', '43757041415618560', 1, 1, '', 43728307660783616, '2022-07-24 18:04:50', NULL, NULL);
INSERT INTO `sys_api` VALUES (43759676889759744, '详情', '/system/user/getById/*', 'GET', '43757041415618560', 2, 1, '', 43728307660783616, '2022-07-24 18:05:20', NULL, NULL);
INSERT INTO `sys_api` VALUES (43761152815005696, '新增', '/system/user', 'POST', '43757041415618560', 3, 1, '', 43728307660783616, '2022-07-24 18:11:12', NULL, NULL);
INSERT INTO `sys_api` VALUES (43761187950690304, '修改', '/system/user', 'PUT', '43757041415618560', 4, 1, '', 43728307660783616, '2022-07-24 18:11:20', NULL, NULL);
INSERT INTO `sys_api` VALUES (43761278916755456, '删除', '/system/user/delete/*', 'DELETE', '43757041415618560', 5, 1, '', 43728307660783616, '2022-07-24 18:11:42', NULL, NULL);
INSERT INTO `sys_api` VALUES (43762647782391808, '重置密码', '/system/user/resetPassword', 'PUT', '43757041415618560', 6, 1, '', 43728307660783616, '2022-07-24 18:17:08', NULL, NULL);
INSERT INTO `sys_api` VALUES (43762807694426112, '分页列表', '/system/role/page', 'GET', '43757069869776896', 1, 1, '', 43728307660783616, '2022-07-24 18:17:46', NULL, NULL);
INSERT INTO `sys_api` VALUES (43762858923655168, '详情', '/system/role/getById/*', 'GET', '43757069869776896', 2, 1, '', 43728307660783616, '2022-07-24 18:17:59', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763188797276160, '新增', '/system/role', 'POST', '43757069869776896', 3, 1, '', 43728307660783616, '2022-07-24 18:19:17', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763232950714368, '修改', '/system/role', 'PUT', '43757069869776896', 4, 1, '', 43728307660783616, '2022-07-24 18:19:28', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763311845572608, '删除', '/system/role/delete/*', 'DELETE', '43757069869776896', 5, 1, '', 43728307660783616, '2022-07-24 18:19:47', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763442175180800, '获取最大排序', '/system/role/getMaxSort', 'GET', '43757069869776896', 6, 1, '', 43728307660783616, '2022-07-24 18:20:18', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763523695673344, '已分配用户分页', '/system/role/auth/user/page', 'GET', '43757069869776896', 7, 1, '', 43728307660783616, '2022-07-24 18:20:37', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763593107210240, '未分配用户分页', '/system/role/auth/user/not/page', 'GET', '43757069869776896', 8, 1, '', 43728307660783616, '2022-07-24 18:20:54', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763693447544832, '授权用户', '/system/role/auth/user', 'POST', '43757069869776896', 9, 1, '', 43728307660783616, '2022-07-24 18:21:18', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763818857234432, '取消授权', '/system/role/auth/user/delete', 'DELETE', '43757069869776896', 10, 1, '', 43728307660783616, '2022-07-24 18:21:48', NULL, NULL);
INSERT INTO `sys_api` VALUES (43763961681674240, '列表', '/system/menu/list', 'GET', '43758191430860800', 1, 1, '', 43728307660783616, '2022-07-24 18:22:22', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764022897541120, '树形', '/system/menu/tree', 'GET', '43758191430860800', 2, 1, '', 43728307660783616, '2022-07-24 18:22:36', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764081659740160, '详情', '/system/menu/getById/*', 'GET', '43758191430860800', 3, 1, '', 43728307660783616, '2022-07-24 18:22:50', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764130418524160, '新增', '/system/menu', 'POST', '43758191430860800', 4, 1, '', 43728307660783616, '2022-07-24 18:23:02', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764160827228160, '修改', '/system/menu', 'PUT', '43758191430860800', 5, 1, '', 43728307660783616, '2022-07-24 18:23:09', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764235854938112, '删除', '/system/menu/delete/*', 'DELETE', '43758191430860800', 6, 1, '', 43728307660783616, '2022-07-24 18:23:27', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764326162497536, '获取最大排序', '/system/menu/getMaxSortByParentId', 'GET', '43758191430860800', 7, 1, '', 43728307660783616, '2022-07-24 18:23:48', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764505833897984, '分页列表', '/system/dictionary/page', 'GET', '43758342685851648', 1, 1, '', 43728307660783616, '2022-07-24 18:24:31', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764571281817600, '列表', '/system/dictionary/list', 'GET', '43758342685851648', 2, 1, '', 43728307660783616, '2022-07-24 18:24:47', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764610037186560, '新增', '/system/dictionary', 'POST', '43758342685851648', 3, 1, '', 43728307660783616, '2022-07-24 18:24:56', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764642895364096, '修改', '/system/dictionary', 'PUT', '43758342685851648', 5, 1, '', 43728307660783616, '2022-07-24 18:25:04', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764689900929024, '删除', '/system/dictionary/delete/*', 'DELETE', '43758342685851648', 6, 1, '', 43728307660783616, '2022-07-24 18:25:15', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764765633282048, '获取最大排序', '/system/dictionary/getMaxSort', 'GET', '43758342685851648', 7, 1, '', 43728307660783616, '2022-07-24 18:25:33', NULL, NULL);
INSERT INTO `sys_api` VALUES (43764977332387840, '分页列表', '/system/dictionary/data/page', 'GET', '43758386155618304', 1, 1, '', 43728307660783616, '2022-07-24 18:26:24', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765061612732416, '详情', '/system/dictionary/data/getById/*', 'GET', '43758386155618304', 2, 1, '', 43728307660783616, '2022-07-24 18:26:44', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765127371030528, '新增', '/system/dictionary/data', 'POST', '43758386155618304', 3, 1, '', 43728307660783616, '2022-07-24 18:26:59', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765165673414656, '修改', '/system/dictionary/data', 'PUT', '43758386155618304', 4, 1, '', 43728307660783616, '2022-07-24 18:27:09', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765212116942848, '删除', '/system/dictionary/data/delete/*', 'DELETE', '43758386155618304', 5, 1, '', 43728307660783616, '2022-07-24 18:27:20', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765276512092160, '获取最大排序', '/system/dictionary/data/getMaxSortByDictionaryId', 'GET', '43758386155618304', 6, 1, '', 43728307660783616, '2022-07-24 18:27:35', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765395617742848, '分页列表', '/system/api/category/page', 'GET', '43758515155632128', 1, 1, '', 43728307660783616, '2022-07-24 18:28:03', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765435992113152, '列表', '/system/api/category/list', 'GET', '43758515155632128', 2, 1, '', 43728307660783616, '2022-07-24 18:28:13', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765499997192192, '详情', '/system/api/category/getById/*', 'GET', '43758515155632128', 3, 1, '', 43728307660783616, '2022-07-24 18:28:28', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765537020313600, '新增', '/system/api/category', 'POST', '43758515155632128', 4, 1, '', 43728307660783616, '2022-07-24 18:28:37', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765569287094272, '修改', '/system/api/category', 'PUT', '43758515155632128', 5, 1, '', 43728307660783616, '2022-07-24 18:28:45', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765629844455424, '删除', '/system/api/category/delete/*', 'DELETE', '43758515155632128', 6, 1, '', 43728307660783616, '2022-07-24 18:28:59', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765696206733312, '获取最大排序', '/system/api/category/getMaxSort', 'GET', '43758515155632128', 7, 1, '', 43728307660783616, '2022-07-24 18:29:15', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765773721665536, '分页列表', '/system/api/page', 'GET', '43758723595763712', 1, 1, '', 43728307660783616, '2022-07-24 18:29:34', NULL, NULL);
INSERT INTO `sys_api` VALUES (43765827249373184, '详情', '/system/api/getById/*', 'GET', '43758723595763712', 2, 1, '', 43728307660783616, '2022-07-24 18:29:46', NULL, NULL);
INSERT INTO `sys_api` VALUES (43766245937381376, '新增', '/system/api', 'POST', '43758723595763712', 3, 1, '', 43728307660783616, '2022-07-24 18:31:26', NULL, NULL);
INSERT INTO `sys_api` VALUES (43766278116081664, '修改', '/system/api', 'PUT', '43758723595763712', 4, 1, '', 43728307660783616, '2022-07-24 18:31:34', NULL, NULL);
INSERT INTO `sys_api` VALUES (43766323594919936, '删除', '/system/api/delete/*', 'DELETE', '43758723595763712', 5, 1, '', 43728307660783616, '2022-07-24 18:31:45', NULL, NULL);
INSERT INTO `sys_api` VALUES (43766380444516352, '获取最大排序', '/system/api/getMaxSortByCategoryId', 'GET', '43758723595763712', 6, 1, '', 43728307660783616, '2022-07-24 18:31:58', NULL, NULL);
INSERT INTO `sys_api` VALUES (43766697940746240, '分页列表', '/system/log/login/page', 'GET', '43766546228576256', 1, 1, '', 43728307660783616, '2022-07-24 18:33:14', NULL, NULL);
INSERT INTO `sys_api` VALUES (43766812147449856, '分页列表', '/system/log/operation/page', 'GET', '43766567304953856', 1, 1, '', 43728307660783616, '2022-07-24 18:33:41', NULL, NULL);
INSERT INTO `sys_api` VALUES (43766869047377920, '详情', '/system/log/operation/getById/*', 'GET', '43766567304953856', 2, 1, '', 43728307660783616, '2022-07-24 18:33:55', NULL, NULL);
INSERT INTO `sys_api` VALUES (45287586729558016, '详情', '/system/dictionary/getById/*', 'GET', '43758342685851648', 4, 1, '', 43728307660783616, '2022-07-28 23:16:42', NULL, NULL);
INSERT INTO `sys_api` VALUES (52141509008424960, '分页列表', '/system/param/page', 'GET', '52133147512406016', 1, 1, '', 43728307660783616, '2022-08-16 21:11:44', NULL, NULL);
INSERT INTO `sys_api` VALUES (52141659554578432, '详情', '/system/param/getById/*', 'GET', '52133147512406016', 2, 1, '', 43728307660783616, '2022-08-16 21:12:20', NULL, NULL);
INSERT INTO `sys_api` VALUES (52141709437435904, '新增', '/system/param', 'POST', '52133147512406016', 3, 1, '', 43728307660783616, '2022-08-16 21:12:32', NULL, NULL);
INSERT INTO `sys_api` VALUES (52141758401740800, '修改', '/system/param', 'PUT', '52133147512406016', 4, 1, '', 43728307660783616, '2022-08-16 21:12:44', NULL, NULL);
INSERT INTO `sys_api` VALUES (52141803498897408, '删除', '/system/param/delete/*', 'DELETE', '52133147512406016', 5, 1, '', 43728307660783616, '2022-08-16 21:12:55', NULL, NULL);
INSERT INTO `sys_api` VALUES (52141938496765952, '获取最大排序', '/system/param/getMaxSort', 'GET', '52133147512406016', 6, 1, '', 43728307660783616, '2022-08-16 21:13:27', NULL, NULL);
INSERT INTO `sys_api` VALUES (86832919972151297, '列表', '/nav/category/list', 'GET', '86832919972151296', 1, 1, '', 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_api` VALUES (86832919972151298, '详情', '/nav/category/getById/*', 'GET', '86832919972151296', 2, 1, '', 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_api` VALUES (86832919972151299, '新增', '/nav/category', 'POST', '86832919972151296', 3, 1, '', 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_api` VALUES (86832919972151300, '修改', '/nav/category', 'PUT', '86832919972151296', 4, 1, '', 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_api` VALUES (86832919972151301, '删除', '/nav/category/delete/*', 'DELETE', '86832919972151296', 5, 1, '', 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_api` VALUES (86832919972151302, '获取最大排序', '/nav/category/getMaxSortByParentId', 'GET', '86832919972151296', 6, 1, '', 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_api` VALUES (86859268749262849, '分页列表', '/nav/site/page', 'GET', '86859268749262848', 1, 1, '', 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_api` VALUES (86859268749262850, '详情', '/nav/site/getById/*', 'GET', '86859268749262848', 2, 1, '', 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_api` VALUES (86859268749262851, '新增', '/nav/site', 'POST', '86859268749262848', 3, 1, '', 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_api` VALUES (86859268749262852, '修改', '/nav/site', 'PUT', '86859268749262848', 4, 1, '', 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_api` VALUES (86859268749262853, '删除', '/nav/site/delete/*', 'DELETE', '86859268749262848', 5, 1, '', 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_api` VALUES (86859268749262854, '获取最大排序', '/nav/site/getMaxSort/', 'GET', '86859268749262848', 6, 1, '', 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_api` VALUES (92732732718710784, '分页列表', '/nav/comment/page', 'GET', '92732554183966720', 1, 1, '', 43728307660783616, '2022-12-06 21:26:46', NULL, NULL);
INSERT INTO `sys_api` VALUES (92732865405517824, '通过', '/nav/comment/pass/*', 'PUT', '92732554183966720', 2, 1, '', 43728307660783616, '2022-12-06 21:27:18', NULL, NULL);
INSERT INTO `sys_api` VALUES (92732919084220416, '驳回', '/nav/comment/reject', 'PUT', '92732554183966720', 3, 1, '', 43728307660783616, '2022-12-06 21:27:31', NULL, NULL);
INSERT INTO `sys_api` VALUES (92733072901931008, '置顶', '/nav/comment/sticky/*', 'PUT', '92732554183966720', 4, 1, '', 43728307660783616, '2022-12-06 21:28:07', NULL, NULL);
INSERT INTO `sys_api` VALUES (92733166082588672, '取消置顶', '/nav/comment/cancelSticky/*', 'PUT', '92732554183966720', 5, 1, '', 43728307660783616, '2022-12-06 21:28:30', NULL, NULL);
INSERT INTO `sys_api` VALUES (92733276258566144, '删除', '/nav/comment/delete/*', 'DELETE', '92732554183966720', 6, 1, '', 43728307660783616, '2022-12-06 21:28:56', NULL, NULL);
INSERT INTO `sys_api` VALUES (94456256298745856, '获取配置', '/nav/config/getConfig', 'GET', '94456130222161920', 1, 1, '', 43728307660783616, '2022-12-11 15:35:26', NULL, NULL);
INSERT INTO `sys_api` VALUES (94456330005250048, '修改', '/nav/config', 'PUT', '94456130222161920', 2, 1, '', 43728307660783616, '2022-12-11 15:35:44', NULL, NULL);

-- ----------------------------
-- Table structure for sys_api_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_api_category`;
CREATE TABLE `sys_api_category`  (
  `id` bigint(20) NOT NULL COMMENT '接口分类 id',
  `category_name` varchar(50) NULL DEFAULT '' COMMENT '分类名称',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  `remark` varchar(500) NULL DEFAULT '' COMMENT '备注',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '系统接口分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_api_category
-- ----------------------------
INSERT INTO `sys_api_category` VALUES (43757041415618560, '用户管理', 1, 1, '', 43728307660783616, '2022-07-24 17:54:52', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (43757069869776896, '角色管理', 2, 1, '', 43728307660783616, '2022-07-24 17:54:58', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (43758191430860800, '菜单管理', 3, 1, '', 43728307660783616, '2022-07-24 17:59:26', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (43758342685851648, '数据字典', 4, 1, '', 43728307660783616, '2022-07-24 18:00:02', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (43758386155618304, '数据字典数据', 5, 1, '', 43728307660783616, '2022-07-24 18:00:12', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (43758515155632128, 'API 接口分类', 6, 1, '', 43728307660783616, '2022-07-24 18:00:43', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (43758723595763712, 'API 接口', 7, 1, '\n', 43728307660783616, '2022-07-24 18:01:33', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (43766546228576256, '登录日志', 9, 1, '', 43728307660783616, '2022-07-24 18:32:38', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (43766567304953856, '操作日志', 10, 1, '', 43728307660783616, '2022-07-24 18:32:43', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (52133147512406016, '参数配置', 8, 1, '', 43728307660783616, '2022-08-16 20:38:31', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (86832919972151296, '导航分类管理', 11, 1, '', 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (86859268749262848, '导航网站管理', 12, 1, '', 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (92732554183966720, '评论管理', 13, 1, '', 43728307660783616, '2022-12-06 21:26:04', NULL, NULL);
INSERT INTO `sys_api_category` VALUES (94456130222161920, '网站配置', 16, 1, '', 43728307660783616, '2022-12-11 15:34:56', NULL, NULL);

-- ----------------------------
-- Table structure for sys_api_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_api_menu`;
CREATE TABLE `sys_api_menu`  (
  `id` bigint(20) NOT NULL COMMENT '接口菜单 id',
  `fk_api_id` bigint(20) NOT NULL COMMENT '接口 id',
  `fk_menu_id` bigint(20) NOT NULL COMMENT '菜单 id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '系统接口菜单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_api_menu
-- ----------------------------
INSERT INTO `sys_api_menu` VALUES (44934431223316480, 43759552742555648, 43738261293629440);
INSERT INTO `sys_api_menu` VALUES (44941778175918080, 43761152815005696, 43779604086784000);
INSERT INTO `sys_api_menu` VALUES (44942911996952576, 43759676889759744, 43779675532558336);
INSERT INTO `sys_api_menu` VALUES (44942911996952577, 43761187950690304, 43779675532558336);
INSERT INTO `sys_api_menu` VALUES (44943459030663168, 43761278916755456, 43779734387032064);
INSERT INTO `sys_api_menu` VALUES (44943477556903936, 43762647782391808, 43779823738290176);
INSERT INTO `sys_api_menu` VALUES (44943667110084608, 43762807694426112, 43738420110950400);
INSERT INTO `sys_api_menu` VALUES (44943839235932160, 43762858923655168, 43780015896133632);
INSERT INTO `sys_api_menu` VALUES (44943839235932161, 43763232950714368, 43780015896133632);
INSERT INTO `sys_api_menu` VALUES (44943888078602240, 43763311845572608, 43780063644090368);
INSERT INTO `sys_api_menu` VALUES (44943942797492224, 43763188797276160, 43779962246791168);
INSERT INTO `sys_api_menu` VALUES (44943942797492225, 43763442175180800, 43779962246791168);
INSERT INTO `sys_api_menu` VALUES (45286549805334528, 43763523695673344, 43780156136882176);
INSERT INTO `sys_api_menu` VALUES (45286549805334529, 43763593107210240, 43780156136882176);
INSERT INTO `sys_api_menu` VALUES (45286549805334530, 43763693447544832, 43780156136882176);
INSERT INTO `sys_api_menu` VALUES (45286600837431296, 43763818857234432, 43780326794723328);
INSERT INTO `sys_api_menu` VALUES (45286731506778112, 43763961681674240, 43738641683447808);
INSERT INTO `sys_api_menu` VALUES (45286823873740800, 43764022897541120, 43780571997929472);
INSERT INTO `sys_api_menu` VALUES (45286823873740801, 43764081659740160, 43780571997929472);
INSERT INTO `sys_api_menu` VALUES (45286823873740802, 43764160827228160, 43780571997929472);
INSERT INTO `sys_api_menu` VALUES (45286823873740803, 43764326162497536, 43780571997929472);
INSERT INTO `sys_api_menu` VALUES (45286924520259584, 43764022897541120, 43780526653308928);
INSERT INTO `sys_api_menu` VALUES (45286924520259585, 43764130418524160, 43780526653308928);
INSERT INTO `sys_api_menu` VALUES (45286924520259586, 43764326162497536, 43780526653308928);
INSERT INTO `sys_api_menu` VALUES (45286959903408128, 43764235854938112, 43780625399808000);
INSERT INTO `sys_api_menu` VALUES (45287084751060992, 43765435992113152, 43780699760623616);
INSERT INTO `sys_api_menu` VALUES (45287084751060993, 43765773721665536, 43780699760623616);
INSERT INTO `sys_api_menu` VALUES (45287155194396672, 43764505833897984, 43738896395141120);
INSERT INTO `sys_api_menu` VALUES (45287205698011136, 43764610037186560, 43780957378969600);
INSERT INTO `sys_api_menu` VALUES (45287205698011137, 43764765633282048, 43780957378969600);
INSERT INTO `sys_api_menu` VALUES (45287965244522496, 43764642895364096, 43781009912627200);
INSERT INTO `sys_api_menu` VALUES (45287965244522497, 43764765633282048, 43781009912627200);
INSERT INTO `sys_api_menu` VALUES (45287965244522498, 45287586729558016, 43781009912627200);
INSERT INTO `sys_api_menu` VALUES (45288010920493056, 43764689900929024, 43781060101668864);
INSERT INTO `sys_api_menu` VALUES (45288359009976320, 43765127371030528, 43781756515516416);
INSERT INTO `sys_api_menu` VALUES (45288359009976321, 43765276512092160, 43781756515516416);
INSERT INTO `sys_api_menu` VALUES (45288394263101440, 43765061612732416, 43781829500600320);
INSERT INTO `sys_api_menu` VALUES (45288394263101441, 43765165673414656, 43781829500600320);
INSERT INTO `sys_api_menu` VALUES (45288394263101442, 43765276512092160, 43781829500600320);
INSERT INTO `sys_api_menu` VALUES (45288418313240576, 43765212116942848, 43781877487632384);
INSERT INTO `sys_api_menu` VALUES (45288563960446976, 43764571281817600, 43781692732735488);
INSERT INTO `sys_api_menu` VALUES (45288563960446977, 43764977332387840, 43781692732735488);
INSERT INTO `sys_api_menu` VALUES (45288684953534464, 43765395617742848, 43739074015526912);
INSERT INTO `sys_api_menu` VALUES (45288725575368704, 43765537020313600, 43820727559782400);
INSERT INTO `sys_api_menu` VALUES (45288725575368705, 43765696206733312, 43820727559782400);
INSERT INTO `sys_api_menu` VALUES (45288799676137472, 43765499997192192, 43820963283861504);
INSERT INTO `sys_api_menu` VALUES (45288799676137473, 43765569287094272, 43820963283861504);
INSERT INTO `sys_api_menu` VALUES (45288799676137474, 43765696206733312, 43820963283861504);
INSERT INTO `sys_api_menu` VALUES (45288869704237056, 43765629844455424, 43821061610930176);
INSERT INTO `sys_api_menu` VALUES (45288915245989888, 43765435992113152, 43821227462098944);
INSERT INTO `sys_api_menu` VALUES (45288915245989889, 43765773721665536, 43821227462098944);
INSERT INTO `sys_api_menu` VALUES (45288959261016064, 43766245937381376, 43821354134274048);
INSERT INTO `sys_api_menu` VALUES (45288959261016065, 43766380444516352, 43821354134274048);
INSERT INTO `sys_api_menu` VALUES (45288998154797056, 43765827249373184, 43821418193879040);
INSERT INTO `sys_api_menu` VALUES (45288998154797057, 43766278116081664, 43821418193879040);
INSERT INTO `sys_api_menu` VALUES (45288998154797058, 43766380444516352, 43821418193879040);
INSERT INTO `sys_api_menu` VALUES (45289037971324928, 43766323594919936, 43821478692519936);
INSERT INTO `sys_api_menu` VALUES (45289082435141632, 43766697940746240, 43746395802304512);
INSERT INTO `sys_api_menu` VALUES (45289104912416768, 43766812147449856, 43746859121901568);
INSERT INTO `sys_api_menu` VALUES (45289104912416769, 43766869047377920, 43746859121901568);
INSERT INTO `sys_api_menu` VALUES (52142019916595200, 52141509008424960, 52073868344426496);
INSERT INTO `sys_api_menu` VALUES (52142059640848384, 52141709437435904, 52132922030817280);
INSERT INTO `sys_api_menu` VALUES (52142059640848385, 52141938496765952, 52132922030817280);
INSERT INTO `sys_api_menu` VALUES (52142106021462016, 52141659554578432, 52133024904511488);
INSERT INTO `sys_api_menu` VALUES (52142106025656320, 52141758401740800, 52133024904511488);
INSERT INTO `sys_api_menu` VALUES (52142106025656321, 52141938496765952, 52133024904511488);
INSERT INTO `sys_api_menu` VALUES (52142131011125248, 52141803498897408, 52133076263763968);
INSERT INTO `sys_api_menu` VALUES (86832919972151307, 86832919972151297, 86832919972151303);
INSERT INTO `sys_api_menu` VALUES (86832919972151308, 86832919972151299, 86832919972151304);
INSERT INTO `sys_api_menu` VALUES (86832919972151309, 86832919972151300, 86832919972151305);
INSERT INTO `sys_api_menu` VALUES (86832919972151310, 86832919972151298, 86832919972151305);
INSERT INTO `sys_api_menu` VALUES (86832919972151311, 86832919972151301, 86832919972151306);
INSERT INTO `sys_api_menu` VALUES (86832919972151312, 86832919972151302, 86832919972151304);
INSERT INTO `sys_api_menu` VALUES (86832919972151313, 86832919972151302, 86832919972151305);
INSERT INTO `sys_api_menu` VALUES (86859268749262859, 86859268749262849, 86859268749262855);
INSERT INTO `sys_api_menu` VALUES (86859268749262860, 86859268749262851, 86859268749262856);
INSERT INTO `sys_api_menu` VALUES (86859268749262861, 86859268749262852, 86859268749262857);
INSERT INTO `sys_api_menu` VALUES (86859268749262862, 86859268749262850, 86859268749262857);
INSERT INTO `sys_api_menu` VALUES (86859268749262863, 86859268749262853, 86859268749262858);
INSERT INTO `sys_api_menu` VALUES (86859268749262864, 86859268749262854, 86859268749262856);
INSERT INTO `sys_api_menu` VALUES (86859268749262865, 86859268749262854, 86859268749262857);
INSERT INTO `sys_api_menu` VALUES (92733359674884096, 92732732718710784, 90179495205535744);
INSERT INTO `sys_api_menu` VALUES (92733462183673856, 92732865405517824, 92733418365779968);
INSERT INTO `sys_api_menu` VALUES (92733623991533568, 92732919084220416, 92733594673348608);
INSERT INTO `sys_api_menu` VALUES (92733755071922176, 92733072901931008, 92733726269636608);
INSERT INTO `sys_api_menu` VALUES (92733896281554944, 92733166082588672, 92733853243801600);
INSERT INTO `sys_api_menu` VALUES (92734000786833408, 92733276258566144, 92733965122666496);
INSERT INTO `sys_api_menu` VALUES (94456518971228160, 94456256298745856, 94456071543848960);
INSERT INTO `sys_api_menu` VALUES (94456548784340992, 94456330005250048, 94456484632461312);

-- ----------------------------
-- Table structure for sys_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary`;
CREATE TABLE `sys_dictionary`  (
  `id` bigint(20) NOT NULL COMMENT '字典 id',
  `dictionary_name` varchar(50) NULL DEFAULT '' COMMENT '字典名称',
  `dictionary_code` varchar(50) NULL DEFAULT '' COMMENT '字典编码',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  `remark` varchar(500) NULL DEFAULT '' COMMENT '备注',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '系统字典' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dictionary
-- ----------------------------
INSERT INTO `sys_dictionary` VALUES (43739630905851904, '通用状态', 'commonStatus', 1, 1, '', 43728307660783616, '2022-07-24 16:45:41', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43739903539806208, '用户类型', 'systemUserType', 2, 1, '', 43728307660783616, '2022-07-24 16:46:46', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43740085404827648, '用户性别', 'systemUserSex', 3, 1, '', 43728307660783616, '2022-07-24 16:47:29', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43740399080046592, '菜单是否缓存', 'systemMenuIsCache', 4, 1, '', 43728307660783616, '2022-07-24 16:48:44', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43740514784116736, '菜单是否外链', 'systemMenuIsFrame', 5, 1, '', 43728307660783616, '2022-07-24 16:49:11', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43740632493064192, '菜单显示状态', 'systemMenuShowStatus', 6, 1, '', 43728307660783616, '2022-07-24 16:49:39', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43741186304770048, '数据字典样式类型', 'dictionaryClassType', 7, 1, '', 43728307660783616, '2022-07-24 16:51:51', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43741186479310919, 'API 请求方式', 'apiRequestMethod', 8, 1, '', 43728307660783616, '2022-07-24 18:07:28', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43747174940409856, '登录日志状态', 'logLoginStatus', 9, 1, '', 43728307660783616, '2022-07-24 17:15:39', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43749175543726080, '操作日志业务类型', 'logOperationBusinessType', 10, 1, '', 43728307660783616, '2022-07-24 17:23:36', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43749667023880192, '操作日志操作类型', 'logOperationType', 11, 1, '', 43728307660783616, '2022-07-24 17:25:33', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (43831966709055488, '操作日志状态', 'logOperationStatus', 12, 1, '', 43728307660783616, '2022-07-24 22:52:35', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (52090055367327744, '系统参数配置类型', 'sysParamType', 13, 1, '', 43728307660783616, '2022-08-16 17:47:17', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (78246041425543168, '通用是否', 'yesNo', 1, 1, '', 43728307660783616, '2022-10-27 22:01:50', NULL, NULL);
INSERT INTO `sys_dictionary` VALUES (102543613031874560, '评论状态', 'navCommentStatus', 14, 1, '', 43728307660783616, '2023-01-02 23:11:43', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dictionary_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary_data`;
CREATE TABLE `sys_dictionary_data`  (
  `id` bigint(20) NOT NULL COMMENT '字典数据 id',
  `dictionary_label` varchar(50) NULL DEFAULT '' COMMENT '字典标签',
  `dictionary_value` varchar(100) NULL DEFAULT '' COMMENT '字典值',
  `fk_dictionary_id` varchar(25) NULL DEFAULT NULL COMMENT '所属字典 id',
  `class_type` varchar(100) NULL DEFAULT '' COMMENT '样式类型（primary，success等）',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  `remark` varchar(500) NULL DEFAULT '' COMMENT '备注',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '系统字典数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dictionary_data
-- ----------------------------
INSERT INTO `sys_dictionary_data` VALUES (43739723671273472, '正常', '1', '43739630905851904', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 16:46:03', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43739751852802048, '停用', '2', '43739630905851904', 'danger', 2, 1, '', 43728307660783616, '2022-07-24 16:46:09', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43744355986440192, '后台用户', '1', '43739903539806208', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 17:04:27', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43744417940504576, '博客用户', '2', '43739903539806208', 'warning', 2, 1, '', 43728307660783616, '2022-07-24 17:04:42', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43744494792736768, '保密', '1', '43740085404827648', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 17:05:00', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43744558772649984, '男', '2', '43740085404827648', 'success', 2, 1, '', 43728307660783616, '2022-07-24 17:05:16', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43744612069670912, '女', '3', '43740085404827648', 'warning', 3, 1, '', 43728307660783616, '2022-07-24 17:05:28', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745015746265088, '缓存', '1', '43740399080046592', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 17:07:04', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745054946230272, '不缓存', '2', '43740399080046592', 'success', 2, 1, '', 43728307660783616, '2022-07-24 17:07:14', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745129718087680, '是', '1', '43740514784116736', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 17:07:32', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745161041149952, '否', '2', '43740514784116736', 'success', 2, 1, '', 43728307660783616, '2022-07-24 17:07:39', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745249540964352, '显示', '1', '43740632493064192', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 17:08:00', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745280234881024, '隐藏', '2', '43740632493064192', 'success', 2, 1, '', 43728307660783616, '2022-07-24 17:08:08', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745438393696256, '默认(default)', 'default', '43741186304770048', 'default', 1, 1, '', 43728307660783616, '2022-07-24 17:08:45', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745535164678144, '主要(primary)', 'primary', '43741186304770048', 'primary', 2, 1, '', 43728307660783616, '2022-07-24 17:09:08', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745625509986304, '成功(success)', 'success', '43741186304770048', 'success', 3, 1, '', 43728307660783616, '2022-07-24 17:09:30', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745706313252864, '信息(info)', 'info', '43741186304770048', 'info', 4, 1, '', 43728307660783616, '2022-07-24 17:09:49', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745788475473920, '警告(warning)', 'warning', '43741186304770048', 'warning', 5, 1, '', 43728307660783616, '2022-07-24 17:10:09', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43745861963874304, '危险(danger)', 'danger', '43741186304770048', 'danger', 6, 1, '', 43728307660783616, '2022-07-24 17:10:26', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43747219504889856, '成功', '1', '43747174940409856', 'success', 1, 1, '', 43728307660783616, '2022-07-24 17:15:50', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43747249070538752, '失败', '2', '43747174940409856', 'danger', 2, 1, '', 43728307660783616, '2022-07-24 17:15:57', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43749310080221184, '其他', '1', '43749175543726080', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 17:24:08', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43749355009605632, '新增', '2', '43749175543726080', 'info', 2, 1, '', 43728307660783616, '2022-07-24 17:24:19', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43749395618856960, '修改', '3', '43749175543726080', 'warning', 3, 1, '', 43728307660783616, '2022-07-24 17:24:29', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43749433191432192, '删除', '4', '43749175543726080', 'danger', 4, 1, '', 43728307660783616, '2022-07-24 17:24:38', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43749748162691072, '其他', '1', '43749667023880192', 'default', 1, 1, '', 43728307660783616, '2022-07-24 17:25:53', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43749792488095744, '后台用户', '2', '43749667023880192', 'primary', 2, 1, '', 43728307660783616, '2022-07-24 17:26:03', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43749847500587008, '手机端用户', '3', '43749667023880192', 'info', 3, 1, '', 43728307660783616, '2022-07-24 17:26:16', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43749905755275264, '博客用户', '4', '43749667023880192', 'warning', 4, 1, '', 43728307660783616, '2022-07-24 17:26:30', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43760754016387072, 'GET', 'GET', '43741186479310919', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 18:09:37', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43760839513079808, 'POST', 'POST', '43741186479310919', 'info', 2, 1, '', 43728307660783616, '2022-07-24 18:09:57', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43760910166130688, 'PUT', 'PUT', '43741186479310919', 'warning', 3, 1, '', 43728307660783616, '2022-07-24 18:10:14', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43760951937204224, 'DELETE', 'DELETE', '43741186479310919', 'danger', 4, 1, '', 43728307660783616, '2022-07-24 18:10:24', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43832012938674176, '成功', '1', '43831966709055488', 'primary', 1, 1, '', 43728307660783616, '2022-07-24 22:52:46', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (43832045444530176, '异常', '2', '43831966709055488', 'danger', 2, 1, '', 43728307660783616, '2022-07-24 22:52:54', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (52090134002139136, '系统内置', '1', '52090055367327744', 'primary', 1, 1, '', 43728307660783616, '2022-08-16 17:47:36', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (67409162056761344, '导航管理', '2', '52090055367327744', 'info', 2, 1, '', 43728307660783616, '2022-09-28 00:19:57', 43728307660783616, '2022-12-10 23:13:20');
INSERT INTO `sys_dictionary_data` VALUES (78246089743925248, '是', '1', '78246041425543168', 'primary', 1, 1, '', 43728307660783616, '2022-10-27 22:02:02', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (78246125886242816, '否', '2', '78246041425543168', 'danger', 2, 1, '', 43728307660783616, '2022-10-27 22:02:10', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (102543668505739264, '待审核', '1', '102543613031874560', 'primary', 1, 1, '', 43728307660783616, '2023-01-02 23:11:56', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (102543729629331456, '已通过', '2', '102543613031874560', 'success', 2, 1, '', 43728307660783616, '2023-01-02 23:12:10', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (102543767784914944, '已驳回', '3', '102543613031874560', 'danger', 3, 1, '', 43728307660783616, '2023-01-02 23:12:19', NULL, NULL);
INSERT INTO `sys_dictionary_data` VALUES (143468816637100032, '主题配置', '3', '52090055367327744', 'warning', 3, 1, '', 43728307660783616, '2023-04-25 21:33:51', 43728307660783616, '2023-04-25 21:34:08');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL COMMENT '菜单 id',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `menu_type` char(1) NULL DEFAULT '' COMMENT '菜单类型（D 目录，M 菜单，B 按钮）',
  `permission_code` varchar(100) NULL DEFAULT '' COMMENT '权限标识',
  `router_url` varchar(200) NULL DEFAULT '' COMMENT '路由地址',
  `component_path` varchar(255) NULL DEFAULT '' COMMENT '组件路径',
  `router_param` varchar(255) NULL DEFAULT '' COMMENT '路由参数',
  `has_frame` tinyint(1) NULL DEFAULT 2 COMMENT '是否为外链（1是，2否）',
  `has_cache` tinyint(1) NULL DEFAULT 1 COMMENT '是否缓存（1缓存，2不缓存）',
  `has_permission` tinyint(1) NULL DEFAULT 1 COMMENT '是否需要权限（1 是，2 否）',
  `menu_icon` varchar(100) NULL DEFAULT '' COMMENT '菜单图标',
  `show_status` tinyint(1) NULL DEFAULT 1 COMMENT '显示状态（1显示，2隐藏）',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '系统菜单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (43737833021636608, '系统管理', 0, 1, 'D', NULL, 'system', NULL, NULL, 2, 1, 1, 'system', 1, 1, 43728307660783616, '2022-07-24 16:38:32', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43738261293629440, '用户管理', 43737833021636608, 1, 'M', 'system:user:page', 'user', 'system/user/index', NULL, 2, 1, 1, 'user', 1, 1, 43728307660783616, '2022-07-24 16:40:14', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43738420110950400, '角色管理', 43737833021636608, 2, 'M', 'system:role:page', 'role', 'system/role/index', NULL, 2, 1, 1, 'peoples', 1, 1, 43728307660783616, '2022-07-24 16:40:52', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43738641683447808, '菜单管理', 43737833021636608, 3, 'M', 'system:menu:list', 'menu', 'system/menu/index', NULL, 2, 1, 1, 'menu', 1, 1, 43728307660783616, '2022-07-24 16:41:45', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43738896395141120, '数据字典', 43737833021636608, 4, 'M', 'system:dictionary:page', 'dictionary', 'system/dictionary/index', NULL, 2, 1, 1, 'dict', 1, 1, 43728307660783616, '2022-07-24 16:42:46', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43739074015526912, 'API 管理', 43737833021636608, 5, 'M', 'system:apiCatetory:page', 'api', 'system/api/category', NULL, 2, 1, 1, 'documentation', 1, 1, 43728307660783616, '2022-07-24 16:43:28', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43746238872420352, '日志审计', 0, 3, 'D', '', 'log', '', '', 2, 1, 1, 'edit', 1, 1, 43728307660783616, '2022-07-24 17:11:56', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43746395802304512, '登录日志', 43746238872420352, 1, 'M', 'log:login:page', 'login', 'system/log/login/index', '', 2, 1, 1, 'logininfor', 1, 1, 43728307660783616, '2022-07-24 17:12:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43746859121901568, '操作日志', 43746238872420352, 2, 'M', 'log:operation:page', 'operation', 'system/log/operation/index', '', 2, 1, 1, 'form', 1, 1, 43728307660783616, '2022-07-24 17:14:24', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43779604086784000, '新增', 43738261293629440, 1, 'B', 'system:user:add', '', 'system/log/operation/index', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:24:31', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43779675532558336, '修改', 43738261293629440, 2, 'B', 'system:user:update', '', 'system/log/operation/index', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:24:48', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43779734387032064, '删除', 43738261293629440, 3, 'B', 'system:user:delete', '', 'system/log/operation/index', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:25:02', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43779823738290176, '重置密码', 43738261293629440, 4, 'B', 'system:user:resetPassword', '', 'system/log/operation/index', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:25:23', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43779962246791168, '新增', 43738420110950400, 1, 'B', 'system:role:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:25:56', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780015896133632, '修改', 43738420110950400, 2, 'B', 'system:role:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:26:09', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780063644090368, '删除', 43738420110950400, 3, 'B', 'system:role:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:26:21', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780156136882176, '分配用户', 43738420110950400, 4, 'B', 'system:role:authUser', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:26:43', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780326794723328, '取消用户授权', 43738420110950400, 5, 'B', 'system:user:deleteAuthUser', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:27:23', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780526653308928, '新增', 43738641683447808, 1, 'B', 'system:menu:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:28:11', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780571997929472, '修改', 43738641683447808, 2, 'B', 'system:menu:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:28:22', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780625399808000, '删除', 43738641683447808, 3, 'B', 'system:menu:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:28:35', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780699760623616, '分配 API', 43738641683447808, 4, 'B', 'system:menu:allocateApi', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:28:52', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43780957378969600, '新增', 43738896395141120, 1, 'B', 'system:dictionary:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:29:54', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43781009912627200, '修改', 43738896395141120, 2, 'B', 'system:dictionary:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:30:06', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43781060101668864, '删除', 43738896395141120, 3, 'B', 'system:dictionary:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:30:18', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43781692732735488, '分配数据', 43738896395141120, 4, 'B', 'system:dictionary:data:page', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:32:49', 43728307660783616, '2022-09-12 16:32:11');
INSERT INTO `sys_menu` VALUES (43781756515516416, '数据新增', 43738896395141120, 5, 'B', 'system:dictionaryData:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:33:04', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43781829500600320, '数据修改', 43738896395141120, 6, 'B', 'system:dictionary:data:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:33:22', 43728307660783616, '2022-09-12 16:32:18');
INSERT INTO `sys_menu` VALUES (43781877487632384, '数据删除', 43738896395141120, 7, 'B', 'system:dictionary:data:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 19:33:33', 43728307660783616, '2022-09-12 16:32:23');
INSERT INTO `sys_menu` VALUES (43820727559782400, '分类新增', 43739074015526912, 1, 'B', 'system:apiCategory:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 22:07:56', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43820963283861504, '分类修改', 43739074015526912, 2, 'B', 'system:apiCategory:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 22:08:52', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43821061610930176, '分类删除', 43739074015526912, 3, 'B', 'system:apiCategory:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 22:09:15', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43821227462098944, '分配数据', 43739074015526912, 4, 'B', 'system:api:page', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 22:09:55', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43821354134274048, '数据新增', 43739074015526912, 5, 'B', 'system:api:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 22:10:25', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43821418193879040, '数据修改', 43739074015526912, 6, 'B', 'system:api:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 22:10:40', NULL, NULL);
INSERT INTO `sys_menu` VALUES (43821478692519936, '数据删除', 43739074015526912, 7, 'B', 'system:api:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-07-24 22:10:55', NULL, NULL);
INSERT INTO `sys_menu` VALUES (52073868344426496, '参数配置', 43737833021636608, 6, 'M', 'system:param:page', 'param', 'system/param/index', '', 2, 1, 1, 'edit', 1, 1, 43728307660783616, '2022-08-16 16:42:58', 43728307660783616, '2022-08-16 16:59:24');
INSERT INTO `sys_menu` VALUES (52132922030817280, '新增', 52073868344426496, 1, 'B', 'system:param:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-08-16 20:37:37', NULL, NULL);
INSERT INTO `sys_menu` VALUES (52133024904511488, '修改', 52073868344426496, 2, 'B', 'system:param:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-08-16 20:38:02', NULL, NULL);
INSERT INTO `sys_menu` VALUES (52133076263763968, '删除', 52073868344426496, 3, 'B', 'system:param:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-08-16 20:38:14', NULL, NULL);
INSERT INTO `sys_menu` VALUES (86832919972151303, '分类管理', 86833558454272000, 1, 'M', 'nav:category:page', 'category', 'nav/category/index', '', 2, 1, 1, 'heart', 1, 1, 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_menu` VALUES (86832919972151304, '新增', 86832919972151303, 1, 'B', 'nav:category:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_menu` VALUES (86832919972151305, '修改', 86832919972151303, 2, 'B', 'nav:category:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_menu` VALUES (86832919972151306, '删除', 86832919972151303, 3, 'B', 'nav:category:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-11-20 14:43:41', NULL, NULL);
INSERT INTO `sys_menu` VALUES (86833558454272000, '导航管理', 0, 4, 'D', '', 'nav', '', '', 2, 1, 1, 'computer', 1, 1, 43728307660783616, '2022-11-20 14:45:34', 43728307660783616, '2023-05-21 16:34:42');
INSERT INTO `sys_menu` VALUES (86859268749262855, '网站管理', 86833558454272000, 2, 'M', 'nav:site:page', 'site', 'nav/site/index', '', 2, 1, 1, 'star', 1, 1, 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_menu` VALUES (86859268749262856, '新增', 86859268749262855, 1, 'B', 'nav:site:add', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_menu` VALUES (86859268749262857, '修改', 86859268749262855, 2, 'B', 'nav:site:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_menu` VALUES (86859268749262858, '删除', 86859268749262855, 3, 'B', 'nav:site:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-11-20 16:27:55', NULL, NULL);
INSERT INTO `sys_menu` VALUES (90179495205535744, '评论管理', 86833558454272000, 3, 'M', 'nav:comment:page', 'comment', 'nav/comment/index', '', 2, 1, 1, 'message', 1, 1, 43728307660783616, '2022-11-29 20:21:07', NULL, NULL);
INSERT INTO `sys_menu` VALUES (92733418365779968, '通过', 90179495205535744, 1, 'B', 'nav:comment:pass', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-12-06 21:29:30', NULL, NULL);
INSERT INTO `sys_menu` VALUES (92733594673348608, '驳回', 90179495205535744, 2, 'B', 'nav:comment:reject', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-12-06 21:30:12', NULL, NULL);
INSERT INTO `sys_menu` VALUES (92733726269636608, '置顶', 90179495205535744, 3, 'B', 'nav:comment:sticky', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-12-06 21:30:43', NULL, NULL);
INSERT INTO `sys_menu` VALUES (92733853243801600, '取消置顶', 90179495205535744, 4, 'B', 'nav:comment:sticky:cancle', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-12-06 21:31:14', NULL, NULL);
INSERT INTO `sys_menu` VALUES (92733965122666496, '删除', 90179495205535744, 5, 'B', 'nav:comment:delete', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-12-06 21:31:40', NULL, NULL);
INSERT INTO `sys_menu` VALUES (94456071543848960, '网站配置', 86833558454272000, 6, 'M', 'nav:config:get', 'config', 'nav/config/index', '', 2, 1, 1, 'website', 1, 1, 43728307660783616, '2022-12-11 15:34:42', 43728307660783616, '2022-12-11 15:37:21');
INSERT INTO `sys_menu` VALUES (94456484632461312, '修改', 94456071543848960, 1, 'B', 'nav:config:update', '', '', '', 2, 1, 1, '', 1, 1, 43728307660783616, '2022-12-11 15:36:21', NULL, NULL);

-- ----------------------------
-- Table structure for sys_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_param`;
CREATE TABLE `sys_param`  (
  `id` bigint(20) NOT NULL COMMENT '参数 id',
  `param_name` varchar(100) NULL DEFAULT '' COMMENT '参数名称',
  `param_key` varchar(100) NULL DEFAULT '' COMMENT '参数键',
  `param_value` varchar(200) NULL DEFAULT '' COMMENT '参数值',
  `param_type` tinyint(1) NULL DEFAULT NULL COMMENT '参数类型（1 系统参数）',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `remark` varchar(500) NULL DEFAULT '' COMMENT '备注',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '参数配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_param
-- ----------------------------
INSERT INTO `sys_param` VALUES (52091717515476992, '默认密码', 'SYS_DEFAULT_PASSWORD', 'gesdh@2022', 1, 1, '默认密码', 43728307660783616, '2022-08-16 17:53:53', 43728307660783616, '2022-12-10 23:22:55');
INSERT INTO `sys_param` VALUES (70810422013329408, '评论开启', 'NAV_COMMENT_OPEN', 'true', 2, 2, '评论是否开启', 43728307660783616, '2022-10-07 09:35:20', 43728307660783616, '2023-04-15 00:55:55');
INSERT INTO `sys_param` VALUES (140123273550626816, '评论无登录开启', 'NAV_COMMENT_NOT_LOGIN_OPEN', 'true', 1, 6, '是否开启不用登录就能提交评论', 43728307660783616, '2023-04-16 15:59:52', 43728307660783616, '2023-04-16 16:23:53');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL COMMENT '角色 id',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_code` varchar(100) NOT NULL COMMENT '角色编码',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  `remark` varchar(500) NULL DEFAULT '' COMMENT '备注',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_role_code`(`role_code` ASC) USING BTREE COMMENT '角色编码唯一索引'
) ENGINE = InnoDB COMMENT = '系统角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (43735562707795968, '超级管理员', 'superAdmin', 1, 1, '', 43728307660783616, '2022-07-24 16:29:31', NULL, NULL);
INSERT INTO `sys_role` VALUES (43767332559912960, '普通角色', 'commonRole', 2, 1, '', 43728307660783616, '2022-07-24 18:35:45', 43728307660783616, '2022-10-31 00:02:36');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(20) NOT NULL COMMENT '角色菜单 id',
  `fk_role_id` bigint(20) NOT NULL COMMENT '角色 id',
  `fk_menu_id` bigint(20) NOT NULL COMMENT '菜单 id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '系统角色菜单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (86492067173236736, 43767332559912960, 43737833021636608);
INSERT INTO `sys_role_menu` VALUES (86492067177431040, 43767332559912960, 43738261293629440);
INSERT INTO `sys_role_menu` VALUES (86492067177431041, 43767332559912960, 43779604086784000);
INSERT INTO `sys_role_menu` VALUES (86492067177431042, 43767332559912960, 43779675532558336);
INSERT INTO `sys_role_menu` VALUES (86492067181625344, 43767332559912960, 43779734387032064);
INSERT INTO `sys_role_menu` VALUES (86492067181625345, 43767332559912960, 43779823738290176);
INSERT INTO `sys_role_menu` VALUES (86492067185819648, 43767332559912960, 43738420110950400);
INSERT INTO `sys_role_menu` VALUES (86492067185819649, 43767332559912960, 43779962246791168);
INSERT INTO `sys_role_menu` VALUES (86492067185819650, 43767332559912960, 43780015896133632);
INSERT INTO `sys_role_menu` VALUES (86492067185819651, 43767332559912960, 43780063644090368);
INSERT INTO `sys_role_menu` VALUES (86492067190013952, 43767332559912960, 43780156136882176);
INSERT INTO `sys_role_menu` VALUES (86492067190013953, 43767332559912960, 43780326794723328);
INSERT INTO `sys_role_menu` VALUES (86492067190013954, 43767332559912960, 43738641683447808);
INSERT INTO `sys_role_menu` VALUES (86492067190013955, 43767332559912960, 43780526653308928);
INSERT INTO `sys_role_menu` VALUES (86492067190013956, 43767332559912960, 43780571997929472);
INSERT INTO `sys_role_menu` VALUES (86492067194208256, 43767332559912960, 43780625399808000);
INSERT INTO `sys_role_menu` VALUES (86492067194208257, 43767332559912960, 43780699760623616);
INSERT INTO `sys_role_menu` VALUES (86492067194208258, 43767332559912960, 43738896395141120);
INSERT INTO `sys_role_menu` VALUES (86492067194208259, 43767332559912960, 43780957378969600);
INSERT INTO `sys_role_menu` VALUES (86492067198402560, 43767332559912960, 43781009912627200);
INSERT INTO `sys_role_menu` VALUES (86492067198402561, 43767332559912960, 43781060101668864);
INSERT INTO `sys_role_menu` VALUES (86492067198402562, 43767332559912960, 43781692732735488);
INSERT INTO `sys_role_menu` VALUES (86492067198402563, 43767332559912960, 43781756515516416);
INSERT INTO `sys_role_menu` VALUES (86492067198402564, 43767332559912960, 43781829500600320);
INSERT INTO `sys_role_menu` VALUES (86492067202596864, 43767332559912960, 43781877487632384);
INSERT INTO `sys_role_menu` VALUES (86492067202596865, 43767332559912960, 43739074015526912);
INSERT INTO `sys_role_menu` VALUES (86492067202596866, 43767332559912960, 43820727559782400);
INSERT INTO `sys_role_menu` VALUES (86492067202596867, 43767332559912960, 43820963283861504);
INSERT INTO `sys_role_menu` VALUES (86492067206791168, 43767332559912960, 43821061610930176);
INSERT INTO `sys_role_menu` VALUES (86492067206791169, 43767332559912960, 43821227462098944);
INSERT INTO `sys_role_menu` VALUES (86492067206791170, 43767332559912960, 43821354134274048);
INSERT INTO `sys_role_menu` VALUES (86492067206791171, 43767332559912960, 43821418193879040);
INSERT INTO `sys_role_menu` VALUES (86492067206791172, 43767332559912960, 43821478692519936);
INSERT INTO `sys_role_menu` VALUES (86492067210985472, 43767332559912960, 52073868344426496);
INSERT INTO `sys_role_menu` VALUES (86492067210985473, 43767332559912960, 52132922030817280);
INSERT INTO `sys_role_menu` VALUES (86492067210985474, 43767332559912960, 52133024904511488);
INSERT INTO `sys_role_menu` VALUES (86492067210985475, 43767332559912960, 52133076263763968);
INSERT INTO `sys_role_menu` VALUES (86492067215179776, 43767332559912960, 86489144947113984);
INSERT INTO `sys_role_menu` VALUES (86492067215179777, 43767332559912960, 86489393493180416);
INSERT INTO `sys_role_menu` VALUES (86492067215179778, 43767332559912960, 86490122438049792);
INSERT INTO `sys_role_menu` VALUES (86492067215179779, 43767332559912960, 86490199768432640);
INSERT INTO `sys_role_menu` VALUES (86492067215179780, 43767332559912960, 86490267254784000);
INSERT INTO `sys_role_menu` VALUES (86492067219374080, 43767332559912960, 86490311785709568);
INSERT INTO `sys_role_menu` VALUES (86492067219374081, 43767332559912960, 86490372783472640);
INSERT INTO `sys_role_menu` VALUES (86492067219374082, 43767332559912960, 86490430765531136);
INSERT INTO `sys_role_menu` VALUES (86492067223568384, 43767332559912960, 43746238872420352);
INSERT INTO `sys_role_menu` VALUES (86492067223568385, 43767332559912960, 43746395802304512);
INSERT INTO `sys_role_menu` VALUES (86492067223568386, 43767332559912960, 43746859121901568);
INSERT INTO `sys_role_menu` VALUES (86492067223568387, 43767332559912960, 52099144042414080);
INSERT INTO `sys_role_menu` VALUES (86492067223568388, 43767332559912960, 52099447332536320);
INSERT INTO `sys_role_menu` VALUES (86492067227762688, 43767332559912960, 52099788358811648);
INSERT INTO `sys_role_menu` VALUES (86492067227762689, 43767332559912960, 52099936145113088);
INSERT INTO `sys_role_menu` VALUES (86492067227762690, 43767332559912960, 52100202487611392);
INSERT INTO `sys_role_menu` VALUES (86492067227762691, 43767332559912960, 52100286625349632);
INSERT INTO `sys_role_menu` VALUES (86492067231956992, 43767332559912960, 52114381915291648);
INSERT INTO `sys_role_menu` VALUES (86492067231956993, 43767332559912960, 52114517684912128);
INSERT INTO `sys_role_menu` VALUES (86492067231956994, 43767332559912960, 52114568226275328);
INSERT INTO `sys_role_menu` VALUES (86492067231956995, 43767332559912960, 52114614602694656);
INSERT INTO `sys_role_menu` VALUES (86492067236151296, 43767332559912960, 52114878701240320);
INSERT INTO `sys_role_menu` VALUES (86492067236151297, 43767332559912960, 52114929196466176);
INSERT INTO `sys_role_menu` VALUES (86492067236151298, 43767332559912960, 52114968178327552);
INSERT INTO `sys_role_menu` VALUES (86492067236151299, 43767332559912960, 52115022117076992);
INSERT INTO `sys_role_menu` VALUES (86492067236151300, 43767332559912960, 55073494739714048);
INSERT INTO `sys_role_menu` VALUES (86492067240345600, 43767332559912960, 61851202979102720);
INSERT INTO `sys_role_menu` VALUES (86492067240345601, 43767332559912960, 61851247690383360);
INSERT INTO `sys_role_menu` VALUES (86492067240345602, 43767332559912960, 61851299972382720);
INSERT INTO `sys_role_menu` VALUES (86492067240345603, 43767332559912960, 61851660971933696);
INSERT INTO `sys_role_menu` VALUES (86492067244539904, 43767332559912960, 61851798276669440);
INSERT INTO `sys_role_menu` VALUES (86492067244539905, 43767332559912960, 61851972713578496);
INSERT INTO `sys_role_menu` VALUES (86492067244539906, 43767332559912960, 70575761538416640);
INSERT INTO `sys_role_menu` VALUES (86492067244539907, 43767332559912960, 70591784899575808);
INSERT INTO `sys_role_menu` VALUES (86492067244539908, 43767332559912960, 70591842319597568);
INSERT INTO `sys_role_menu` VALUES (86492067248734208, 43767332559912960, 70591937538686976);
INSERT INTO `sys_role_menu` VALUES (86492067248734209, 43767332559912960, 77878458918633472);
INSERT INTO `sys_role_menu` VALUES (86492067248734210, 43767332559912960, 78232604175761408);
INSERT INTO `sys_role_menu` VALUES (86492067248734211, 43767332559912960, 78232661448982528);
INSERT INTO `sys_role_menu` VALUES (86492067252928512, 43767332559912960, 78243661845889024);
INSERT INTO `sys_role_menu` VALUES (86492067252928513, 43767332559912960, 78261905201823744);
INSERT INTO `sys_role_menu` VALUES (86492067252928514, 43767332559912960, 78261973308932096);
INSERT INTO `sys_role_menu` VALUES (86492067252928515, 43767332559912960, 78262028635996160);
INSERT INTO `sys_role_menu` VALUES (86492067257122816, 43767332559912960, 78582377730801664);
INSERT INTO `sys_role_menu` VALUES (86492067257122817, 43767332559912960, 78594439798325248);
INSERT INTO `sys_role_menu` VALUES (86492067257122818, 43767332559912960, 78595081065463808);
INSERT INTO `sys_role_menu` VALUES (104307851295457280, 104307851257708544, 104307285068611584);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL COMMENT '用户 id',
  `username` varchar(40) NOT NULL DEFAULT '' COMMENT '用户名',
  `nick_name` varchar(40) NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(100) NULL DEFAULT '' COMMENT '密码',
  `sex` tinyint(1) NULL DEFAULT 1 COMMENT '用户性别（1 保密，2 男，3 女）',
  `user_type` tinyint(1) NULL DEFAULT 1 COMMENT '用户类型（1 后台用户，2 博客用户）',
  `email` varchar(50) NULL DEFAULT '' COMMENT '邮箱',
  `mobile_phone` varchar(11) NULL DEFAULT '' COMMENT '手机号码',
  `avatar` varchar(100) NULL DEFAULT '' COMMENT '头像地址',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1 正常，2 停用）',
  `remark` varchar(500) NULL DEFAULT '' COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 1 COMMENT '删除标志（1 未删除，2 已删除）',
  `fk_create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人用户 id',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_modify_user_id` bigint(20) NULL DEFAULT NULL COMMENT '修改人用户 id',
  `gmt_modify` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_username`(`username` ASC) USING BTREE COMMENT '用户名唯一索引'
) ENGINE = InnoDB COMMENT = '系统用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (43728307660783616, 'admin', '管理员', '$2a$10$uYSATn7m4cmLFtr4uz7rs.W8a0s3EbwZJCyGnthUrZacMgKh4GoIG', 1, 1, '497301391@qq.com', '', '', 1, '我是管理员', 1, 43728307660783616, '2022-07-24 16:02:02', 43728307660783616, '2023-01-04 22:44:48');
INSERT INTO `sys_user` VALUES (43767104519798784, 'geshanzsq', '格姗知识圈', '$2a$10$rm5jwWc6lRM11Q.OOEH2T.t41GnkzITcvVAI19LdAicn5/AJdD0im', 3, 1, '497301391@qq.com', '', '', 1, '', 1, 43728307660783616, '2022-07-24 18:34:51', 43728307660783616, '2022-08-15 00:03:28');
INSERT INTO `sys_user` VALUES (43767196689629184, 'xgz', '小格子', '$2a$10$mh3A6xcNuwM6zfjQgQ/xHOmilj92Vj1JWbiB9VTktUD7zccynLD02', 2, 1, '497301391@qq.com', '', '', 1, '', 1, 43728307660783616, '2022-07-24 18:35:13', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL COMMENT '用户角色 id',
  `fk_user_id` bigint(20) NOT NULL COMMENT '用户 id',
  `fk_role_id` bigint(20) NOT NULL COMMENT '角色 id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '系统用户角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (43737619212795904, 43728307660783616, 43735562707795968);
INSERT INTO `sys_user_role` VALUES (43767363438379008, 43767104519798784, 43767332559912960);
INSERT INTO `sys_user_role` VALUES (43767363438379009, 43767196689629184, 43767332559912960);

SET FOREIGN_KEY_CHECKS = 1;
