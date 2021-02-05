/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : geshanzsq_nav

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 07/01/2021 00:17:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '表描述',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for nav_menu
-- ----------------------------
DROP TABLE IF EXISTS `nav_menu`;
CREATE TABLE `nav_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父级id',
  `order_num` int(11) NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `menu_icon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '修改人',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态，0 正常，1 停用',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1048 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '导航分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nav_menu
-- ----------------------------
INSERT INTO `nav_menu` VALUES (102, 0, 2, '常用推荐', 'star', '2020-07-04 13:31:32', '2020-07-29 20:59:13', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (103, 0, 3, '资源搜索', 'search', '2020-07-10 23:58:54', '2020-07-29 20:59:25', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (104, 0, 4, '常用工具', 'cogs', '2020-07-25 19:39:39', '2020-07-29 21:00:56', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (105, 0, 5, '学习教程', 'study', '2020-07-25 19:39:39', '2020-07-29 21:01:07', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (106, 0, 6, '软件下载', 'software', '2020-07-25 19:39:39', '2020-07-29 21:01:15', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (107, 0, 7, '休闲娱乐', 'music', '2020-07-25 19:39:39', '2020-07-29 21:02:10', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (108, 0, 8, '灵感采集', 'Light-Bulb', '2020-07-25 21:41:31', '2020-08-01 15:23:44', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (109, 0, 9, '素材资源', 'international', '2020-07-25 21:41:31', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1001, 103, 1, '网盘搜索', 'chart', '2020-07-11 00:02:09', '2020-07-11 11:35:42', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1002, 103, 2, '电子书搜索', 'code', '2020-07-11 10:46:40', '2020-07-11 11:35:46', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1004, 104, 1, '格式转换', 'lock', '2020-07-25 21:30:22', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1005, 104, 2, '语言翻译', 'component', '2020-07-25 21:30:22', '2020-07-25 21:31:18', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1006, 109, 1, '图标素材', 'component', '2020-07-25 21:30:22', '2020-07-25 21:31:18', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1007, 105, 1, '博客网站', 'wechat', '2020-07-25 21:43:34', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1008, 106, 1, 'Windows', 'tool', '2020-07-25 21:44:10', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1009, 106, 2, 'Android', 'upload', '2020-07-25 21:44:36', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1010, 106, 3, 'Apple|Mac', 'time', '2020-07-25 21:44:52', '2020-08-18 22:46:22', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1011, 107, 1, '影视', 'icon', '2020-07-25 21:45:44', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1012, 107, 2, '音乐', 'people', '2020-07-25 21:45:58', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1013, 104, 3, '图形创意', 'dict', '2020-08-01 15:06:54', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1014, 104, 4, '界面设计', NULL, '2020-08-01 15:08:33', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1015, 104, 5, '交互动效', NULL, '2020-08-01 15:13:19', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1016, 104, 6, '在线配色', NULL, '2020-08-01 15:15:46', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1017, 104, 7, '在线工具', NULL, '2020-08-01 15:15:58', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1018, 104, 8, 'Chrome插件', NULL, '2020-08-01 15:16:14', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1019, 108, 1, '发现产品', NULL, '2020-08-01 15:23:57', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1020, 108, 2, '界面灵感', NULL, '2020-08-01 15:24:11', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1021, 108, 3, '网页灵感', NULL, '2020-08-01 15:24:34', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1022, 109, 2, 'LOGO设计', NULL, '2020-08-01 15:35:28', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1023, 109, 3, '平面素材', NULL, '2020-08-01 15:35:55', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1024, 109, 4, 'UI资源', NULL, '2020-08-01 15:36:05', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1025, 109, 5, 'Sketch资源', NULL, '2020-08-01 15:36:17', '2020-08-01 15:36:34', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1026, 109, 6, '字体资源', NULL, '2020-08-01 15:36:40', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1027, 109, 7, 'Mockup', NULL, '2020-08-01 15:37:03', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1028, 109, 8, '摄影图库', NULL, '2020-08-01 15:37:24', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1029, 109, 9, 'PPT资源', NULL, '2020-08-01 15:37:35', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1030, 105, 4, '后端学习', NULL, '2020-08-08 15:06:09', '2020-08-08 15:19:02', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1031, 105, 3, '前端学习', NULL, '2020-08-08 15:07:26', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1032, 105, 2, '个人博客', NULL, '2020-08-08 15:19:13', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1033, 103, 3, '综合搜索', NULL, '2020-08-09 21:59:05', '2020-08-09 22:02:10', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1034, 0, 10, '自媒体', 'select', '2020-08-11 17:44:07', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1035, 1034, 1, '运营平台', NULL, '2020-08-11 17:44:31', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1036, 1034, 3, '图片素材', NULL, '2020-08-11 20:12:23', '2020-08-20 11:02:38', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1037, 109, 0, '桌面壁纸', NULL, '2020-08-19 19:39:19', '2020-08-19 19:59:41', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1038, 103, 4, '网盘提取码', NULL, '2020-08-19 20:22:06', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1039, 1034, 2, '排版工具', NULL, '2020-08-20 11:02:52', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1040, 104, 9, 'Github加速下载', NULL, '2020-08-31 22:51:30', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1041, 104, 10, '文库文档', NULL, '2020-09-16 10:31:16', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1042, 105, 5, '开源项目', NULL, '2020-09-16 14:37:04', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1043, 104, 11, '电视直播', NULL, '2020-09-20 14:54:03', NULL, 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1046, 106, 0, '软件博客', NULL, '2020-10-16 21:41:47', '2020-10-16 21:41:55', 'geshanzsq', 'geshanzsq', 0);
INSERT INTO `nav_menu` VALUES (1047, 107, 3, '游戏资源', NULL, '2020-10-16 22:59:20', NULL, 'geshanzsq', 'geshanzsq', 0);

-- ----------------------------
-- Table structure for nav_picture
-- ----------------------------
DROP TABLE IF EXISTS `nav_picture`;
CREATE TABLE `nav_picture`  (
  `picture_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `picture_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图片路径',
  `picture_old` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '原图片名称',
  `picture_md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图片md5',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '修改人',
  `status` tinyint(1) DEFAULT 0 COMMENT '状态，0 保存，1 停用',
  PRIMARY KEY (`picture_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '导航图片' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for nav_site
-- ----------------------------
DROP TABLE IF EXISTS `nav_site`;
CREATE TABLE `nav_site`  (
  `site_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL COMMENT '菜单id',
  `site_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网站名称',
  `site_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网站图片路径',
  `site_description` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网站描述',
  `site_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网站地址',
  `order_num` int(11) NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `click_count` int(11) DEFAULT 0 COMMENT '点击量',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '修改人',
  `status` tinyint(1) DEFAULT 0 COMMENT '状态，0 正常，1 停用',
  PRIMARY KEY (`site_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 481 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户导航网站信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nav_site
-- ----------------------------
INSERT INTO `nav_site` VALUES (1, 102, 'Json 格式化', '/profile/site/system/affd14d5845d9aec96a05276b8a725e7.ico', '在线 Json 格式化、解析、校验', 'http://tool.geshanzsq.com/json', 2, 131, '2020-07-11 16:05:53', '2020-08-04 09:32:44', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (2, 1001, '大力盘搜索', '/profile/site/system/e841db29ab195535f92560f076789ff5.png', '搜索网盘资源、电子书', 'https://www.dalipan.com/', 1, 266, '2020-07-11 16:16:05', '2020-07-30 22:10:06', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (3, 1001, '小昭来啦', '/profile/site/system/b27e89c97230454302cbb24a115c3577.ico', '网盘搜索', 'https://www.xiaozhaolaila.com', 2, 87, '2020-07-30 22:18:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (4, 1001, '小可搜搜', '/profile/site/system/60634f3f32c0411103b6e25a09c51582.ico', '有你更方便', 'https://www.xiaokesoso.com/', 3, 66, '2020-07-30 22:18:26', '2020-07-30 23:11:52', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (5, 1001, '茶杯狐', '/profile/site/system/550d05a952420da3fcaa2c0acf920f59.png', '电影、剧集、动漫、节目', 'https://www.cupfox.com/', 4, 98, '2020-07-30 22:18:26', '2020-07-30 23:14:45', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (6, 1001, '小不点搜索', '/profile/site/system/7f0c4a571333ea397c688b7fc0ba7191.jpg', '好资源一网打尽', 'https://www.xiaoso.net', 5, 60, '2020-07-30 22:18:26', '2020-07-30 23:16:32', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (7, 1001, '56网盘搜索', '/profile/site/system/7dc0f592b6ac032ca20e3d29c2daf2dd.ico', '网盘搜索', 'https://www.56wangpan.com', 6, 32, '2020-07-30 22:18:26', '2020-07-30 23:17:37', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (8, 1001, '大圣盘', '/profile/site/system/b054e2e190eb787aedcef330c4a78e1e.png', '网盘搜索，就用大圣盘 - 最好用的百度网盘搜索引擎', 'https://www.dashengpan.com', 7, 58, '2020-07-30 22:18:26', '2020-07-30 23:20:10', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (9, 1001, '西林街', '/profile/site/system/e6e4b820705cf5d7e51c04c072b88deb.ico', '干净的搜索引擎', 'https://xilinjie.cc', 8, 47, '2020-07-30 22:18:26', '2020-07-30 23:21:51', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (10, 102, '腾讯云', '/profile/site/system/300494ffdcb8eec397637945ed8abefe.ico', '云产品限时抢购，1核2G云服务器首年88元。', 'https://curl.qcloud.com/6YaTrvJq', 6, 41, '2020-07-30 22:18:26', '2020-10-20 23:25:36', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (11, 102, '阿里云', '/profile/site/system/665d673aa9281cbf7ff1c86c3be26219.ico', '领取限量云产品优惠，今日限时秒杀', 'https://www.aliyun.com/1111/home?userCode=tox0h0tg', 7, 45, '2020-07-30 22:18:26', '2020-11-02 00:26:10', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (12, 102, '华为云', '/profile/site/system/084551331821cc0fa2aa385e9dc9bea1.jpg', '精选主流配置云服务器，帮助您打造可靠、安全、灵活、高效的应用环境', 'https://activity.huaweicloud.com/discount_area_v5/index.html?fromacct=f20483a6-4bd1-459f-af53-79829f3f6add&amp;utm_source=V1g3MDY4NTY=&amp;utm_medium=cps&amp;utm_campaign=201905', 8, 29, '2020-07-30 22:18:26', '2020-08-20 11:30:07', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (13, 102, '小格子实用技巧', '/profile/site/system/4dd11609-752d-41d6-90cc-624cbe35d7e1.jpg', '分享高质量实用技巧、黑科技工具、手机电脑网站等系列工具与干货！', 'https://space.bilibili.com/437306082', 1, 197, '2020-07-30 22:18:26', '2020-07-31 22:54:06', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (14, 102, '尔雅通识课', '/profile/site/system/c5d6b82510c991fb1fc22e24403ee4e7.png', '在线查询尔雅通识课答案', 'http://tool.geshanzsq.com/erya', 3, 54, '2020-07-30 22:18:26', '2020-08-08 14:48:10', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (15, 102, '字符串拼接', '/profile/site/system/247318238fc469eed32169b9be62ae3e.png', '在线字符串拼接', 'http://tool.geshanzsq.com/string', 4, 57, '2020-07-30 22:18:26', '2020-08-07 10:43:07', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (16, 1002, '点点文档搜索', '/profile/site/system/a35d2046-f0c9-4a94-b007-79322b05c5a7.jpg', '专注专业文档搜索', 'https://www.torrent.org.cn/bd', 1, 33, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (17, 1002, 'Telegram书籍搜索', '/profile/site/system/d51adf1b-6baa-4aaf-90e7-d444309ce737.png', '免费电子书搜索', 'https://bks.thefuture.top/', 2, 68, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (18, 1002, 'ePUBee', '/profile/site/system/d96e69e6-6233-473a-b843-41e071bdb413.png', '最大的电子书库，在线电子书管理', 'http://cn.epubee.com/books', 3, 42, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (19, 1002, '鸠摩搜索', '/profile/site/system/69d815f7-ff4f-49ba-b294-535fd1f5ddbf.png', '强大的电子书搜索', 'https://www.jiumodiary.com/', 4, 36, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (20, 1002, 'kindle 漫画', '/profile/site/system/9ff2df64-77bd-4c12-8e6d-92d28ae264df.ico', '漫画', 'https://volmoe.com/', 5, 16, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (21, 1002, '中华珍宝馆', '/profile/site/system/857063b3-ea38-4eb8-8c29-d372ba2740a6.png', '中华珍宝馆', 'https://ltfc.net/', 6, 10, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (22, 1002, '国图文津', '/profile/site/system/c356a6b5-f8f4-4857-9142-732d5defd004.png', '文津搜索', 'http://find.nlc.cn', 7, 6, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (23, 1002, '书格', '/profile/site/system/a60e1981c4c4a14e5469b9c2e8a16cac.png', '搜索资源集', 'https://new.shuge.org/', 8, 18, '2020-08-01 14:24:18', '2020-08-08 14:50:00', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (24, 1002, '古籍馆', '/profile/site/system/5350f9dd-1818-4b8b-84b3-cf926d5c7cc2.ico', '中國最大的古籍圖書館，在线搜索', 'https://www.gujiguan.com', 9, 12, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (25, 1002, 'Gutenberg', '/profile/site/system/5b2c64cb-a793-4bd9-a69a-e6535cdd36bc.png', ' 无版权书籍在线搜索与下载，外文版', 'http://www.gutenberg.org', 10, 7, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (26, 1002, 'Daily Script', '/profile/site/system/e2353889-b895-42c0-b294-2357b6dd0b4a.png', '剧本搜索与下载，英文版', 'http://www.daily.com', 11, 1, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (27, 1002, '苦瓜书盘', '/profile/site/system/69a209a3-bd8c-4fce-9b11-25c82c855d6d.png', '免费电子书下载站', 'https://www.kgbook.com/', 12, 23, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (28, 1002, '书栈网', '/profile/site/system/2e2d77a6-3c44-4de0-a5eb-a6d2b754a731.png', '程序员IT互联网开源编程书籍免费阅读与下载，取之于猿用之于猿', 'https://www.bookstack.cn', 13, 25, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (29, 1002, '码农之家', '/profile/site/system/54f8a778eaaa63550b63e8a051484d43.ico', '计算机电子书下载网-编程pdf电子书下载', 'https://www.xz577.com', 14, 26, '2020-08-01 14:24:18', '2020-08-06 13:53:33', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (30, 1002, '书享家', '/profile/site/system/6737d6da-43f3-4b67-b528-5aa58e77e86d.png', '电子书下载导航', 'http://shuxiangjia.cn', 15, 28, '2020-08-01 14:24:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (31, 1005, '有道翻译', '/profile/site/system/316e6dde-d4a6-4590-9d0a-e082b40a4876.ico', '免费、及时的多语种在线翻译', 'http://fanyi.youdao.com/', 1, 21, '2020-08-01 14:41:43', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (32, 1005, 'Google 翻译', '/profile/site/system/1c68f29a-92e7-4ff7-8659-0c4ce3efb62b.jpg', 'Google 在线翻译', 'https://translate.google.cn/', 2, 30, '2020-08-01 14:41:43', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (33, 1005, '百度翻译', '/profile/site/system/b4354f2c-a638-4e25-9269-f572af38318c.jpg', '百度在线翻译', 'https://fanyi.baidu.com/translate', 3, 15, '2020-08-01 14:41:43', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (34, 1005, '必应翻译', '/profile/site/system/8e6484e4-486e-473e-8075-03b6cf60664d.png', '微软在线翻译', 'https://cn.bing.com/translator', 4, 5, '2020-08-01 14:41:43', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (35, 1008, '腾讯软件中心', '/profile/site/system/3d244575922fd6f3f251cf2326901817.ico', '不错的软件商店', 'https://pc.qq.com/', 1, 32, '2020-08-01 14:48:15', '2020-08-06 13:43:40', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (36, 1008, 'MSDN', '/profile/site/system/e377b1038d9b1de65faa974cd0f1697d.ico', '原版系统镜像下载', 'https://msdn.itellyou.cn', 2, 31, '2020-08-01 14:48:15', '2020-08-06 13:44:22', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (37, 1008, '致美化', '/profile/site/system/095e81f7aabe0a02d59e260b5a006181.ico', '桌面美化交流平台', 'https://zhutix.com', 3, 36, '2020-08-01 14:48:15', '2020-08-06 13:45:11', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (38, 1046, '大眼仔旭', '/profile/site/system/e9b2f20ae9880fb20b98a07a309b96c1.ico', '专注视频剪辑、解压、录屏、思维导图等办公软件分享', 'http://www.dayanzai.me', 2, 25, '2020-08-01 14:48:15', '2020-10-16 21:45:14', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (39, 1046, '爱绿软', '/profile/site/system/161d313406154438d4319655b0892cd8.png', '收集分享各类有趣好玩的绿色软件', 'https://ilvruan.com', 3, 57, '2020-08-01 14:48:15', '2020-10-16 21:45:18', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (40, 1046, '异次元软件站', '/profile/site/system/5edb929d595ea22f900244e4985e4cb2.ico', '异次元软件世界 - 软件改变生活', 'https://www.iplaysoft.com', 4, 33, '2020-08-01 14:48:15', '2020-10-16 21:45:22', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (41, 1046, '吾爱破解', '/profile/site/system/25ef62ba415682c09a4a0a2dea4cbf67.ico', '软件交流社区', 'https://www.52pojie.cn', 0, 60, '2020-08-01 14:48:15', '2020-10-16 21:45:05', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (42, 1009, '魔趣 ROM', '/profile/site/system/46363edb-dafa-451a-bb0b-74030679e0e1.png', '可能是中国最好的安卓开源系统', 'https://www.mokeedev.com', 1, 54, '2020-08-01 14:49:28', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (43, 1009, 'Xposed框架中文站', '/profile/site/system/29575a8c-5830-4310-b04c-1ddb978dcb3f.png', '超多Xposed框架模块介绍与下载', 'http://xposed.appkg.com', 2, 25, '2020-08-01 14:49:28', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (44, 1009, '观道', '/profile/site/system/1b3a7fddd824ac8f01e5c0d400875808.ico', '国外App下载_App下载界的一股清流', 'http://www.guandao.cc', 3, 24, '2020-08-01 14:49:28', '2020-08-06 13:51:36', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (45, 1009, '豌豆荚', '/profile/site/system/e0ccaa1741577bac575a049479df805e.ico', '海量安卓APP应用与游戏免费下载', 'https://www.wandoujia.com', 4, 10, '2020-08-01 14:49:28', '2020-08-06 13:50:56', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (46, 1009, 'TapTap', '/profile/site/system/0f03874c92974facb1706e69c54f94d4.png', '发现好游戏', 'https://www.taptap.com', 5, 6, '2020-08-01 14:49:28', '2020-08-06 13:52:24', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (47, 1010, '腾讯柠檬精选', '/profile/site/system/25206276f20af4103ea56a75be6c0802.png', '收录免费、正版、好用的Mac应用及产品', 'https://lemon.qq.com/lab/', 1, 23, '2020-08-01 14:50:21', '2020-08-06 13:49:34', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (48, 1010, '每日限免', '/profile/site/system/5d4d23c3-7135-4f82-b946-6c10f3a11f84.png', '每日精品限免_促销应用', 'https://app.so/xianmian', 2, 69, '2020-08-01 14:50:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (49, 1011, '80s', '/profile/site/system/58b7190f323f41cffc5434f50158de2f.ico', 'MP4高清手机电影下载', 'http://www.80s.la', 1, 70, '2020-08-01 14:51:38', '2020-08-06 13:40:47', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (50, 1011, '电影天堂', '/profile/site/system/eebed0eb-0379-4805-bdb0-9b58544dbb93.jpg', '免费电影_迅雷电影下载_电影天堂网', 'https://www.dytt8.net', 2, 38, '2020-08-01 14:51:38', '2020-10-06 11:11:42', 'geshazsq', 'geshanzsq', 1);
INSERT INTO `nav_site` VALUES (51, 1011, '秋霞电影网', '/profile/site/system/92fad790-b5fc-47e5-82da-539f9e115731.png', '一个免费的电影网站，不收费', 'https://www.yp868.com', 3, 89, '2020-08-01 14:51:38', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (52, 1011, '腾讯视频', '/profile/site/system/fe2b466d9fe6bed552c0adcaac1c2813.ico', '中国领先的在线视频媒体平台,海量高清视频在线观看', 'https://v.qq.com', 4, 24, '2020-08-01 14:51:38', '2020-08-06 13:42:24', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (53, 1011, '爱奇艺', '/profile/site/system/c98299374e866651cf08fc17ba074d42.ico', '在线视频网站-海量正版高清视频在线观看', 'https://www.iqiyi.com', 5, 13, '2020-08-01 14:51:38', '2020-08-06 13:41:46', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (54, 1011, '优酷', '/profile/site/system/e4e0ee80c4466950ae51cecdd28080e1.png', '这世界很酷', 'https://www.youku.com', 6, 14, '2020-08-01 14:51:38', '2020-08-06 13:39:48', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (55, 1012, '疯狂音乐', '/profile/site/system/8b6d2e5b-52aa-49ee-a2a4-e18aa9f7326a.jpg', '音乐聚集平台，支持国内大部分音乐平台', 'http://music.ifkdy.com', 1, 33, '2020-08-01 14:52:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (56, 1012, '超级无损音乐', '/profile/site/system/88f09734-6e3e-4ba1-9abd-c3abecd8b4ce.jpg', '我们只有无损音乐', 'https://www.sq688.com', 2, 45, '2020-08-01 14:52:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (57, 1012, '51ape', '/profile/site/system/e0b00596f46464f89bf478cef781fe67.png', '一个无损音乐网站，拥有大量的无损音乐歌曲，数量高达数10万', 'http://www.51ape.com', 3, 19, '2020-08-01 14:52:55', '2020-08-05 00:21:33', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (58, 1012, '果汁音乐', '/profile/site/system/aaf2072e019d59ddeb4825de181ea9ff.ico', '只听最动听的歌', 'http://guozhivip.com/yinyue', 4, 14, '2020-08-01 14:52:55', '2020-08-05 00:20:27', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (59, 1012, 'QQ音乐', '/profile/site/system/6dfcb9895c4d834dac1bc7256a54a9b8.ico', '千万正版音乐海量无损曲库新歌热歌天天畅听的高品质音乐平台', 'https://y.qq.com', 5, 12, '2020-08-01 14:52:55', '2020-08-04 14:48:12', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (60, 1012, '网易云音乐', '/profile/site/system/21f3ff494c85b7adbd62f6308651e4cf.png', '专注于发现与分享的音乐产品，依托专业音乐人、DJ、好友推荐及社交功能，为用户打造全新的音乐生活', 'https://music.163.com', 6, 15, '2020-08-01 14:52:55', '2020-08-04 14:49:42', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (61, 1012, '酷狗音乐', '/profile/site/system/0e8a8d31be0727fcd077c9df5e6a9ba9.ico', '就是歌多', 'https://www.kugou.com', 7, 14, '2020-08-01 14:52:55', '2020-08-04 14:52:05', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (62, 1012, '虾米音乐', '/profile/site/system/3d4c138efe8f0c64cf3a94c17c3344b7.png', '发现音乐新世界', 'https://www.xiami.com', 8, 6, '2020-08-01 14:52:55', '2020-08-05 00:19:33', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (63, 1004, '在线格式转换', '/profile/site/system/95ed0b48-8dbc-4407-a52a-2541bc16f054.jpg', '万能且免费的格式转换，支持各种格式。', 'https://www.alltoall.net', 1, 120, '2020-08-01 14:54:25', '2020-08-11 23:28:53', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (64, 1032, '良许', '/profile/site/system/87dcee317bc17f027d9e6f6b8c77e555.png', '定期分享技术资料、源码等干货，定期送书', 'http://www.liangxu.co/', 9, 17, '2020-08-01 14:56:49', '2020-09-24 20:56:55', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (65, 1032, '程序猿圈', '/profile/site/system/a198ddc1-8b73-4900-93b4-87fda77fb50f.jpg', '程序员在线学习站点', 'https://www.cxyquan.com/', 2, 12, '2020-08-01 14:56:49', '2020-08-08 15:19:47', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (66, 1032, '纯洁的微笑', '/profile/site/system/bee2f3c7-4fb8-4b06-8ba3-c678585d5b54.jpg', '分享技术，品味人生', 'http://ityouknow.com/', 3, 22, '2020-08-01 14:56:49', '2020-08-08 15:19:56', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (67, 1032, '江南一点雨', '/profile/site/system/063a8d1d-1e81-4c0d-9c43-53cc8a873d7a.jpg', '技术文章分享', 'http://www.javaboy.org', 4, 19, '2020-08-01 14:56:49', '2020-08-08 15:20:07', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (68, 1032, '程序猿DD', '/profile/site/system/9625e95b-8a7b-4548-8e57-5a191b306f2f.jpg', 'Java Spring Boot Spring Cloud 最新干货分享', 'http://blog.didispace.com', 5, 25, '2020-08-01 14:56:49', '2020-08-08 15:20:11', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (69, 1006, 'Iconfinder', '/profile/site/system/e3325f68179436ccfc25b9f0ffff5a39.png', '2,100,000+个免费和高级矢量图标。', 'https://www.iconfinder.com', 1, 17, '2020-08-01 14:58:10', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (70, 1006, 'iconfont', '/profile/site/system/e1f63337915f79f8bcad1952adb9f6e1.png', '阿里巴巴矢量图标库。', 'http://www.iconfont.cn/', 2, 19, '2020-08-01 14:58:10', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (71, 1006, 'iconmonstr', '/profile/site/system/afd4885651455f12dcac4f214460dd99.png', '您的下一个项目的免费简单图标。', 'https://iconmonstr.com/', 3, 4, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (72, 1006, 'FindIcons', '/profile/site/system/0171a46b0f643752aa90aa314a22a546.png', '搜索300,000个免费图标。', 'https://findicons.com/', 4, 8, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (73, 1006, 'Icon Archive', '/profile/site/system/40c43a8932f24370cf456789b2ab51db.png', '搜索590,912个免费图标。', 'http://www.iconarchive.com/', 5, 4, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (74, 1006, 'IcoMoonApp', '/profile/site/system/d19c97ead3760f1b70efa4ee9ad6859c.png', '图标字体，SVG，PDF和PNG生成器。', 'https://icomoon.io/app/', 6, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (75, 1006, 'easyicon', '/profile/site/system/34b4382075e047c6d1456f8fe591a1ef.png', 'PNG、ICO、ICNS格式图标搜索、图标下载服务。', 'http://www.easyicon.net/', 7, 4, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (76, 1006, 'flaticon', '/profile/site/system/582cf7361a0b4f444628c68b98e5cfc7.png', '634,000+免费矢量图标为SVG，PSD，PNG，EPS格式或图标字体。', 'https://www.flaticon.com/', 8, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (77, 1006, 'UICloud', '/profile/site/system/f9840e127d500449da1c5c721f3634c3.png', '世界上最大的用户界面设计数据库。', 'http://ui-cloud.com/', 9, 5, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (78, 1006, 'Material icons', '/profile/site/system/32a037ffbdd2f97f6f6e62e56321c519.png', '可访问900多种材质系统图标，这些图标以各种大小和密度提供，并且可以作为网络字体使用。', 'https://material.io/icons/', 10, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (79, 1006, 'Font Awesome Icon', '/profile/site/system/88440b8b0d5dc43a3f766670e2d11746.png', '惊人的675个图标的完整集合。', 'https://fontawesome.com/', 11, 2, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (80, 1006, 'ion icons', '/profile/site/system/6d0fd0bf35549f6d61037bd86e2ca242.png', 'Ionic Framework的高级图标字体。', 'http://ionicons.com/', 12, 2, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (81, 1006, 'Simpleline Icons', '/profile/site/system/acf446f1af754f863260cc10dd8d546e.png', '简单的线条图标包。', 'http://simplelineicons.com/', 13, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (82, 1013, 'photoshop', '/profile/site/system/e7117e80fdb340589bc8969900e2af61.png', 'Photoshop不需要解释', 'https://www.adobe.com/cn/products/photoshop.html', 1, 65, '2020-08-01 15:07:48', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (83, 1013, 'Affinity Designer', '/profile/site/system/290add1cdb3cdb80e6e30af137d48525.png', '专业创意软件', 'https://affinity.serif.com/', 2, 10, '2020-08-01 15:07:48', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (84, 1013, 'Illustrator', '/profile/site/system/6882fdb094820bae95054ea1c38a3baf.png', '矢量图形和插图。', 'https://www.adobe.com/cn/products/illustrator/', 3, 12, '2020-08-01 15:07:48', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (85, 1013, 'indesign', '/profile/site/system/4db54894b6751e253212a690dada0df8.png', '页面设计、布局和出版。', 'http://www.adobe.com/cn/products/indesign.html', 4, 8, '2020-08-01 15:07:48', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (86, 1013, 'cinema-4d', '/profile/site/system/ac0344f03fc1e59b4144fef92a12e211.png', 'Cinema 4D是所有想要快速，轻松地获得惊人效果的3D艺术家的理想选择。', 'https://www.maxon.net/en/products/cinema-4d/overview/', 5, 6, '2020-08-01 15:07:49', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (87, 1013, '3ds-max', '/profile/site/system/3aacac5d23583cdc250a970a0e30a9aa.png', '3D建模，动画和渲染软件', 'https://www.autodesk.com/products/3ds-max/overview', 6, 15, '2020-08-01 15:07:49', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (88, 1013, 'Blender', '/profile/site/system/5d61addac4350caee364f0a3e850a3f7.png', 'Blender是免费的开源3D创建套件。', 'https://www.blender.org/', 7, 5, '2020-08-01 15:07:49', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (89, 1014, 'Sketch', '/profile/site/system/75cc5b5775361d5f0b471b706a115403.png', '数字设计工具包', 'https://sketchapp.com/', 1, 12, '2020-08-01 15:09:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (90, 1014, 'Adobe XD', '/profile/site/system/9eda46042e2ad058951fa4e4bb3a9957.png', '引入Adobe XD。 设计。 原型。 经验。', 'http://www.adobe.com/products/xd.html', 2, 8, '2020-08-01 15:09:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (91, 1014, 'invisionapp', '/profile/site/system/7d5620f1b4fd85c4a7ea4733deed8823.png', '强大的设计原型工具', 'https://www.invisionapp.com/', 3, 6, '2020-08-01 15:09:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (92, 1014, 'marvelapp', '/profile/site/system/28ec81158c67d9783afccf8fcd1bbee6.png', '简单的设计，原型制作和协作', 'https://marvelapp.com/', 4, 7, '2020-08-01 15:09:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (93, 1014, 'Muse CC', '/profile/site/system/612cf530fe80b5f28dc826c4384087bf.png', '无需利用编码即可进行网站设计。', 'https://creative.adobe.com/zh-cn/products/download/muse', 5, 10, '2020-08-01 15:09:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (94, 1014, 'figma', '/profile/site/system/0623aab0bc72437206deca9d4c55df1c.png', '使用Figma一站式设计，制作原型并收集反馈。', 'https://www.figma.com/', 6, 6, '2020-08-01 15:09:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (95, 1015, 'Adobe After Effects CC', '/profile/site/system/01306292e590f37b934785ed67288f80.png', '电影般的视觉效果和动态图形。', 'https://www.adobe.com/cn/products/aftereffects/', 1, 23, '2020-08-01 15:14:56', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (96, 1015, 'principle', '/profile/site/system/485a410f2076ad20856199caa300f548.png', '激发您的想法，设计更好的应用程序', 'http://principleformac.com/', 2, 11, '2020-08-01 15:14:56', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (97, 1015, 'flinto', '/profile/site/system/f655d57c7d752c429510e0f649d69666.png', 'Flinto是Mac应用程序，世界各地的顶级设计师都使用它来创建其应用程序设计的交互式动画原型。', 'https://www.flinto.com/', 3, 3, '2020-08-01 15:14:56', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (98, 1015, 'framer', '/profile/site/system/e64c3cd0283a3bf6a75c9c4ba821049d.png', '从详细的图标到高保真的交互，一切都设计在一个地方。', 'https://framer.com/', 4, 6, '2020-08-01 15:14:56', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (99, 1015, 'ProtoPie', '/profile/site/system/bdbb0e0485d816b88c75c9276d273873.png', '高保真交互原型设计', 'http://www.protopie.cn/', 5, 10, '2020-08-01 15:14:56', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (100, 1016, 'khroma', '/profile/site/system/8b158c18b49f0160100086bfcdbe158d.png', 'Khroma是发现，搜索和保存要使用的颜色组合的最快方法。', 'http://khroma.co/generator/', 1, 24, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (101, 1016, 'uigradients', '/profile/site/system/9842ff5c221d6411444d3c13660ba097.png', '美丽的彩色渐变', 'https://uigradients.com', 2, 10, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (102, 1016, 'gradients', '/profile/site/system/64d0ac5dc78b65d83ba500df5b1eab30.png', '为设计师和开发人员设计的渐变色', 'http://gradients.io/', 3, 10, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (103, 1016, 'Coolest', '/profile/site/system/9b77eaad5ef27823b9feb3f765b9d593.png', '最酷的精选渐变色为您的下一个超级⚡惊人的东西', 'https://webkul.github.io/coolhue/', 4, 11, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (104, 1016, 'webgradients', '/profile/site/system/49bfc25c217107d7209eea098ad0307c.png', 'WebGradients是180个线性渐变的免费集合，您可以将其用作网站任何部分的内容背景。', 'https://webgradients.com/', 5, 6, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (105, 1016, 'grabient', '/profile/site/system/8ab1a1044ef9bc5c306c60b81d83b0a2.png', '2017 Grabient展开', 'https://www.grabient.com/', 6, 4, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (106, 1016, 'thedayscolor', '/profile/site/system/6e63366cb896fa19e204cf6b95691062.png', '日常色彩摘要', 'http://www.thedayscolor.com/', 7, 7, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (107, 1016, 'flatuicolors', '/profile/site/system/0b6e14ae22ff962a96ad66de4fc86aff.png', '从平面UI主题复制粘贴调色板', 'http://flatuicolors.com/', 8, 7, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (108, 1016, 'coolors', '/profile/site/system/9176968478c5c42ed20bce8b69f25bf6.png', '超快速配色方案生成器！', 'https://coolors.co/', 9, 14, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (109, 1016, 'Adobe Color CC', '/profile/site/system/ff4d69bedb642bd132297ed22018369b.png', '使用色轮创建配色方案或浏览“颜色”社区中的数千种颜色组合。', 'https://color.adobe.com/zh/create/color-wheel', 10, 3, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (110, 1016, 'flatuicolorpicker', '/profile/site/system/2faf82318597d846e9522c5f52500031.png', 'UI设计的最佳平面颜色', 'http://www.flatuicolorpicker.com/', 11, 8, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (111, 1016, 'trianglify', '/profile/site/system/88261a86b35e5b015bbe35ab9141bc8f.png', '三角生成器', 'http://qrohlf.com/trianglify-generator/', 12, 6, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (112, 1016, 'klart', '/profile/site/system/c51065aaec56c7c65aafd40f4797dba0.png', '每周都会为您的收件箱提供漂亮的颜色和设计', 'https://klart.co/colors/', 13, 6, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (113, 1016, 'vanschneider', '/profile/site/system/4690e9281c23d5fc9df0e2cfbe018edd.png', '“颜色声明”由Tobias van Schneider于2012年创建，目标是为我的未来项目收集和组合独特的颜色。', 'http://www.vanschneider.com/colors', 14, 4, '2020-08-01 15:16:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (114, 1017, 'tinypng', '/profile/site/system/9344c4d9769745c1e63d8f1e7b2f3f25.png', '通过质量和文件大小的完美平衡来优化图像。', 'https://tinypng.com/', 1, 5, '2020-08-01 15:17:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (115, 1017, 'Android 9 patch', '/profile/site/system/dc5b75e3455673384a8f738429789d4b.png', 'Android 9补丁阴影生成器完全可自定义阴影', 'http://inloop.github.io/shadow4android/', 2, 6, '2020-08-01 15:17:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (116, 1017, 'screen sizes', '/profile/site/system/d79583290bc400c0e8a2629d0e7f9f63.png', '流行设备的视口大小和像素密度', 'http://screensiz.es/', 3, 6, '2020-08-01 15:17:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (117, 1017, 'svgomg', '/profile/site/system/f573dc81e4689cb9ce482f35a6fb82f1.png', 'SVG在线压缩平台', 'https://jakearchibald.github.io/svgomg/', 4, 1, '2020-08-01 15:17:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (118, 1017, '稿定抠图', '/profile/site/system/0a6b1b1ea1d5ca5cb49e8cf95470a3b5.png', '免费在线抠图软件,图片快速换背景-抠白底图', 'https://www.gaoding.com', 5, 7, '2020-08-01 15:17:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (119, 1017, '中文转换英文首字母', '/profile/site/system/0fcf02f7a6dc850af65961ce29e4b4cd.png', '在线中文转换英文首字母', 'http://tool.geshanzsq.com/chinese', 6, 3, '2020-08-01 15:17:33', '2020-08-07 10:54:12', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (120, 1017, 'php数组转Json', '/profile/site/system/9a1139692d3d565d5bb15c816548f13b.png', '在线php数组转Json', 'http://tool.geshanzsq.com/phpToJson', 7, 2, '2020-08-01 15:17:33', '2020-08-07 10:53:01', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (121, 1017, '在线工具', '/profile/site/system/a2143416-fe6d-4cd5-8a58-bc9ab3911a6a.jpg', '程序员的工具箱', 'https://tool.lu', 8, 27, '2020-08-01 15:17:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (122, 1018, 'wappalyzer', '/profile/site/system/60696fcbba523de88eca68121dee7be7.png', '识别网站上的技术', 'https://www.wappalyzer.com/', 1, 9, '2020-08-01 15:19:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (123, 1018, 'Panda', '/profile/site/system/35e1bbf29c1116cb1dbb703b52ea2ae9.png', '专为提高生产力而打造的智能新闻阅读器。', 'http://usepanda.com/', 2, 17, '2020-08-01 15:19:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (124, 1018, 'sizzy', '/profile/site/system/5ca0b65bcc3606640ba1b4aadd25c7df.png', '快速开发响应式网站的工具', 'https://sizzy.co/', 3, 12, '2020-08-01 15:19:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (125, 1018, 'csspeeper', '/profile/site/system/84fedbd61bf8c93726b713bae36a88ae.png', '专为设计师量身定制的智能CSS查看器。', 'https://csspeeper.com/', 4, 7, '2020-08-01 15:19:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (126, 1018, 'insight', '/profile/site/system/fc5a318293079a2674f1d92f3dce7650.png', '云端上类似IDE的代码搜索和导航', 'http://insight.io/', 5, 11, '2020-08-01 15:19:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (127, 1018, 'mustsee', '/profile/site/system/709ff744a41559fa06b8e8dc199206a3.png', '在每个打开的标签页中发现世界上最美丽的地方。', 'http://mustsee.earth/', 6, 8, '2020-08-01 15:19:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (128, 1019, 'Producthunt', '/profile/site/system/a1cc88fa0a3bf74349ba9c08a67abdc7.png', '发现新鲜有趣的产品。', 'https://www.producthunt.com/', 1, 24, '2020-08-01 15:25:50', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (129, 1019, 'NEXT', '/profile/site/system/0e2b6c9a5afd4f83d2e22632b08f56ef.png', '不错过任何一个新产品。', 'http://next.36kr.com/posts', 2, 12, '2020-08-01 15:25:50', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (130, 1019, '少数派', '/profile/site/system/2d01ac82bb496b607c43e7b2b29cd069.png', '高品质数字消费指南。', 'https://sspai.com/', 3, 12, '2020-08-01 15:25:51', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (131, 1019, '利器', '/profile/site/system/98e2ee62a90b6243630f4aa479b4b47b.png', '创造者和他们的工具。', 'http://liqi.io/', 4, 14, '2020-08-01 15:25:51', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (132, 1019, 'Today', '/profile/site/system/1726189292537c3a2733ebc673b7f1d6.png', '为身边的新产品喝彩。', 'http://today.itjuzi.com/', 5, 7, '2020-08-01 15:25:51', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (133, 1019, '小众软件', '/profile/site/system/76b49053ce87ab3c7419c7cdf6fa4f07.png', '在这里发现更多有趣的应用。', 'https://faxian.appinn.com', 6, 32, '2020-08-01 15:25:51', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (134, 1020, 'Pttrns', '/profile/site/system/1c759dc53774e5758a31fee0401e213a.png', '查看最佳的设计模式，资源，移动应用程序和灵感集合', 'https://www.pttrns.com/', 1, 22, '2020-08-01 15:26:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (135, 1020, 'Collect UI', '/profile/site/system/7e802c77c7bb6c85c1e2bb608a4a13cd.png', '从每日ui档案库及其他收集的每日灵感。', 'http://collectui.com/', 2, 20, '2020-08-01 15:26:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (136, 1020, 'UI uigreat', '/profile/site/system/d140fe4bd548f273ddd00f35e1ad5ff5.png', 'APP界面截图参考。', 'http://ui.uigreat.com/', 3, 18, '2020-08-01 15:26:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (137, 1020, 'Android Niceties', '/profile/site/system/8b6e0af7df3a5d77a14e41a0f5f36dc5.png', '屏幕快照集合，其中包含一些最漂亮的Android应用程序。', 'http://androidniceties.tumblr.com/', 4, 5, '2020-08-01 15:26:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (138, 1021, 'Awwwards', '/profile/site/system/bdd6c88417790c97de2c2d0643cc602c.png', '互联网设计、创意和创新奖', 'https://www.awwwards.com/', 1, 19, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (139, 1021, 'CSS Design Awards', '/profile/site/system/481219fe4285f1f4ec1311acce7deb06.png', '网站奖项与灵感-CSS Gallery', 'https://www.cssdesignawards.com/', 2, 7, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (140, 1021, 'The FWA', '/profile/site/system/8fe5280ff7dc3012fb88781dd9ff4b93.png', 'FWA-自2000年以来每天都在展示创新', 'https://thefwa.com/', 3, 2, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (141, 1021, 'Ecommercefolio', '/profile/site/system/950d52c71e28f1c9ed964732d6ed18fd.png', '只有最佳电子商务设计灵感。', 'http://www.ecommercefolio.com/', 4, 1, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (142, 1021, 'Lapa', '/profile/site/system/1824678ec13d01b76df47fc5975178fa.png', '最佳登陆页面设计灵感来自网络。', 'http://www.lapa.ninja/', 5, 9, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (143, 1021, 'Reeoo', '/profile/site/system/5205b768b9b640bfada244ce9d15318d.png', '网页设计灵感和网站库。', 'http://reeoo.com/', 6, 5, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (144, 1021, 'Designmunk', '/profile/site/system/31de409b71235b76d605e98293d68cb3.png', '最佳首页设计灵感。', 'https://designmunk.com/', 7, 3, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (145, 1021, 'Best Websites Gallery', '/profile/site/system/862823249aa701d8bc8af16ae98f1e3a.png', '网站展示灵感| 最佳网站画廊。', 'https://bestwebsite.gallery/', 8, 2, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (146, 1021, 'Pages', '/profile/site/system/90fd20bd3e7ae7c7fe37ea689dcca32c.png', '最佳网页的精选目录。', 'http://www.pages.xyz/', 9, 3, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (147, 1021, 'SiteSee', '/profile/site/system/da24d08a597456be98191b4a08eff4d6.png', '精选的精美，现代网站集的画廊。', 'https://sitesee.co/', 10, 5, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (148, 1021, 'Site Inspire', '/profile/site/system/c15c9017ad6874faae0df64bd969115b.png', '一个CSS画廊和最佳网页设计灵感的展示。', 'https://www.siteinspire.com/', 11, 3, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (149, 1021, 'WebInspiration', '/profile/site/system/f8fe63594e2083755086ee294b036108.png', '网页设计欣赏,全球顶级网页设计。', 'http://web.uedna.com/', 12, 5, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (150, 1021, 'navnav', '/profile/site/system/86b9e596068f2a71d2a2444733a4094e.png', '来自网络的大量CSS，jQuery和JavaScript响应式导航示例，演示和教程。', 'http://navnav.co/', 13, 4, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (151, 1021, 'Really Good UX', '/profile/site/system/948b0f5b62e59ef0a97edf4b9a51c404.png', '屏幕截图库和非常好的UX示例。 带给你的。', 'https://www.reallygoodux.io/', 14, 3, '2020-08-01 15:27:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (152, 1022, 'Dribbble', '/profile/site/system/7db1257f40b9b04482744387a00b359d.png', '全球UI设计师作品分享平台。', 'https://dribbble.com/', 1, 27, '2020-08-01 15:38:39', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (153, 1022, 'Iconsfeed', '/profile/site/system/aee21da67d9771c2ebf3f6779afc9649.png', 'iOS图标库。', 'http://www.iconsfeed.com/', 2, 8, '2020-08-01 15:38:39', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (154, 1022, 'iOS Icon Gallery', '/profile/site/system/98c9f52ede06a56532d5d16afda9d570.png', '展示来自iOS App Store的精美图标设计。', 'http://iosicongallery.com/', 3, 6, '2020-08-01 15:38:39', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (155, 1022, 'World Vector Logo', '/profile/site/system/c8da40d11f726d974293efc40c9acfb5.png', '免费下载品牌徽标。', 'https://worldvectorlogo.com/', 4, 7, '2020-08-01 15:38:40', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (156, 1022, 'Instant Logo Search', '/profile/site/system/907f35950eae72526a314306cc59efa7.png', '立即搜索和下载数千个徽标。', 'http://instantlogosearch.com/', 5, 5, '2020-08-01 15:38:40', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (157, 1023, 'freepik', '/profile/site/system/6a96564b2d100bad3674db5e56794a97.png', '超过一百万的免费矢量，PSD，照片和免费图标。', 'https://www.freepik.com/', 1, 5, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (158, 1023, 'wallhalla', '/profile/site/system/9354f99621e8530d0f996fe4b96ad2c3.png', '在一处找到用于台式机和手机的超酷优质壁纸。', 'https://wallhalla.com/', 2, 3, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (159, 1023, '365PSD', '/profile/site/system/13b10a2f9388e83101d7a35b83ff28bc.png', '免费PSD和图形，插图。', 'https://365psd.com/', 3, 2, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (160, 1023, 'Medialoot', '/profile/site/system/b117eb768a44d662ded91d1f0a9cb1c2.png', '免费和高级设计资源-Medialoot。', 'https://medialoot.com/', 4, 2, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (161, 1023, '千图网', '/profile/site/system/9a24027c0e9d498efb4ad88a330882f8.png', '专注免费设计素材下载的网站。', 'http://www.58pic.com/', 5, 9, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (162, 1023, '千库网', '/profile/site/system/15ffa7b3a5cab15c7d23d402be12cc4c.png', '免费png图片背景素材下载。', 'http://588ku.com/', 6, 6, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (163, 1023, '我图网', '/profile/site/system/a887a255bbe7fe994e0479ae988372c7.png', '我图网,提供图片素材及模板下载,专注正版设计作品交易。', 'http://www.ooopic.com/', 7, 4, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (164, 1023, '90设计', '/profile/site/system/c510c1946d6191a98c6fd3b08ca720ec.png', '电商设计（淘宝美工）千图免费淘宝素材库。', 'http://90sheji.com/', 8, 4, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (165, 1023, '昵图网', '/profile/site/system/d4fba2a16c7a1692ea21f4f0a8ae7672.png', '原创素材共享平台。', 'http://www.nipic.com/', 9, 3, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (166, 1023, '懒人图库', '/profile/site/system/a7e5f98173ea111df83da146a86436a1.png', '懒人图库专注于提供网页素材下载。', 'http://www.lanrentuku.com/', 10, 7, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (167, 1023, '素材搜索', '/profile/site/system/cbca7fabfd7c6d1b117547466bc564ad.png', '设计素材搜索聚合。', 'http://so.ui001.com/', 11, 4, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (168, 1023, 'PS饭团网', '/profile/site/system/7ffad2eac8cbad395d33914344d3aa0a.png', '不一样的设计素材库！让自己的设计与众不同！', 'http://psefan.com/', 12, 6, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (169, 1023, '素材中国', '/profile/site/system/ced6b2a53069c7d360ba78706244081f.png', '免费素材共享平台。', 'http://www.sccnn.com/', 13, 9, '2020-08-01 15:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (170, 1024, 'UI中国', '/profile/site/system/9458ececbfeea651b5e871179f245ce5.png', '图形交互与界面设计交流、作品展示、学习平台。', 'http://www.ui.cn/', 1, 14, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (171, 1024, 'Freebiesbug', '/profile/site/system/4288052485ced84952e206a4acfb92ad.png', '网页设计人员和开发人员的精选资源不断更新。', 'https://freebiesbug.com/', 2, 3, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (172, 1024, 'Freebie Supply', '/profile/site/system/2ae393ad916a108ba20d21a8b907477e.png', '设计师的免费资源。', 'https://freebiesupply.com/', 3, 3, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (173, 1024, '云瑞', '/profile/site/system/528f9304b0dab49f5fe2426d4d9d047c.png', '优秀设计资源的分享网站。', 'https://www.yrucd.com/', 4, 1, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (174, 1024, 'Designmodo', '/profile/site/system/2061e0ccebfbb1a94a28d86237589b23.png', '网页设计博客和商店。', 'https://designmodo.com/', 5, 2, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (175, 1024, '稀土区', '/profile/site/system/4f5171443ad0ec6b13b7f96b8cead4bd.png', '优质设计开发资源分享。', 'https://xituqu.com/', 6, 2, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (176, 1024, 'ui8', '/profile/site/system/b815917aad63f449a96900979a16eb4e.png', 'UI套件，线框套件，模板，图标等。', 'https://ui8.net/', 7, 6, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (177, 1024, 'uplabs', '/profile/site/system/42d3d29c62a19e8d4ca6395586d79ee7.png', '产品设计师和开发人员的日常资源。', 'https://www.uplabs.com/', 8, 2, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (178, 1024, 'UIkit.me', '/profile/site/system/13b4ac8efdc9f92e52e7f271b8034b24.png', '最便捷新鲜的uikit资源下载网站。', 'http://www.uikit.me/', 9, 1, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (179, 1024, 'Fribbble', '/profile/site/system/04c1b51de97ceac330358fa7d1685034.png', 'Dribbblers提供了免费的PSD文件和其他免费设计资源。', 'http://www.fribbble.com/', 10, 1, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (180, 1024, 'PrincipleRepo', '/profile/site/system/e3e93f407dcc94461bea06979e89e4a2.png', '免费的高质量原则资源。', 'http://principlerepo.com/', 11, 1, '2020-08-01 15:39:53', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (181, 1025, 'Sketch', '/profile/site/system/ff6a2f8afaeb91004416c96788f9da95.png', '数字设计工具包。', 'https://sketchapp.com/', 1, 2, '2020-08-01 15:40:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (182, 1025, 'Sketch Measure', '/profile/site/system/69bf814d311d932ea13b746ffc1f9f54.png', '友好的用户界面为您提供了一种更直观的标记方式。', 'http://utom.design/measure/', 2, 2, '2020-08-01 15:40:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (183, 1025, 'Sketch App Sources', '/profile/site/system/ccf82c5a27a285ba63cf3c4ff8964a25.png', '免费的设计资源和插件-图标，UI套件，线框，iOS，Android草图模板', 'https://www.sketchappsources.com/', 3, 1, '2020-08-01 15:40:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (184, 1025, 'Sketch.im', '/profile/site/system/6055276a55b62db423c2b060d3f6b044.png', 'Sketch 相关资源汇聚。', 'http://www.sketch.im/', 4, 1, '2020-08-01 15:40:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (185, 1025, 'Sketch Hunt', '/profile/site/system/c4bf007a61d761db1f895672a2519cd0.png', 'Sketch Hunt是一个独立的博客，为Sketch应用程序的爱好者分享学习，插件和设计工具方面的瑰宝。', 'http://sketchhunt.com/', 5, 0, '2020-08-01 15:40:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (186, 1025, 'Sketch中文网', '/profile/site/system/a26a90da0d304cd3502cdb53e85995b9.png', '分享最新的Sketch中文手册。', 'http://www.sketchcn.com/', 6, 2, '2020-08-01 15:40:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (187, 1025, 'Awesome Sketch Plugins', '/profile/site/system/255cf49affef2fbaba8cd15c3e7329b5.png', '真正有用的Sketch插件的集合。', 'https://awesome-sket.ch/', 7, 0, '2020-08-01 15:40:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (188, 1025, 'Sketchcasts', '/profile/site/system/fa8c8b179ab48ad61e61a18d1720e019.png', '学习素描通过每周的视频教程来训练您的设计技能', 'https://www.sketchcasts.net/', 8, 1, '2020-08-01 15:40:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (189, 1026, 'Google Font', '/profile/site/system/91c604a4ca98b1bb5719e04c80043419.png', '通过出色的排版，使网络更加美观，快速和开放。', 'https://fonts.google.com/', 1, 1, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (190, 1026, 'Typekit', '/profile/site/system/7dbc17741d30274995615612dc1d075f.png', '来自世界上最好的铸造厂的高质量字体。', 'https://typekit.com/', 2, 1, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (191, 1026, '方正字库', '/profile/site/system/8ffeec1d3ad96a39dd4ede9794756b87.png', '方正字库官方网站。', 'http://www.foundertype.com/', 3, 4, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (192, 1026, '字体传奇网', '/profile/site/system/d5fc1ea541fe215ae449a0ae27a09a76.png', '中国首个字体品牌设计师交流网。', 'http://ziticq.com/', 4, 4, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (193, 1026, '私藏字体', '/profile/site/system/125e538efd8b3ea68d3655cb81ccc06f.png', '优质字体免费下载站。', 'http://sicangziti.com/', 5, 8, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (194, 1026, 'Fontsquirrel', '/profile/site/system/94684e5203623eb5540a4b5a0e0b70b0.png', '图形设计师的免费字体。', 'https://www.fontsquirrel.com/', 6, 1, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (195, 1026, 'Urban Fonts', '/profile/site/system/40139afeda032d1a3cd54459d065b31b.png', '下载免费字体和免费Dingbats。', 'https://www.urbanfonts.com/', 7, 1, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (196, 1026, 'Lost Type', '/profile/site/system/cfe0904ec3e37914be51687a2b15f5cf.png', '失物招领是一个协作数字类型代工厂。', 'http://www.losttype.com/', 8, 0, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (197, 1026, 'FONTS2U', '/profile/site/system/19bd844dc123066620d1f6fda7287e48.png', '为Windows和Macintosh下载免费字体。', 'https://fonts2u.com/', 9, 1, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (198, 1026, 'Fontex', '/profile/site/system/1576a7303fb2fa3839016a599418203b.png', '免费字体下载+高级字体。', 'http://www.fontex.org/', 10, 0, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (199, 1026, 'FontM', '/profile/site/system/5ee459b3c52027eb8dcd9c8c6e9266a0.png', '免费字体。', 'http://fontm.com/', 11, 4, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (200, 1026, 'My Fonts', '/profile/site/system/22572b2d9b38ea02f173074d59acf334.png', '用于印刷，产品和屏幕的字体。', 'http://www.myfonts.com/', 12, 0, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (201, 1026, 'Da Font', '/profile/site/system/d0478f80b89bff215437714e62c6d997.png', '可免费下载的字体的存档。', 'https://www.dafont.com/', 13, 0, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (202, 1026, 'OnlineWebFonts', '/profile/site/system/bccc59c04f6f283a63430700273ffdee.png', '适用于Windows和Mac的WEB免费字体/免费下载字体。', 'https://www.onlinewebfonts.com/', 14, 2, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (203, 1026, 'Abstract Fonts', '/profile/site/system/fbedc66f865056e650a036f042625057.png', '抽象字体（13,866个免费字体）。', 'http://www.abstractfonts.com/', 15, 1, '2020-08-01 15:40:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (204, 1027, 'MockupZone', '/profile/site/system/75e599ff2f061dc25fa272de94045ca9.png', 'Mockup Zone是一个在线商店，您可以在其中找到免费的高级PSD样机文件，以专业的方式展示您的设计。', 'https://mockup.zone/', 1, 5, '2020-08-01 15:41:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (205, 1027, 'Dunnnk', '/profile/site/system/7949d12743b95779412dd8673c324164.png', '免费生成产品模型。', 'http://dunnnk.com/', 2, 3, '2020-08-01 15:41:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (206, 1027, 'Graphberry', '/profile/site/system/1216f3642b463e7e9d493e4d00506566.png', '免费设计资源，样机，PSD Web模板，图标。', 'http://www.graphberry.com/', 3, 1, '2020-08-01 15:41:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (207, 1027, 'Threed', '/profile/site/system/252114418dc086100cd58d10035a9436.png', '直接在浏览器中生成3D模型', 'http://threed.io/', 4, 1, '2020-08-01 15:41:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (208, 1027, 'Mockup World', '/profile/site/system/c94ee98e4ada29c0916888820da31744.png', '网上最好的免费模型', 'https://free.lstore.graphics/', 5, 3, '2020-08-01 15:41:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (209, 1027, 'Lstore', '/profile/site/system/965f25d08ae3cd33fab21d764a514967.png', '面向设计师和开发人员的独家令人兴奋的免费赠品。', 'https://free.lstore.graphics/', 6, 1, '2020-08-01 15:41:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (210, 1027, 'pixeden', '/profile/site/system/f8b5261bc1d5e5189b9c1216a6de8b3b.png', '免费的网络资源和图形设计模板。', 'https://www.pixeden.com/', 7, 2, '2020-08-01 15:41:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (211, 1027, 'For Graphic TM', '/profile/site/system/20fceec1b9dd6c1183ad73a90becce7f.png', '适用于图形设计师的高质量PSD样机。', 'http://forgraphictm.com/', 8, 1, '2020-08-01 15:41:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (212, 1028, 'Unsplash', '/profile/site/system/72880b02dbea40fd84472abc05e6d23b.png', '漂亮的免费照片。', 'https://unsplash.com/', 1, 13, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (213, 1028, 'visualhunt', '/profile/site/system/b2a1a1e4c043858ac2411f02b9236ff3.png', '100％免费的高质量照片。', 'https://visualhunt.com/', 2, 4, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (214, 1028, 'librestock', '/profile/site/system/94c5305f78dfadb241f9edcf3d9b870d.png', '65,084高品质的照片，随您想要。', 'https://librestock.com/', 3, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (215, 1028, 'pixabay', '/profile/site/system/310cb7b52774323c7fdffe67aa0f12aa.png', '可在任何地方使用的免费图片和视频。', 'https://pixabay.com/', 4, 4, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (216, 1028, 'SplitShire', '/profile/site/system/0e9933021af7cc4714e900c247010b30.png', '免费图片和视频供商业使用。', 'https://www.splitshire.com/', 5, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (217, 1028, 'StockSnap', '/profile/site/system/fabf86558eb3a7c943c124f7f62f3542.png', '美丽的免费图片素材。', 'https://stocksnap.io/', 6, 5, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (218, 1028, 'albumarium', '/profile/site/system/de8b7f26a21ea0b781f93a3163341731.png', '查找和分享精美图像的最佳场所。', 'http://albumarium.com/', 7, 0, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (219, 1028, 'myphotopack', '/profile/site/system/80d85ea59d293bd43731a890f63c5dc9.png', '专门为您提供的免费照片包。 每个月。', 'https://myphotopack.com/', 8, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (220, 1028, 'Notaselfie', '/profile/site/system/eb5f9a9661e582883c9d3128bb9b4482.png', '一路上发生的照片。 您可以随时使用图像。 玩得开心！', 'http://notaselfie.com/', 9, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (221, 1028, 'papers', '/profile/site/system/3a6396ba24d253502f40432751a11b07.png', '每小时都有墙纸！手工收集', 'http://papers.co/', 10, 5, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (222, 1028, 'stokpic', '/profile/site/system/9dce238279b24893eaa20a99fba802ea.png', '免费图片供商业使用。', 'http://stokpic.com/', 11, 2, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (223, 1028, '55mm', '/profile/site/system/dd8adcbc65cc20e8fb6d6335fd57814a.png', '使用我们的免费照片讲述您的故事！', 'https://55mm.co/visuals', 12, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (224, 1028, 'thestocks', '/profile/site/system/2be533b5b00139b9022f09604f3bd136.png', '使用我们的免费照片讲述您的故事！', 'http://thestocks.im/', 13, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (225, 1028, 'freenaturestock', '/profile/site/system/85c87259ac26b4f48b084066b9e3ec8e.png', '面向设计师和开发人员的独家令人兴奋的免费赠品。', 'http://freenaturestock.com/', 14, 3, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (226, 1028, 'negativespace', '/profile/site/system/9b470b26c5e7e6604f3f17d2fe518af7.png', '美丽，高分辨率免费图片素材。', 'https://negativespace.co/', 15, 3, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (227, 1028, 'gratisography', '/profile/site/system/37a9bff7f4d756e7b227ef295aa5ff82.png', '免费的高分辨率图片，可用于您的个人和商业项目，不受版权限制。', 'https://gratisography.com/', 16, 2, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (228, 1028, 'imcreator', '/profile/site/system/568ae371ba49ce83463d5833af6a8e88.png', '精选的免费网页设计资源集合，全部用于商业用途。', 'http://imcreator.com/free', 17, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (229, 1028, 'lifeofpix', '/profile/site/system/94bf5d51c1367552f337610dbc6aa44b.png', '免费高分辨率摄影', 'http://www.lifeofpix.com/', 18, 2, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (230, 1028, 'skitterphoto', '/profile/site/system/23663c43cb7025f3bf36e9733bea6171.png', '创意专业人士的免费图片素材', 'https://skitterphoto.com/', 19, 2, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (231, 1028, 'mmtstock', '/profile/site/system/d8d5768d2dc63763480478ae25aa176a.png', '免费商业照片', 'https://mmtstock.com/', 20, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (232, 1028, 'magdeleine', '/profile/site/system/12ca6edef00d1d897eb28c4a8e2f8915.png', '精选免费照片供您启发', 'https://magdeleine.co/browse/', 21, 1, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (233, 1028, 'jeshoots', '/profile/site/system/a016e8d2ae3ee88f0ec136440e92fca8.png', '新的免费照片和样机进入您的收件箱！', 'http://jeshoots.com/', 22, 2, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (234, 1028, 'hdwallpapers', '/profile/site/system/74db036ddf1bbfc49a22a5a6dcd392ab.png', '高清壁纸和桌面背景', 'https://www.hdwallpapers.net', 23, 3, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (235, 1028, 'publicdomainarchive', '/profile/site/system/3c7427a4bab6bb40c12a77014f809a2a.png', '新的100％免费图片。 每一个 单。 周。', 'http://publicdomainarchive.com/', 24, 5, '2020-08-01 15:42:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (236, 1029, 'OfficePLUS', '/profile/site/system/4773ef0cfcf8c9fd158fc7db0bc2cf0b.png', 'OfficePLUS，微软Office官方在线模板网站！', 'http://www.officeplus.cn/Template/Home.shtml', 1, 13, '2020-08-01 15:43:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (237, 1029, '优品PPT', '/profile/site/system/b1d803179735ea628d1d914c63c0b9f7.png', '高质量的模版，而且还有PPT图表，PPT背景图等资源', 'http://www.ypppt.com/', 2, 18, '2020-08-01 15:43:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (238, 1029, 'PPT+', '/profile/site/system/bfabed8750869b0214622d158ec9bddf.png', 'PPT加直播、录制和分享—PPT+语音内容分享平台', 'http://www.pptplus.cn/', 3, 10, '2020-08-01 15:43:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (239, 1029, 'PPTMind', '/profile/site/system/857bb0f6927c2a8c246653cb41136ce7.png', '分享高端ppt模板与keynote模板的数字作品交易平台', 'http://www.pptmind.com/', 4, 10, '2020-08-01 15:43:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (240, 1029, 'tretars', '/profile/site/system/14a77db5ab4af0ba947b1e1707295c5d.png', '网上最好的免费模型', 'http://www.tretars.com/ppt-templates', 5, 8, '2020-08-01 15:43:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (241, 1029, '5百丁', '/profile/site/system/3f735ae4b6e18cd6cff3965661289aac.png', '中国领先的PPT模板共享平台', 'http://ppt.500d.me/', 6, 8, '2020-08-01 15:43:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (276, 1004, 'PDF Candy', '/profile/site/system/0b897cff5f1f2d98efd8dc7ea69b38ae.ico', '一个免费在线的PDF编辑网站。包含了几十种PDF小工具，可以Word与PDF互转、Excel表格与PDF互转、图片与PDF互转等各种实用功能。', 'https://pdfcandy.com/cn/', 2, 27, '2020-08-05 13:28:17', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (277, 1004, 'LightPDF', '/profile/site/system/6281eb27f1a6c6f07d56588e5e4849ae.png', '一个只需要一步，即可解决PDF所有问题的免费PDF工具!', 'https://lightpdf.com/zh/', 3, 12, '2020-08-05 13:30:31', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (278, 1004, 'SmallPDF', '/profile/site/system/341475474199e2cf28ce10308fcad860.png', '轻松玩转PDF，功能一应俱全、简单好用的线上 PDF 工具', 'https://smallpdf.com/cn', 4, 17, '2020-08-05 13:31:49', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (279, 1004, 'HiPDF', '/profile/site/system/3cac096ab252280f24a70ca5550a0287.ico', '一站式在线PDF解决方案的网站。', 'https://www.hipdf.cn/', 5, 5, '2020-08-05 13:33:37', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (280, 1004, 'iLovePDF', '/profile/site/system/cc239ae8c064a5bbb65318fb40e02cdf.png', '完全免费、易于使用、丰富的PDF处理工具，包括：合并、拆分、压缩、转换、旋转和解锁PDF文件，以及给PDF文件添加水印的工具等。仅需几秒钟即可完成。', 'https://www.ilovepdf.com/zh-cn', 6, 15, '2020-08-05 13:35:10', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (281, 1007, 'CSDN', '/profile/site/system/0b91790e27fe8cd3941fc6e6ee57ee4a.jpg', '专业开发者社区', 'https://www.csdn.net/', 2, 9, '2020-08-08 15:12:00', '2020-08-08 15:20:24', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (282, 1007, '博客园', '/profile/site/system/2ec8affefca78704574f1ba17fe070f2.png', '开发者的网上家园', 'https://www.cnblogs.com/', 1, 11, '2020-08-08 15:13:36', '2020-08-08 15:20:20', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (283, 1007, '思否', '/profile/site/system/570d66cff03484e48b05d6f02db9dfe4.ico', ' 在 SegmentFault，学习技能、解决问题。', 'https://segmentfault.com/', 4, 13, '2020-08-08 15:16:50', '2020-08-08 15:20:39', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (284, 1007, '掘金', '/profile/site/system/dcc82ea8e38e1bd994cabb18b8eb4e32.ico', '一个帮助开发者成长的社区。', 'https://juejin.im/', 3, 12, '2020-08-08 15:18:11', '2020-08-08 15:20:35', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (285, 1031, 'Vue', '/profile/site/system/5ebfa247ff3e3cbcb1ada1c5a9b2506b.png', '渐进式 JavaScript 框架。', 'https://cn.vuejs.org/', 1, 23, '2020-08-08 15:21:55', '2020-08-08 15:23:40', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (286, 1031, 'React', '/profile/site/system/9e76a67ae80210b18e4db37b45a2574a.ico', '用于构建用户界面的 JavaScript 库。', 'https://react.docschina.org/', 2, 11, '2020-08-08 15:23:35', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (287, 1031, 'Angular', '/profile/site/system/ed0f155ed1b6acc4e6f307543883aa7e.ico', '一套框架，多种平台 移动端 &amp; 桌面端。', 'https://angular.cn/', 3, 9, '2020-08-08 15:25:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (288, 102, '哔哩哔哩', '/profile/site/system/2c834f873a91bf3264f868a06dafab21.ico', '国内知名的视频弹幕网站，这里有最及时的动漫新番，最棒的ACG氛围，最有创意的Up主。', 'https://www.bilibili.com/', 5, 101, '2020-08-08 15:27:31', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (289, 1031, 'Element', '/profile/site/system/d636a118f9f69184a730ffa3082fdb80.ico', '一套为开发者、设计师和产品经理准备的基于 Vue 2.0 的桌面端组件库', 'https://element.eleme.cn/', 4, 87, '2020-08-08 15:30:27', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (290, 1031, 'vue-element-admin', '/profile/site/system/d91882f77429ded326a30bda549c329d.png', '一个后台前端解决方案，它基于 vue 和 element-ui 实现。', 'https://panjiachen.gitee.io/vue-element-admin-site/zh/', 5, 18, '2020-08-08 15:32:01', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (291, 1007, '知乎', '/profile/site/system/02090c1f2ff7d580395b7dfe44ba066c.ico', '有问题，上知乎。知乎，可信赖的问答社区，以让每个人高效获得可信赖的解答为使命。', 'https://www.zhihu.com', 5, 20, '2020-08-08 15:34:36', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (292, 1030, 'Spring', '/profile/site/system/39caf5180b7d84ff2f277b25ca10f6ce.png', 'Spring 框架是一个开源的 Java 平台，它为容易而快速的开发出耐用的 Java 应用程序提供了全面的基础设施。', 'https://spring.io/', 1, 24, '2020-08-08 15:37:04', '2020-08-08 15:38:49', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (293, 1030, 'MyBatis-Plus', '/profile/site/system/4eb015ca9291887d648fc075f76303ac.png', '为简化开发而生。', 'https://mp.baomidou.com/', 2, 11, '2020-08-08 15:40:12', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (294, 1030, '力扣 LeetCode', '/profile/site/system/3b0dcb135f4c9a960b385170ce5f3946.png', '全球极客挚爱的技术成长平台', 'https://leetcode-cn.com/', 3, 12, '2020-08-08 15:44:12', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (295, 1004, 'Convertio 文件转换器', '/profile/site/system/b5d554962ba1cc493607a32f5328787d.png', '超级强大的文件格式转化器，视频、图片、字体、音频通通都可以。', 'https://convertio.co/zh/', 7, 14, '2020-08-09 13:01:13', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (296, 1007, '菜鸟教程', '/profile/site/system/b66656c08273c4761073eab6ae59b1ca.ico', '学的不仅是技术，更是梦想！', 'https://www.runoob.com/', 6, 17, '2020-08-09 13:08:03', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (297, 1031, 'Bootstrap', '/profile/site/system/5285612ea8533aa78c30bfa382171077.ico', '简洁、直观、强悍的前端开发框架，让web开发更迅速、简单。', 'https://www.bootcss.com/', 6, 5, '2020-08-09 13:09:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (298, 1007, 'W3School', '/profile/site/system/4d2b466766140ef66ab6e4e92f73383d.png', '在 W3School，你可以找到你所需要的所有的网站建设教程。', 'https://www.w3school.com.cn/', 7, 8, '2020-08-09 13:14:17', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (299, 1032, '五分钟学算法', '/profile/site/system/4356bd8feb9ae4b14a75fa81b79a6d2a.png', '一个不错的算法网站！', 'https://www.cxyxiaowu.com/', 6, 28, '2020-08-09 13:15:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (300, 1001, '凌风云搜索', '/profile/site/system/ed2c1e745ad694bbe206dd93c0ff8ea1.jpg', '专注于互联网免费资源的大数据搜索，网盘搜索，云盘资源等', 'https://www.lingfengyun.com/', 9, 19, '2020-08-09 21:53:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (301, 1001, '盘搜一下', '/profile/site/system/8e7c3e845590840d08c7a69f9803501f.ico', '网盘搜索，盘搜一下，百度网盘就搜到-国内优秀百度网盘搜索引擎。', 'http://www.pansou.com/', 10, 42, '2020-08-09 21:58:08', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (302, 1033, '坑搜网', '/profile/site/system/35c88e78a9a5d7d17f72a1ef159d236e.png', '坑搜网网盘搜索是专业的百度云搜索引擎，实时收录百度云、百度网盘等资源，每天更新各类高清电影、视频、种子、小说等网盘资源，真正你懂的网盘搜索神器!', 'http://www.kengso.com/', 1, 44, '2020-08-09 22:01:12', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (303, 1001, '罗马盘', '/profile/site/system/69d01f6bbf50666a7f5bb36c8e59fcbc.ico', '百度网盘搜索引擎 自动更新网络共享资源', 'https://www.luomapan.com/', 11, 29, '2020-08-09 22:03:54', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (304, 1001, 'bdyso', '/profile/site/system/b6494b1345e86d25a090af4e96e084b2.ico', '百度网盘资源搜索与分享', 'http://www.bdyso.com/', 12, 29, '2020-08-09 22:05:30', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (305, 1001, '史莱姆搜索', '/profile/site/system/1acf36c7d8a499cddc6a4058981015a7.png', '最丰富的学习资料库,收集整理了大量免费资源,教学资源,百度云资源,网盘资源。包含主流的资源搜索外,还能找到各行业细分的学习资源。', 'http://www.slimego.cn/', 13, 66, '2020-08-09 22:09:34', '2020-08-09 22:10:20', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (306, 1035, '微信公众号', '/profile/site/system/eb7f53364e44272c8a2ec83d0e83df43.png', '再小的个体，也有自己的品牌。', 'https://mp.weixin.qq.com/', 1, 32, '2020-08-11 17:47:03', '2020-08-11 17:52:22', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (307, 1035, '头条号', '/profile/site/system/0db580c9e8afe1e543c120a8e026be05.png', '今日头条推出的开放的内容创作与分发平台。', 'https://mp.toutiao.com', 2, 18, '2020-08-11 17:49:28', '2020-08-11 17:51:26', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (308, 1035, '知乎', '/profile/site/system/02090c1f2ff7d580395b7dfe44ba066c.ico', '有问题，上知乎。知乎，可信赖的问答社区，以让每个人高效获得可信赖的解答为使命。', 'https://www.zhihu.com', 5, 6, '2020-08-11 19:58:24', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (309, 1035, 'CSDN', '/profile/site/system/0b91790e27fe8cd3941fc6e6ee57ee4a.jpg', '专业开发者社区', 'https://www.csdn.net/', 6, 3, '2020-08-08 15:12:00', '2020-08-08 15:20:24', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (310, 1035, '博客园', '/profile/site/system/2ec8affefca78704574f1ba17fe070f2.png', '开发者的网上家园', 'https://www.cnblogs.com/', 7, 4, '2020-08-08 15:13:36', '2020-08-08 15:20:20', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (311, 1035, '思否', '/profile/site/system/570d66cff03484e48b05d6f02db9dfe4.ico', ' 在 SegmentFault，学习技能、解决问题。', 'https://segmentfault.com/', 8, 3, '2020-08-08 15:16:50', '2020-08-08 15:20:39', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (312, 1035, '掘金', '/profile/site/system/dcc82ea8e38e1bd994cabb18b8eb4e32.ico', '一个帮助开发者成长的社区。', 'https://juejin.im/', 9, 5, '2020-08-08 15:18:11', '2020-08-08 15:20:35', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (313, 1035, '企鹅号', '/profile/site/system/7c7b65475eddc144e90e6e9e059b75a7.png', '让世界看到你', 'https://om.qq.com/', 4, 3, '2020-08-11 20:03:20', '2020-08-11 20:07:10', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (314, 1035, '微博号', '/profile/site/system/0457b6128c225591f7b04dd23eaf4445.ico', '为创作者提供更优质的创作环境，帮助原创作者打造专属的个人品牌。', 'https://me.weibo.com/', 4, 3, '2020-08-11 20:05:49', '2020-08-11 20:06:30', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (315, 1035, '简书', '/profile/site/system/e7b0af0a5129784c861dd0730cebfea7.png', '一个优质的创作社区，在这里，你可以任性地创作。', 'https://www.jianshu.com/', 10, 2, '2020-08-11 20:08:35', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (316, 1035, '百家号', '/profile/site/system/ebb9886c7983ded7a1867941643de37f.png', '从这里影响世界。', 'https://baijiahao.baidu.com/', 4, 8, '2020-08-11 20:11:07', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (317, 1036, 'Unsplash', '/profile/site/system/09b7b39944a6893fbffa2842c0951468.png', '美丽的免费图片图片', 'https://unsplash.com/', 1, 7, '2020-08-11 20:15:40', '2020-08-11 20:23:02', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (318, 1036, 'Pexels', '/profile/site/system/5116557ff603b6d0cc4ba5270588684e.png', '免费图片', 'https://www.pexels.com/', 2, 23, '2020-08-11 20:17:44', '2020-08-11 20:23:35', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (319, 1036, 'UnDraw', '/profile/site/system/fb631125f144e2a6fe14120c2f4bd53f.png', '带有开源插图的设计项目，可满足您可以想象和创建的任何想法。', 'https://undraw.co', 3, 2, '2020-08-11 20:25:06', '2020-08-11 20:27:00', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (320, 1036, 'Pixabay', '/profile/site/system/3846a4474d17612128f18f51f3487fd9.png', '我们的才华横溢的社区分享了超过210万张免版税的图片。', 'https://pixabay.com/', 4, 4, '2020-08-11 20:28:06', '2020-08-11 20:30:43', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (321, 1036, 'Iconfinder', '/profile/site/system/e3325f68179436ccfc25b9f0ffff5a39.png', '2,100,000+个免费和高级矢量图标。', 'https://www.iconfinder.com', 5, 2, '2020-08-01 14:58:10', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (322, 1036, 'iconfont', '/profile/site/system/e1f63337915f79f8bcad1952adb9f6e1.png', '阿里巴巴矢量图标库。', 'http://www.iconfont.cn/', 6, 7, '2020-08-01 14:58:10', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (323, 1036, 'iconmonstr', '/profile/site/system/afd4885651455f12dcac4f214460dd99.png', '您的下一个项目的免费简单图标。', 'https://iconmonstr.com/', 7, 0, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (324, 1036, 'FindIcons', '/profile/site/system/0171a46b0f643752aa90aa314a22a546.png', '搜索300,000个免费图标。', 'https://findicons.com/', 8, 2, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (325, 1036, 'Icon Archive', '/profile/site/system/40c43a8932f24370cf456789b2ab51db.png', '搜索590,912个免费图标。', 'http://www.iconarchive.com/', 9, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (326, 1036, 'IcoMoonApp', '/profile/site/system/d19c97ead3760f1b70efa4ee9ad6859c.png', '图标字体，SVG，PDF, PNG生成器。', 'https://icomoon.io/app/', 10, 0, '2020-08-01 14:58:11', '2020-08-11 20:36:42', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (327, 1036, 'easyicon', '/profile/site/system/34b4382075e047c6d1456f8fe591a1ef.png', 'PNG、ICO、ICNS格式图标搜索、图标下载服务。', 'http://www.easyicon.net/', 11, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (328, 1036, 'flaticon', '/profile/site/system/582cf7361a0b4f444628c68b98e5cfc7.png', '634,000+免费矢量图标为SVG，PSD，PNG，EPS格式或图标字体。', 'https://www.flaticon.com/', 12, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (329, 1036, 'UICloud', '/profile/site/system/f9840e127d500449da1c5c721f3634c3.png', '世界上最大的用户界面设计数据库。', 'http://ui-cloud.com/', 13, 2, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (330, 1036, 'Font Awesome Icon', '/profile/site/system/88440b8b0d5dc43a3f766670e2d11746.png', '惊人的675个图标的完整集合。', 'https://fontawesome.com/', 14, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (331, 1036, 'ion icons', '/profile/site/system/6d0fd0bf35549f6d61037bd86e2ca242.png', 'Ionic Framework的高级图标字体。', 'http://ionicons.com/', 15, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (332, 1036, 'Simpleline Icons', '/profile/site/system/acf446f1af754f863260cc10dd8d546e.png', '简单的线条图标包。', 'http://simplelineicons.com/', 16, 1, '2020-08-01 14:58:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (333, 1038, '盘密码', '/profile/site/system/db4c1d5baba69d0c426cedae275c808c.ico', '网盘提取码查询！', 'https://pnote.net/pan/', 1, 62, '2020-08-11 20:40:20', '2020-08-19 20:22:42', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (334, 1032, 'Java知音', '/profile/site/system/bbe364f9-0c94-4f88-a4ad-2b590064d624.jpeg', '一个专注于Java技术分享的网站', 'https://www.javazhiyin.com/', 7, 17, '2020-08-18 21:50:19', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (335, 1010, 'MacWk', '/profile/site/system/17a92b31-c9da-4dee-a04c-4ecf9cd92933.jpeg', '无广告，无后门，安全！', 'https://macwk.com/', 3, 18, '2020-08-18 21:54:00', '2020-08-18 21:54:34', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (336, 1002, '时宜搜书', '/profile/site/system/87f1e744-95e3-4c59-818e-039ee2918b2b.jpeg', '专业电子书搜索引擎', 'https://www.shiyisoushu.com/', 16, 10, '2020-08-19 00:13:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (337, 1002, '熊猫搜书', '/profile/site/system/716ae21b-c7f1-4493-8678-38acd489ec2d.jpeg', '好用的电子书搜索', 'https://ebook.huzerui.com/', 17, 27, '2020-08-19 00:15:37', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (338, 1002, '最宜读', '/profile/site/system/6a65988a-4c55-484c-955d-fb21e5d14a61.png', '最易读书库', 'https://zuiyidu.com/', 18, 15, '2020-08-19 00:16:32', '2020-09-20 20:27:02', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (339, 1002, '采书', '/profile/site/system/cb4ce9d0-2bb0-4189-a4f3-b9d6a20c95b9.jpeg', '免费电子书搜索引擎', 'http://ebook.name/', 19, 21, '2020-08-19 00:17:39', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (340, 1002, '知轩藏书', '/profile/site/system/2e3e22f2-cd93-45b3-8278-604c483ed70e.jpeg', '玄幻小说排行榜精校-校对全本TXT小说下载网', 'http://zxcs.info/', 20, 8, '2020-08-19 00:20:24', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (341, 1037, 'WallHaven', '/profile/site/system/ff5238ff-e030-4f55-a6fb-ba49fd772ea8.jpeg', '种类多，壁纸好看！', 'https://wallhaven.cc/', 1, 69, '2020-08-19 19:42:33', '2020-09-20 20:28:40', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (342, 1037, 'Wallls', '/profile/site/system/3267d11e-db69-4dde-80fb-e3fef5d7ae6f.jpeg', '您从未见过的壁纸。', 'http://wallls.com/', 2, 31, '2020-08-19 19:44:48', '2020-09-20 20:28:47', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (344, 1037, 'SimpleDesktops', '/profile/site/system/1687352f-29f4-4eea-a61e-a0eeded626f1.jpeg', '简单', 'http://simpledesktops.com/', 4, 18, '2020-08-19 19:52:00', '2020-09-20 20:29:03', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (345, 1037, '彼岸桌面', '/profile/site/system/bd5b21c3-3bf1-47cc-b25f-36b4aa38180d.jpeg', '美丽精致的壁纸，免费提供风景、日历、美女、动漫、汽车、花卉、节日、动物、游戏、qq、阿狸等唯美、可爱、好看的壁纸，下载您所需要的壁纸', 'http://www.netbian.com/', 1, 98, '2020-08-19 19:57:41', '2020-12-03 13:37:09', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (346, 1001, '猪猪盘', '/profile/site/system/04e0b7e4-2569-49bf-8629-b7a503dd8fe2.png', '索引1亿+网盘资源', 'http://www.zhuzhupan.com/', 15, 55, '2020-08-19 20:13:29', '2020-09-20 20:25:48', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (347, 1001, '酷搜', '/profile/site/system/4d63b4a7-534b-4de8-a163-3a477a55e3cf.jpeg', '百度网盘搜索引擎,百度云资源搜索,网盘资源下载', 'https://www.kolsou.com/', 16, 19, '2020-08-19 20:14:54', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (348, 1001, '小白盘', '/profile/site/system/f04b12a5-3a1d-4af2-9672-08a0e5458bf2.jpeg', '网盘搜索', 'https://www.xiaobaipan.com/', 17, 30, '2020-08-19 20:16:51', '2020-08-19 20:18:03', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (349, 1001, '天天云搜', '/profile/site/system/dfacb5aa-2533-4b42-8972-aa8d27a06b1d.jpeg', '百度云搜索引擎入口-网盘搜索神器-天天云搜-百度云资源分享吧', 'https://www.ttyunsou.com/', 18, 22, '2020-08-19 20:19:16', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (350, 1001, '微友搜索', '/profile/site/system/dce69c1f-56dd-44fe-8aba-911d3b2b12ff.jpeg', '你懂的专业、强大、快速的百度云网盘资源搜索与下载引擎！', 'http://www.weiyoou8.com/', 19, 32, '2020-08-19 20:20:21', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (351, 1038, '百度云盘万能钥匙', '/profile/site/system/0fe8c974-ee32-4c45-ab1e-eb97924da2b3.jpeg', '百度云盘万能钥匙,百度云盘提取码查询', 'http://tools.bugscaner.com/baiduyunpassword/', 2, 64, '2020-08-19 20:24:47', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (352, 1004, '快用工具', '/profile/site/system/c5a1b819-a2ac-40a5-8aba-4b2204b8e115.jpeg', '提供各种优质、快捷、易用的在线工具，无需下载安装即可使用。', 'https://fastools.cn/', 1, 24, '2020-08-20 10:43:46', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (353, 1037, '极简壁纸', '/profile/site/system/7dcc6100-d451-4d78-915e-ea68c166d5cd.jpeg', '超高清电脑桌面壁纸美图；每天更新海量 4K 电脑壁纸，9012年最潮的壁纸网站，壁纸包括美女、二次元、自然风景。', 'https://bz.zzzmh.cn/', 1, 104, '2020-08-20 10:50:21', '2020-12-03 13:37:05', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (354, 1039, '135编辑器', '/profile/site/system/37ddd142-39c9-447c-b116-06f2e25878a0.jpeg', '提供丰富的样式库，支持插入排版、秒刷排版、一键排版等。', 'http://www.135editor.com/', 1, 1, '2020-08-20 11:05:19', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (355, 1039, '秀米', '/profile/site/system/db7eb18d-abdc-4979-bad3-2df745827332.jpeg', '素材顺应时下的审美，质量高，以布局的概念来进行不同组件的排版。', 'https://xiumi.us', 2, 5, '2020-08-20 11:12:34', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (356, 1039, '96微信编辑器', '/profile/site/system/849bb7d5-0616-478a-bada-40c3ad70a35f.jpeg', '大量精选素材、可以制作动态二维码、超多色值推荐、表情符号等。', 'https://bj.96weixin.com/', 3, 5, '2020-08-20 11:13:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (357, 1039, 'i排版', '/profile/site/system/0107da22-c291-4d7d-9270-3ef7d8b9a5ac.jpeg', '偏清新文艺风，编辑界面较干净，容易上手，支持各种文本格式样式。', 'http://ipaiban.com/', 4, 3, '2020-08-20 11:18:13', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (358, 1039, '新榜编辑器', '/profile/site/system/61ed7aaf-2edd-4877-9d2a-4635a22b49e1.jpeg', '海量在线图片搜索、一键同步多平台，大量爆文可供参考。', 'https://edit.newrank.cn/', 5, 1, '2020-08-20 11:19:12', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (359, 1039, 'Markdown Nice', '/profile/site/system/a4db5eb7-7b52-4278-8a03-d147c817e494.jpeg', '一款在线，支持自定义样式的微信 Markdown 排版工具；现支持微信公众号、知乎、开源中国、稀土掘金、博客园和 CSDN 等一系列平台。另外，支持变更不同主题风格、格式化（微信外链转脚注、中英文间带空格）等。', 'https://www.mdnice.com/', 0, 14, '2020-08-20 11:22:19', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (360, 1039, '壹伴', '/profile/site/system/2632d2f2-c7bc-4278-90c4-ae75221e167a.jpeg', '更好用的微信编辑器，但不止于此。你可以使用壹伴小插件来高效地排版、修图、找素材、回消息和导出数据，50万公众号运营者的共同选择', 'https://yiban.io/', 6, 1, '2020-08-22 10:29:29', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (361, 1036, '创客贴', '/profile/site/system/3808ba9d-c655-42c9-b56f-cbdc04169be2.jpeg', '提供了15万+精品设计模板，120万+图片素材，涵盖营销海报、新媒体配图、印刷物料、PPT、简历等办公文档、电商设计、定制设计等百余种设计场景，选择喜爱的模板，AI智能生成设计，设计不求人。', 'https://www.chuangkit.com/', 0, 8, '2020-08-22 10:33:27', '2020-08-22 10:40:29', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (362, 1036, '懒设计', '/profile/site/system/bb76267f-1f2f-47c5-8c63-b4c136d58386.jpeg', '全球最受欢迎的平面设计工具和在线平面设计软件之一,提供海量海报、邀请函、贺卡、banner、logo、名片等免费设计素材和模板,可在线一键稿定设计印刷', 'https://www.fotor.com.cn/', 0, 4, '2020-08-22 10:39:01', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (363, 1011, '磁力熊', '/profile/site/system/75babf0b-ac99-4b61-8de0-b500f06398ff.jpeg', '1080P高清电影磁力迅雷下载,豆瓣Top250及豆瓣高分电影1080P高清磁力下载。', 'https://www.cilixiong.com/', 7, 82, '2020-08-22 18:25:13', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (364, 1011, '片吧', '/profile/site/system/8818f6a1-df1a-4094-91c9-640f9b3cdae6.jpeg', '最新好看的电视剧、电影免费在线播放，高清电影MP4下载、在线云播，经典动漫、热门综艺娱乐节目在线点播！', 'http://www.pianba.tv/', 8, 61, '2020-08-22 18:26:42', '2020-08-22 18:26:58', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (365, 1011, '剧汇TV', '/profile/site/system/e010d0cf-a914-4741-88dd-572b313b7672.jpeg', '免费热门在线视频站，影视大全。囊括国内外电影，电视剧，韩剧，日剧等精彩视频尽在剧汇TV免费在线观看！支持国内各大平台视频超前点播！支持安卓端、电脑端、网页端！', 'https://www.juhuitv.com/', 9, 29, '2020-08-22 18:28:28', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (366, 1011, '神马影院', '/profile/site/system/8ecdec9c-7802-4007-a30c-078fa7977a27.jpeg', '资源丰富，播放流畅缓冲快！', 'https://www.shenma4480.com/', 10, 59, '2020-08-22 18:29:46', '2020-08-22 18:37:47', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (367, 1011, '哔嘀影视', '/profile/site/system/f32be96e-14c9-41cb-9217-ea8a28948c65.jpeg', '在线观看，支持百度云，电驴，磁力链接下载', 'https://bde4.com/', 11, 64, '2020-08-22 18:31:14', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (368, 1011, 'NO视频', '/profile/site/system/bf08096d-7cb2-45e2-a00c-3efe03f0e84b.jpeg', '欧美、日韩、港台影视', 'https://www.novipnoad.com/', 12, 13, '2020-08-22 18:32:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (369, 1011, '奈菲影视', '/profile/site/system/f40b59fe-783a-4662-bfc5-7b8e7cf921d3.jpeg', '欧美、日韩、港台影视', 'https://www.nfmovies.com/', 13, 21, '2020-08-22 18:33:57', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (370, 1011, '91美剧网', '/profile/site/system/932b2628-a9c4-4b96-897f-e9587882a06d.jpeg', '美剧资源丰富，更新快', 'https://91mjw.com/', 14, 36, '2020-08-22 18:35:18', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (371, 1011, '南柯电影', '/profile/site/system/1687352f-29f4-4eea-a61e-a0eeded626f1.jpeg', '无广告，速度快！', 'https://www.nkdyw.com/', 15, 38, '2020-08-22 18:36:51', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (372, 1011, 'ADC电影网', '/profile/site/system/4e48001d-e551-40fc-9613-4b06096bad81.jpeg', '资源更新快', 'https://www.adcmove.com/', 16, 59, '2020-08-22 18:38:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (373, 1011, '太初电影', '/profile/site/system/d6fc09c1-76cf-4c8f-ae7c-edd95d72de50.jpeg', '资源丰富更新快', 'https://www.tcmove.com/', 17, 33, '2020-08-22 18:41:14', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (374, 1011, '1090影视', '/profile/site/system/7aa95b10-e303-4cb2-9869-361106c46132.jpeg', '全站无水印播放极速不卡顿', 'http://1090ys1.com/', 18, 48, '2020-08-22 18:42:28', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (375, 1011, '泡饭网', '/profile/site/system/cf26fdaf-ff99-4dd7-9648-2f4019d503e1.jpeg', '超清无水印视频站', 'https://www.paofans.net/', 19, 26, '2020-08-22 18:43:36', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (376, 1012, 'MyFree MP3', '/profile/site/system/3267d11e-db69-4dde-80fb-e3fef5d7ae6f.jpeg', '支持音乐在线试听、下载，以及无损音质的下载！', 'http://tool.liumingye.cn/music/', 9, 27, '2020-08-22 18:46:10', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (377, 1012, '铜钟音乐', '/profile/site/system/ff5238ff-e030-4f55-a6fb-ba49fd772ea8.jpeg', '可以在线聆听来自QQ音乐、网易云音乐、虾米音乐和酷我音乐四家平台的音乐。音乐在线试听，音乐下载！', 'http://tongzhong.xyz/', 10, 15, '2020-08-22 18:47:55', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (378, 1031, 'Ant Design', '/profile/site/system/6df56693-ffd1-4470-b905-0986f1236deb.jpeg', '一套企业级 UI 设计语言和 React 组件库', 'https://ant.design/index-cn', 7, 7, '2020-08-24 21:44:54', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (379, 1030, 'knife4j', '/profile/site/system/c74470de-7f78-4894-a475-522fa6774170.jpeg', '为Java MVC框架集成Swagger生成Api文档的增强解决方案 ', 'https://doc.xiaominfo.com/', 4, 3, '2020-08-25 19:39:38', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (380, 1040, 'GitHub 加速下载', '/profile/site/system/github.png', '一个对于 GitHub.com 的镜像加速器。我们使用开放资源为 GitHub 加速。', 'http://toolwa.com/github/', 1, 22, '2020-08-31 22:52:30', '2020-09-25 08:42:27', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (381, 1040, '下载', '/profile/site/system/github.png', '不需要购买，直接下载！', 'https://d.serctl.com/', 2, 24, '2020-08-31 23:01:16', '2020-09-25 08:43:52', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (382, 1040, 'GitHub 文件加速', '/profile/site/system/github.png', '直接走本服务器 CN2 GIA 线路 . 大多数情况下体验更佳！', 'https://g.ioiox.com/', 3, 10, '2020-08-31 23:01:46', '2020-09-25 08:44:40', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (383, 1040, 'GitHub代下', '/profile/site/system/github.png', '代下服务，永久免费！', 'http://gitd.cc/', 4, 10, '2020-08-31 23:03:00', '2020-09-25 08:45:21', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (384, 1040, 'GitHub加速链接生成工具', '/profile/site/system/github.png', '利用ucloud提供的GlobalSSH功能，对ssh协议数据进行加速！', 'https://github.zhlh6.cn/', 5, 3, '2020-08-31 23:04:04', '2020-09-25 08:46:18', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (385, 1017, 'SQL转Java', '/profile/site/system/3804cbf8-bb0e-437f-890e-7db6f6f778e0.jpeg', 'SQL转Java JPA、MYBATIS实现类代码生成平台。', 'https://java.bejson.com/generator/', 9, 20, '2020-09-07 10:12:34', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (386, 1011, 'M3U8播放器', '/profile/site/system/8b13f949-cc19-4882-aa8c-f236fbc04b84.jpeg', '电影、美剧、韩剧、漫画的直链', 'https://www.m3u8play.com/', 20, 31, '2020-09-08 20:33:58', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (387, 1017, '免费在线语音转文字', '/profile/site/system/bb15ab1d-410b-4242-ab81-50c1b6f1a81b.jpeg', '语音转文字，做纪录或者文字稿等', 'https://beecut.cn/speech-to-text-online', 10, 4, '2020-09-09 15:50:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (388, 1037, 'Wallpaper', '/profile/site/system/f32be96e-14c9-41cb-9217-ea8a28948c65.jpeg', '设计，室内设计，建筑，时尚，艺术', 'https://wall.alphacoders.com/?lang=Chinese', 7, 24, '2020-09-09 23:40:13', '2020-12-11 09:07:39', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (389, 1035, '视频号助手', '/profile/site/system/wxshipinghao.ico', '微信视频号助手', 'https://channels.weixin.qq.com/', 11, 5, '2020-09-11 20:52:11', '2020-09-11 20:55:03', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (390, 1005, 'DeepL翻译', '/profile/site/system/1cba9c99-73ef-422f-87ef-2e541bf82d1b.png', '将一段文字翻译到尽可能的通顺和便于理解，甚至是俚语、方言、名言名句、古诗词等内容都可以几乎没有任何语病的翻译出来。', 'https://www.deepl.com/translator', 5, 3, '2020-09-12 15:58:24', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (391, 1002, '搬书匠', '/profile/site/system/a7e8a0e2-ffe5-417c-bddf-43921d07554b.png', '编程书籍的好网站', 'http://www.banshujiang.cn/', 21, 12, '2020-09-13 14:43:50', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (392, 1035, '网易见外', '/profile/site/system/c6348b72-41e6-4237-9122-33b4c52cdf3e.png', '由人工智能事业部研发,是一个集视频听翻、直播听翻、语音转写、文档直翻功能为一体的AI智能语音转写听翻平台。', 'https://jianwai.youdao.com/', 10, 0, '2020-09-15 00:24:00', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (393, 1041, '文库社', '/profile/site/system/86f7eb02-110f-49a4-8401-e2223802da15.jpeg', '百度文库文档免费下载', 'https://www.wenku.zone/', 1, 16, '2020-09-16 10:33:36', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (394, 1042, '若依 / RuoYi-Vue', '/profile/site/system/35196237-8319-4204-a844-bc06b4409a39.png', '基于SpringBoot，Spring Security，JWT，Vue & Element 的前后端分离权限管理系统 ', 'https://gitee.com/y_project/RuoYi-Vue', 1, 46, '2020-09-16 14:39:29', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (395, 1042, '若依 / RuoYi-Cloud', '/profile/site/system/35196237-8319-4204-a844-bc06b4409a39.png', '基于Spring Boot、Spring Cloud & Alibaba、OAuth2的分布式微服务架构权限管理系统 ', 'https://gitee.com/y_project/RuoYi-Cloud', 2, 15, '2020-09-16 14:41:32', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (396, 1042, '陌溪 / 蘑菇博客', '/profile/site/system/3247f776-f5a8-452a-998a-ebf411948607.png', '一个基于微服务架构的前后端分离博客系统。', 'https://gitee.com/moxi159753/mogu_blog_v2', 3, 31, '2020-09-16 14:43:45', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (397, 1042, 'FEBS-Cloud', '/profile/site/system/35fcf5e6-8980-4b4d-9da4-564b3bd3f333.png', '基于Spring Cloud Hoxton.RELEASE、Spring Cloud OAuth2 & Spring Cloud Alibaba & Element 微服务权限系统，开箱即用。', 'https://github.com/febsteam/FEBS-Cloud', 4, 8, '2020-09-16 14:46:37', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (398, 1042, '慕容若冰 / spring-microservice-exam', '/profile/site/system/15afba18-f1c2-4313-b664-ba8943a333a4.png', '硕果云，基于Spring Cloud搭建的新一代微服务教学管理平台，提供多租户、权限管理、考试、练习等功能，题型支持单选题、多选题、不定项选择题、判断题、简答题，二维码分享，移动端答题等 ', 'https://gitee.com/wells2333/spring-microservice-exam', 5, 20, '2020-09-16 14:48:27', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (399, 1032, '蘑菇博客', '/profile/site/system/3247f776-f5a8-452a-998a-ebf411948607.png', '专注于技术分享的博客平台', 'http://www.moguit.cn', 8, 30, '2020-09-16 14:54:32', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (400, 1035, 'QQ公众平台', '/profile/site/system/7424959f-6ada-48f9-9077-a7e0477e6e3d.png', 'QQ公众平台，为解决个人，企业，组织在QQ平台上的业务服务与用户管理提供实用的服务工具平台。', 'https://mp.qq.com', 14, 3, '2020-09-18 09:52:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (401, 1035, '抖音短视频', '/profile/site/system/b5541655-6a6f-47b9-8698-9bab021fa846.ico', '抖音短视频，一个旨在帮助大众用户表达自我，记录美好生活的短视频分享平台。为用户创造丰富多样的玩法，让用户在生活中轻松快速产出优质短视频。', 'https://www.douyin.com/', 15, 5, '2020-09-18 09:54:01', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (402, 1017, 'GitMind', '/profile/site/system/d3799599-6413-4944-a6f4-241e5c54c51c.png', '免费在线思维导图软件，简化逻辑梳理，集思广益，释放创造力在线脑图、思维导图、流程图、工业设计、工程管理，一图涵千面 ', 'https://gitmind.cn/', 11, 5, '2020-09-20 14:33:02', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (403, 1004, 'DocSmall', '/profile/site/system/380cb37a-370d-40df-8807-5c318e5310f2.png', '免费在线图片压缩、GIF压缩工具、PDF压缩工具、PDF合并工具、PDF分割工具', 'https://docsmall.com/', 8, 5, '2020-09-20 14:36:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (404, 1017, 'Dimmy', '/profile/site/system/12d7985a-2fc7-49b7-b6e6-55312ac1c550.png', '手机电脑等设备的展示模型，可以让你的图片放在电脑、手机、ipad等模型中展示，图片档次大大提升。', 'https://dimmy.club/', 12, 4, '2020-09-20 14:38:10', '2020-09-20 14:42:26', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (405, 1017, 'BrowserFrame', '/profile/site/system/251a15a3-811e-4359-98e2-f03b3319240e.ico', '浏览器展示模型工具', 'http://browserframe.com/', 13, 3, '2020-09-20 14:39:26', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (406, 1017, 'Flourish', '/profile/site/system/3416f7ae-1e74-45ef-b03d-4dfa730f1105.png', ' 数据可视化工具，快速地把表格数据转换为各种各样好看的图表，并且还支持动态可视化。', 'https://flourish.studio/', 14, 4, '2020-09-20 14:41:21', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (407, 1017, 'RemoveBg', '/profile/site/system/b2377b53-291b-4129-bdbe-68cb3a1fa7c3.png', '抠图神器，消除图片中的背景。', 'https://www.remove.bg/zh', 15, 2, '2020-09-20 14:44:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (408, 1018, 'Crx4Chrome', '/profile/site/system/af48b33f-ab08-4e71-a4de-32af6b930860.ico', ' Chrome浏览器插件站', 'https://www.crx4chrome.com/', 7, 5, '2020-09-20 14:46:03', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (409, 1043, '易视网', '/profile/site/system/e393d0d3-5a07-4c3a-a648-b5fa63b55fea.ico', '直播网络电视直播在线观看', 'https://www.cietv.com/', 1, 17, '2020-09-20 14:55:21', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (410, 1043, '好趣网', '/profile/site/system/f6ce09df-432f-4903-b308-99f65ab9504b.png', '2000套高清网络电视直播在线观看', 'http://tv.haoqu99.com/', 2, 17, '2020-09-20 14:56:41', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (411, 1042, 'EasyCaptcha', '/profile/site/system/c85348a4-7b34-488c-bd95-8b7b106f793d.png', 'Java图形验证码，支持gif、中文、算术等类型，可用于Java Web、JavaSE等项目。', 'https://gitee.com/whvse/EasyCaptcha', 6, 15, '2020-09-20 15:59:37', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (412, 1017, '短视频解析', '/profile/site/system/b0ffc6e6-6b42-4f5a-a221-44d9ff2c3ee7.png', '支持解析快手、抖音、Youtube、Tiktok、火山、今日头条、西瓜视频、皮皮虾、小咖秀、趣多拍、微视、美拍、秒拍、网易云、TikTok、哔哩哔哩、陌陌、映客、迅雷、阳光宽频、全民 K 歌、刷宝、WIDE 短视频、小红书、等平台的视频，而且解析出来的网站视频没有水印。', 'http://www.dspjx.com/', 16, 13, '2020-09-23 23:57:07', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (413, 1008, '微 PE 工具箱', '/profile/site/system/93975589-a3c2-4540-9893-69a0149d6435.png', '微 PE 工具箱 就是一款常用的 Windows PE 工具包，支持 Windows 10，提供了 32/64 位版本，并且支持 NVME 硬盘。', 'http://www.wepe.com.cn/', 8, 10, '2020-09-23 23:59:35', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (414, 1017, 'GeoGebra', '/profile/site/system/68292c53-cd3e-4a4a-9a4e-7d67359fb1e6.png', '一款结合几何、代数与微积分的免费动态数学软件，也支持在线直接绘图 /计算。', 'https://www.geogebra.org', 17, 1, '2020-09-24 00:01:36', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (415, 1017, 'Screely 截图美化工具', '/profile/site/system/logo.jpg', 'Mac 电脑自带的截图工具，因为它默认会给截图窗口添加阴影，非常漂亮。', 'https://www.screely.com/', 18, 0, '2020-09-24 00:05:56', NULL, 'geshazsq', 'geshanzsq', 1);
INSERT INTO `nav_site` VALUES (416, 1017, 'Maven 仓库', '/profile/site/system/4242630d-0216-4950-9646-d3ee647ba8e3.png', 'Jar 下载，Jar 依赖引用', 'https://mvnrepository.com/', 19, 12, '2020-09-24 08:41:01', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (417, 1035, '哔哩哔哩', '/profile/site/system/2c834f873a91bf3264f868a06dafab21.ico', '国内知名的视频弹幕网站，这里有最及时的动漫新番，最棒的ACG氛围，最有创意的Up主。', 'https://www.bilibili.com/', 16, 1, '2020-09-24 08:43:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (418, 1004, '萝卜工坊', '/profile/site/system/a970e871-9f79-4caa-a09e-df2fb7c9ddc2.png', '快速转换模拟手写字体文档，让打印出的字看起来像手写的 一个软件在线解决文字抄写烦恼', 'http://www.beautifulcarrot.com/', 9, 10, '2020-09-24 08:52:18', '2020-09-24 08:53:58', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (419, 1004, '二维码解码器', '/profile/site/system/989df62a-e0e5-468f-8fc7-f4b766d27ddd.png', '在线二维码解析和生成', 'https://jiema.wwei.cn/', 10, 6, '2020-09-24 08:57:01', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (420, 1004, 'PickFrom', '/profile/site/system/12736188-5677-410f-a628-1bab12ab00d9.ico', '一站式视频剪辑平台，让工作更简单。', 'https://zh.pickfrom.net/', 11, 5, '2020-09-24 08:59:06', '2020-09-24 08:59:32', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (421, 1004, '转字体', '/profile/site/system/89d9be4b-cb72-45ac-a30d-def2c1e30e1c.ico', '简体字繁体字互转', 'https://www.aies.cn/', 12, 3, '2020-09-24 09:02:38', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (422, 1040, 'GitHub 文件加速', '/profile/site/system/github.png', '利用 Cloudflare Workers 对 github release 、archive 以及项目文件进行加速，部署无需服务器且自带CDN。', 'https://gh.api.99988866.xyz/', 6, 1, '2020-09-25 08:41:24', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (427, 1037, '美桌网', '/profile/site/system/7510faa4-8159-49be-ae55-02629202fbe3.ico', '陪你下载生活的美！', 'http://www.win4000.com/', 8, 19, '2020-09-29 14:43:48', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (428, 1037, '回车桌面', '/profile/site/system/d40daccb-e4d7-4f34-a909-0341e49cd238.ico', '动画、漫画、卡通、锁屏图片、高清手机壁纸！', 'https://www.enterdesk.com/', 9, 15, '2020-09-29 14:45:43', '2020-09-29 14:47:00', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (429, 1037, '全面屏壁纸', '/profile/site/system/1ab3ecc5-ebc6-474a-814e-fa57b3781edb.ico', '专为全面屏和刘海屏手机适配的2K超高清壁纸网站！', 'http://m.bcoderss.com/', 10, 28, '2020-09-29 14:48:48', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (430, 1011, '无限影视网', '/profile/site/system/2c0a0e63-e07a-4344-aa11-e461e9616fee.png', '百万影片任你搜索！', 'https://www.wxtv.net/', 21, 17, '2020-09-30 14:36:33', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (431, 1011, '4K屋', '/profile/site/system/f52dc06e-5713-4e11-8e50-26edbd73e1fa.png', '4k屋是一个专门观看电视剧的网站，网站的电影几乎都是超高清、4k画质，保证让你看得舒服。需要会员的电视剧在这里几乎都能观看，可以省去开会员，特别适合女生。如果追求画面，或者需要观看的效果很好，这个绝对是你的不二选择。', 'http://www.kkkkwu.cc/', 22, 17, '2020-10-09 13:52:55', '2020-10-09 13:55:52', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (432, 1032, '不忘初心', '/profile/site/system/9b57a3c2-adc0-4dc9-a3d4-8d573be1fce0.png', '从心出发，专注精简系统！', 'https://www.pc521.net/', 10, 11, '2020-10-09 16:56:49', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (433, 1036, '免费版权图片', '/profile/site/system/19e0d9d2-cf36-4046-a2d3-80a028b789a3.jpg', '一键搜索多家免版权图库，再也不用担心商用图片侵权了 ！', 'https://www.logosc.cn/so/', 17, 7, '2020-10-09 17:25:56', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (434, 1036, 'ColorHub', '/profile/site/system/a51c8e1f-bc7b-4b91-8fcb-9511cc234682.png', '高清无版权图片，个人和商业用途免费！', 'https://colorhub.me/', 18, 2, '2020-10-09 17:28:50', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (435, 1036, 'Hippopx', '/profile/site/system/c44b31d2-6a73-4879-84da-6a2e909d8a8f.ico', '基于CC0协议的免版权图库！', 'https://www.hippopx.com/zh/', 19, 1, '2020-10-09 17:30:41', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (436, 1036, 'FreePik', '/profile/site/system/45c6ebba-1fa4-4728-8210-9f9218ecc6cd.jpg', '查找免费矢量，图库照片，PSD和图标！', 'https://www.freepik.com/', 20, 1, '2020-10-09 17:34:34', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (437, 1011, '影视2345', '/profile/site/system/93ff1384-6ceb-4357-818d-180b19e6fe0b.png', '免费超清影视大全在线看！', 'https://yingshi2345.com/', 23, 10, '2020-10-09 22:47:09', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (438, 1011, '云播TV', '/profile/site/system/e7d75bda-6468-48f9-9dee-84a7b304b420.png', '一个单纯不做作的电影站！', 'https://www.yunbtv.com/', 24, 8, '2020-10-09 23:47:22', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (439, 1011, '两个BT', '/profile/site/system/a2e70378-c88c-437c-9dd3-a68302d96a07.png', 'BT下载与分享', 'https://www.bttwo.com/', 25, 10, '2020-10-09 23:49:04', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (440, 1011, '音范丝', '/profile/site/system/e8eb094d-efb6-40b9-886e-3ab03871950d.ico', '高清无水印，影音集、精选4K蓝光原盘下载，顶级收藏！', 'http://www.yinfans.me/', 26, 12, '2020-10-12 14:14:54', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (441, 1011, '腾讯视频WeTV', '/profile/site/system/fe2b466d9fe6bed552c0adcaac1c2813.ico', '腾讯视频海外版，无广告，而且可以免费观看1080P！', 'https://wetv.vip/zh-cn', 4, 13, '2020-10-12 20:45:11', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (442, 1017, '千千秀字', '/profile/site/system/fbdf9a0d-88d9-4fcc-88cc-c63a49ea1eab.png', '提供文字翻译、字体转换、字效生成等在线服务的同时，也关注着文字的历史和文字的各行应用。', 'https://www.qqxiuzi.cn/', 20, 2, '2020-10-12 23:10:47', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (443, 1002, '搜韵', '/profile/site/system/6b06e347-bfe9-4230-92e4-d4caba9b6747.png', '诗词门户网站，可检索，分经史子集和四库之外等，图像清晰，速度快，非常便捷', 'https://sou-yun.cn/', 22, 0, '2020-10-16 19:08:14', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (444, 1033, '磁力蚂蚁', '/profile/site/system/c34a0b59-42ef-4c6e-a842-427d3d11381c.ico', '磁力链接磁力搜索引擎，可以搜索各种电影电视剧，音乐，书籍和图片等', 'http://www.eclmy.space', 3, 23, '2020-10-16 21:39:56', '2020-10-16 21:40:13', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (445, 1046, '老殁', '/profile/site/system/22a74e7f-c58c-4914-86d6-4f557f572df9.png', '免费推荐优秀软件', 'https://www.mpyit.com', 1, 21, '2020-10-16 21:43:27', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (446, 1046, '果核剥壳', '/profile/site/system/1796f330-4e4f-49e6-819b-9810fca40735.png', '还原软件的本质，纯净软件分享，守住互联网最后的一片净土', 'https://www.ghpym.com', 5, 8, '2020-10-16 21:49:17', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (447, 1046, '423Down', '/profile/site/system/e005555a-a43c-423a-b74d-375b3867e442.ico', '有品质的电脑软件、Android软件分享博客', 'https://www.423down.com', 6, 6, '2020-10-16 21:51:13', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (448, 1046, '心海e站', '/profile/site/system/69c513c7-6150-4f58-bbf6-f866718b9238.jpg', '发布由烈火汉化的一些实用的软件，全部免费，杜绝广告！', 'https://hrtsea.com', 7, 10, '2020-10-16 21:53:50', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (449, 1046, '落尘之木', '/profile/site/system/292ba100-2d1a-4f63-acde-9c0f2c02bfe1.png', '分享互联网优秀软件、电脑经验、技术交流、IT类', 'https://www.luochenzhimu.com', 8, 7, '2020-10-16 21:55:28', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (450, 1046, '易破解', '/profile/site/system/4eba4e9c-e02d-47de-873b-7ae48b49a3f4.png', '给你所需要的内容', 'https://www.ypojie.com', 9, 16, '2020-10-16 21:56:42', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (451, 1046, 'QQ前线乐园', '/profile/site/system/1cef9d6a-2f6d-42a3-b133-a59ccea947eb.png', '专注于分享，分享好资源。', 'https://www.yijingying.com', 10, 3, '2020-10-16 21:58:21', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (452, 1046, '风刑软件站', '/profile/site/system/17597510-396f-41a5-abf2-41c847c0fa62.png', '一个满载优秀、严谨、开放的软件下载平台', 'https://www.wsf1234.com', 11, 8, '2020-10-16 22:01:28', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (453, 1046, '软件缘', '/profile/site/system/172e5128-b12a-45b9-8de2-cbf906d53164.png', '软件缘 - 精品绿软，品鉴独特', 'https://www.appcgn.com', 12, 11, '2020-10-16 22:03:19', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (454, 1010, 'XClient', '/profile/site/system/99befcc4-2463-4aba-a763-55566511a30c.png', '精品MAC应用分享', 'https://xclient.info', 4, 5, '2020-10-16 22:05:32', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (455, 1046, '孤独求软', '/profile/site/system/5ed58741-2885-48e1-98fe-65dbe3e4972a.png', '常用软件一站齐全', 'http://www.dugubest.com', 13, 9, '2020-10-16 22:06:56', '2020-10-16 22:56:07', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (456, 1010, '史蒂芬周的博客', '/profile/site/system/8b57d624-b4e1-48e3-8307-0c10b393ccb9.ico', '软硬兼施，娱乐共享。', 'http://www.sdifen.com', 5, 8, '2020-10-16 22:08:45', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (457, 1010, '苹果软件盒子', '/profile/site/system/2799a66d-646d-445f-87b8-b7335826b812.png', '分享优质 Mac', 'https://www.macappbox.com', 6, 11, '2020-10-16 22:10:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (458, 1046, 'Extfans 扩展迷', '/profile/site/system/809b5446-21e5-48fb-b68f-efa4409b673d.png', '好用的浏览器插件推荐', 'https://www.extfans.com', 14, 6, '2020-10-16 22:57:50', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (459, 1047, 'Golink加速器', '/profile/site/system/1432bb7a-5e20-446e-9ba7-72856d445abb.ico', '国内首款免费游戏加速器', 'https://www.golink.com', 1, 2, '2020-10-16 23:01:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (460, 1047, '流星游戏加速器', '/profile/site/system/c4597214-2353-414c-b9a2-af8d0ce250d2.ico', '真免费,为痛快!', 'https://www.liuxing.com', 2, 1, '2020-10-16 23:02:15', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (461, 1047, '奇妙网游加速器', '/profile/site/system/f00c3d4a-e411-42d5-9b26-fda14cc9dd68.png', '真正免费，低延时，真专线，真稳定，真好用', 'https://www.qimiao.com', 3, 1, '2020-10-16 23:03:41', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (462, 1047, 'WeFun游戏加速器', '/profile/site/system/ad592556-8fda-4087-9f0b-ebc8e3200c33.ico', '业的外服网游加速器免费使用', 'https://www.wefunapp.cn', 4, 4, '2020-10-16 23:07:31', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (463, 1047, '小霸王', '/profile/site/system/65fcca63-5610-4e2d-8ab9-9084c8b68e58.png', '找回童年的快乐 ', 'https://www.yikm.net', 5, 21, '2020-10-16 23:08:38', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (464, 1047, '侠聚网', '/profile/site/system/6b430ae2-c72b-45ac-829d-ea3ecd5551ee.png', '免费的Android游戏修改神器，内置海量游戏下载', 'http://www.huluxia.com', 6, 2, '2020-10-16 23:09:48', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (465, 1047, '骑士下载', '/profile/site/system/193635d3-0fff-4886-ac47-e801ec314ed1.png', '好玩的安卓游戏免费下载', 'https://www.vqs.com', 7, 1, '2020-10-16 23:11:23', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (466, 1047, 'TapTap', '/profile/site/system/6558f840-b408-4ee1-a019-9514d107c7f8.ico', '推荐高质量好玩的手机游戏', 'https://www.taptap.com', 8, 1, '2020-10-16 23:12:31', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (467, 1047, '拇指玩', '/profile/site/system/7805233d-3782-4b2f-9e8b-3c974aca4c87.png', 'Android安卓游戏免费下载', 'https://www.muzhiwan.com', 9, 2, '2020-10-16 23:13:22', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (468, 102, '大屏数据展示模板', '/profile/site/system/logo.jpg', '智慧交通、智慧电商、智慧金融、智慧城市、智慧气象、智慧物联、智慧物流、智慧医疗、智慧运维、智慧运营、智慧政务', 'https://bs.geshanzsq.com', 9, 68, '2020-10-17 23:06:37', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (469, 1042, '大屏数据展示模板', '/profile/site/system/logo.jpg', '智慧交通、智慧电商、智慧金融、智慧城市、智慧气象、智慧物联、智慧物流、智慧医疗、智慧运维、智慧运营、智慧政务', 'https://bs.geshanzsq.com', 7, 29, '2020-10-17 23:06:37', '2020-10-18 21:37:47', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (470, 1011, '快狐影视', '/profile/site/system/17977afa-97bb-482c-b28d-4de4da7a7b29.ico', '免费观看电视电影，在线看电视直播！', 'https://apoe.pw/', 27, 15, '2020-10-20 21:31:20', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (471, 1011, '思古影视', '/profile/site/system/5c8372f4-bd97-4f95-a927-665675f1b8e1.ico', '高清免费VIP视频在线解析', 'https://www.sigu.cc/', 28, 27, '2020-10-20 21:32:59', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (472, 1017, '文档免费下载', '/profile/site/system/7c70855c-a7c2-4377-8e4b-8837a688b43b.ico', '从此,下载百度文库文档变得简单', 'https://doc.chaney.top/', 21, 5, '2020-10-25 11:23:39', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (473, 1009, 'ROM乐园', '/profile/site/system/34cfc67c-7490-4f5f-b7fb-a0b1f3d812a7.jpeg', '专注于打造全网优质特色ROM刷机包下载官方网站', 'http://www.romleyuan.com', 6, 10, '2020-10-27 23:23:28', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (474, 1012, '听蛙', '/profile/site/system/d343a0ca-ba53-449a-a18d-feac6d6b0d3d.ico', '最好听的轻音乐纯音乐分享、试听、欣赏、下载、推荐、排行', 'https://www.itingwa.com', 0, 7, '2020-11-19 10:41:27', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (475, 1036, '免费版权图片一键搜索', '/profile/site/system/e1b9de70-d73a-4aa4-891b-884fdd5ccebf.png', '一键搜索多家免版权图库，再也不用担心商用图片侵权了 ', 'https://www.logosc.cn/so/', 21, 0, '2020-11-20 08:53:58', NULL, 'geshazsq', 'geshanzsq', 1);
INSERT INTO `nav_site` VALUES (476, 102, '格姗知识圈', '/profile/site/system/logo.jpg', '我的博客网站，专注于技术分享、实用工具与技巧的博客平台！', 'https://geshanzsq.com', 0, 36, '2020-11-25 00:49:54', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (477, 1032, '格姗知识圈', '/profile/site/system/logo.jpg', '我的博客网站，专注于技术分享、实用工具与技巧的博客平台！', 'https://geshanzsq.com', 1, 7, '2020-11-29 17:13:06', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (478, 1037, '人工桌面', '/profile/site/system/3982b997-0e85-4573-bb8c-ccf4db4bf83d.ico', '简洁又可爱的萌妹桌面软件。绝对是美女帅哥、宅男宅女的喜爱。', 'https://lumi.mihoyo.com/#/', 0, 9, '2020-12-03 13:39:48', '2020-12-03 13:39:55', 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (479, 1037, '故宫壁纸', '/profile/site/system/6dd9f9cc-d49e-4b32-abcd-5eba13580739.ico', '将历史的精彩收集到自己的手中', 'https://www.dpm.org.cn/lights/royal.html', 11, 2, '2020-12-11 09:10:22', NULL, 'geshazsq', 'geshanzsq', 0);
INSERT INTO `nav_site` VALUES (480, 1037, 'CGWallpapers', '/profile/site/system/0e5e058c-bf93-4c40-b327-b4064a023560.ico', ' 游戏CG壁纸站，超细腻，真假难分', 'https://www.cgwallpapers.com/', 12, 1, '2020-12-11 09:12:58', NULL, 'geshazsq', 'geshanzsq', 0);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-01-03 11:04:12', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-01-03 11:04:12', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-01-03 11:04:12', '', NULL, '深色主题theme-dark，浅色主题theme-light');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '格姗知识圈部门', 0, '格姗知识圈', '18888888888', '497301391@qq.com', '0', '0', 'admin', '2021-01-03 11:04:12', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '正常', '0', 'nav_menu_status', NULL, NULL, 'N', '0', 'admin', '2021-01-07 00:14:10', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (101, 2, '停用', '1', 'nav_menu_status', NULL, NULL, 'N', '0', 'admin', '2021-01-07 00:14:22', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (102, 1, '正常', '0', 'nav_site_status', NULL, NULL, 'N', '0', 'admin', '2021-01-07 00:16:16', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (103, 2, '停用', '1', 'nav_site_status', NULL, NULL, 'N', '0', 'admin', '2021-01-07 00:16:34', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '导航菜单状态', 'nav_menu_status', '0', 'admin', '2021-01-07 00:13:29', '', NULL, '导航菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (101, '导航网站状态', 'nav_site_status', '0', 'admin', '2021-01-07 00:15:59', '', NULL, '导航网站状态列表');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(1) DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2003 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-01-03 11:04:12', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-01-03 11:04:12', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-01-03 11:04:12', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-01-03 11:04:12', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-01-03 11:04:12', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-01-03 11:04:12', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-01-03 11:04:12', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-01-03 11:04:12', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-01-03 11:04:12', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-01-03 11:04:12', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2021-01-03 11:04:12', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2021-01-03 11:04:12', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-01-03 11:04:12', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2021-01-03 11:04:12', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-01-03 11:04:12', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-01-03 11:04:12', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2021-01-03 11:04:12', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-01-03 11:04:12', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-01-03 11:04:12', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-01-03 11:04:12', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-01-03 11:04:12', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '导航管理', 0, 0, 'nav', NULL, 1, 0, 'M', '0', '0', '', 'server', 'admin', '2021-01-03 16:44:52', 'admin', '2021-01-03 16:46:31', '');
INSERT INTO `sys_menu` VALUES (2001, '菜单管理', 2000, 1, 'menu', 'nav/menu/index', 1, 0, 'C', '0', '0', 'nav:menu:list', 'tool', 'admin', '2021-01-03 16:46:23', 'admin', '2021-01-03 16:48:13', '');
INSERT INTO `sys_menu` VALUES (2002, '网站管理', 2000, 2, 'site', 'nav/site/index', 1, 0, 'C', '0', '0', 'nav:site:list', 'star', 'admin', '2021-01-03 16:48:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '菜单查询', 2001, 1, '', NULL, 1, 0, 'F', '0', '0', 'nav:menu:list', '#', 'admin', '2021-01-07 00:04:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '菜单新增', 2001, 2, '', NULL, 1, 0, 'F', '0', '0', 'nav:menu:add', '#', 'admin', '2021-01-07 00:05:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '菜单修改', 2001, 3, '', NULL, 1, 0, 'F', '0', '0', 'nav:menu:edit', '#', 'admin', '2021-01-07 00:05:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '菜单删除', 2001, 4, '', NULL, 1, 0, 'F', '0', '0', 'nav:menu:remove', '#', 'admin', '2021-01-07 00:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '获取菜单下最大的排序', 2001, 5, '', NULL, 1, 0, 'F', '0', '0', 'nav:menu:getMaxChildrenMenuOrderNum', '#', 'admin', '2021-01-07 00:06:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '网站查询', 2002, 1, '', NULL, 1, 0, 'F', '0', '0', 'nav:site:query', '#', 'admin', '2021-01-07 00:07:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '网站添加', 2002, 2, '', NULL, 1, 0, 'F', '0', '0', 'nav:site:add', '#', 'admin', '2021-01-07 00:07:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '网站修改', 2002, 3, '', NULL, 1, 0, 'F', '0', '0', 'nav:site:edit', '#', 'admin', '2021-01-07 00:08:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '网站删除', 2002, 4, '', NULL, 1, 0, 'F', '0', '0', 'nav:site:remove', '#', 'admin', '2021-01-07 00:08:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '网站图片上传', 2002, 5, '', NULL, 1, 0, 'F', '0', '0', 'nav:site:uploadSiteImg', '#', 'admin', '2021-01-07 00:09:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '获取网站菜单下最大的排序', 2002, 6, '', NULL, 1, 0, 'F', '0', '0', 'nav:site:getSiteMaxOrderNum', '#', 'admin', '2021-01-07 00:09:30', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2021-01-01 格姗知识圈导航系统发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2021-01-03 11:04:12', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2021-01-03 格姗知识圈导航系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2021-01-03 11:04:12', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2021-01-03 11:04:12', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2021-01-03 11:04:12', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-01-03 11:04:12', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2021-01-03 11:04:12', 'admin', '2021-01-07 00:09:45', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2011);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (2, 2013);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 100, 'admin', '格姗知识圈', '00', '497301391@qq.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2021-01-03 11:04:12', 'admin', '2021-01-03 11:04:12', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 100, 'geshanzsq', '格姗知识圈', '00', '497301391@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2021-01-03 11:04:12', 'admin', '2021-01-03 11:04:12', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
