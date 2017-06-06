/*
Navicat MySQL Data Transfer

Source Server         : edusoho
Source Server Version : 50538
Source Host           : 127.0.0.1:3306
Source Database       : edusoho

Target Server Type    : MYSQL
Target Server Version : 50538
File Encoding         : 65001

Date: 2017-06-02 19:32:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '课程公告ID',
  `userId` int(10) NOT NULL COMMENT '公告发布人ID',
  `targetType` varchar(64) NOT NULL DEFAULT 'course' COMMENT '公告类型',
  `url` varchar(255) NOT NULL,
  `startTime` int(10) unsigned NOT NULL DEFAULT '0',
  `endTime` int(10) unsigned NOT NULL DEFAULT '0',
  `targetId` int(10) unsigned NOT NULL COMMENT '所属ID',
  `content` text NOT NULL COMMENT '公告内容',
  `createdTime` int(10) NOT NULL COMMENT '公告创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公告最后更新时间',
  `orgId` int(10) unsigned DEFAULT '1',
  `orgCode` varchar(255) DEFAULT '1.' COMMENT '组织机构内部编码',
  `copyId` int(11) NOT NULL DEFAULT '0' COMMENT '复制的公告ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of announcement
-- ----------------------------

-- ----------------------------
-- Table structure for announcement_bak
-- ----------------------------
DROP TABLE IF EXISTS `announcement_bak`;
CREATE TABLE `announcement_bak` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `startTime` int(10) unsigned NOT NULL DEFAULT '0',
  `endTime` int(10) unsigned NOT NULL DEFAULT '0',
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of announcement_bak
-- ----------------------------

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '栏目',
  `tagIds` tinytext COMMENT 'tag标签',
  `source` varchar(1024) DEFAULT '' COMMENT '来源',
  `sourceUrl` varchar(1024) DEFAULT '' COMMENT '来源URL',
  `publishedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `body` text COMMENT '正文',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图',
  `originalThumb` varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图原图',
  `picture` varchar(255) NOT NULL DEFAULT '' COMMENT '文章头图，文章编辑／添加时，自动取正文的第１张图',
  `status` enum('published','unpublished','trash') NOT NULL DEFAULT 'unpublished' COMMENT '状态',
  `hits` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击量',
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否头条',
  `promoted` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '推荐',
  `sticky` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶',
  `postNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复数',
  `upsNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章发布人的ID',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `orgId` int(10) unsigned DEFAULT '1',
  `orgCode` varchar(255) DEFAULT '1.' COMMENT '组织机构内部编码',
  `school_id` int(11) DEFAULT '0' COMMENT '学校ID',
  PRIMARY KEY (`id`),
  KEY `updatedTime` (`updatedTime`),
  KEY `updatedTime_2` (`updatedTime`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '栏目名称',
  `code` varchar(64) NOT NULL COMMENT 'URL目录名称',
  `weight` int(11) NOT NULL DEFAULT '0',
  `publishArticle` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许发布文章',
  `seoTitle` varchar(1024) NOT NULL DEFAULT '' COMMENT '栏目标题',
  `seoKeyword` varchar(1024) NOT NULL DEFAULT '' COMMENT 'SEO 关键字',
  `seoDesc` varchar(1024) NOT NULL DEFAULT '' COMMENT '栏目描述（SEO）',
  `published` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否启用（1：启用 0：停用)',
  `parentId` int(10) unsigned NOT NULL DEFAULT '0',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_category
-- ----------------------------

-- ----------------------------
-- Table structure for article_like
-- ----------------------------
DROP TABLE IF EXISTS `article_like`;
CREATE TABLE `article_like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统id',
  `articleId` int(10) unsigned NOT NULL COMMENT '资讯id',
  `userId` int(10) unsigned NOT NULL COMMENT '用户id',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='资讯点赞表';

-- ----------------------------
-- Records of article_like
-- ----------------------------

-- ----------------------------
-- Table structure for batch_notification
-- ----------------------------
DROP TABLE IF EXISTS `batch_notification`;
CREATE TABLE `batch_notification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '群发通知id',
  `type` enum('text','image','video','audio') NOT NULL DEFAULT 'text' COMMENT '通知类型',
  `title` text NOT NULL COMMENT '通知标题',
  `fromId` int(10) unsigned NOT NULL COMMENT '发送人id',
  `content` text NOT NULL COMMENT '通知内容',
  `targetType` text NOT NULL COMMENT '通知发送对象group,global,course,classroom等',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通知发送对象ID',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送通知时间',
  `published` int(10) NOT NULL DEFAULT '0' COMMENT '是否已经发送',
  `sendedTime` int(10) NOT NULL DEFAULT '0' COMMENT '群发通知的发送时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='群发通知表';

-- ----------------------------
-- Records of batch_notification
-- ----------------------------

-- ----------------------------
-- Table structure for blacklist
-- ----------------------------
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userId` int(10) unsigned NOT NULL COMMENT '名单拥有者id',
  `blackId` int(10) unsigned NOT NULL COMMENT '黑名单用户id',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入黑名单时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='黑名单表';

-- ----------------------------
-- Records of blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for block
-- ----------------------------
DROP TABLE IF EXISTS `block`;
CREATE TABLE `block` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编辑区ID',
  `userId` int(11) NOT NULL COMMENT '编辑区创建人ID',
  `content` text COMMENT '编辑区内容',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '编辑区编码',
  `data` text COMMENT '编辑区内容',
  `createdTime` int(11) unsigned NOT NULL COMMENT '编辑区创建时间',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '编辑区最后更新时间',
  `orgId` int(11) NOT NULL DEFAULT '1' COMMENT '组织机构Id',
  `blockTemplateId` int(11) NOT NULL COMMENT '模版ID',
  PRIMARY KEY (`id`),
  KEY `block_code_orgId_index` (`code`,`orgId`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of block
-- ----------------------------
INSERT INTO `block` VALUES ('9', '1', '<div class=\"col-md-8 footer-main clearfix\">\r\n  <div class=\"link-item \">\r\n  <h3>关于我们</h3>\r\n  <ul>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">关于同言</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">管理团队</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">同言动态</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_self\">福利待遇</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_self\">招聘信息</a>\r\n      </li>\r\n      </ul>\r\n</div>\r\n\r\n  <div class=\"link-item \">\r\n  <h3>服务保障</h3>\r\n  <ul>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">资质认证</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">管理服务</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">试听课程</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_self\">无忧退款</a>\r\n      </li>\r\n      </ul>\r\n</div>\r\n\r\n  <div class=\"link-item \">\r\n  <h3>关注我们</h3>\r\n  <ul>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_self\">联系我们</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">关注微信</a>\r\n      </li>\r\n      </ul>\r\n</div>\r\n\r\n  <div class=\"link-item hidden-xs\">\r\n  <h3>服务支持</h3>\r\n  <ul>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">学习资讯</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">在线资讯</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_self\">意见反馈</a>\r\n      </li>\r\n          <li>\r\n        <a href=\"../add/school\" target=\"_blank\">机构入驻</a>\r\n      </li>\r\n      </ul>\r\n</div>\r\n\r\n  <div class=\"link-item hidden-xs\">\r\n  <h3>联系我们</h3>\r\n  <ul>\r\n          <li>\r\n        <a href=\"http://www.kmbdqn.com\" target=\"_blank\">联系我们</a>\r\n      </li>\r\n      </ul>\r\n</div>\r\n\r\n</div>\r\n\r\n<div class=\"col-md-4 footer-logo hidden-sm hidden-xs\">\r\n  <!--<a class=\"\" href=\"http://www.kmbdqn.com\" target=\"_blank\"><img src=\"/files/system/block_picture_1484805596.jpg?7.2.9\" alt=\"建议图片大小为233*64\"></a>-->\r\n  <div class=\"footer-sns\">\r\n        <a href=\"http://weibo.com/kmbdqn\" target=\"_blank\"><i class=\"es-icon es-icon-weibo\"></i></a>\r\n            <a class=\"qrcode-popover top\">\r\n      <i class=\"es-icon es-icon-weixin\"></i>\r\n      <div class=\"qrcode-content\">\r\n        <img src=\"/files/system/block_picture_1481255249.jpg?7.2.9\" alt=\"\">  \r\n      </div>\r\n    </a>\r\n            <a class=\"qrcode-popover top\">\r\n      <i class=\"es-icon es-icon-apple\"></i>\r\n      <div class=\"qrcode-content\">\r\n        <img src=\"/files/system/block_picture_1481255267.jpg?7.2.9\" alt=\"\"> \r\n      </div>\r\n    </a>\r\n            <a class=\"qrcode-popover top\">\r\n      <i class=\"es-icon es-icon-android\"></i>\r\n      <div class=\"qrcode-content\">\r\n        <img src=\"/files/system/block_picture_1481255279.jpg?7.2.9\" alt=\"\"> \r\n      </div>\r\n    </a>\r\n      </div>\r\n</div>', 'jianmo:bottom_info', '{\"firstColumnText\":[{\"value\":\"\\u5173\\u4e8e\\u6211\\u4eec\"}],\"firstColumnLinks\":[{\"value\":\"\\u5173\\u4e8e\\u540c\\u8a00\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"},{\"value\":\"\\u7ba1\\u7406\\u56e2\\u961f\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"},{\"value\":\"\\u540c\\u8a00\\u52a8\\u6001\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"},{\"value\":\"\\u798f\\u5229\\u5f85\\u9047\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_self\"},{\"value\":\"\\u62db\\u8058\\u4fe1\\u606f\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_self\"}],\"secondColumnText\":[{\"value\":\"\\u670d\\u52a1\\u4fdd\\u969c\"}],\"secondColumnLinks\":[{\"value\":\"\\u8d44\\u8d28\\u8ba4\\u8bc1\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"},{\"value\":\"\\u7ba1\\u7406\\u670d\\u52a1\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"},{\"value\":\"\\u8bd5\\u542c\\u8bfe\\u7a0b\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"},{\"value\":\"\\u65e0\\u5fe7\\u9000\\u6b3e\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_self\"}],\"thirdColumnText\":[{\"value\":\"\\u5173\\u6ce8\\u6211\\u4eec\"}],\"thirdColumnLinks\":[{\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_self\"},{\"value\":\"\\u5173\\u6ce8\\u5fae\\u4fe1\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"}],\"fourthColumnText\":[{\"value\":\"\\u670d\\u52a1\\u652f\\u6301\"}],\"fourthColumnLinks\":[{\"value\":\"\\u5b66\\u4e60\\u8d44\\u8baf\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"},{\"value\":\"\\u5728\\u7ebf\\u8d44\\u8baf\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"},{\"value\":\"\\u610f\\u89c1\\u53cd\\u9988\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_self\"},{\"value\":\"\\u673a\\u6784\\u5165\\u9a7b\",\"href\":\"..\\/add\\/school\",\"target\":\"_blank\"}],\"fifthColumnText\":[{\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\"}],\"fifthColumnLinks\":[{\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"target\":\"_blank\"}],\"bottomLogo\":[{\"src\":\"\\/files\\/system\\/block_picture_1484805596.jpg\",\"alt\":\"\\u5efa\\u8bae\\u56fe\\u7247\\u5927\\u5c0f\\u4e3a233*64\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"background\":\"\",\"target\":\"_blank\"}],\"weibo\":[{\"value\":\"\\u5fae\\u535a\\u9996\\u9875\",\"href\":\"http:\\/\\/weibo.com\\/kmbdqn\",\"target\":\"_blank\"}],\"weixin\":[{\"src\":\"\\/files\\/system\\/block_picture_1481255249.jpg\",\"target\":\"_self\"}],\"apple\":[{\"src\":\"\\/files\\/system\\/block_picture_1481255267.jpg\",\"target\":\"_self\"}],\"android\":[{\"src\":\"\\/files\\/system\\/block_picture_1481255279.jpg\",\"target\":\"_self\"}]}', '1433916977', '1492231214', '1', '6');
INSERT INTO `block` VALUES ('7', '1', ' <section class=\"es-poster swiper-container\">', 'jianmo:home_top_banner', '{\"posters\":[{\"alt\":\"\\u6d77\\u62a5(1)\",\"status\":\"1\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/files\\/system\\/2016\\/12-27\\/132340c8c343001926.jpg?7.2.9\",\"background\":\"#46c47b\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3F3F3F;\\\">\\r\\n                <div class=\\\"container\\\">\\r\\n                    <a href=\\\"\\/course\\/11\\\" target=\\\"_blank\\\" >\\r\\n                        <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_bg.jpg\\\">\\r\\n                        <div class=\\\"mask\\\">\\r\\n                            <div class=\\\"title\\\">\\r\\n                                <span>\\u4e00\\u7ad9\\u5f0f<\\/span><span>\\u89e3\\u51b3\\u65b9\\u6848<\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"subtitle\\\">\\r\\n                                <span>EduSoho\\u73ed\\u7ea7<\\/span><span>\\u4e13\\u6ce8\\u670d\\u52a1<\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"item-mac\\\">\\r\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_mac.png\\\">\\r\\n                            <\\/div>\\r\\n                        <\\/div>\\r\\n                    <\\/a>\\r\\n                <\\/div>\\r\\n            <\\/div>\"},{\"alt\":\"\\u6d77\\u62a5(2)\",\"status\":\"1\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/files\\/system\\/2016\\/12-27\\/1324066b0513043457.jpg?7.2.9\",\"background\":\"#109afb\",\"href\":\"http:\\/\\/www.kmbdqn.com\",\"html\":\"\"},{\"alt\":\"\\u6d77\\u62a5(3)\",\"status\":\"1\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/files\\/system\\/2016\\/12-27\\/13241606dd96728836.jpg?7.2.9\",\"background\":\"#109afb\",\"href\":\"http:\\/\\/www.kmbdqn.com\\/\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3c4250;\\\">\\r\\n                <div class=\\\"container\\\">\\r\\n                    <a href=\\\"http:\\/\\/www.qiqiuyu.com\\/course\\/426\\\" target=\\\"_blank\\\" >\\r\\n                        <img class=\\\"img-responsive\\\" src=\\\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/block_picture_1434019737.jpg\\\">\\r\\n                        <div class=\\\"mask\\\">\\r\\n                            <div class=\\\"title\\\">\\r\\n                                <span><\\/span><span><\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"subtitle\\\">\\r\\n                                <span><\\/span><span><\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"item-mac\\\">\\r\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\\">\\r\\n                            <\\/div>\\r\\n                        <\\/div>\\r\\n                    <\\/a>\\r\\n                <\\/div>\\r\\n            <\\/div>\"},{\"alt\":\"\\u6d77\\u62a5(4)\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/files\\/system\\/2016\\/12-25\\/20110595de37396398.jpg?7.2.9\",\"background\":\"#0984f7\",\"href\":\"\\/mobile\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3F3F3F;\\\">\\r\\n                <div class=\\\"container\\\">\\r\\n                    <a href=\\\"\\/course\\/4\\\" target=\\\"_blank\\\" >\\r\\n                        <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_bg.jpg\\\">\\r\\n                        <div class=\\\"mask\\\">\\r\\n                            <div class=\\\"title\\\">\\r\\n                                <span>\\u5f00\\u542f<\\/span><span>\\u7f51\\u6821\\u4e4b\\u8def<\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"subtitle\\\">\\r\\n                                <span>\\u70b9\\u4eae\\u4e07\\u76cf\\u706f<\\/span><span>\\u7167\\u4eae\\u6c42\\u77e5\\u8def<\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"item-mac\\\">\\r\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_mac.png\\\">\\r\\n                            <\\/div>\\r\\n                        <\\/div>\\r\\n                    <\\/a>\\r\\n                <\\/div>\\r\\n            <\\/div>\"},{\"alt\":\"\\u6d77\\u62a5(5)\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\"},{\"alt\":\"\\u6d77\\u62a5(6)\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\"},{\"alt\":\"\\u6d77\\u62a5(7)\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\"},{\"alt\":\"\\u6d77\\u62a5(8)\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\"}]}', '1433916977', '1482816262', '1', '4');

-- ----------------------------
-- Table structure for block_history
-- ----------------------------
DROP TABLE IF EXISTS `block_history`;
CREATE TABLE `block_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编辑区历史记录ID',
  `blockId` int(11) NOT NULL COMMENT '编辑区ID',
  `templateData` text COMMENT '模板历史数据',
  `data` text COMMENT 'block元信息',
  `content` text COMMENT '编辑区历史内容',
  `userId` int(11) NOT NULL COMMENT '编辑区编辑人ID',
  `createdTime` int(11) unsigned NOT NULL COMMENT '编辑区历史记录创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 COMMENT='历史表';

-- ----------------------------
-- Records of block_history
-- ----------------------------

-- ----------------------------
-- Table structure for block_template
-- ----------------------------
DROP TABLE IF EXISTS `block_template`;
CREATE TABLE `block_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模版ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `mode` enum('html','template') NOT NULL DEFAULT 'html' COMMENT '模式',
  `template` text COMMENT '模板',
  `templateName` varchar(255) DEFAULT NULL COMMENT '编辑区模板名字',
  `templateData` text COMMENT '模板数据',
  `content` text COMMENT '默认内容',
  `data` text COMMENT '编辑区内容',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '编辑区编码',
  `meta` text COMMENT '编辑区元信息',
  `tips` varchar(255) DEFAULT NULL,
  `category` varchar(60) NOT NULL DEFAULT 'system' COMMENT '分类(系统/主题)',
  `createdTime` int(11) unsigned NOT NULL COMMENT '创建时间',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='编辑区模板';

-- ----------------------------
-- Records of block_template
-- ----------------------------
INSERT INTO `block_template` VALUES ('6', '首页底部.链接区域', 'template', null, '@theme/jianmo/block/bottom_info.template.html.twig', null, '\n<div class=\"col-md-8 footer-main clearfix\">\n  <div class=\"link-item \">\n  <h3>我是学生</h3>\n  <ul>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/347/learn#lesson/673\" target=\"_blank\">如何注册</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/347/learn#lesson/705\" target=\"_blank\">如何学习</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/347/learn#lesson/811\" target=\"_blank\">如何互动</a>\n      </li>\n      </ul>\n</div>\n\n  <div class=\"link-item \">\n  <h3>我是老师</h3>\n  <ul>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/22\" target=\"_blank\">发布课程</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/147\" target=\"_blank\">使用题库</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/232\" target=\"_blank\">教学资料库</a>\n      </li>\n      </ul>\n</div>\n\n  <div class=\"link-item \">\n  <h3>我是管理员</h3>\n  <ul>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/page/help#13\" target=\"_self\">修改底部链接</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/429\" target=\"_blank\">系统设置</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/429\" target=\"_blank\">课程设置</a>\n      </li>\n      </ul>\n</div>\n\n  <div class=\"link-item hidden-xs\">\n  <h3>商业应用</h3>\n  <ul>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/232\" target=\"_blank\">会员专区</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/232\" target=\"_blank\">题库增强版</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/course/232\" target=\"_blank\">用户导入导出</a>\n      </li>\n      </ul>\n</div>\n\n  <div class=\"link-item hidden-xs\">\n  <h3>关于我们</h3>\n  <ul>\n          <li>\n        <a href=\"http://www.edusoho.com/\" target=\"_blank\">ES官网</a>\n      </li>\n          <li>\n        <a href=\"http://www.qiqiuyu.com/\" target=\"_blank\">教程网站</a>\n      </li>\n          <li>\n        <a href=\"http://demo.edusoho.com/\" target=\"_blank\">产品演示站</a>\n      </li>\n      </ul>\n</div>\n\n</div>\n\n<div class=\"col-md-4 footer-logo hidden-sm hidden-xs\">\n  <a class=\"\" href=\"http://www.edusoho.com\" target=\"_blank\"><img src=\"/assets/v2/img/bottom_logo.png?6.5.5\" alt=\"建议图片大小为233*64\"></a>\n  <div class=\"footer-sns\">\n        <a href=\"http://weibo.com/edusoho\" target=\"_blank\"><i class=\"es-icon es-icon-weibo\"></i></a>\n            <a class=\"qrcode-popover top\">\n      <i class=\"es-icon es-icon-weixin\"></i>\n      <div class=\"qrcode-content\">\n        <img src=\"http://edusoho-demo.b0.upaiyun.com/files/system/block_picture_1441519788.jpg?6.5.5\" alt=\"\">  \n      </div>\n    </a>\n            <a class=\"qrcode-popover top\">\n      <i class=\"es-icon es-icon-apple\"></i>\n      <div class=\"qrcode-content\">\n        <img src=\"http://edusoho-demo.b0.upaiyun.com/files/system/block_picture_1441521835.png?6.5.5\" alt=\"\"> \n      </div>\n    </a>\n            <a class=\"qrcode-popover top\">\n      <i class=\"es-icon es-icon-android\"></i>\n      <div class=\"qrcode-content\">\n        <img src=\"http://edusoho-demo.b0.upaiyun.com/files/system/block_picture_1441521844.png?6.5.5\" alt=\"\"> \n      </div>\n    </a>\n      </div>\n</div>\n\n\n', '{\"firstColumnText\":[{\"value\":\"\\u6211\\u662f\\u5b66\\u751f\"}],\"firstColumnLinks\":[{\"value\":\"\\u5982\\u4f55\\u6ce8\\u518c\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/347\\/learn#lesson\\/673\",\"target\":\"_blank\"},{\"value\":\"\\u5982\\u4f55\\u5b66\\u4e60\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/347\\/learn#lesson\\/705\",\"target\":\"_blank\"},{\"value\":\"\\u5982\\u4f55\\u4e92\\u52a8\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/347\\/learn#lesson\\/811\",\"target\":\"_blank\"}],\"secondColumnText\":[{\"value\":\"\\u6211\\u662f\\u8001\\u5e08\"}],\"secondColumnLinks\":[{\"value\":\"\\u53d1\\u5e03\\u8bfe\\u7a0b\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/22\",\"target\":\"_blank\"},{\"value\":\"\\u4f7f\\u7528\\u9898\\u5e93\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/147\",\"target\":\"_blank\"},{\"value\":\"\\u6559\\u5b66\\u8d44\\u6599\\u5e93\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/232\",\"target\":\"_blank\"}],\"thirdColumnText\":[{\"value\":\"\\u6211\\u662f\\u7ba1\\u7406\\u5458\"}],\"thirdColumnLinks\":[{\"value\":\"\\u4fee\\u6539\\u5e95\\u90e8\\u94fe\\u63a5\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/page\\/help#13\",\"target\":\"_self\"},{\"value\":\"\\u7cfb\\u7edf\\u8bbe\\u7f6e\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/429\",\"target\":\"_blank\"},{\"value\":\"\\u8bfe\\u7a0b\\u8bbe\\u7f6e\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/429\",\"target\":\"_blank\"}],\"fourthColumnText\":[{\"value\":\"\\u5546\\u4e1a\\u5e94\\u7528\"}],\"fourthColumnLinks\":[{\"value\":\"\\u4f1a\\u5458\\u4e13\\u533a\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/232\",\"target\":\"_blank\"},{\"value\":\"\\u9898\\u5e93\\u589e\\u5f3a\\u7248\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/232\",\"target\":\"_blank\"},{\"value\":\"\\u7528\\u6237\\u5bfc\\u5165\\u5bfc\\u51fa\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/232\",\"target\":\"_blank\"}],\"fifthColumnText\":[{\"value\":\"\\u5173\\u4e8e\\u6211\\u4eec\"}],\"fifthColumnLinks\":[{\"value\":\"ES\\u5b98\\u7f51\",\"href\":\"http:\\/\\/www.edusoho.com\\/\",\"target\":\"_blank\"},{\"value\":\"\\u6559\\u7a0b\\u7f51\\u7ad9\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/\",\"target\":\"_blank\"},{\"value\":\"\\u4ea7\\u54c1\\u6f14\\u793a\\u7ad9\",\"href\":\"http:\\/\\/demo.edusoho.com\\/\",\"target\":\"_blank\"}],\"bottomLogo\":[{\"src\":\"\\/assets\\/v2\\/img\\/bottom_logo.png\",\"alt\":\"\\u5efa\\u8bae\\u56fe\\u7247\\u5927\\u5c0f\\u4e3a233*64\",\"href\":\"http:\\/\\/www.edusoho.com\",\"target\":\"_blank\"}],\"weibo\":[{\"value\":\"\\u5fae\\u535a\\u9996\\u9875\",\"href\":\"http:\\/\\/weibo.com\\/edusoho\",\"target\":\"_blank\"}],\"weixin\":[{\"src\":\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/block_picture_1441519788.jpg\",\"alt\":\"\\u5fae\\u4fe1\\u516c\\u4f17\\u53f7\"}],\"apple\":[{\"src\":\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/block_picture_1441521835.png\",\"alt\":\"\\u7f51\\u6821\\u7684iOS\\u7248APP\"}],\"android\":[{\"src\":\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/block_picture_1441521835.png\",\"alt\":\"\\u7f51\\u6821\\u7684Android\\u7248APP\"}]}', 'jianmo:bottom_info', '{\"title\":\"\\u9ed8\\u8ba4\\u4e3b\\u9898: \\u9996\\u9875\\u5e95\\u90e8.\\u94fe\\u63a5\\u533a\\u57df\",\"category\":\"jianmo\",\"templateName\":\"@theme\\/jianmo\\/block\\/bottom_info.template.html.twig\",\"items\":{\"firstColumnText\":{\"title\":\"\\u7b2c\\uff11\\u5217\\u94fe\\u63a5\\u6807\\u9898\",\"desc\":\"\",\"count\":1,\"type\":\"text\",\"default\":[{\"value\":\"\\u6211\\u662f\\u5b66\\u751f\"}]},\"firstColumnLinks\":{\"title\":\"\\u7b2c\\uff11\\u5217\\u94fe\\u63a5\",\"desc\":\"\",\"count\":5,\"type\":\"link\",\"default\":[{\"value\":\"\\u5982\\u4f55\\u6ce8\\u518c\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/347\\/learn#lesson\\/673\",\"target\":\"_blank\"},{\"value\":\"\\u5982\\u4f55\\u5b66\\u4e60\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/347\\/learn#lesson\\/705\",\"target\":\"_blank\"},{\"value\":\"\\u5982\\u4f55\\u4e92\\u52a8\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/347\\/learn#lesson\\/811\",\"target\":\"_blank\"}]},\"secondColumnText\":{\"title\":\"\\u7b2c\\uff12\\u5217\\u94fe\\u63a5\\u6807\\u9898\",\"desc\":\"\",\"count\":1,\"type\":\"text\",\"default\":[{\"value\":\"\\u6211\\u662f\\u8001\\u5e08\"}]},\"secondColumnLinks\":{\"title\":\"\\u7b2c\\uff12\\u5217\\u94fe\\u63a5\",\"desc\":\"\",\"count\":5,\"type\":\"link\",\"default\":[{\"value\":\"\\u53d1\\u5e03\\u8bfe\\u7a0b\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/22\",\"target\":\"_blank\"},{\"value\":\"\\u4f7f\\u7528\\u9898\\u5e93\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/147\",\"target\":\"_blank\"},{\"value\":\"\\u6559\\u5b66\\u8d44\\u6599\\u5e93\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/372\",\"target\":\"_blank\"}]},\"thirdColumnText\":{\"title\":\"\\u7b2c\\uff13\\u5217\\u94fe\\u63a5\\u6807\\u9898\",\"desc\":\"\",\"count\":1,\"type\":\"text\",\"default\":[{\"value\":\"\\u6211\\u662f\\u7ba1\\u7406\\u5458\"}]},\"thirdColumnLinks\":{\"title\":\"\\u7b2c\\uff13\\u5217\\u94fe\\u63a5\",\"desc\":\"\",\"count\":5,\"type\":\"link\",\"default\":[{\"value\":\"\\u7cfb\\u7edf\\u8bbe\\u7f6e\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/340\",\"target\":\"_blank\"},{\"value\":\"\\u8bfe\\u7a0b\\u8bbe\\u7f6e\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/341\",\"target\":\"_blank\"},{\"value\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/343\",\"target\":\"_blank\"}]},\"fourthColumnText\":{\"title\":\"\\u7b2c\\uff14\\u5217\\u94fe\\u63a5\\u6807\\u9898\",\"desc\":\"\",\"count\":1,\"type\":\"text\",\"default\":[{\"value\":\"\\u5546\\u4e1a\\u5e94\\u7528\"}]},\"fourthColumnLinks\":{\"title\":\"\\u7b2c\\uff14\\u5217\\u94fe\\u63a5\\u6807\\u9898\",\"desc\":\"\",\"count\":5,\"type\":\"link\",\"default\":[{\"value\":\"\\u4f1a\\u5458\\u4e13\\u533a\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/232\\/learn#lesson\\/358\",\"target\":\"_blank\"},{\"value\":\"\\u9898\\u5e93\\u589e\\u5f3a\\u7248\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/232\\/learn#lesson\\/467\",\"target\":\"_blank\"},{\"value\":\"\\u7528\\u6237\\u5bfc\\u5165\\u5bfc\\u51fa\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/380\",\"target\":\"_blank\"}]},\"fifthColumnText\":{\"title\":\"\\u7b2c\\uff15\\u5217\\u94fe\\u63a5\\u6807\\u9898\",\"desc\":\"\",\"count\":1,\"type\":\"text\",\"default\":[{\"value\":\"\\u5173\\u4e8e\\u6211\\u4eec\"}]},\"fifthColumnLinks\":{\"title\":\"\\u7b2c\\uff15\\u5217\\u94fe\\u63a5\\u6807\\u9898\",\"desc\":\"\",\"count\":5,\"type\":\"link\",\"default\":[{\"value\":\"ES\\u5b98\\u7f51\",\"href\":\"http:\\/\\/www.edusoho.com\\/\",\"target\":\"_blank\"},{\"value\":\"\\u5b98\\u65b9\\u5fae\\u535a\",\"href\":\"http:\\/\\/weibo.com\\/qiqiuyu\\/profile?rightmod=1&wvr=6&mod=personinfo\",\"target\":\"_blank\"},{\"value\":\"\\u52a0\\u5165\\u6211\\u4eec\",\"href\":\"http:\\/\\/www.edusoho.com\\/abouts\\/joinus\",\"target\":\"_blank\"}]},\"bottomLogo\":{\"title\":\"\\u5e95\\u90e8Logo\",\"desc\":\"\\u5efa\\u8bae\\u56fe\\u7247\\u5927\\u5c0f\\u4e3a233*64\",\"count\":1,\"type\":\"imglink\",\"default\":[{\"src\":\"\\/assets\\/v2\\/img\\/bottom_logo.png\",\"alt\":\"\\u5efa\\u8bae\\u56fe\\u7247\\u5927\\u5c0f\\u4e3a233*64\",\"href\":\"http:\\/\\/www.edusoho.com\",\"target\":\"_blank\"}]},\"weibo\":{\"title\":\"\\u5e95\\u90e8\\u5fae\\u535a\\u94fe\\u63a5\",\"desc\":\"\\u586b\\u5165\\u7f51\\u6821\\u7684\\u5fae\\u535a\\u9996\\u9875\\u5730\\u5740\",\"count\":1,\"type\":\"link\",\"default\":[{\"value\":\"\\u5fae\\u535a\\u9996\\u9875\",\"href\":\"http:\\/\\/weibo.com\\/edusoho\",\"target\":\"_blank\"}]},\"weixin\":{\"title\":\"\\u5e95\\u90e8\\u5fae\\u4fe1\\u516c\\u4f17\\u53f7\",\"desc\":\"\\u4e0a\\u4f20\\u7f51\\u6821\\u7684\\u5fae\\u4fe1\\u516c\\u4f17\\u53f7\\u7684\\u4e8c\\u7ef4\\u7801\",\"count\":1,\"type\":\"img\",\"default\":[{\"src\":\"\\/assets\\/img\\/default\\/weixin.png\",\"alt\":\"\\u5fae\\u4fe1\\u516c\\u4f17\\u53f7\"}]},\"apple\":{\"title\":\"\\u5e95\\u90e8iOS\\u7248APP\\u4e0b\\u8f7d\\u4e8c\\u7ef4\\u7801\",\"desc\":\"\\u4e0a\\u4f20\\u7f51\\u6821\\u7684iOS\\u7248APP\\u4e0b\\u8f7d\\u4e8c\\u7ef4\\u7801\",\"count\":1,\"type\":\"img\",\"default\":[{\"src\":\"\\/assets\\/img\\/default\\/apple.png\",\"alt\":\"\\u7f51\\u6821\\u7684iOS\\u7248APP\"}]},\"android\":{\"title\":\"\\u5e95\\u90e8Android\\u7248APP\\u4e0b\\u8f7d\\u4e8c\\u7ef4\\u7801\",\"desc\":\"\\u4e0a\\u4f20\\u7f51\\u6821\\u7684Android\\u7248APP\\u4e0b\\u8f7d\\u4e8c\\u7ef4\\u7801\",\"count\":1,\"type\":\"img\",\"default\":[{\"src\":\"\\/assets\\/img\\/default\\/android.png\",\"alt\":\"\\u7f51\\u6821\\u7684Android\\u7248APP\"}]}}}', '', 'jianmo', '1433916977', '1444891218');
INSERT INTO `block_template` VALUES ('4', '首页顶部.轮播图', 'template', null, '@theme/jianmo/block/carousel.template.html.twig', null, '<section class=\"es-poster swiper-container\">\n  <div class=\"swiper-wrapper\">\n                            <div class=\"swiper-slide swiper-hidden\" style=\"background: #46c47b;\">\n            <div class=\"container\">\n              <a href=\"http://www.qiqiuyu.com\" target=\"_blank\" ><img class=\"img-responsive\" src=\"http://edusoho-demo.b0.upaiyun.com/files/system/2015/09-25/09480994b6b9674166.jpg?6.6.3\">\n              </a>\n            </div>\n          </div>\n                                          <div class=\"swiper-slide swiper-hidden\" style=\"background: #0984f7;\">\n            <div class=\"container\">\n              <a href=\"/mobile\" target=\"_blank\" ><img class=\"img-responsive\" src=\"http://edusoho-demo.b0.upaiyun.com/files/system/2015/09-06/164332443847097647.jpg?6.5.5\">\n              </a>\n            </div>\n          </div>\n                                          <div class=\"swiper-slide swiper-hidden\" style=\"background: #109afb;\">\n            <div class=\"container\">\n              <a href=\"http://open.edusoho.com/educloud\" target=\"_blank\" ><img class=\"img-responsive\" src=\"http://edusoho-demo.b0.upaiyun.com/files/system/2015/09-25/094844caca67527539.png?6.6.3\">\n              </a>\n            </div>\n          </div>\n                                                                      </div>\n  <div class=\"swiper-pager\"></div>\n</section>', '{\"posters\":[{\"alt\":\"\\u6d77\\u62a51\",\"status\":\"1\",\"layout\":\"limitWide\",\"mode\":\"img\",\"src\":\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/2015\\/09-25\\/09480994b6b9674166.jpg?6.6.3\",\"background\":\"#46c47b\",\"href\":\"http:\\/\\/www.qiqiuyu.com\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3F3F3F;\\\">\\r\\n                <div class=\\\"container\\\">\\r\\n                    <a href=\\\"\\/course\\/11\\\" target=\\\"_blank\\\" >\\r\\n                        <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_bg.jpg\\\">\\r\\n                        <div class=\\\"mask\\\">\\r\\n                            <div class=\\\"title\\\">\\r\\n                                <span>\\u4e00\\u7ad9\\u5f0f<\\/span><span>\\u89e3\\u51b3\\u65b9\\u6848<\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"subtitle\\\">\\r\\n                                <span>EduSoho\\u73ed\\u7ea7<\\/span><span>\\u4e13\\u6ce8\\u670d\\u52a1<\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"item-mac\\\">\\r\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_mac.png\\\">\\r\\n                            <\\/div>\\r\\n                        <\\/div>\\r\\n                    <\\/a>\\r\\n                <\\/div>\\r\\n            <\\/div>\"},{\"alt\":\"\\u6d77\\u62a52\",\"status\":\"1\",\"layout\":\"limitWide\",\"mode\":\"img\",\"src\":\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/2015\\/09-06\\/164332443847097647.jpg\",\"background\":\"#0984f7\",\"href\":\"\\/mobile\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3F3F3F;\\\">\\r\\n                <div class=\\\"container\\\">\\r\\n                    <a href=\\\"\\/course\\/4\\\" target=\\\"_blank\\\" >\\r\\n                        <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_bg.jpg\\\">\\r\\n                        <div class=\\\"mask\\\">\\r\\n                            <div class=\\\"title\\\">\\r\\n                                <span>\\u5f00\\u542f<\\/span><span>\\u7f51\\u6821\\u4e4b\\u8def<\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"subtitle\\\">\\r\\n                                <span>\\u70b9\\u4eae\\u4e07\\u76cf\\u706f<\\/span><span>\\u7167\\u4eae\\u6c42\\u77e5\\u8def<\\/span>\\r\\n                            <\\/div>\\r\\n                            <div class=\\\"item-mac\\\">\\r\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_mac.png\\\">\\r\\n                            <\\/div>\\r\\n                        <\\/div>\\r\\n                    <\\/a>\\r\\n                <\\/div>\\r\\n            <\\/div>\"},{\"alt\":\"\\u6d77\\u62a53\",\"status\":\"1\",\"layout\":\"limitWide\",\"mode\":\"img\",\"src\":\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/2015\\/09-25\\/094844caca67527539.png\",\"background\":\"#109afb\",\"href\":\"http:\\/\\/open.edusoho.com\\/educloud\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3c4250;\\\">\\n                <div class=\\\"container\\\">\\n                    <a href=\\\"http:\\/\\/www.kmbdqn.com\\/course\\/426\\\" target=\\\"_blank\\\" >\\n                        <img class=\\\"img-responsive\\\" src=\\\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/block_picture_1434019737.jpg\\\">\\n                        <div class=\\\"mask\\\">\\n                            <div class=\\\"title\\\">\\n                                <span><\\/span><span><\\/span>\\n                            <\\/div>\\n                            <div class=\\\"subtitle\\\">\\n                                <span><\\/span><span><\\/span>\\n                            <\\/div>\\n                            <div class=\\\"item-mac\\\">\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\\">\\n                            <\\/div>\\n                        <\\/div>\\n                    <\\/a>\\n                <\\/div>\\n            <\\/div>\"},{\"alt\":\"\\u6d77\\u62a54\",\"status\":\"0\",\"layout\":\"limitWide\",\"mode\":\"img\",\"src\":\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/2015\\/09-06\\/1643528b5717520327.png\",\"background\":\"#109afb\",\"href\":\"http:\\/\\/www.kmbdqn.com\\/educloud\",\"html\":\"\"},{\"alt\":\"\\u6d77\\u62a55\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\"},{\"alt\":\"\\u6d77\\u62a56\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\"},{\"alt\":\"\\u6d77\\u62a57\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\"},{\"alt\":\"\\u6d77\\u62a58\",\"status\":\"0\",\"layout\":\"tile\",\"mode\":\"img\",\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\"}]}', 'jianmo:home_top_banner', '{\"title\":\"\\u9ed8\\u8ba4\\u4e3b\\u9898\\uff1a\\u9996\\u9875\\u9876\\u90e8.\\u8f6e\\u64ad\\u56fe \",\"category\":\"jianmo\",\"templateName\":\"@theme\\/jianmo\\/block\\/carousel.template.html.twig\",\"items\":{\"posters\":{\"title\":\"\\u6d77\\u62a5\",\"desc\":\"\\u9996\\u9875\\u6d77\\u62a5\",\"count\":1,\"type\":\"poster\",\"default\":[{\"src\":\"\\/themes\\/jianmo\\/img\\/poster_bg.jpg\",\"alt\":\"\\u6d77\\u62a51\",\"layout\":\"limitWide\",\"background\":\"#3F3F3F\",\"href\":\"\\/course\\/4\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3F3F3F;\\\">\\n                <div class=\\\"container\\\">\\n                    <a href=\\\"\\/course\\/4\\\" target=\\\"_blank\\\" >\\n                        <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_bg.jpg\\\">\\n                        <div class=\\\"mask\\\">\\n                            <div class=\\\"title\\\">\\n                                <span>\\u5f00\\u542f<\\/span><span>\\u7f51\\u6821\\u4e4b\\u8def<\\/span>\\n                            <\\/div>\\n                            <div class=\\\"subtitle\\\">\\n                                <span>\\u70b9\\u4eae\\u4e07\\u76cf\\u706f<\\/span><span>\\u7167\\u4eae\\u6c42\\u77e5\\u8def<\\/span>\\n                            <\\/div>\\n                            <div class=\\\"item-mac\\\">\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_mac.png\\\">\\n                            <\\/div>\\n                        <\\/div>\\n                    <\\/a>\\n                <\\/div>\\n            <\\/div>\",\"status\":1,\"mode\":\"html\"},{\"src\":\"\\/themes\\/jianmo\\/img\\/poster_bg.jpg\",\"alt\":\"\\u6d77\\u62a52\",\"layout\":\"limitWide\",\"background\":\"#3F3F3F\",\"href\":\"\\/course\\/11\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3F3F3F;\\\">\\n                <div class=\\\"container\\\">\\n                    <a href=\\\"\\/course\\/11\\\" target=\\\"_blank\\\" >\\n                        <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_bg.jpg\\\">\\n                        <div class=\\\"mask\\\">\\n                            <div class=\\\"title\\\">\\n                                <span>\\u4e00\\u7ad9\\u5f0f<\\/span><span>\\u89e3\\u51b3\\u65b9\\u6848<\\/span>\\n                            <\\/div>\\n                            <div class=\\\"subtitle\\\">\\n                                <span>EduSoho\\u73ed\\u7ea7<\\/span><span>\\u4e13\\u6ce8\\u670d\\u52a1<\\/span>\\n                            <\\/div>\\n                            <div class=\\\"item-mac\\\">\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\/themes\\/jianmo\\/img\\/poster_mac.png\\\">\\n                            <\\/div>\\n                        <\\/div>\\n                    <\\/a>\\n                <\\/div>\\n            <\\/div>\",\"status\":1,\"mode\":\"html\"},{\"src\":\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/block_picture_1434019737.jpg\",\"alt\":\"\\u6d77\\u62a53\",\"layout\":\"limitWide\",\"background\":\"#3c4250\",\"href\":\"http:\\/\\/www.qiqiuyu.com\\/course\\/426\",\"html\":\"<div class=\\\"swiper-slide swiper-hidden\\\" style=\\\"background: #3c4250;\\\">\\n                <div class=\\\"container\\\">\\n                    <a href=\\\"http:\\/\\/www.qiqiuyu.com\\/course\\/426\\\" target=\\\"_blank\\\" >\\n                        <img class=\\\"img-responsive\\\" src=\\\"http:\\/\\/edusoho-demo.b0.upaiyun.com\\/files\\/system\\/block_picture_1434019737.jpg\\\">\\n                        <div class=\\\"mask\\\">\\n                            <div class=\\\"title\\\">\\n                                <span><\\/span><span><\\/span>\\n                            <\\/div>\\n                            <div class=\\\"subtitle\\\">\\n                                <span><\\/span><span><\\/span>\\n                            <\\/div>\\n                            <div class=\\\"item-mac\\\">\\n                                <img class=\\\"img-responsive\\\" src=\\\"\\\">\\n                            <\\/div>\\n                        <\\/div>\\n                    <\\/a>\\n                <\\/div>\\n            <\\/div>\",\"status\":1,\"mode\":\"html\"},{\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"alt\":\"\\u6d77\\u62a54\",\"layout\":\"tile\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\",\"status\":0,\"mode\":\"img\"},{\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"alt\":\"\\u6d77\\u62a55\",\"layout\":\"tile\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\",\"status\":0,\"mode\":\"img\"},{\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"alt\":\"\\u6d77\\u62a56\",\"layout\":\"tile\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\",\"status\":0,\"mode\":\"img\"},{\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"alt\":\"\\u6d77\\u62a57\",\"layout\":\"tile\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\",\"status\":0,\"mode\":\"img\"},{\"src\":\"\\/themes\\/jianmo\\/img\\/banner_net.jpg\",\"alt\":\"\\u6d77\\u62a58\",\"layout\":\"tile\",\"background\":\"#3ec768\",\"href\":\"\",\"html\":\"\",\"status\":0,\"mode\":\"img\"}]}}}', '', 'jianmo', '1433916977', '1444891218');

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '缓存ID',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '缓存名称',
  `data` longblob COMMENT '缓存数据',
  `serialized` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '缓存是否为序列化的标记位',
  `expiredTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '缓存过期时间',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '缓存创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `expiredTime` (`expiredTime`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for card
-- ----------------------------
DROP TABLE IF EXISTS `card`;
CREATE TABLE `card` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cardId` varchar(255) NOT NULL DEFAULT '' COMMENT '卡的ID',
  `cardType` varchar(255) NOT NULL DEFAULT '' COMMENT '卡的类型',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '到期时间',
  `useTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用时间',
  `status` enum('used','receive','invalid','deleted') NOT NULL DEFAULT 'receive' COMMENT '使用状态',
  `userId` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '使用者',
  `createdTime` int(10) unsigned NOT NULL COMMENT '领取时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of card
-- ----------------------------

-- ----------------------------
-- Table structure for cash_account
-- ----------------------------
DROP TABLE IF EXISTS `cash_account`;
CREATE TABLE `cash_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL,
  `cash` float(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cash_account
-- ----------------------------

-- ----------------------------
-- Table structure for cash_change
-- ----------------------------
DROP TABLE IF EXISTS `cash_change`;
CREATE TABLE `cash_change` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL,
  `amount` double(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cash_change
-- ----------------------------

-- ----------------------------
-- Table structure for cash_flow
-- ----------------------------
DROP TABLE IF EXISTS `cash_flow`;
CREATE TABLE `cash_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL COMMENT '账号ID，即用户ID',
  `sn` bigint(20) unsigned NOT NULL COMMENT '账目流水号',
  `type` enum('inflow','outflow') NOT NULL COMMENT '流水类型',
  `amount` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `cashType` enum('RMB','Coin') NOT NULL DEFAULT 'Coin' COMMENT '账单类型',
  `cash` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '账单生成后的余额',
  `parentSn` bigint(20) DEFAULT NULL COMMENT '上一个账单的流水号',
  `name` varchar(1024) NOT NULL DEFAULT '' COMMENT '帐目名称',
  `orderSn` varchar(40) NOT NULL COMMENT '订单号',
  `category` varchar(128) NOT NULL DEFAULT '' COMMENT '帐目类目',
  `payment` varchar(32) DEFAULT '',
  `note` text COMMENT '备注',
  `createdTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tradeNo` (`sn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='帐目流水';

-- ----------------------------
-- Records of cash_flow
-- ----------------------------

-- ----------------------------
-- Table structure for cash_orders
-- ----------------------------
DROP TABLE IF EXISTS `cash_orders`;
CREATE TABLE `cash_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) NOT NULL COMMENT '订单号',
  `status` enum('created','paid','cancelled') NOT NULL,
  `title` varchar(255) NOT NULL,
  `amount` float(10,2) unsigned NOT NULL DEFAULT '0.00',
  `payment` varchar(32) NOT NULL DEFAULT 'none',
  `paidTime` int(10) unsigned NOT NULL DEFAULT '0',
  `note` varchar(255) NOT NULL DEFAULT '',
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  `targetType` varchar(64) NOT NULL DEFAULT 'coin' COMMENT '订单类型',
  `token` varchar(50) DEFAULT NULL COMMENT '令牌',
  `data` text COMMENT '订单业务数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cash_orders
-- ----------------------------

-- ----------------------------
-- Table structure for cash_orders_log
-- ----------------------------
DROP TABLE IF EXISTS `cash_orders_log`;
CREATE TABLE `cash_orders_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderId` int(10) unsigned NOT NULL,
  `message` text,
  `data` text,
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(255) NOT NULL,
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cash_orders_log
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `code` varchar(64) NOT NULL DEFAULT '' COMMENT '分类编码',
  `name` varchar(255) NOT NULL COMMENT '分类名称',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类完整路径',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '分类权重',
  `groupId` int(10) unsigned NOT NULL COMMENT '分类组ID',
  `parentId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父分类ID',
  `description` text,
  `orgId` int(10) unsigned DEFAULT '1',
  `orgCode` varchar(255) DEFAULT '1.' COMMENT '组织机构内部编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uri` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', 'fuction', '使用更改', '', '', '1', '1', '0', '', '1', '1.');
INSERT INTO `category` VALUES ('2', 'default', '分类更改', '', '', '10', '1', '0', '', '1', '1.');
INSERT INTO `category` VALUES ('3', 'intro', '介绍更改', '', '', '0', '1', '0', '', '1', '1.');
INSERT INTO `category` VALUES ('4', 'administrator', '管理员', '', '', '10', '1', '1', '本分类介绍管理员如何管理网校。', '1', '1.');
INSERT INTO `category` VALUES ('5', 'teacher', '教师', '', '', '20', '1', '1', '本分类介绍教师如何在网校教学。', '1', '1.');
INSERT INTO `category` VALUES ('6', 'student', '学员', '', '', '30', '1', '1', '本分类介绍学员如何在网校学习和交流。', '1', '1.');

-- ----------------------------
-- Table structure for category_group
-- ----------------------------
DROP TABLE IF EXISTS `category_group`;
CREATE TABLE `category_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类组ID',
  `code` varchar(64) NOT NULL COMMENT '分类组编码',
  `name` varchar(255) NOT NULL COMMENT '分类组名称',
  `depth` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '该组下分类允许的最大层级数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category_group
-- ----------------------------
INSERT INTO `category_group` VALUES ('1', 'course', '分类', '3');

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_index` int(11) NOT NULL,
  `province_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=392 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO `city` VALUES ('1', '1', '1', '北京市');
INSERT INTO `city` VALUES ('2', '1', '2', '天津市');
INSERT INTO `city` VALUES ('3', '1', '3', '上海市');
INSERT INTO `city` VALUES ('4', '1', '4', '重庆市');
INSERT INTO `city` VALUES ('5', '1', '5', '石家庄市');
INSERT INTO `city` VALUES ('6', '2', '5', '唐山市');
INSERT INTO `city` VALUES ('7', '3', '5', '秦皇岛市');
INSERT INTO `city` VALUES ('8', '4', '5', '邯郸市');
INSERT INTO `city` VALUES ('9', '5', '5', '邢台市');
INSERT INTO `city` VALUES ('10', '6', '5', '保定市');
INSERT INTO `city` VALUES ('11', '7', '5', '张家口市');
INSERT INTO `city` VALUES ('12', '8', '5', '承德市');
INSERT INTO `city` VALUES ('13', '9', '5', '沧州市');
INSERT INTO `city` VALUES ('14', '10', '5', '廊坊市');
INSERT INTO `city` VALUES ('15', '11', '5', '衡水市');
INSERT INTO `city` VALUES ('16', '1', '6', '太原市');
INSERT INTO `city` VALUES ('17', '2', '6', '大同市');
INSERT INTO `city` VALUES ('18', '3', '6', '阳泉市');
INSERT INTO `city` VALUES ('19', '4', '6', '长治市');
INSERT INTO `city` VALUES ('20', '5', '6', '晋城市');
INSERT INTO `city` VALUES ('21', '6', '6', '朔州市');
INSERT INTO `city` VALUES ('22', '7', '6', '晋中市');
INSERT INTO `city` VALUES ('23', '8', '6', '运城市');
INSERT INTO `city` VALUES ('24', '9', '6', '忻州市');
INSERT INTO `city` VALUES ('25', '10', '6', '临汾市');
INSERT INTO `city` VALUES ('26', '11', '6', '吕梁市');
INSERT INTO `city` VALUES ('27', '1', '7', '台北市');
INSERT INTO `city` VALUES ('28', '2', '7', '高雄市');
INSERT INTO `city` VALUES ('29', '3', '7', '基隆市');
INSERT INTO `city` VALUES ('30', '4', '7', '台中市');
INSERT INTO `city` VALUES ('31', '5', '7', '台南市');
INSERT INTO `city` VALUES ('32', '6', '7', '新竹市');
INSERT INTO `city` VALUES ('33', '7', '7', '嘉义市');
INSERT INTO `city` VALUES ('34', '8', '7', '台北县');
INSERT INTO `city` VALUES ('35', '9', '7', '宜兰县');
INSERT INTO `city` VALUES ('36', '10', '7', '桃园县');
INSERT INTO `city` VALUES ('37', '11', '7', '新竹县');
INSERT INTO `city` VALUES ('38', '12', '7', '苗栗县');
INSERT INTO `city` VALUES ('39', '13', '7', '台中县');
INSERT INTO `city` VALUES ('40', '14', '7', '彰化县');
INSERT INTO `city` VALUES ('41', '15', '7', '南投县');
INSERT INTO `city` VALUES ('42', '16', '7', '云林县');
INSERT INTO `city` VALUES ('43', '17', '7', '嘉义县');
INSERT INTO `city` VALUES ('44', '18', '7', '台南县');
INSERT INTO `city` VALUES ('45', '19', '7', '高雄县');
INSERT INTO `city` VALUES ('46', '20', '7', '屏东县');
INSERT INTO `city` VALUES ('47', '21', '7', '澎湖县');
INSERT INTO `city` VALUES ('48', '22', '7', '台东县');
INSERT INTO `city` VALUES ('49', '23', '7', '花莲县');
INSERT INTO `city` VALUES ('50', '1', '8', '沈阳市');
INSERT INTO `city` VALUES ('51', '2', '8', '大连市');
INSERT INTO `city` VALUES ('52', '3', '8', '鞍山市');
INSERT INTO `city` VALUES ('53', '4', '8', '抚顺市');
INSERT INTO `city` VALUES ('54', '5', '8', '本溪市');
INSERT INTO `city` VALUES ('55', '6', '8', '丹东市');
INSERT INTO `city` VALUES ('56', '7', '8', '锦州市');
INSERT INTO `city` VALUES ('57', '8', '8', '营口市');
INSERT INTO `city` VALUES ('58', '9', '8', '阜新市');
INSERT INTO `city` VALUES ('59', '10', '8', '辽阳市');
INSERT INTO `city` VALUES ('60', '11', '8', '盘锦市');
INSERT INTO `city` VALUES ('61', '12', '8', '铁岭市');
INSERT INTO `city` VALUES ('62', '13', '8', '朝阳市');
INSERT INTO `city` VALUES ('63', '14', '8', '葫芦岛市');
INSERT INTO `city` VALUES ('64', '1', '9', '长春市');
INSERT INTO `city` VALUES ('65', '2', '9', '吉林市');
INSERT INTO `city` VALUES ('66', '3', '9', '四平市');
INSERT INTO `city` VALUES ('67', '4', '9', '辽源市');
INSERT INTO `city` VALUES ('68', '5', '9', '通化市');
INSERT INTO `city` VALUES ('69', '6', '9', '白山市');
INSERT INTO `city` VALUES ('70', '7', '9', '松原市');
INSERT INTO `city` VALUES ('71', '8', '9', '白城市');
INSERT INTO `city` VALUES ('72', '9', '9', '延边朝鲜族自治州');
INSERT INTO `city` VALUES ('73', '1', '10', '哈尔滨市');
INSERT INTO `city` VALUES ('74', '2', '10', '齐齐哈尔市');
INSERT INTO `city` VALUES ('75', '3', '10', '鹤岗市');
INSERT INTO `city` VALUES ('76', '4', '10', '双鸭山市');
INSERT INTO `city` VALUES ('77', '5', '10', '鸡西市');
INSERT INTO `city` VALUES ('78', '6', '10', '大庆市');
INSERT INTO `city` VALUES ('79', '7', '10', '伊春市');
INSERT INTO `city` VALUES ('80', '8', '10', '牡丹江市');
INSERT INTO `city` VALUES ('81', '9', '10', '佳木斯市');
INSERT INTO `city` VALUES ('82', '10', '10', '七台河市');
INSERT INTO `city` VALUES ('83', '11', '10', '黑河市');
INSERT INTO `city` VALUES ('84', '12', '10', '绥化市');
INSERT INTO `city` VALUES ('85', '13', '10', '大兴安岭地区');
INSERT INTO `city` VALUES ('86', '1', '11', '南京市');
INSERT INTO `city` VALUES ('87', '2', '11', '无锡市');
INSERT INTO `city` VALUES ('88', '3', '11', '徐州市');
INSERT INTO `city` VALUES ('89', '4', '11', '常州市');
INSERT INTO `city` VALUES ('90', '5', '11', '苏州市');
INSERT INTO `city` VALUES ('91', '6', '11', '南通市');
INSERT INTO `city` VALUES ('92', '7', '11', '连云港市');
INSERT INTO `city` VALUES ('93', '8', '11', '淮安市');
INSERT INTO `city` VALUES ('94', '9', '11', '盐城市');
INSERT INTO `city` VALUES ('95', '10', '11', '扬州市');
INSERT INTO `city` VALUES ('96', '11', '11', '镇江市');
INSERT INTO `city` VALUES ('97', '12', '11', '泰州市');
INSERT INTO `city` VALUES ('98', '13', '11', '宿迁市');
INSERT INTO `city` VALUES ('99', '1', '12', '杭州市');
INSERT INTO `city` VALUES ('100', '2', '12', '宁波市');
INSERT INTO `city` VALUES ('101', '3', '12', '温州市');
INSERT INTO `city` VALUES ('102', '4', '12', '嘉兴市');
INSERT INTO `city` VALUES ('103', '5', '12', '湖州市');
INSERT INTO `city` VALUES ('104', '6', '12', '绍兴市');
INSERT INTO `city` VALUES ('105', '7', '12', '金华市');
INSERT INTO `city` VALUES ('106', '8', '12', '衢州市');
INSERT INTO `city` VALUES ('107', '9', '12', '舟山市');
INSERT INTO `city` VALUES ('108', '10', '12', '台州市');
INSERT INTO `city` VALUES ('109', '11', '12', '丽水市');
INSERT INTO `city` VALUES ('110', '1', '13', '合肥市');
INSERT INTO `city` VALUES ('111', '2', '13', '芜湖市');
INSERT INTO `city` VALUES ('112', '3', '13', '蚌埠市');
INSERT INTO `city` VALUES ('113', '4', '13', '淮南市');
INSERT INTO `city` VALUES ('114', '5', '13', '马鞍山市');
INSERT INTO `city` VALUES ('115', '6', '13', '淮北市');
INSERT INTO `city` VALUES ('116', '7', '13', '铜陵市');
INSERT INTO `city` VALUES ('117', '8', '13', '安庆市');
INSERT INTO `city` VALUES ('118', '9', '13', '黄山市');
INSERT INTO `city` VALUES ('119', '10', '13', '滁州市');
INSERT INTO `city` VALUES ('120', '11', '13', '阜阳市');
INSERT INTO `city` VALUES ('121', '12', '13', '宿州市');
INSERT INTO `city` VALUES ('122', '13', '13', '巢湖市');
INSERT INTO `city` VALUES ('123', '14', '13', '六安市');
INSERT INTO `city` VALUES ('124', '15', '13', '亳州市');
INSERT INTO `city` VALUES ('125', '16', '13', '池州市');
INSERT INTO `city` VALUES ('126', '17', '13', '宣城市');
INSERT INTO `city` VALUES ('127', '1', '14', '福州市');
INSERT INTO `city` VALUES ('128', '2', '14', '厦门市');
INSERT INTO `city` VALUES ('129', '3', '14', '莆田市');
INSERT INTO `city` VALUES ('130', '4', '14', '三明市');
INSERT INTO `city` VALUES ('131', '5', '14', '泉州市');
INSERT INTO `city` VALUES ('132', '6', '14', '漳州市');
INSERT INTO `city` VALUES ('133', '7', '14', '南平市');
INSERT INTO `city` VALUES ('134', '8', '14', '龙岩市');
INSERT INTO `city` VALUES ('135', '9', '14', '宁德市');
INSERT INTO `city` VALUES ('136', '1', '15', '南昌市');
INSERT INTO `city` VALUES ('137', '2', '15', '景德镇市');
INSERT INTO `city` VALUES ('138', '3', '15', '萍乡市');
INSERT INTO `city` VALUES ('139', '4', '15', '九江市');
INSERT INTO `city` VALUES ('140', '5', '15', '新余市');
INSERT INTO `city` VALUES ('141', '6', '15', '鹰潭市');
INSERT INTO `city` VALUES ('142', '7', '15', '赣州市');
INSERT INTO `city` VALUES ('143', '8', '15', '吉安市');
INSERT INTO `city` VALUES ('144', '9', '15', '宜春市');
INSERT INTO `city` VALUES ('145', '10', '15', '抚州市');
INSERT INTO `city` VALUES ('146', '11', '15', '上饶市');
INSERT INTO `city` VALUES ('147', '1', '16', '济南市');
INSERT INTO `city` VALUES ('148', '2', '16', '青岛市');
INSERT INTO `city` VALUES ('149', '3', '16', '淄博市');
INSERT INTO `city` VALUES ('150', '4', '16', '枣庄市');
INSERT INTO `city` VALUES ('151', '5', '16', '东营市');
INSERT INTO `city` VALUES ('152', '6', '16', '烟台市');
INSERT INTO `city` VALUES ('153', '7', '16', '潍坊市');
INSERT INTO `city` VALUES ('154', '8', '16', '济宁市');
INSERT INTO `city` VALUES ('155', '9', '16', '泰安市');
INSERT INTO `city` VALUES ('156', '10', '16', '威海市');
INSERT INTO `city` VALUES ('157', '11', '16', '日照市');
INSERT INTO `city` VALUES ('158', '12', '16', '莱芜市');
INSERT INTO `city` VALUES ('159', '13', '16', '临沂市');
INSERT INTO `city` VALUES ('160', '14', '16', '德州市');
INSERT INTO `city` VALUES ('161', '15', '16', '聊城市');
INSERT INTO `city` VALUES ('162', '16', '16', '滨州市');
INSERT INTO `city` VALUES ('163', '17', '16', '菏泽市');
INSERT INTO `city` VALUES ('164', '1', '17', '郑州市');
INSERT INTO `city` VALUES ('165', '2', '17', '开封市');
INSERT INTO `city` VALUES ('166', '3', '17', '洛阳市');
INSERT INTO `city` VALUES ('167', '4', '17', '平顶山市');
INSERT INTO `city` VALUES ('168', '5', '17', '安阳市');
INSERT INTO `city` VALUES ('169', '6', '17', '鹤壁市');
INSERT INTO `city` VALUES ('170', '7', '17', '新乡市');
INSERT INTO `city` VALUES ('171', '8', '17', '焦作市');
INSERT INTO `city` VALUES ('172', '9', '17', '濮阳市');
INSERT INTO `city` VALUES ('173', '10', '17', '许昌市');
INSERT INTO `city` VALUES ('174', '11', '17', '漯河市');
INSERT INTO `city` VALUES ('175', '12', '17', '三门峡市');
INSERT INTO `city` VALUES ('176', '13', '17', '南阳市');
INSERT INTO `city` VALUES ('177', '14', '17', '商丘市');
INSERT INTO `city` VALUES ('178', '15', '17', '信阳市');
INSERT INTO `city` VALUES ('179', '16', '17', '周口市');
INSERT INTO `city` VALUES ('180', '17', '17', '驻马店市');
INSERT INTO `city` VALUES ('181', '18', '17', '济源市');
INSERT INTO `city` VALUES ('182', '1', '18', '武汉市');
INSERT INTO `city` VALUES ('183', '2', '18', '黄石市');
INSERT INTO `city` VALUES ('184', '3', '18', '十堰市');
INSERT INTO `city` VALUES ('185', '4', '18', '荆州市');
INSERT INTO `city` VALUES ('186', '5', '18', '宜昌市');
INSERT INTO `city` VALUES ('187', '6', '18', '襄樊市');
INSERT INTO `city` VALUES ('188', '7', '18', '鄂州市');
INSERT INTO `city` VALUES ('189', '8', '18', '荆门市');
INSERT INTO `city` VALUES ('190', '9', '18', '孝感市');
INSERT INTO `city` VALUES ('191', '10', '18', '黄冈市');
INSERT INTO `city` VALUES ('192', '11', '18', '咸宁市');
INSERT INTO `city` VALUES ('193', '12', '18', '随州市');
INSERT INTO `city` VALUES ('194', '13', '18', '仙桃市');
INSERT INTO `city` VALUES ('195', '14', '18', '天门市');
INSERT INTO `city` VALUES ('196', '15', '18', '潜江市');
INSERT INTO `city` VALUES ('197', '16', '18', '神农架林区');
INSERT INTO `city` VALUES ('198', '17', '18', '恩施土家族苗族自治州');
INSERT INTO `city` VALUES ('199', '1', '19', '长沙市');
INSERT INTO `city` VALUES ('200', '2', '19', '株洲市');
INSERT INTO `city` VALUES ('201', '3', '19', '湘潭市');
INSERT INTO `city` VALUES ('202', '4', '19', '衡阳市');
INSERT INTO `city` VALUES ('203', '5', '19', '邵阳市');
INSERT INTO `city` VALUES ('204', '6', '19', '岳阳市');
INSERT INTO `city` VALUES ('205', '7', '19', '常德市');
INSERT INTO `city` VALUES ('206', '8', '19', '张家界市');
INSERT INTO `city` VALUES ('207', '9', '19', '益阳市');
INSERT INTO `city` VALUES ('208', '10', '19', '郴州市');
INSERT INTO `city` VALUES ('209', '11', '19', '永州市');
INSERT INTO `city` VALUES ('210', '12', '19', '怀化市');
INSERT INTO `city` VALUES ('211', '13', '19', '娄底市');
INSERT INTO `city` VALUES ('212', '14', '19', '湘西土家族苗族自治州');
INSERT INTO `city` VALUES ('213', '1', '20', '广州市');
INSERT INTO `city` VALUES ('214', '2', '20', '深圳市');
INSERT INTO `city` VALUES ('215', '3', '20', '珠海市');
INSERT INTO `city` VALUES ('216', '4', '20', '汕头市');
INSERT INTO `city` VALUES ('217', '5', '20', '韶关市');
INSERT INTO `city` VALUES ('218', '6', '20', '佛山市');
INSERT INTO `city` VALUES ('219', '7', '20', '江门市');
INSERT INTO `city` VALUES ('220', '8', '20', '湛江市');
INSERT INTO `city` VALUES ('221', '9', '20', '茂名市');
INSERT INTO `city` VALUES ('222', '10', '20', '肇庆市');
INSERT INTO `city` VALUES ('223', '11', '20', '惠州市');
INSERT INTO `city` VALUES ('224', '12', '20', '梅州市');
INSERT INTO `city` VALUES ('225', '13', '20', '汕尾市');
INSERT INTO `city` VALUES ('226', '14', '20', '河源市');
INSERT INTO `city` VALUES ('227', '15', '20', '阳江市');
INSERT INTO `city` VALUES ('228', '16', '20', '清远市');
INSERT INTO `city` VALUES ('229', '17', '20', '东莞市');
INSERT INTO `city` VALUES ('230', '18', '20', '中山市');
INSERT INTO `city` VALUES ('231', '19', '20', '潮州市');
INSERT INTO `city` VALUES ('232', '20', '20', '揭阳市');
INSERT INTO `city` VALUES ('233', '21', '20', '云浮市');
INSERT INTO `city` VALUES ('234', '1', '21', '兰州市');
INSERT INTO `city` VALUES ('235', '2', '21', '金昌市');
INSERT INTO `city` VALUES ('236', '3', '21', '白银市');
INSERT INTO `city` VALUES ('237', '4', '21', '天水市');
INSERT INTO `city` VALUES ('238', '5', '21', '嘉峪关市');
INSERT INTO `city` VALUES ('239', '6', '21', '武威市');
INSERT INTO `city` VALUES ('240', '7', '21', '张掖市');
INSERT INTO `city` VALUES ('241', '8', '21', '平凉市');
INSERT INTO `city` VALUES ('242', '9', '21', '酒泉市');
INSERT INTO `city` VALUES ('243', '10', '21', '庆阳市');
INSERT INTO `city` VALUES ('244', '11', '21', '定西市');
INSERT INTO `city` VALUES ('245', '12', '21', '陇南市');
INSERT INTO `city` VALUES ('246', '13', '21', '临夏回族自治州');
INSERT INTO `city` VALUES ('247', '14', '21', '甘南藏族自治州');
INSERT INTO `city` VALUES ('248', '1', '22', '成都市');
INSERT INTO `city` VALUES ('249', '2', '22', '自贡市');
INSERT INTO `city` VALUES ('250', '3', '22', '攀枝花市');
INSERT INTO `city` VALUES ('251', '4', '22', '泸州市');
INSERT INTO `city` VALUES ('252', '5', '22', '德阳市');
INSERT INTO `city` VALUES ('253', '6', '22', '绵阳市');
INSERT INTO `city` VALUES ('254', '7', '22', '广元市');
INSERT INTO `city` VALUES ('255', '8', '22', '遂宁市');
INSERT INTO `city` VALUES ('256', '9', '22', '内江市');
INSERT INTO `city` VALUES ('257', '10', '22', '乐山市');
INSERT INTO `city` VALUES ('258', '11', '22', '南充市');
INSERT INTO `city` VALUES ('259', '12', '22', '眉山市');
INSERT INTO `city` VALUES ('260', '13', '22', '宜宾市');
INSERT INTO `city` VALUES ('261', '14', '22', '广安市');
INSERT INTO `city` VALUES ('262', '15', '22', '达州市');
INSERT INTO `city` VALUES ('263', '16', '22', '雅安市');
INSERT INTO `city` VALUES ('264', '17', '22', '巴中市');
INSERT INTO `city` VALUES ('265', '18', '22', '资阳市');
INSERT INTO `city` VALUES ('266', '19', '22', '阿坝藏族羌族自治州');
INSERT INTO `city` VALUES ('267', '20', '22', '甘孜藏族自治州');
INSERT INTO `city` VALUES ('268', '21', '22', '凉山彝族自治州');
INSERT INTO `city` VALUES ('269', '1', '23', '贵阳市');
INSERT INTO `city` VALUES ('270', '2', '23', '六盘水市');
INSERT INTO `city` VALUES ('271', '3', '23', '遵义市');
INSERT INTO `city` VALUES ('272', '4', '23', '安顺市');
INSERT INTO `city` VALUES ('273', '5', '23', '铜仁地区');
INSERT INTO `city` VALUES ('274', '6', '23', '毕节地区');
INSERT INTO `city` VALUES ('275', '7', '23', '黔西南布依族苗族自治州');
INSERT INTO `city` VALUES ('276', '8', '23', '黔东南苗族侗族自治州');
INSERT INTO `city` VALUES ('277', '9', '23', '黔南布依族苗族自治州');
INSERT INTO `city` VALUES ('278', '1', '24', '海口市');
INSERT INTO `city` VALUES ('279', '2', '24', '三亚市');
INSERT INTO `city` VALUES ('280', '3', '24', '五指山市');
INSERT INTO `city` VALUES ('281', '4', '24', '琼海市');
INSERT INTO `city` VALUES ('282', '5', '24', '儋州市');
INSERT INTO `city` VALUES ('283', '6', '24', '文昌市');
INSERT INTO `city` VALUES ('284', '7', '24', '万宁市');
INSERT INTO `city` VALUES ('285', '8', '24', '东方市');
INSERT INTO `city` VALUES ('286', '9', '24', '澄迈县');
INSERT INTO `city` VALUES ('287', '10', '24', '定安县');
INSERT INTO `city` VALUES ('288', '11', '24', '屯昌县');
INSERT INTO `city` VALUES ('289', '12', '24', '临高县');
INSERT INTO `city` VALUES ('290', '13', '24', '白沙黎族自治县');
INSERT INTO `city` VALUES ('291', '14', '24', '昌江黎族自治县');
INSERT INTO `city` VALUES ('292', '15', '24', '乐东黎族自治县');
INSERT INTO `city` VALUES ('293', '16', '24', '陵水黎族自治县');
INSERT INTO `city` VALUES ('294', '17', '24', '保亭黎族苗族自治县');
INSERT INTO `city` VALUES ('295', '18', '24', '琼中黎族苗族自治县');
INSERT INTO `city` VALUES ('296', '1', '25', '昆明市');
INSERT INTO `city` VALUES ('297', '2', '25', '曲靖市');
INSERT INTO `city` VALUES ('298', '3', '25', '玉溪市');
INSERT INTO `city` VALUES ('299', '4', '25', '保山市');
INSERT INTO `city` VALUES ('300', '5', '25', '昭通市');
INSERT INTO `city` VALUES ('301', '6', '25', '丽江市');
INSERT INTO `city` VALUES ('302', '7', '25', '思茅市');
INSERT INTO `city` VALUES ('303', '8', '25', '临沧市');
INSERT INTO `city` VALUES ('304', '9', '25', '文山壮族苗族自治州');
INSERT INTO `city` VALUES ('305', '10', '25', '红河哈尼族彝族自治州');
INSERT INTO `city` VALUES ('306', '11', '25', '西双版纳傣族自治州');
INSERT INTO `city` VALUES ('307', '12', '25', '楚雄彝族自治州');
INSERT INTO `city` VALUES ('308', '13', '25', '大理白族自治州');
INSERT INTO `city` VALUES ('309', '14', '25', '德宏傣族景颇族自治州');
INSERT INTO `city` VALUES ('310', '15', '25', '怒江傈傈族自治州');
INSERT INTO `city` VALUES ('311', '16', '25', '迪庆藏族自治州');
INSERT INTO `city` VALUES ('312', '1', '26', '西宁市');
INSERT INTO `city` VALUES ('313', '2', '26', '海东地区');
INSERT INTO `city` VALUES ('314', '3', '26', '海北藏族自治州');
INSERT INTO `city` VALUES ('315', '4', '26', '黄南藏族自治州');
INSERT INTO `city` VALUES ('316', '5', '26', '海南藏族自治州');
INSERT INTO `city` VALUES ('317', '6', '26', '果洛藏族自治州');
INSERT INTO `city` VALUES ('318', '7', '26', '玉树藏族自治州');
INSERT INTO `city` VALUES ('319', '8', '26', '海西蒙古族藏族自治州');
INSERT INTO `city` VALUES ('320', '1', '27', '西安市');
INSERT INTO `city` VALUES ('321', '2', '27', '铜川市');
INSERT INTO `city` VALUES ('322', '3', '27', '宝鸡市');
INSERT INTO `city` VALUES ('323', '4', '27', '咸阳市');
INSERT INTO `city` VALUES ('324', '5', '27', '渭南市');
INSERT INTO `city` VALUES ('325', '6', '27', '延安市');
INSERT INTO `city` VALUES ('326', '7', '27', '汉中市');
INSERT INTO `city` VALUES ('327', '8', '27', '榆林市');
INSERT INTO `city` VALUES ('328', '9', '27', '安康市');
INSERT INTO `city` VALUES ('329', '10', '27', '商洛市');
INSERT INTO `city` VALUES ('330', '1', '28', '南宁市');
INSERT INTO `city` VALUES ('331', '2', '28', '柳州市');
INSERT INTO `city` VALUES ('332', '3', '28', '桂林市');
INSERT INTO `city` VALUES ('333', '4', '28', '梧州市');
INSERT INTO `city` VALUES ('334', '5', '28', '北海市');
INSERT INTO `city` VALUES ('335', '6', '28', '防城港市');
INSERT INTO `city` VALUES ('336', '7', '28', '钦州市');
INSERT INTO `city` VALUES ('337', '8', '28', '贵港市');
INSERT INTO `city` VALUES ('338', '9', '28', '玉林市');
INSERT INTO `city` VALUES ('339', '10', '28', '百色市');
INSERT INTO `city` VALUES ('340', '11', '28', '贺州市');
INSERT INTO `city` VALUES ('341', '12', '28', '河池市');
INSERT INTO `city` VALUES ('342', '13', '28', '来宾市');
INSERT INTO `city` VALUES ('343', '14', '28', '崇左市');
INSERT INTO `city` VALUES ('344', '1', '29', '拉萨市');
INSERT INTO `city` VALUES ('345', '2', '29', '那曲地区');
INSERT INTO `city` VALUES ('346', '3', '29', '昌都地区');
INSERT INTO `city` VALUES ('347', '4', '29', '山南地区');
INSERT INTO `city` VALUES ('348', '5', '29', '日喀则地区');
INSERT INTO `city` VALUES ('349', '6', '29', '阿里地区');
INSERT INTO `city` VALUES ('350', '7', '29', '林芝地区');
INSERT INTO `city` VALUES ('351', '1', '30', '银川市');
INSERT INTO `city` VALUES ('352', '2', '30', '石嘴山市');
INSERT INTO `city` VALUES ('353', '3', '30', '吴忠市');
INSERT INTO `city` VALUES ('354', '4', '30', '固原市');
INSERT INTO `city` VALUES ('355', '5', '30', '中卫市');
INSERT INTO `city` VALUES ('356', '1', '31', '乌鲁木齐市');
INSERT INTO `city` VALUES ('357', '2', '31', '克拉玛依市');
INSERT INTO `city` VALUES ('358', '3', '31', '石河子市　');
INSERT INTO `city` VALUES ('359', '4', '31', '阿拉尔市');
INSERT INTO `city` VALUES ('360', '5', '31', '图木舒克市');
INSERT INTO `city` VALUES ('361', '6', '31', '五家渠市');
INSERT INTO `city` VALUES ('362', '7', '31', '吐鲁番市');
INSERT INTO `city` VALUES ('363', '8', '31', '阿克苏市');
INSERT INTO `city` VALUES ('364', '9', '31', '喀什市');
INSERT INTO `city` VALUES ('365', '10', '31', '哈密市');
INSERT INTO `city` VALUES ('366', '11', '31', '和田市');
INSERT INTO `city` VALUES ('367', '12', '31', '阿图什市');
INSERT INTO `city` VALUES ('368', '13', '31', '库尔勒市');
INSERT INTO `city` VALUES ('369', '14', '31', '昌吉市　');
INSERT INTO `city` VALUES ('370', '15', '31', '阜康市');
INSERT INTO `city` VALUES ('371', '16', '31', '米泉市');
INSERT INTO `city` VALUES ('372', '17', '31', '博乐市');
INSERT INTO `city` VALUES ('373', '18', '31', '伊宁市');
INSERT INTO `city` VALUES ('374', '19', '31', '奎屯市');
INSERT INTO `city` VALUES ('375', '20', '31', '塔城市');
INSERT INTO `city` VALUES ('376', '21', '31', '乌苏市');
INSERT INTO `city` VALUES ('377', '22', '31', '阿勒泰市');
INSERT INTO `city` VALUES ('378', '1', '32', '呼和浩特市');
INSERT INTO `city` VALUES ('379', '2', '32', '包头市');
INSERT INTO `city` VALUES ('380', '3', '32', '乌海市');
INSERT INTO `city` VALUES ('381', '4', '32', '赤峰市');
INSERT INTO `city` VALUES ('382', '5', '32', '通辽市');
INSERT INTO `city` VALUES ('383', '6', '32', '鄂尔多斯市');
INSERT INTO `city` VALUES ('384', '7', '32', '呼伦贝尔市');
INSERT INTO `city` VALUES ('385', '8', '32', '巴彦淖尔市');
INSERT INTO `city` VALUES ('386', '9', '32', '乌兰察布市');
INSERT INTO `city` VALUES ('387', '10', '32', '锡林郭勒盟');
INSERT INTO `city` VALUES ('388', '11', '32', '兴安盟');
INSERT INTO `city` VALUES ('389', '12', '32', '阿拉善盟');
INSERT INTO `city` VALUES ('390', '1', '33', '澳门特别行政区');
INSERT INTO `city` VALUES ('391', '1', '34', '香港特别行政区');

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `status` enum('closed','draft','published') NOT NULL DEFAULT 'draft' COMMENT '状态关闭，未发布，发布',
  `about` text COMMENT '简介',
  `categoryId` int(10) NOT NULL DEFAULT '0' COMMENT '分类id',
  `description` text COMMENT '课程说明',
  `price` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `vipLevelId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支持的vip等级',
  `smallPicture` varchar(255) NOT NULL DEFAULT '' COMMENT '小图',
  `middlePicture` varchar(255) NOT NULL DEFAULT '' COMMENT '中图',
  `largePicture` varchar(255) NOT NULL DEFAULT '' COMMENT '大图',
  `headTeacherId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '班主任ID',
  `teacherIds` varchar(255) NOT NULL DEFAULT '' COMMENT '教师IDs',
  `assistantIds` text COMMENT '助教Ids',
  `hitNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `auditorNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '旁听生数',
  `studentNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学员数',
  `courseNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程数',
  `lessonNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时数',
  `threadNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题数',
  `noteNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '班级笔记数量',
  `postNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复数',
  `rating` float unsigned NOT NULL DEFAULT '0' COMMENT '排行数值',
  `ratingNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投票人数',
  `income` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '收入',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `service` varchar(255) DEFAULT NULL COMMENT '班级服务',
  `private` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否封闭班级',
  `recommended` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为推荐班级',
  `recommendedSeq` int(10) unsigned NOT NULL DEFAULT '100' COMMENT '推荐序号',
  `recommendedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐时间',
  `maxRate` tinyint(3) unsigned NOT NULL DEFAULT '100' COMMENT '最大抵扣百分比',
  `showable` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否开放展示',
  `buyable` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否开放购买',
  `orgId` int(10) unsigned DEFAULT '1',
  `orgCode` varchar(255) DEFAULT '1.' COMMENT '组织机构内部编码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classroom
-- ----------------------------

-- ----------------------------
-- Table structure for classroom_courses
-- ----------------------------
DROP TABLE IF EXISTS `classroom_courses`;
CREATE TABLE `classroom_courses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `classroomId` int(10) unsigned NOT NULL COMMENT '班级ID',
  `courseId` int(10) unsigned NOT NULL COMMENT '课程ID',
  `parentCourseId` int(10) unsigned NOT NULL COMMENT '父课程Id',
  `seq` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '班级课程顺序',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classroom_courses
-- ----------------------------

-- ----------------------------
-- Table structure for classroom_member
-- ----------------------------
DROP TABLE IF EXISTS `classroom_member`;
CREATE TABLE `classroom_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `classroomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '班级ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `orderId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
  `levelId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `noteNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '笔记数',
  `threadNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题数',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学员是否被锁定',
  `remark` text COMMENT '备注',
  `role` varchar(255) NOT NULL DEFAULT 'auditor' COMMENT '角色',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classroom_member
-- ----------------------------

-- ----------------------------
-- Table structure for classroom_review
-- ----------------------------
DROP TABLE IF EXISTS `classroom_review`;
CREATE TABLE `classroom_review` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `classroomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '班级ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `rating` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评分0-5',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `parentId` int(10) NOT NULL DEFAULT '0' COMMENT '回复ID',
  `updatedTime` int(10) DEFAULT NULL,
  `meta` text COMMENT '评价元信息',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classroom_review
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_app
-- ----------------------------
DROP TABLE IF EXISTS `cloud_app`;
CREATE TABLE `cloud_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '云应用ID',
  `name` varchar(255) NOT NULL COMMENT '云应用名称',
  `code` varchar(64) NOT NULL COMMENT '云应用编码',
  `type` enum('plugin','theme') NOT NULL DEFAULT 'plugin' COMMENT '应用类型(plugin插件应用, theme主题应用)',
  `description` text NOT NULL COMMENT '云应用描述',
  `icon` varchar(255) NOT NULL COMMENT '云应用图标',
  `version` varchar(32) NOT NULL COMMENT '云应用当前版本',
  `fromVersion` varchar(32) NOT NULL DEFAULT '0.0.0' COMMENT '云应用更新前版本',
  `developerId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '云应用开发者用户ID',
  `developerName` varchar(255) NOT NULL DEFAULT '' COMMENT '云应用开发者名称',
  `installedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '云应用安装时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '云应用最后更新时间',
  `edusohoMinVersion` varchar(32) NOT NULL DEFAULT '0.0.0' COMMENT '依赖Edusoho的最小版本',
  `edusohoMaxVersion` varchar(32) NOT NULL DEFAULT 'up' COMMENT '依赖Edusoho的最大版本',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='已安装的应用';

-- ----------------------------
-- Records of cloud_app
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_app_logs
-- ----------------------------
DROP TABLE IF EXISTS `cloud_app_logs`;
CREATE TABLE `cloud_app_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '云应用运行日志ID',
  `code` varchar(32) NOT NULL DEFAULT '' COMMENT '应用编码',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '应用名称',
  `fromVersion` varchar(32) DEFAULT NULL COMMENT '升级前版本',
  `toVersion` varchar(32) NOT NULL DEFAULT '' COMMENT '升级后版本',
  `type` enum('install','upgrade') NOT NULL DEFAULT 'install' COMMENT '升级类型',
  `dbBackupPath` varchar(255) NOT NULL DEFAULT '' COMMENT '数据库备份文件',
  `sourceBackupPath` varchar(255) NOT NULL DEFAULT '' COMMENT '源文件备份地址',
  `status` varchar(32) NOT NULL COMMENT '升级状态(ROLLBACK,ERROR,SUCCESS,RECOVERED)',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `ip` varchar(32) NOT NULL DEFAULT '' COMMENT 'IP',
  `message` text COMMENT '失败原因',
  `createdTime` int(10) unsigned NOT NULL COMMENT '日志记录时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用升级日志';

-- ----------------------------
-- Records of cloud_app_logs
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_data
-- ----------------------------
DROP TABLE IF EXISTS `cloud_data`;
CREATE TABLE `cloud_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `timestamp` int(10) unsigned NOT NULL,
  `createdTime` int(10) unsigned NOT NULL,
  `updatedTime` int(10) unsigned NOT NULL,
  `createdUserId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cloud_data
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `objectType` varchar(32) NOT NULL,
  `objectId` int(10) unsigned NOT NULL,
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `content` text NOT NULL,
  `createdTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `objectType` (`objectType`,`objectId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for content
-- ----------------------------
DROP TABLE IF EXISTS `content`;
CREATE TABLE `content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '内容ID',
  `title` varchar(255) NOT NULL COMMENT '内容标题',
  `editor` enum('richeditor','none') NOT NULL DEFAULT 'richeditor' COMMENT '编辑器选择类型字段',
  `type` varchar(255) NOT NULL COMMENT '内容类型',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT '内容别名',
  `summary` text COMMENT '内容摘要',
  `body` text COMMENT '内容正文',
  `picture` varchar(255) NOT NULL DEFAULT '' COMMENT '内容头图',
  `template` varchar(255) NOT NULL DEFAULT '' COMMENT '内容模板',
  `status` enum('published','unpublished','trash') NOT NULL COMMENT '内容状态',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '内容分类ID',
  `tagIds` tinytext COMMENT '内容标签ID',
  `hits` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '内容点击量',
  `featured` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否头条',
  `promoted` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否推荐',
  `sticky` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶',
  `userId` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `field1` text COMMENT '扩展字段',
  `field2` text COMMENT '扩展字段',
  `field3` text COMMENT '扩展字段',
  `field4` text COMMENT '扩展字段',
  `field5` text COMMENT '扩展字段',
  `field6` text COMMENT '扩展字段',
  `field7` text COMMENT '扩展字段',
  `field8` text COMMENT '扩展字段',
  `field9` text COMMENT '扩展字段',
  `field10` text COMMENT '扩展字段',
  `publishedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `createdTime` int(10) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of content
-- ----------------------------
INSERT INTO `content` VALUES ('1', '关于我们', 'richeditor', 'page', 'aboutus', null, '<p><img alt=\"\" src=\"http://edusoho-demo.b0.upaiyun.com/files/default/2015/06-11/1756524ac51a987008.jpg?6.0.2\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>XXX网络科技有限公司是中国领先的在线教育基础服务提供商，专注于在线教育，截止XXXX年XX月XX日已有X万X千多家网校在使用搭建网校，目前<strong>网校数量行业第一，客户规模行业第一，中国首个开源网络课堂-通用版。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>推出中国第一个教育行业专属教育云：</strong>云视频、云直播、云文档、云短信，独创TLP2.0安全技术，最高性价比方案（比其他云再省百分50成本），最高安全技术（万家网校0事故），最简集成（一键集成）。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>XXX网络成立于XXXX年X月，创始团队拥有海内外的教育和工作背景。公司坚持以创新为企业发展动力，以共赢共生为合作理念，为加速中国在线教育发展，创造全新教育方式做出贡献。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>官网：<u><a href=\"http://www.edusoho.com/\">http://www.kmbdqn.com/</a></u></strong></p>\r\n\r\n<p><strong>网络课堂演示站：<u><a href=\"http://demo.edusoho.com/\">http://demo.kmbdqn.com/</a></u></strong></p>\r\n\r\n<p><strong>E网络课堂使用学习站（）：<u><a href=\"http://www.qiqiuyu.com/\">http://www.kmbdqn.com/</a></u></strong></p>\r\n', '', 'default', 'published', '0', null, '0', '0', '0', '0', '1', null, null, null, null, null, null, null, null, null, null, '1429260383', '1429260383');
INSERT INTO `content` VALUES ('2', '帮助', 'richeditor', 'page', 'help', null, '<p>&nbsp;</p>\r\n\r\n<p><span style=\"font-size:18px\">除了提供领先的在线教育平台产品，还从更多方面帮助用户做在线教育：</span></p>\r\n\r\n<p><strong>产品及服务介绍：</strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; 官网:<u><a href=\"http://www.edusoho.com/\">http://www.kmbdqn.com/</a></u></strong></p>\r\n\r\n<p><strong>课程制作及维护</strong></p>\r\n\r\n<p>&nbsp; &nbsp; 录制及制作，请与销售联系。</p>\r\n\r\n<p><strong>在线教育行业资讯</strong></p>\r\n\r\n<p><strong>&nbsp; <u>&nbsp;<a href=\"http://www.qiqiuyu.com/article/category/news\">&nbsp;http://www.kmbdqn.com/article/category/news</a></u></strong></p>\r\n\r\n<p><strong>网校运营知识</strong></p>\r\n\r\n<p>&nbsp; &nbsp; 网校运营课程:<strong><u><a href=\"http://www.qiqiuyu.com/course/explore/operation\">http://www.kmbdqn.com/course/explore/operation</a></u></strong></p>\r\n\r\n<p><strong>系统二次开发与开发者</strong></p>\r\n\r\n<ul>\r\n	<li>开放平台官网：<strong><u><a href=\"http://open.edusoho.com/\">http://open.kmbdqn.com/</a></u></strong></li>\r\n	<li>开发者社区：<a href=\"http://www.qiqiuyu.com/group/5\"><u><strong>http://www.kmbdqn.com/group/5</strong></u></a></li>\r\n	<li>开发课程：<u><strong><a href=\"http://www.qiqiuyu.com/course/explore/developer\">http://www.kmbdqn.com/course/explore/developer</a></strong></u></li>\r\n</ul>\r\n\r\n<div><strong>使用</strong></div>\r\n\r\n<div>&nbsp; &nbsp; 使用课程:<strong><a href=\"http://www.qiqiuyu.com/course/explore/developer\">http://www.kmbdqn.com/course/explore/fuction</a></strong></div>\r\n\r\n<div><strong>反馈社区</strong></div>\r\n\r\n<div><strong>&nbsp; &nbsp;&nbsp;</strong>建议小组:<strong><a href=\"http://www.qiqiuyu.com/course/explore/developer\">http://www.kmbdqn.com/group/4</a></strong></div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div>关注微信，了解最新的产品及活动消息！</div>\r\n\r\n<p>&nbsp;</p>\r\n', '', 'default', 'published', '0', null, '0', '0', '0', '0', '1', null, null, null, null, null, null, null, null, null, null, '1429260383', '1429260383');

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL COMMENT '优惠码',
  `type` enum('minus','discount') NOT NULL COMMENT '优惠方式',
  `status` enum('used','unused','receive') NOT NULL COMMENT '使用状态',
  `rate` float(10,2) unsigned NOT NULL COMMENT '若优惠方式为打折，则为打折率，若为抵价，则为抵价金额',
  `batchId` int(10) unsigned DEFAULT NULL COMMENT '批次号',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用者',
  `deadline` int(10) unsigned NOT NULL COMMENT '失效时间',
  `targetType` varchar(64) DEFAULT NULL COMMENT '使用对象类型',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用对象',
  `orderId` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单号',
  `orderTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用时间',
  `createdTime` int(10) unsigned NOT NULL,
  `receiveTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '接收时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='优惠码表';

-- ----------------------------
-- Records of coupon
-- ----------------------------

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `title` varchar(1024) NOT NULL COMMENT '课程标题',
  `subtitle` varchar(1024) NOT NULL DEFAULT '' COMMENT '课程副标题',
  `status` enum('draft','published','closed') NOT NULL DEFAULT 'draft' COMMENT '课程状态',
  `buyable` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否开放购买',
  `buyExpiryTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买开放有效期',
  `type` varchar(255) NOT NULL DEFAULT 'normal' COMMENT '课程类型',
  `maxStudentNum` int(11) NOT NULL DEFAULT '0' COMMENT '直播课程最大学员数上线',
  `price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '课程价格',
  `originPrice` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '课程人民币原价',
  `coinPrice` float(10,2) NOT NULL DEFAULT '0.00',
  `originCoinPrice` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '课程虚拟币原价',
  `expiryMode` enum('date','days','none') NOT NULL DEFAULT 'none' COMMENT '有效期模式（截止日期|有效期天数|不设置）',
  `expiryDay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程过期天数',
  `showStudentNumType` enum('opened','closed') NOT NULL DEFAULT 'opened' COMMENT '学员数显示模式',
  `serializeMode` enum('none','serialize','finished') NOT NULL DEFAULT 'none' COMMENT '连载模式',
  `income` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '课程销售总收入',
  `lessonNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时数',
  `giveCredit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学完课程所有课时，可获得的总学分',
  `rating` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排行分数',
  `ratingNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投票人数',
  `vipLevelId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '可以免费看的，会员等级',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `tags` text COMMENT '标签IDs',
  `smallPicture` varchar(255) NOT NULL DEFAULT '' COMMENT '小图',
  `middlePicture` varchar(255) NOT NULL DEFAULT '' COMMENT '中图',
  `largePicture` varchar(255) NOT NULL DEFAULT '' COMMENT '大图',
  `about` text COMMENT '简介',
  `teacherIds` text COMMENT '显示的课程教师IDs',
  `goals` text COMMENT '课程目标',
  `audiences` text COMMENT '适合人群',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为推荐课程',
  `recommendedSeq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐序号',
  `recommendedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐时间',
  `locationId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上课地区ID',
  `parentId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程的父Id',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '上课地区地址',
  `studentNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学员数',
  `hitNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看次数',
  `noteNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程笔记数量',
  `userId` int(10) unsigned NOT NULL COMMENT '课程发布人ID',
  `discountId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '折扣活动ID',
  `discount` float(10,2) NOT NULL DEFAULT '10.00' COMMENT '折扣',
  `deadlineNotify` enum('active','none') NOT NULL DEFAULT 'none' COMMENT '开启有效期通知',
  `daysOfNotifyBeforeDeadline` int(10) NOT NULL DEFAULT '0',
  `watchLimit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时观看次数限制',
  `useInClassroom` enum('single','more') NOT NULL DEFAULT 'single' COMMENT '课程能否用于多个班级',
  `singleBuy` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '加入班级后课程能否单独购买',
  `createdTime` int(10) unsigned NOT NULL COMMENT '课程创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `freeStartTime` int(10) NOT NULL DEFAULT '0',
  `freeEndTime` int(10) NOT NULL DEFAULT '0',
  `approval` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否需要实名认证',
  `locked` int(10) NOT NULL DEFAULT '0' COMMENT '是否上锁1上锁,0解锁',
  `maxRate` tinyint(3) unsigned NOT NULL DEFAULT '100' COMMENT '最大抵扣百分比',
  `tryLookable` tinyint(4) NOT NULL DEFAULT '0',
  `tryLookTime` int(11) NOT NULL DEFAULT '0',
  `orgId` int(10) unsigned DEFAULT '1',
  `orgCode` varchar(255) DEFAULT '1.' COMMENT '组织机构内部编码',
  `crowd_id` int(11) DEFAULT NULL COMMENT '培训机构ID',
  `school_id` int(11) DEFAULT NULL COMMENT '学校ID',
  `populationClassify` int(11) DEFAULT '0' COMMENT '人群分类(0,初中生;1,高中生;2.大学生;3.职场人员)',
  `level_id` int(11) DEFAULT '1' COMMENT '课程分类ID(默认1)',
  PRIMARY KEY (`id`),
  KEY `updatedTime` (`updatedTime`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------

-- ----------------------------
-- Table structure for course_announcement
-- ----------------------------
DROP TABLE IF EXISTS `course_announcement`;
CREATE TABLE `course_announcement` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '课程公告ID',
  `userId` int(10) NOT NULL COMMENT '公告发布人ID',
  `courseId` int(10) NOT NULL COMMENT '公告所属课程ID',
  `content` text NOT NULL COMMENT '公告内容',
  `createdTime` int(10) NOT NULL COMMENT '公告创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公告最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_announcement
-- ----------------------------

-- ----------------------------
-- Table structure for course_chapter
-- ----------------------------
DROP TABLE IF EXISTS `course_chapter`;
CREATE TABLE `course_chapter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程章节ID',
  `courseId` int(10) unsigned NOT NULL COMMENT '章节所属课程ID',
  `type` enum('chapter','unit') NOT NULL DEFAULT 'chapter' COMMENT '章节类型：chapter为章节，unit为单元。',
  `parentId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'parentId大于０时为单元',
  `number` int(10) unsigned NOT NULL COMMENT '章节编号',
  `seq` int(10) unsigned NOT NULL COMMENT '章节序号',
  `title` varchar(255) NOT NULL COMMENT '章节名称',
  `createdTime` int(10) unsigned NOT NULL COMMENT '章节创建时间',
  `copyId` int(10) NOT NULL DEFAULT '0' COMMENT '复制章节的id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_chapter
-- ----------------------------

-- ----------------------------
-- Table structure for course_draft
-- ----------------------------
DROP TABLE IF EXISTS `course_draft`;
CREATE TABLE `course_draft` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `summary` text COMMENT '摘要',
  `courseId` int(10) unsigned NOT NULL COMMENT '课程ID',
  `content` text COMMENT '内容',
  `userId` int(10) unsigned NOT NULL COMMENT '用户ID',
  `lessonId` int(10) unsigned NOT NULL COMMENT '课时ID',
  `createdTime` int(10) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=205 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_draft
-- ----------------------------

-- ----------------------------
-- Table structure for course_favorite
-- ----------------------------
DROP TABLE IF EXISTS `course_favorite`;
CREATE TABLE `course_favorite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `courseId` int(10) unsigned NOT NULL COMMENT '收藏课程的ID',
  `userId` int(10) unsigned NOT NULL COMMENT '收藏人的ID',
  `createdTime` int(10) NOT NULL COMMENT '创建时间',
  `type` varchar(50) NOT NULL DEFAULT 'course' COMMENT '课程类型',
  PRIMARY KEY (`id`),
  KEY `course_favorite_userId_courseId_type_index` (`userId`,`courseId`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户的收藏数据表';

-- ----------------------------
-- Records of course_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for course_lesson
-- ----------------------------
DROP TABLE IF EXISTS `course_lesson`;
CREATE TABLE `course_lesson` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课时ID',
  `courseId` int(10) unsigned NOT NULL COMMENT '课时所属课程ID',
  `chapterId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时所属章节ID',
  `number` int(10) unsigned NOT NULL COMMENT '课时编号',
  `seq` int(10) unsigned NOT NULL COMMENT '课时在课程中的序号',
  `free` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为免费课时',
  `status` enum('unpublished','published') NOT NULL DEFAULT 'published' COMMENT '课时状态',
  `title` varchar(255) NOT NULL COMMENT '课时标题',
  `summary` text COMMENT '课时摘要',
  `tags` text COMMENT '课时标签',
  `type` varchar(64) NOT NULL DEFAULT 'text' COMMENT '课时类型',
  `content` text COMMENT '课时正文',
  `giveCredit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学完课时获得的学分',
  `requireCredit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学习课时前，需达到的学分',
  `mediaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '媒体文件ID',
  `mediaSource` varchar(32) NOT NULL DEFAULT '' COMMENT '媒体文件来源(self:本站上传,youku:优酷)',
  `mediaName` varchar(255) NOT NULL DEFAULT '' COMMENT '媒体文件名称',
  `mediaUri` text COMMENT '媒体文件资源名',
  `homeworkId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '作业iD',
  `exerciseId` int(10) unsigned DEFAULT '0' COMMENT '练习ID',
  `length` int(11) unsigned DEFAULT NULL COMMENT '时长',
  `materialNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传的资料数量',
  `quizNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测验题目数量',
  `learnedNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已学的学员数',
  `viewedNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `startTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '直播课时开始时间',
  `endTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '直播课时结束时间',
  `memberNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '直播课时加入人数',
  `replayStatus` enum('ungenerated','generating','generated','videoGenerated') NOT NULL DEFAULT 'ungenerated',
  `maxOnlineNum` int(11) DEFAULT '0' COMMENT '直播在线人数峰值',
  `liveProvider` int(10) unsigned NOT NULL DEFAULT '0',
  `userId` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `createdTime` int(10) unsigned NOT NULL COMMENT '创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `copyId` int(10) NOT NULL DEFAULT '0' COMMENT '复制课时id',
  `testMode` enum('normal','realTime') DEFAULT 'normal' COMMENT '考试模式',
  `testStartTime` int(10) DEFAULT '0' COMMENT '实时考试开始时间',
  PRIMARY KEY (`id`),
  KEY `updatedTime` (`updatedTime`)
) ENGINE=MyISAM AUTO_INCREMENT=272 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_lesson
-- ----------------------------

-- ----------------------------
-- Table structure for course_lesson_extend
-- ----------------------------
DROP TABLE IF EXISTS `course_lesson_extend`;
CREATE TABLE `course_lesson_extend` (
  `id` int(10) NOT NULL COMMENT '课时ID',
  `courseId` int(10) NOT NULL DEFAULT '0' COMMENT '课程ID',
  `doTimes` int(10) NOT NULL DEFAULT '0' COMMENT '可考试次数',
  `redoInterval` float(10,1) NOT NULL DEFAULT '0.0' COMMENT '重做时间间隔(小时)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='试卷课时扩展表';

-- ----------------------------
-- Records of course_lesson_extend
-- ----------------------------

-- ----------------------------
-- Table structure for course_lesson_learn
-- ----------------------------
DROP TABLE IF EXISTS `course_lesson_learn`;
CREATE TABLE `course_lesson_learn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '学员课时学习记录ID',
  `userId` int(10) unsigned NOT NULL COMMENT '学员ID',
  `courseId` int(10) unsigned NOT NULL COMMENT '课程ID',
  `lessonId` int(10) unsigned NOT NULL COMMENT '课时ID',
  `status` enum('learning','finished') NOT NULL COMMENT '学习状态',
  `startTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学习开始时间',
  `finishedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学习完成时间',
  `learnTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学习时间',
  `watchTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学习观看时间',
  `watchNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时已观看次数',
  `videoStatus` enum('paused','playing') NOT NULL DEFAULT 'paused' COMMENT '学习观看时间',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId_lessonId` (`userId`,`lessonId`),
  KEY `userId_courseId` (`userId`,`courseId`)
) ENGINE=MyISAM AUTO_INCREMENT=220 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_lesson_learn
-- ----------------------------

-- ----------------------------
-- Table structure for course_lesson_replay
-- ----------------------------
DROP TABLE IF EXISTS `course_lesson_replay`;
CREATE TABLE `course_lesson_replay` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonId` int(10) unsigned NOT NULL COMMENT '所属课时',
  `courseId` int(10) unsigned NOT NULL COMMENT '所属课程',
  `title` varchar(255) NOT NULL COMMENT '名称',
  `replayId` text NOT NULL COMMENT '云直播中的回放id',
  `userId` int(10) unsigned NOT NULL COMMENT '创建者',
  `createdTime` int(10) unsigned NOT NULL COMMENT '创建时间',
  `hidden` tinyint(1) unsigned DEFAULT '0' COMMENT '观看状态',
  `type` varchar(50) NOT NULL DEFAULT 'live' COMMENT '课程类型',
  `copyId` int(10) DEFAULT '0' COMMENT '复制回放的ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_lesson_replay
-- ----------------------------

-- ----------------------------
-- Table structure for course_lesson_view
-- ----------------------------
DROP TABLE IF EXISTS `course_lesson_view`;
CREATE TABLE `course_lesson_view` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseId` int(10) NOT NULL,
  `lessonId` int(10) NOT NULL,
  `fileId` int(10) NOT NULL,
  `userId` int(10) NOT NULL,
  `fileType` enum('document','video','audio','image','ppt','other','none') NOT NULL DEFAULT 'none',
  `fileStorage` enum('local','cloud','net','none') NOT NULL DEFAULT 'none',
  `fileSource` varchar(32) NOT NULL,
  `createdTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_lesson_view
-- ----------------------------

-- ----------------------------
-- Table structure for course_material
-- ----------------------------
DROP TABLE IF EXISTS `course_material`;
CREATE TABLE `course_material` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程资料ID',
  `courseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资料所属课程ID',
  `lessonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资料所属课时ID',
  `title` varchar(1024) NOT NULL COMMENT '资料标题',
  `description` text COMMENT '资料描述',
  `link` varchar(1024) NOT NULL DEFAULT '' COMMENT '外部链接地址',
  `fileId` int(10) unsigned NOT NULL COMMENT '资料文件ID',
  `fileUri` varchar(255) NOT NULL DEFAULT '' COMMENT '资料文件URI',
  `fileMime` varchar(255) NOT NULL DEFAULT '' COMMENT '资料文件MIME',
  `fileSize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资料文件大小',
  `source` varchar(50) NOT NULL DEFAULT 'coursematerial',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资料创建人ID',
  `createdTime` int(10) unsigned NOT NULL COMMENT '资料创建时间',
  `copyId` int(10) NOT NULL DEFAULT '0' COMMENT '复制的资料Id',
  `type` varchar(50) NOT NULL DEFAULT 'course' COMMENT '课程类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_material
-- ----------------------------

-- ----------------------------
-- Table structure for course_member
-- ----------------------------
DROP TABLE IF EXISTS `course_member`;
CREATE TABLE `course_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程学员记录ID',
  `courseId` int(10) unsigned NOT NULL COMMENT '课程ID',
  `classroomId` int(10) NOT NULL DEFAULT '0' COMMENT '班级ID',
  `joinedType` enum('course','classroom') NOT NULL DEFAULT 'course' COMMENT '购买班级或者课程加入学习',
  `userId` int(10) unsigned NOT NULL COMMENT '学员ID',
  `orderId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学员购买课程时的订单ID',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学习最后期限',
  `levelId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户以会员的方式加入课程学员时的会员ID',
  `learnedNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已学课时数',
  `credit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学员已获得的学分',
  `noteNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '笔记数目',
  `noteLastUpdateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最新的笔记更新时间',
  `isLearned` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已学完',
  `seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序序号',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `isVisible` tinyint(2) NOT NULL DEFAULT '1' COMMENT '可见与否，默认为可见',
  `role` enum('student','teacher') NOT NULL DEFAULT 'student' COMMENT '课程会员角色',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学员是否被锁定',
  `deadlineNotified` int(10) NOT NULL DEFAULT '0' COMMENT '有效期通知',
  `createdTime` int(10) unsigned NOT NULL COMMENT '学员加入课程时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseId` (`courseId`,`userId`),
  KEY `courseId_role_createdTime` (`courseId`,`role`,`createdTime`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_member
-- ----------------------------

-- ----------------------------
-- Table structure for course_note
-- ----------------------------
DROP TABLE IF EXISTS `course_note`;
CREATE TABLE `course_note` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '笔记ID',
  `userId` int(10) NOT NULL COMMENT '笔记作者ID',
  `courseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `lessonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时ID',
  `content` text NOT NULL COMMENT '笔记内容',
  `length` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '笔记内容的字数',
  `likeNum` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '点赞人数',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '笔记状态：0:私有, 1:公开',
  `createdTime` int(10) NOT NULL COMMENT '笔记创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '笔记更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_note
-- ----------------------------

-- ----------------------------
-- Table structure for course_note_like
-- ----------------------------
DROP TABLE IF EXISTS `course_note_like`;
CREATE TABLE `course_note_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `noteId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `createdTime` int(11) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_note_like
-- ----------------------------

-- ----------------------------
-- Table structure for course_review
-- ----------------------------
DROP TABLE IF EXISTS `course_review`;
CREATE TABLE `course_review` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程评价ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价人ID',
  `courseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被评价的课程ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '评价标题',
  `content` text NOT NULL COMMENT '评论内容',
  `rating` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评分',
  `private` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `createdTime` int(10) unsigned NOT NULL COMMENT '评价创建时间',
  `parentId` int(10) NOT NULL DEFAULT '0' COMMENT '回复ID',
  `updatedTime` int(10) DEFAULT NULL,
  `meta` text COMMENT '评价元信息',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_review
-- ----------------------------

-- ----------------------------
-- Table structure for course_thread
-- ----------------------------
DROP TABLE IF EXISTS `course_thread`;
CREATE TABLE `course_thread` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程话题ID',
  `courseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题所属课程ID',
  `lessonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题所属课时ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题发布人ID',
  `type` enum('discussion','question') NOT NULL DEFAULT 'discussion' COMMENT '话题类型',
  `isStick` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶',
  `isElite` tinyint(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否精华',
  `isClosed` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否关闭',
  `private` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `title` varchar(255) NOT NULL COMMENT '话题标题',
  `content` text COMMENT '话题内容',
  `postNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复数',
  `hitNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `followNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注数',
  `latestPostUserId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后回复人ID',
  `latestPostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后回复时间',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `updatedTime` (`updatedTime`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_thread
-- ----------------------------

-- ----------------------------
-- Table structure for course_thread_post
-- ----------------------------
DROP TABLE IF EXISTS `course_thread_post`;
CREATE TABLE `course_thread_post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程话题回复ID',
  `courseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复所属课程ID',
  `lessonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复所属课时ID',
  `threadId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复所属话题ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复人',
  `isElite` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否精华',
  `content` text NOT NULL COMMENT '正文',
  `createdTime` int(10) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_thread_post
-- ----------------------------

-- ----------------------------
-- Table structure for crontab_job
-- ----------------------------
DROP TABLE IF EXISTS `crontab_job`;
CREATE TABLE `crontab_job` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(1024) NOT NULL COMMENT '任务名称',
  `cycle` enum('once','everyhour','everyday','everymonth') NOT NULL DEFAULT 'once' COMMENT '任务执行周期',
  `cycleTime` varchar(255) NOT NULL DEFAULT '0' COMMENT '任务执行时间',
  `jobClass` varchar(1024) NOT NULL COMMENT '任务的Class名称',
  `jobParams` text COMMENT '任务参数',
  `targetType` varchar(64) NOT NULL DEFAULT '',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0',
  `executing` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '任务执行状态',
  `nextExcutedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务下次执行的时间',
  `latestExecutedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务最后执行的时间',
  `creatorId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务创建人',
  `createdTime` int(10) unsigned NOT NULL COMMENT '任务创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crontab_job
-- ----------------------------

-- ----------------------------
-- Table structure for crowd_classification
-- ----------------------------
DROP TABLE IF EXISTS `crowd_classification`;
CREATE TABLE `crowd_classification` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '培训机构ID',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '培训机构名称',
  `notice` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '民族',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `phone` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '联系方式',
  `IDCards` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '身份证号',
  `address` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '地址',
  `guardianName` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '监护人姓名',
  `guardianPhone` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '监护人联系方式',
  `reportedSchool` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '所报学校',
  `reportedClass` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '所报课程',
  `smallPicture` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '小图片',
  `middlePicture` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '中图',
  `largePicture` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '大图',
  `briefIntroduction` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '简介',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of crowd_classification
-- ----------------------------

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '字典名称',
  `type` varchar(255) NOT NULL COMMENT '字典类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------

-- ----------------------------
-- Table structure for dictionary_item
-- ----------------------------
DROP TABLE IF EXISTS `dictionary_item`;
CREATE TABLE `dictionary_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL COMMENT '字典类型',
  `code` varchar(64) DEFAULT NULL COMMENT '编码',
  `name` varchar(255) NOT NULL COMMENT '字典内容名称',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `createdTime` int(10) unsigned NOT NULL,
  `updateTime` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary_item
-- ----------------------------

-- ----------------------------
-- Table structure for discovery_column
-- ----------------------------
DROP TABLE IF EXISTS `discovery_column`;
CREATE TABLE `discovery_column` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` varchar(32) NOT NULL COMMENT '栏目类型',
  `categoryId` int(10) NOT NULL DEFAULT '0' COMMENT '分类',
  `orderType` varchar(32) NOT NULL COMMENT '排序字段',
  `showCount` int(10) NOT NULL COMMENT '展示数量',
  `seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `createdTime` int(10) unsigned NOT NULL,
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='发现页栏目';

-- ----------------------------
-- Records of discovery_column
-- ----------------------------

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '上传文件ID',
  `groupId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传文件组ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传人ID',
  `uri` varchar(255) NOT NULL COMMENT '文件URI',
  `mime` varchar(255) NOT NULL COMMENT '文件MIME',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件状态',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件上传时间',
  `uploadFileId` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=919 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for file_group
-- ----------------------------
DROP TABLE IF EXISTS `file_group`;
CREATE TABLE `file_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '上传文件组ID',
  `name` varchar(255) NOT NULL COMMENT '上传文件组名称',
  `code` varchar(255) NOT NULL COMMENT '上传文件组编码',
  `public` tinyint(4) NOT NULL DEFAULT '1' COMMENT '文件组文件是否公开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of file_group
-- ----------------------------
INSERT INTO `file_group` VALUES ('1', '默认文件组', 'default', '1');
INSERT INTO `file_group` VALUES ('2', '缩略图', 'thumb', '1');
INSERT INTO `file_group` VALUES ('3', '课程', 'course', '1');
INSERT INTO `file_group` VALUES ('4', '用户', 'user', '1');
INSERT INTO `file_group` VALUES ('5', '课程私有文件', 'course_private', '0');
INSERT INTO `file_group` VALUES ('6', '资讯', 'article', '1');
INSERT INTO `file_group` VALUES ('7', '临时目录', 'tmp', '1');
INSERT INTO `file_group` VALUES ('8', '全局设置文件', 'system', '1');
INSERT INTO `file_group` VALUES ('9', '小组', 'group', '1');
INSERT INTO `file_group` VALUES ('10', '编辑区', 'block', '1');
INSERT INTO `file_group` VALUES ('11', '班级', 'classroom', '1');

-- ----------------------------
-- Table structure for file_used
-- ----------------------------
DROP TABLE IF EXISTS `file_used`;
CREATE TABLE `file_used` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `fileId` int(11) NOT NULL COMMENT 'upload_files id',
  `targetType` varchar(32) NOT NULL,
  `targetId` int(11) NOT NULL,
  `createdTime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `file_used_type_targetType_targetId_index` (`type`,`targetType`,`targetId`),
  KEY `file_used_type_targetType_targetId_fileId_index` (`type`,`targetType`,`targetId`,`fileId`),
  KEY `file_used_fileId_index` (`fileId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of file_used
-- ----------------------------

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '关注ID',
  `fromId` int(10) unsigned NOT NULL COMMENT '关注人ID',
  `toId` int(10) unsigned NOT NULL COMMENT '被关注人ID',
  `pair` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为互加好友',
  `createdTime` int(10) unsigned NOT NULL COMMENT '关注时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES ('1', '9', '5', '0', '1433229237');
INSERT INTO `friend` VALUES ('2', '1', '2', '0', '1434020230');

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '小组id',
  `title` varchar(100) NOT NULL COMMENT '小组名称',
  `about` text COMMENT '小组介绍',
  `logo` varchar(100) NOT NULL DEFAULT '' COMMENT 'logo',
  `backgroundLogo` varchar(100) NOT NULL DEFAULT '',
  `status` enum('open','close') NOT NULL DEFAULT 'open',
  `memberNum` int(10) unsigned NOT NULL DEFAULT '0',
  `threadNum` int(10) unsigned NOT NULL DEFAULT '0',
  `postNum` int(10) unsigned NOT NULL DEFAULT '0',
  `ownerId` int(10) unsigned NOT NULL COMMENT '小组组长id',
  `createdTime` int(11) unsigned NOT NULL COMMENT '创建小组时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groups
-- ----------------------------

-- ----------------------------
-- Table structure for groups_member
-- ----------------------------
DROP TABLE IF EXISTS `groups_member`;
CREATE TABLE `groups_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '成员id主键',
  `groupId` int(10) unsigned NOT NULL COMMENT '小组id',
  `userId` int(10) unsigned NOT NULL COMMENT '用户id',
  `role` varchar(100) NOT NULL DEFAULT 'member',
  `postNum` int(10) unsigned NOT NULL DEFAULT '0',
  `threadNum` int(10) unsigned NOT NULL DEFAULT '0',
  `createdTime` int(11) unsigned NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groups_member
-- ----------------------------

-- ----------------------------
-- Table structure for groups_thread
-- ----------------------------
DROP TABLE IF EXISTS `groups_thread`;
CREATE TABLE `groups_thread` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '话题id',
  `title` varchar(1024) NOT NULL COMMENT '话题标题',
  `content` text COMMENT '话题内容',
  `isElite` int(11) unsigned NOT NULL DEFAULT '0',
  `isStick` int(11) unsigned NOT NULL DEFAULT '0',
  `lastPostMemberId` int(10) unsigned NOT NULL DEFAULT '0',
  `lastPostTime` int(10) unsigned NOT NULL DEFAULT '0',
  `groupId` int(10) unsigned NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  `createdTime` int(10) unsigned NOT NULL COMMENT '添加时间',
  `postNum` int(10) unsigned NOT NULL DEFAULT '0',
  `status` enum('open','close') NOT NULL DEFAULT 'open',
  `hitNum` int(10) unsigned NOT NULL DEFAULT '0',
  `rewardCoin` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(255) NOT NULL DEFAULT 'default',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `updatedTime` (`updatedTime`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groups_thread
-- ----------------------------

-- ----------------------------
-- Table structure for groups_thread_collect
-- ----------------------------
DROP TABLE IF EXISTS `groups_thread_collect`;
CREATE TABLE `groups_thread_collect` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `threadId` int(11) unsigned NOT NULL COMMENT '收藏的话题id',
  `userId` int(10) unsigned NOT NULL COMMENT '收藏人id',
  `createdTime` int(10) unsigned NOT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groups_thread_collect
-- ----------------------------

-- ----------------------------
-- Table structure for groups_thread_goods
-- ----------------------------
DROP TABLE IF EXISTS `groups_thread_goods`;
CREATE TABLE `groups_thread_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `description` text,
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `type` enum('content','attachment','postAttachment') NOT NULL,
  `threadId` int(10) unsigned NOT NULL,
  `postId` int(10) unsigned NOT NULL DEFAULT '0',
  `coin` int(10) unsigned NOT NULL,
  `fileId` int(10) unsigned NOT NULL DEFAULT '0',
  `hitNum` int(10) unsigned NOT NULL DEFAULT '0',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groups_thread_goods
-- ----------------------------

-- ----------------------------
-- Table structure for groups_thread_post
-- ----------------------------
DROP TABLE IF EXISTS `groups_thread_post`;
CREATE TABLE `groups_thread_post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `threadId` int(11) unsigned NOT NULL COMMENT '话题id',
  `content` text NOT NULL COMMENT '回复内容',
  `userId` int(10) unsigned NOT NULL COMMENT '回复人id',
  `fromUserId` int(10) unsigned NOT NULL DEFAULT '0',
  `postId` int(10) unsigned DEFAULT '0',
  `createdTime` int(10) unsigned NOT NULL COMMENT '回复时间',
  `adopt` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groups_thread_post
-- ----------------------------

-- ----------------------------
-- Table structure for groups_thread_trade
-- ----------------------------
DROP TABLE IF EXISTS `groups_thread_trade`;
CREATE TABLE `groups_thread_trade` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `threadId` int(10) unsigned DEFAULT '0',
  `goodsId` int(10) DEFAULT '0',
  `userId` int(10) unsigned NOT NULL,
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groups_thread_trade
-- ----------------------------

-- ----------------------------
-- Table structure for im_conversation
-- ----------------------------
DROP TABLE IF EXISTS `im_conversation`;
CREATE TABLE `im_conversation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `no` varchar(64) NOT NULL COMMENT 'IM云端返回的会话id',
  `targetType` varchar(16) NOT NULL DEFAULT '',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0',
  `memberIds` text NOT NULL COMMENT '会话中用户列表(用户id按照小到大排序，竖线隔开)',
  `memberHash` varchar(32) NOT NULL DEFAULT '' COMMENT 'memberIds字段的hash值，用于优化查询',
  `createdTime` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `no` (`no`),
  KEY `targetId` (`targetId`),
  KEY `targetType` (`targetType`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='IM云端会话记录表';

-- ----------------------------
-- Records of im_conversation
-- ----------------------------

-- ----------------------------
-- Table structure for im_member
-- ----------------------------
DROP TABLE IF EXISTS `im_member`;
CREATE TABLE `im_member` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `convNo` varchar(32) NOT NULL COMMENT '会话ID',
  `targetId` int(10) NOT NULL,
  `targetType` varchar(15) NOT NULL,
  `userId` int(10) NOT NULL DEFAULT '0',
  `createdTime` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `convno_userId` (`convNo`,`userId`),
  KEY `userId_targetType` (`userId`,`targetType`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会话用户表';

-- ----------------------------
-- Records of im_member
-- ----------------------------

-- ----------------------------
-- Table structure for installed_packages
-- ----------------------------
DROP TABLE IF EXISTS `installed_packages`;
CREATE TABLE `installed_packages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ename` varchar(255) NOT NULL COMMENT '包名称',
  `cname` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL COMMENT 'version',
  `installTime` int(11) NOT NULL COMMENT '安装时间',
  `fromVersion` varchar(255) NOT NULL DEFAULT '' COMMENT '来源',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cname` (`ename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='已安装包';

-- ----------------------------
-- Records of installed_packages
-- ----------------------------

-- ----------------------------
-- Table structure for invite_record
-- ----------------------------
DROP TABLE IF EXISTS `invite_record`;
CREATE TABLE `invite_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inviteUserId` int(11) unsigned DEFAULT NULL COMMENT '邀请者',
  `invitedUserId` int(11) unsigned DEFAULT NULL COMMENT '被邀请者',
  `inviteTime` int(11) unsigned DEFAULT NULL COMMENT '邀请时间',
  `inviteUserCardId` int(11) unsigned DEFAULT NULL COMMENT '邀请者获得奖励的卡的ID',
  `invitedUserCardId` int(11) unsigned DEFAULT NULL COMMENT '被邀请者获得奖励的卡的ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='邀请记录表';

-- ----------------------------
-- Records of invite_record
-- ----------------------------

-- ----------------------------
-- Table structure for ip_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `ip_blacklist`;
CREATE TABLE `ip_blacklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) NOT NULL,
  `type` enum('failed','banned') NOT NULL,
  `counter` int(10) unsigned NOT NULL DEFAULT '0',
  `expiredTime` int(10) unsigned NOT NULL DEFAULT '0',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ip_blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for keyword
-- ----------------------------
DROP TABLE IF EXISTS `keyword`;
CREATE TABLE `keyword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `state` enum('replaced','banned') NOT NULL DEFAULT 'replaced',
  `bannedNum` int(10) unsigned NOT NULL DEFAULT '0',
  `createdTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of keyword
-- ----------------------------

-- ----------------------------
-- Table structure for keyword_banlog
-- ----------------------------
DROP TABLE IF EXISTS `keyword_banlog`;
CREATE TABLE `keyword_banlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `keywordId` int(10) unsigned NOT NULL,
  `keywordName` varchar(64) NOT NULL DEFAULT '',
  `state` enum('replaced','banned') NOT NULL DEFAULT 'replaced',
  `text` text NOT NULL,
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(64) NOT NULL DEFAULT '',
  `createdTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `keywordId` (`keywordId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of keyword_banlog
-- ----------------------------

-- ----------------------------
-- Table structure for level
-- ----------------------------
DROP TABLE IF EXISTS `level`;
CREATE TABLE `level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT '',
  `level` int(11) DEFAULT '0',
  `next` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of level
-- ----------------------------
INSERT INTO `level` VALUES ('1', '学历文凭', '1', '0');
INSERT INTO `level` VALUES ('2', '职业技能', '1', '3');
INSERT INTO `level` VALUES ('3', '出国留学', '1', '4');
INSERT INTO `level` VALUES ('4', '课外辅导', '1', '5');
INSERT INTO `level` VALUES ('5', '才艺专长', '1', '6');
INSERT INTO `level` VALUES ('6', '企业管理', '1', '7');
INSERT INTO `level` VALUES ('7', '测试一', '2', '1');
INSERT INTO `level` VALUES ('8', '测试二', '2', '2');

-- ----------------------------
-- Table structure for location
-- ----------------------------
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `id` bigint(20) unsigned NOT NULL,
  `parentId` bigint(20) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `pinyin` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of location
-- ----------------------------

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统日志ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作人ID',
  `module` varchar(32) NOT NULL COMMENT '日志所属模块',
  `action` varchar(32) NOT NULL COMMENT '日志所属操作类型',
  `message` text NOT NULL COMMENT '日志内容',
  `data` text COMMENT '日志数据',
  `ip` varchar(255) NOT NULL COMMENT '日志记录IP',
  `createdTime` int(10) unsigned NOT NULL COMMENT '日志发生时间',
  `level` char(10) NOT NULL COMMENT '日志等级',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=2198 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for marker
-- ----------------------------
DROP TABLE IF EXISTS `marker`;
CREATE TABLE `marker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `second` int(10) unsigned NOT NULL COMMENT '驻点时间',
  `mediaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '媒体文件ID',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='驻点';

-- ----------------------------
-- Records of marker
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '私信Id',
  `type` enum('text','image','video','audio') NOT NULL DEFAULT 'text' COMMENT '私信类型',
  `fromId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发信人Id',
  `toId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收信人Id',
  `content` text NOT NULL COMMENT '私信内容',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '私信发送时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for message_conversation
-- ----------------------------
DROP TABLE IF EXISTS `message_conversation`;
CREATE TABLE `message_conversation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '会话Id',
  `fromId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发信人Id',
  `toId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收信人Id',
  `messageNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '此对话的信息条数',
  `latestMessageUserId` int(10) unsigned DEFAULT NULL COMMENT '最后发信人ID',
  `latestMessageTime` int(10) unsigned NOT NULL COMMENT '最后发信时间',
  `latestMessageContent` text NOT NULL COMMENT '最后发信内容',
  `latestMessageType` enum('text','image','video','audio') NOT NULL DEFAULT 'text' COMMENT '最后一条私信类型',
  `unreadNum` int(10) unsigned NOT NULL COMMENT '未读数量',
  `createdTime` int(10) unsigned NOT NULL COMMENT '会话创建时间',
  PRIMARY KEY (`id`),
  KEY `toId_fromId` (`toId`,`fromId`),
  KEY `toId_latestMessageTime` (`toId`,`latestMessageTime`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_conversation
-- ----------------------------

-- ----------------------------
-- Table structure for message_relation
-- ----------------------------
DROP TABLE IF EXISTS `message_relation`;
CREATE TABLE `message_relation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '消息关联ID',
  `conversationId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联的会话ID',
  `messageId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联的消息ID',
  `isRead` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否已读',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_relation
-- ----------------------------

-- ----------------------------
-- Table structure for migration_versions
-- ----------------------------
DROP TABLE IF EXISTS `migration_versions`;
CREATE TABLE `migration_versions` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of migration_versions
-- ----------------------------

-- ----------------------------
-- Table structure for mobile_device
-- ----------------------------
DROP TABLE IF EXISTS `mobile_device`;
CREATE TABLE `mobile_device` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `imei` varchar(255) NOT NULL COMMENT '串号',
  `platform` varchar(255) NOT NULL COMMENT '平台',
  `version` varchar(255) NOT NULL COMMENT '版本',
  `screenresolution` varchar(100) NOT NULL COMMENT '分辨率',
  `kernel` varchar(255) NOT NULL COMMENT '内核',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mobile_device
-- ----------------------------

-- ----------------------------
-- Table structure for navigation
-- ----------------------------
DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '导航ID',
  `name` varchar(255) NOT NULL COMMENT '导航名称',
  `url` varchar(300) NOT NULL COMMENT '链接地址',
  `sequence` tinyint(4) unsigned NOT NULL COMMENT '显示顺序',
  `parentId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父导航ID',
  `createdTime` int(11) NOT NULL COMMENT '创建时间',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `type` varchar(30) NOT NULL COMMENT '类型',
  `isOpen` tinyint(2) NOT NULL DEFAULT '1' COMMENT '默认1，为开启',
  `isNewWin` tinyint(2) NOT NULL DEFAULT '1' COMMENT '默认为1,另开窗口',
  `orgId` int(10) unsigned DEFAULT '1',
  `orgCode` varchar(255) DEFAULT '1.' COMMENT '组织机构内部编码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='导航数据表';

-- ----------------------------
-- Records of navigation
-- ----------------------------
INSERT INTO `navigation` VALUES ('2', '课程', 'course/explore', '1', '0', '1429260383', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('8', '资讯', '/article', '7', '0', '1429778251', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('11', '全部资讯', '/article', '8', '8', '1432211413', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('12', 'BDQN', '/article/category/news', '9', '8', '1432211455', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('14', '全部课程', 'course/explore', '2', '2', '1432256445', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('15', '产品介绍', 'course/explore/intro', '3', '2', '1432256750', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('17', '行业资讯', '/article/category/news', '10', '8', '1432288695', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('18', '默认分类', '/article/category/default', '11', '8', '1432288716', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('19', '使用帮助', 'course/explore/fuction', '4', '2', '1432525802', '1481255060', 'top', '1', '0', '1', '1.');
INSERT INTO `navigation` VALUES ('24', '关于我们', '/page/aboutus', '14', '0', '1434016879', '1481255060', 'top', '1', '0', '1', '1.');

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `userId` int(10) unsigned NOT NULL COMMENT '被通知的用户ID',
  `type` varchar(64) NOT NULL DEFAULT 'default' COMMENT '通知类型',
  `content` text COMMENT '通知内容',
  `batchId` int(10) NOT NULL DEFAULT '0' COMMENT '群发通知表中的ID',
  `createdTime` int(10) unsigned NOT NULL COMMENT '通知时间',
  `isRead` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已读',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_access_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_token`;
CREATE TABLE `oauth_access_token` (
  `token` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires` datetime NOT NULL,
  `scope` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `IDX_F7FA86A419EB6921` (`client_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of oauth_access_token
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_authorization_code
-- ----------------------------
DROP TABLE IF EXISTS `oauth_authorization_code`;
CREATE TABLE `oauth_authorization_code` (
  `code` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires` datetime NOT NULL,
  `user_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_uri` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:simple_array)',
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `IDX_793B081719EB6921` (`client_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of oauth_authorization_code
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_client
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client`;
CREATE TABLE `oauth_client` (
  `client_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `client_secret` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_uri` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:simple_array)',
  `grant_types` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:simple_array)',
  `scopes` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:simple_array)',
  PRIMARY KEY (`client_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of oauth_client
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_client_public_key
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_public_key`;
CREATE TABLE `oauth_client_public_key` (
  `client_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `public_key` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE KEY `UNIQ_4D89651719EB6921` (`client_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of oauth_client_public_key
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_token`;
CREATE TABLE `oauth_refresh_token` (
  `token` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires` datetime NOT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `IDX_55DCF75519EB6921` (`client_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of oauth_refresh_token
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_scope
-- ----------------------------
DROP TABLE IF EXISTS `oauth_scope`;
CREATE TABLE `oauth_scope` (
  `scope` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`scope`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of oauth_scope
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `oauth_user`;
CREATE TABLE `oauth_user` (
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:simple_array)',
  `scopes` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:simple_array)',
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for open_course
-- ----------------------------
DROP TABLE IF EXISTS `open_course`;
CREATE TABLE `open_course` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `title` varchar(1024) NOT NULL COMMENT '课程标题',
  `subtitle` varchar(1024) NOT NULL DEFAULT '' COMMENT '课程副标题',
  `status` enum('draft','published','closed') NOT NULL DEFAULT 'draft' COMMENT '课程状态',
  `type` varchar(255) NOT NULL DEFAULT 'normal' COMMENT '课程类型',
  `lessonNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时数',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `tags` text COMMENT '标签IDs',
  `smallPicture` varchar(255) NOT NULL DEFAULT '' COMMENT '小图',
  `middlePicture` varchar(255) NOT NULL DEFAULT '' COMMENT '中图',
  `largePicture` varchar(255) NOT NULL DEFAULT '' COMMENT '大图',
  `about` text COMMENT '简介',
  `teacherIds` text COMMENT '显示的课程教师IDs',
  `studentNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学员数',
  `hitNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看次数',
  `likeNum` int(10) NOT NULL DEFAULT '0' COMMENT '点赞数',
  `postNum` int(10) NOT NULL DEFAULT '0' COMMENT '评论数',
  `userId` int(10) unsigned NOT NULL COMMENT '课程发布人ID',
  `parentId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程的父Id',
  `locked` int(10) NOT NULL DEFAULT '0' COMMENT '是否上锁1上锁,0解锁',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为推荐课程',
  `recommendedSeq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐序号',
  `recommendedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐时间',
  `createdTime` int(10) unsigned NOT NULL COMMENT '课程创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `updatedTime` (`updatedTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of open_course
-- ----------------------------

-- ----------------------------
-- Table structure for open_course_lesson
-- ----------------------------
DROP TABLE IF EXISTS `open_course_lesson`;
CREATE TABLE `open_course_lesson` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '课时ID',
  `courseId` int(10) unsigned NOT NULL COMMENT '课时所属课程ID',
  `chapterId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时所属章节ID',
  `number` int(10) unsigned NOT NULL COMMENT '课时编号',
  `seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时在课程中的序号',
  `free` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为免费课时',
  `status` enum('unpublished','published') NOT NULL DEFAULT 'published' COMMENT '课时状态',
  `title` varchar(255) NOT NULL COMMENT '课时标题',
  `summary` text COMMENT '课时摘要',
  `tags` text COMMENT '课时标签',
  `type` varchar(64) NOT NULL DEFAULT 'text' COMMENT '课时类型',
  `content` text COMMENT '课时正文',
  `giveCredit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学完课时获得的学分',
  `requireCredit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学习课时前，需达到的学分',
  `mediaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '媒体文件ID',
  `mediaSource` varchar(32) NOT NULL DEFAULT '' COMMENT '媒体文件来源(self:本站上传,youku:优酷)',
  `mediaName` varchar(255) NOT NULL DEFAULT '' COMMENT '媒体文件名称',
  `mediaUri` text COMMENT '媒体文件资源名',
  `homeworkId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '作业iD',
  `exerciseId` int(10) unsigned DEFAULT '0' COMMENT '练习ID',
  `length` int(11) unsigned DEFAULT NULL COMMENT '时长',
  `materialNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传的资料数量',
  `quizNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测验题目数量',
  `learnedNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已学的学员数',
  `viewedNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `startTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '直播课时开始时间',
  `endTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '直播课时结束时间',
  `memberNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '直播课时加入人数',
  `replayStatus` enum('ungenerated','generating','generated','videoGenerated') NOT NULL DEFAULT 'ungenerated',
  `maxOnlineNum` int(11) DEFAULT '0' COMMENT '直播在线人数峰值',
  `liveProvider` int(10) unsigned NOT NULL DEFAULT '0',
  `userId` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `createdTime` int(10) unsigned NOT NULL COMMENT '创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `copyId` int(10) NOT NULL DEFAULT '0' COMMENT '复制课时id',
  `testMode` enum('normal','realTime') DEFAULT 'normal' COMMENT '考试模式',
  `testStartTime` int(10) DEFAULT '0' COMMENT '实时考试开始时间',
  PRIMARY KEY (`id`),
  KEY `updatedTime` (`updatedTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of open_course_lesson
-- ----------------------------

-- ----------------------------
-- Table structure for open_course_member
-- ----------------------------
DROP TABLE IF EXISTS `open_course_member`;
CREATE TABLE `open_course_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '课程学员记录ID',
  `courseId` int(10) unsigned NOT NULL COMMENT '课程ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学员ID',
  `mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号码',
  `learnedNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已学课时数',
  `learnTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学习时间',
  `seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序序号',
  `isVisible` tinyint(2) NOT NULL DEFAULT '1' COMMENT '可见与否，默认为可见',
  `role` enum('student','teacher') NOT NULL DEFAULT 'student' COMMENT '课程会员角色',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `lastEnterTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上次进入时间',
  `isNotified` int(10) NOT NULL DEFAULT '0' COMMENT '直播开始通知',
  `createdTime` int(10) unsigned NOT NULL COMMENT '学员加入课程时间',
  PRIMARY KEY (`id`),
  KEY `open_course_member_ip_courseId_index` (`ip`,`courseId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of open_course_member
-- ----------------------------

-- ----------------------------
-- Table structure for open_course_recommend
-- ----------------------------
DROP TABLE IF EXISTS `open_course_recommend`;
CREATE TABLE `open_course_recommend` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `openCourseId` int(10) NOT NULL COMMENT '公开课id',
  `recommendCourseId` int(10) NOT NULL DEFAULT '0' COMMENT '推荐课程id',
  `seq` int(10) NOT NULL DEFAULT '0' COMMENT '序列',
  `type` varchar(255) NOT NULL COMMENT '类型',
  `createdTime` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `open_course_recommend_openCourseId_index` (`openCourseId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='公开课推荐课程表';

-- ----------------------------
-- Records of open_course_recommend
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `sn` varchar(32) NOT NULL COMMENT '订单编号',
  `status` enum('created','paid','refunding','refunded','cancelled') NOT NULL COMMENT '订单状态',
  `title` varchar(255) NOT NULL COMMENT '订单标题',
  `targetType` varchar(64) NOT NULL DEFAULT '' COMMENT '订单所属对象类型',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单所属对象ID',
  `amount` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单实付金额',
  `totalPrice` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单总价',
  `isGift` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为赠送礼物',
  `giftTo` varchar(64) NOT NULL DEFAULT '' COMMENT '赠送给用户ID',
  `discountId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '折扣活动ID',
  `discount` float(10,2) NOT NULL DEFAULT '10.00' COMMENT '折扣',
  `refundId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次退款操作记录的ID',
  `userId` int(10) unsigned NOT NULL COMMENT '订单创建人',
  `coupon` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠码',
  `couponDiscount` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '优惠码扣减金额',
  `payment` varchar(32) NOT NULL DEFAULT 'none' COMMENT '订单支付方式',
  `coinAmount` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '虚拟币支付额',
  `coinRate` float(10,2) NOT NULL DEFAULT '1.00' COMMENT '虚拟币汇率',
  `priceType` enum('RMB','Coin') NOT NULL DEFAULT 'RMB' COMMENT '创建订单时的标价类型',
  `bank` varchar(32) NOT NULL DEFAULT '' COMMENT '银行编号',
  `paidTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支付时间',
  `cashSn` bigint(20) DEFAULT NULL COMMENT '支付流水号',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `data` text COMMENT '订单业务数据',
  `createdTime` int(10) unsigned NOT NULL COMMENT '订单创建时间',
  `token` varchar(50) DEFAULT NULL COMMENT '令牌',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`sn`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for order_log
-- ----------------------------
DROP TABLE IF EXISTS `order_log`;
CREATE TABLE `order_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单日志ID',
  `orderId` int(10) unsigned NOT NULL COMMENT '订单ID',
  `type` varchar(32) NOT NULL COMMENT '订单日志类型',
  `message` text COMMENT '订单日志内容',
  `data` text COMMENT '订单日志数据',
  `userId` int(10) unsigned NOT NULL COMMENT '订单操作人',
  `ip` varchar(255) NOT NULL COMMENT '订单操作IP',
  `createdTime` int(10) unsigned NOT NULL COMMENT '订单日志记录时间',
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_log
-- ----------------------------

-- ----------------------------
-- Table structure for order_referer
-- ----------------------------
DROP TABLE IF EXISTS `order_referer`;
CREATE TABLE `order_referer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uv` varchar(64) NOT NULL,
  `data` text NOT NULL,
  `orderIds` text,
  `expiredTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  PRIMARY KEY (`id`),
  KEY `order_referer_uv_expiredTime_index` (`uv`,`expiredTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户访问日志Token';

-- ----------------------------
-- Records of order_referer
-- ----------------------------

-- ----------------------------
-- Table structure for order_referer_log
-- ----------------------------
DROP TABLE IF EXISTS `order_referer_log`;
CREATE TABLE `order_referer_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `refererLogId` int(11) NOT NULL COMMENT '促成订单的访问日志ID',
  `orderId` int(10) unsigned DEFAULT '0' COMMENT '订单ID',
  `sourceTargetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  `sourceTargetType` varchar(64) NOT NULL DEFAULT '' COMMENT '来源类型',
  `targetType` varchar(64) NOT NULL DEFAULT '' COMMENT '订单的对象类型',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单的对象ID',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `createdUserId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付者',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单促成日志';

-- ----------------------------
-- Records of order_referer_log
-- ----------------------------

-- ----------------------------
-- Table structure for order_refund
-- ----------------------------
DROP TABLE IF EXISTS `order_refund`;
CREATE TABLE `order_refund` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单退款记录ID',
  `orderId` int(10) unsigned NOT NULL COMMENT '退款订单ID',
  `userId` int(10) unsigned NOT NULL COMMENT '退款人ID',
  `targetType` varchar(64) NOT NULL DEFAULT '' COMMENT '订单退款记录所属对象类型',
  `targetId` int(10) unsigned NOT NULL COMMENT '订单退款记录所属对象ID',
  `status` enum('created','success','failed','cancelled') NOT NULL DEFAULT 'created' COMMENT '退款状态',
  `expectedAmount` float(10,2) unsigned DEFAULT '0.00' COMMENT '期望退款的金额，NULL代表未知，0代表不需要退款',
  `actualAmount` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际退款金额，0代表无退款',
  `reasonType` varchar(64) NOT NULL DEFAULT '' COMMENT '退款理由类型',
  `reasonNote` varchar(1024) NOT NULL DEFAULT '' COMMENT '退款理由',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单退款记录最后更新时间',
  `createdTime` int(10) unsigned NOT NULL COMMENT '订单退款记录创建时间',
  `operator` int(11) unsigned NOT NULL COMMENT '操作人',
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_refund
-- ----------------------------

-- ----------------------------
-- Table structure for org
-- ----------------------------
DROP TABLE IF EXISTS `org`;
CREATE TABLE `org` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组织机构ID',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `parentId` int(11) NOT NULL DEFAULT '0' COMMENT '组织机构父ID',
  `childrenNum` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '辖下组织机构数量',
  `depth` int(11) NOT NULL DEFAULT '1' COMMENT '当前组织机构层级',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '索引',
  `description` text COMMENT '备注',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '机构编码',
  `orgCode` varchar(255) NOT NULL DEFAULT '0' COMMENT '内部编码',
  `createdUserId` int(11) NOT NULL COMMENT '创建用户ID',
  `createdTime` int(11) unsigned NOT NULL COMMENT '创建时间',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orgCode` (`orgCode`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='组织机构';

-- ----------------------------
-- Records of org
-- ----------------------------
INSERT INTO `org` VALUES ('1', '全站', '0', '0', '1', '0', '', 'FullSite', '1.', '1', '1463555406', '0');

-- ----------------------------
-- Table structure for pay
-- ----------------------------
DROP TABLE IF EXISTS `pay`;
CREATE TABLE `pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT '0',
  `course_id` int(11) DEFAULT '0',
  `studentName` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '学生姓名',
  `courseCost` decimal(10,2) DEFAULT '0.00' COMMENT '课程费用',
  `payment` int(10) DEFAULT '0' COMMENT '交费方式(1,线下缴费;2.线上全额缴费;3.预交部分定金)',
  `paidInCost` decimal(10,2) DEFAULT '0.00' COMMENT '实缴费用',
  `backFee` decimal(10,2) DEFAULT '0.00' COMMENT '补缴费用',
  `status` int(10) DEFAULT '0' COMMENT '状态(0,默认没报到,1.确认报到)',
  `createDate` int(10) DEFAULT '0' COMMENT '创建时间',
  `smsContent` varchar(50) CHARACTER SET utf8 DEFAULT '000000' COMMENT '短信验证码',
  `payID` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '订单号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of pay
-- ----------------------------

-- ----------------------------
-- Table structure for pay_log
-- ----------------------------
DROP TABLE IF EXISTS `pay_log`;
CREATE TABLE `pay_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(10) DEFAULT '0',
  `user_id` int(10) DEFAULT NULL,
  `pay_id` int(11) DEFAULT NULL,
  `createDate` int(10) DEFAULT '0',
  `school_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of pay_log
-- ----------------------------

-- ----------------------------
-- Table structure for personal_custom
-- ----------------------------
DROP TABLE IF EXISTS `personal_custom`;
CREATE TABLE `personal_custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '姓名',
  `intention` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '想学意向',
  `phone` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '联系方式',
  `city_id` int(11) DEFAULT '0' COMMENT '所在城市ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of personal_custom
-- ----------------------------

-- ----------------------------
-- Table structure for province
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of province
-- ----------------------------
INSERT INTO `province` VALUES ('1', '北京市');
INSERT INTO `province` VALUES ('2', '天津市');
INSERT INTO `province` VALUES ('3', '上海市');
INSERT INTO `province` VALUES ('4', '重庆市');
INSERT INTO `province` VALUES ('5', '河北省');
INSERT INTO `province` VALUES ('6', '山西省');
INSERT INTO `province` VALUES ('7', '台湾省');
INSERT INTO `province` VALUES ('8', '辽宁省');
INSERT INTO `province` VALUES ('9', '吉林省');
INSERT INTO `province` VALUES ('10', '黑龙江省');
INSERT INTO `province` VALUES ('11', '江苏省');
INSERT INTO `province` VALUES ('12', '浙江省');
INSERT INTO `province` VALUES ('13', '安徽省');
INSERT INTO `province` VALUES ('14', '福建省');
INSERT INTO `province` VALUES ('15', '江西省');
INSERT INTO `province` VALUES ('16', '山东省');
INSERT INTO `province` VALUES ('17', '河南省');
INSERT INTO `province` VALUES ('18', '湖北省');
INSERT INTO `province` VALUES ('19', '湖南省');
INSERT INTO `province` VALUES ('20', '广东省');
INSERT INTO `province` VALUES ('21', '甘肃省');
INSERT INTO `province` VALUES ('22', '四川省');
INSERT INTO `province` VALUES ('23', '贵州省');
INSERT INTO `province` VALUES ('24', '海南省');
INSERT INTO `province` VALUES ('25', '云南省');
INSERT INTO `province` VALUES ('26', '青海省');
INSERT INTO `province` VALUES ('27', '陕西省');
INSERT INTO `province` VALUES ('28', '广西壮族自治区');
INSERT INTO `province` VALUES ('29', '西藏自治区');
INSERT INTO `province` VALUES ('30', '宁夏回族自治区');
INSERT INTO `province` VALUES ('31', '新疆维吾尔自治区');
INSERT INTO `province` VALUES ('32', '内蒙古自治区');
INSERT INTO `province` VALUES ('33', '澳门特别行政区');
INSERT INTO `province` VALUES ('34', '香港特别行政区');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '题目ID',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT '题目类型',
  `stem` text COMMENT '题干',
  `score` float(10,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '分数',
  `answer` text COMMENT '参考答案',
  `analysis` text COMMENT '解析',
  `metas` text COMMENT '题目元信息',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '类别',
  `difficulty` varchar(64) NOT NULL DEFAULT 'normal' COMMENT '难度',
  `target` varchar(255) NOT NULL DEFAULT '' COMMENT '从属于',
  `parentId` int(10) unsigned DEFAULT '0' COMMENT '材料父ID',
  `subCount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子题数量',
  `finishedTimes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '完成次数',
  `passedTimes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '成功次数',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `copyId` int(10) NOT NULL DEFAULT '0' COMMENT '复制问题对应Id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='问题表';

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for question_category
-- ----------------------------
DROP TABLE IF EXISTS `question_category`;
CREATE TABLE `question_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '题目类别ID',
  `name` varchar(255) NOT NULL COMMENT '类别名称',
  `target` varchar(255) NOT NULL DEFAULT '' COMMENT '从属于',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作用户',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序序号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='题库类别表';

-- ----------------------------
-- Records of question_category
-- ----------------------------

-- ----------------------------
-- Table structure for question_favorite
-- ----------------------------
DROP TABLE IF EXISTS `question_favorite`;
CREATE TABLE `question_favorite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '题目收藏ID',
  `questionId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被收藏的题目ID',
  `target` varchar(255) NOT NULL DEFAULT '' COMMENT '题目所属对象',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏人ID',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for question_marker
-- ----------------------------
DROP TABLE IF EXISTS `question_marker`;
CREATE TABLE `question_marker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `markerId` int(10) unsigned NOT NULL COMMENT '驻点Id',
  `questionId` int(10) unsigned NOT NULL COMMENT '问题Id',
  `seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT '题目类型',
  `stem` text COMMENT '题干',
  `answer` text COMMENT '参考答案',
  `analysis` text COMMENT '解析',
  `metas` text COMMENT '题目元信息',
  `difficulty` varchar(64) NOT NULL DEFAULT 'normal' COMMENT '难度',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='弹题';

-- ----------------------------
-- Records of question_marker
-- ----------------------------

-- ----------------------------
-- Table structure for question_marker_result
-- ----------------------------
DROP TABLE IF EXISTS `question_marker_result`;
CREATE TABLE `question_marker_result` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `markerId` int(10) unsigned NOT NULL COMMENT '驻点Id',
  `questionMarkerId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '弹题ID',
  `lessonId` int(10) unsigned NOT NULL DEFAULT '0',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '做题人ID',
  `status` enum('none','right','partRight','wrong','noAnswer') NOT NULL DEFAULT 'none' COMMENT '结果状态',
  `answer` text,
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question_marker_result
-- ----------------------------

-- ----------------------------
-- Table structure for recent_post_num
-- ----------------------------
DROP TABLE IF EXISTS `recent_post_num`;
CREATE TABLE `recent_post_num` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ip` varchar(20) NOT NULL COMMENT 'IP',
  `type` varchar(255) NOT NULL COMMENT '类型',
  `num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'post次数',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次更新时间',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='黑名单表';

-- ----------------------------
-- Records of recent_post_num
-- ----------------------------

-- ----------------------------
-- Table structure for referer_log
-- ----------------------------
DROP TABLE IF EXISTS `referer_log`;
CREATE TABLE `referer_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `targetId` varchar(64) DEFAULT NULL COMMENT '模块ID',
  `targetType` varchar(64) NOT NULL COMMENT '模块类型',
  `targetInnerType` varchar(64) DEFAULT NULL COMMENT '模块自身的类型',
  `refererUrl` varchar(1024) DEFAULT '' COMMENT '访问来源Url',
  `refererHost` varchar(1024) DEFAULT '' COMMENT '访问来源Url',
  `refererName` varchar(64) DEFAULT '' COMMENT '访问来源站点名称',
  `orderCount` int(10) unsigned DEFAULT '0' COMMENT '促成订单数',
  `ip` varchar(64) DEFAULT NULL COMMENT '访问者IP',
  `userAgent` text COMMENT '浏览器的标识',
  `uri` varchar(1024) DEFAULT '' COMMENT '访问Url',
  `createdUserId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问者',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='模块(课程|班级|公开课|...)的访问来源日志';

-- ----------------------------
-- Records of referer_log
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '权限名称',
  `code` varchar(32) NOT NULL COMMENT '权限代码',
  `data` text COMMENT '权限配置',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `createdUserId` int(10) unsigned NOT NULL COMMENT '创建用户ID',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '学员', 'ROLE_USER', '[]', '1474873824', '1', '0');
INSERT INTO `role` VALUES ('2', '教师', 'ROLE_TEACHER', '[\"web\",\"course_manage\",\"course_manage_info\",\"course_manage_base\",\"course_manage_detail\",\"course_manage_picture\",\"course_manage_lesson\",\"live_course_manage_replay\",\"course_manage_files\",\"course_manage_setting\",\"course_manage_price\",\"course_manage_teachers\",\"course_manage_students\",\"course_manage_student_create\",\"course_manage_questions\",\"course_manage_question\",\"course_manage_testpaper\",\"course_manange_operate\",\"course_manage_data\",\"course_manage_order\",\"classroom_manage\",\"classroom_manage_settings\",\"classroom_manage_set_info\",\"classroom_manage_set_price\",\"classroom_manage_set_picture\",\"classroom_manage_service\",\"classroom_manage_headteacher\",\"classroom_manage_teachers\",\"classroom_manage_assistants\",\"classroom_manage_content\",\"classroom_manage_courses\",\"classroom_manage_students\",\"classroom_manage_testpaper\"]', '1474873824', '1', '0');
INSERT INTO `role` VALUES ('3', '管理员', 'ROLE_ADMIN', '[\"admin\",\"admin_user\",\"admin_user_show\",\"admin_user_manage\",\"admin_user_create\",\"admin_user_edit\",\"admin_user_roles\",\"admin_user_send_passwordreset_email\",\"admin_user_send_emailverify_email\",\"admin_user_lock\",\"admin_user_unlock\",\"admin_user_org_update\",\"admin_login_record\",\"admin_teacher\",\"admin_teacher_manage\",\"admin_teacher_promote\",\"admin_teacher_promote_cancel\",\"admin_teacher_promote_list\",\"admin_approval_manage\",\"admin_approval_approvals\",\"admin_approval_cancel\",\"admin_message_manage\",\"admin_message\",\"admin_course\",\"admin_course_show\",\"admin_course_manage\",\"admin_course_content_manage\",\"admin_course_add\",\"admin_course_recommend\",\"admin_course_cancel_recommend\",\"admin_course_copy\",\"admin_course_guest_member_preview\",\"admin_course_member_preview\",\"admin_course_close\",\"admin_course_sms_prepare\",\"admin_course_publish\",\"admin_course_delete\",\"admin_course_recommend_list\",\"admin_course_data\",\"admin_open_course_manage\",\"admin_open_course\",\"admin_open_course_recommend_list\",\"admin_opencourse_analysis\",\"admin_live_course\",\"admin_live_course_manage\",\"admin_course_thread\",\"admin_course_thread_manage\",\"admin_classroom_thread_manage\",\"admin_course_question\",\"admin_course_question_manage\",\"admin_course_note\",\"admin_course_note_manage\",\"admin_course_review\",\"admin_course_review_tab\",\"admin_classroom_review_tab\",\"admin_course_category\",\"admin_course_category_manage\",\"admin_category_create\",\"admin_course_tag\",\"admin_course_tag_manage\",\"admin_course_tag_add\",\"admin_classroom\",\"admin_classroom_manage\",\"admin_classroom_content_manage\",\"admin_classroom_create\",\"admin_classroom_cancel_recommend\",\"admin_classroom_set_recommend\",\"admin_classroom_close\",\"admin_sms_prepare\",\"admin_classroom_open\",\"admin_classroom_delete\",\"admin_classroom_recommend\",\"admin_operation\",\"admin_operation_article\",\"admin_operation_article_manage\",\"admin_operation_article_create\",\"admin_operation_article_category\",\"admin_operation_category_create\",\"admin_operation_group\",\"admin_operation_group_manage\",\"admin_operation_group_create\",\"admin_operation_group_thread\",\"admin_operation_invite\",\"admin_operation_invite_manage\",\"admin_operation_invite_coupon\",\"admin_announcement\",\"admin_announcement_manage\",\"admin_announcement_create\",\"admin_operation_notification\",\"admin_batch_notification\",\"admin_batch_notification_create\",\"admin_block_manage\",\"admin_block\",\"admin_block_visual_edit\",\"admin_operation_content\",\"admin_content\",\"admin_operation_mobile\",\"admin_operation_mobile_banner_manage\",\"admin_operation_mobile_select_manage\",\"admin_discovery_column_index\",\"admin_discovery_column_create\",\"admin_operation_analysis_register\",\"admin_operation_analysis\",\"admin_operation_keyword\",\"admin_keyword\",\"admin_keyword_create\",\"admin_keyword_banlogs\",\"admin_order\",\"admin_course_order_manage\",\"admin_course_order\",\"admin_coin_order_manange\",\"admin_coin_orders\",\"admin_classroom_order_manage\",\"admin_classroom_order\",\"admin_finance\",\"admin_bills\",\"admin_bill\",\"admin_coin_records\",\"admin_coin_user\",\"admin_coin_user_records\",\"admin_course_refunds\",\"admin_course_refunds_manage\",\"admin_classroom_refunds\",\"admin_classroom_refunds_manage\",\"admin_app\",\"admin_app_im\",\"admin_app_im_setting\",\"admin_app_center_show\",\"admin_app_center\",\"admin_app_installed\",\"admin_app_upgrades\",\"admin_app_logs\",\"admin_cloud_attachment_manage\",\"admin_cloud_attachment\",\"admin_cloud_file_manage\",\"admin_cloud_file\",\"web\",\"course_manage\",\"course_manage_info\",\"course_manage_base\",\"course_manage_detail\",\"course_manage_picture\",\"course_manage_lesson\",\"live_course_manage_replay\",\"course_manage_files\",\"course_manage_setting\",\"course_manage_price\",\"course_manage_teachers\",\"course_manage_students\",\"course_manage_student_create\",\"course_manage_questions\",\"course_manage_question\",\"course_manage_testpaper\",\"course_manange_operate\",\"course_manage_data\",\"course_manage_order\",\"classroom_manage\",\"classroom_manage_settings\",\"classroom_manage_set_info\",\"classroom_manage_set_price\",\"classroom_manage_set_picture\",\"classroom_manage_service\",\"classroom_manage_headteacher\",\"classroom_manage_teachers\",\"classroom_manage_assistants\",\"classroom_manage_content\",\"classroom_manage_courses\",\"classroom_manage_students\",\"classroom_manage_testpaper\"]', '1474873824', '1', '0');
INSERT INTO `role` VALUES ('4', '超级管理员', 'ROLE_SUPER_ADMIN', '[\"admin\",\"admin_user\",\"admin_user_show\",\"admin_user_manage\",\"admin_user_create\",\"admin_user_edit\",\"admin_user_roles\",\"admin_user_avatar\",\"admin_user_change_password\",\"admin_user_send_passwordreset_email\",\"admin_user_send_emailverify_email\",\"admin_user_lock\",\"admin_user_unlock\",\"admin_user_org_update\",\"admin_login_record\",\"admin_teacher\",\"admin_teacher_manage\",\"admin_teacher_promote\",\"admin_teacher_promote_cancel\",\"admin_teacher_promote_list\",\"admin_approval_manage\",\"admin_approval_approvals\",\"admin_approval_cancel\",\"admin_message_manage\",\"admin_message\",\"admin_course\",\"admin_course_show\",\"admin_course_manage\",\"admin_course_content_manage\",\"admin_course_add\",\"admin_course_recommend\",\"admin_course_cancel_recommend\",\"admin_course_copy\",\"admin_course_guest_member_preview\",\"admin_course_member_preview\",\"admin_course_close\",\"admin_course_sms_prepare\",\"admin_course_publish\",\"admin_course_delete\",\"admin_course_recommend_list\",\"admin_course_data\",\"admin_open_course_manage\",\"admin_open_course\",\"admin_open_course_recommend_list\",\"admin_opencourse_analysis\",\"admin_live_course\",\"admin_live_course_manage\",\"admin_course_thread\",\"admin_course_thread_manage\",\"admin_classroom_thread_manage\",\"admin_course_question\",\"admin_course_question_manage\",\"admin_course_note\",\"admin_course_note_manage\",\"admin_course_review\",\"admin_course_review_tab\",\"admin_classroom_review_tab\",\"admin_course_category\",\"admin_course_category_manage\",\"admin_category_create\",\"admin_course_tag\",\"admin_course_tag_manage\",\"admin_course_tag_add\",\"admin_classroom\",\"admin_classroom_manage\",\"admin_classroom_content_manage\",\"admin_classroom_create\",\"admin_classroom_cancel_recommend\",\"admin_classroom_set_recommend\",\"admin_classroom_close\",\"admin_sms_prepare\",\"admin_classroom_open\",\"admin_classroom_delete\",\"admin_classroom_recommend\",\"admin_operation\",\"admin_operation_article\",\"admin_operation_article_manage\",\"admin_operation_article_create\",\"admin_operation_article_category\",\"admin_operation_category_create\",\"admin_operation_group\",\"admin_operation_group_manage\",\"admin_operation_group_create\",\"admin_operation_group_thread\",\"admin_operation_invite\",\"admin_operation_invite_manage\",\"admin_operation_invite_coupon\",\"admin_announcement\",\"admin_announcement_manage\",\"admin_announcement_create\",\"admin_operation_notification\",\"admin_batch_notification\",\"admin_batch_notification_create\",\"admin_block_manage\",\"admin_block\",\"admin_block_visual_edit\",\"admin_operation_content\",\"admin_content\",\"admin_operation_mobile\",\"admin_operation_mobile_banner_manage\",\"admin_operation_mobile_select_manage\",\"admin_discovery_column_index\",\"admin_discovery_column_create\",\"admin_operation_analysis_register\",\"admin_operation_analysis\",\"admin_operation_keyword\",\"admin_keyword\",\"admin_keyword_create\",\"admin_keyword_banlogs\",\"admin_order\",\"admin_course_order_manage\",\"admin_course_order\",\"admin_coin_order_manange\",\"admin_coin_orders\",\"admin_classroom_order_manage\",\"admin_classroom_order\",\"admin_finance\",\"admin_bills\",\"admin_bill\",\"admin_coin_records\",\"admin_coin_user\",\"admin_coin_user_records\",\"admin_course_refunds\",\"admin_course_refunds_manage\",\"admin_classroom_refunds\",\"admin_classroom_refunds_manage\",\"admin_app\",\"admin_my_cloud\",\"admin_my_cloud_overview\",\"admin_cloud_video_setting\",\"admin_setting_cloud_video\",\"admin_edu_cloud_sms\",\"admin_edu_cloud_sms_setting\",\"admin_edu_cloud_search_setting\",\"admin_edu_cloud_search\",\"admin_app_im\",\"admin_app_im_setting\",\"admin_setting_cloud_attachment\",\"admin_edu_cloud_attachment\",\"admin_app_center_show\",\"admin_app_center\",\"admin_app_installed\",\"admin_app_upgrades\",\"admin_app_logs\",\"admin_cloud_attachment_manage\",\"admin_cloud_attachment\",\"admin_setting_cloud\",\"admin_setting_my_cloud\",\"admin_cloud_file_manage\",\"admin_cloud_file\",\"admin_system\",\"admin_setting\",\"admin_setting_message\",\"admin_setting_theme\",\"admin_setting_mailer\",\"admin_top_navigation\",\"admin_foot_navigation\",\"admin_friendlyLink_navigation\",\"admin_setting_consult_setting\",\"admin_setting_es_bar\",\"admin_setting_share\",\"admin_setting_user\",\"admin_user_auth\",\"admin_setting_login_bind\",\"admin_setting_user_center\",\"admin_setting_user_fields\",\"admin_setting_avatar\",\"admin_setting_course_setting\",\"admin_setting_course\",\"admin_setting_live_course\",\"admin_setting_questions_setting\",\"admin_setting_course_avatar\",\"admin_classroom_setting\",\"admin_setting_operation\",\"admin_article_setting\",\"admin_group_set\",\"admin_invite_set\",\"admin_setting_finance\",\"admin_payment\",\"admin_coin_settings\",\"admin_setting_refund\",\"admin_setting_mobile\",\"admin_setting_mobile_settings\",\"admin_optimize\",\"admin_optimize_settings\",\"admin_jobs\",\"admin_jobs_manage\",\"admin_setting_ip_blacklist\",\"admin_setting_ip_blacklist_manage\",\"admin_setting_post_num_rules\",\"admin_setting_post_num_rules_settings\",\"admin_report_status\",\"admin_report_status_list\",\"admin_logs\",\"admin_logs_query\",\"admin_logs_prod\",\"admin_org_manage\",\"admin_org\",\"admin_roles\",\"admin_role_manage\",\"admin_role_create\",\"admin_role_edit\",\"admin_role_delete\",\"web\",\"course_manage\",\"course_manage_info\",\"course_manage_base\",\"course_manage_detail\",\"course_manage_picture\",\"course_manage_lesson\",\"live_course_manage_replay\",\"course_manage_files\",\"course_manage_setting\",\"course_manage_price\",\"course_manage_teachers\",\"course_manage_students\",\"course_manage_student_create\",\"course_manage_questions\",\"course_manage_question\",\"course_manage_testpaper\",\"course_manange_operate\",\"course_manage_data\",\"course_manage_order\",\"classroom_manage\",\"classroom_manage_settings\",\"classroom_manage_set_info\",\"classroom_manage_set_price\",\"classroom_manage_set_picture\",\"classroom_manage_service\",\"classroom_manage_headteacher\",\"classroom_manage_teachers\",\"classroom_manage_assistants\",\"classroom_manage_content\",\"classroom_manage_courses\",\"classroom_manage_students\",\"classroom_manage_testpaper\"]', '1474873824', '1', '0');
INSERT INTO `role` VALUES ('5', '学校系统管理员', 'ROLE_SCHOOL_ADMIN', '[\"admin\",\"newadmin\",\"newadmin_whole\",\"newadmin_whole_show\",\"newadmin_whole_manage\",\"newadmin_whole_roles\",\"newadmin_site_setting\",\"newadmin_team_manager\",\"newadmin_pay_platform\",\"newadmin_student\",\"newadmin_enroll_message\",\"newadmin_customization_manager\",\"newadmin_audition_manager\",\"newadmin_leaveSchool_manager\",\"newadmin_forSchool_manager\",\"newadmin_school\",\"newadmin_registersc_manager\",\"newadmin_authentication_manager\",\"newadmin_coursesc_manager\",\"newadmin_articlesc_manager\",\"newadmin_statistics\",\"newadmin_enrollstat_statistics\",\"newadmin_auditionstat_statistics\",\"newadmin_customizationstat_statistics\",\"newadmin_leaveSchoolstat_statistics\",\"newadmin_forSchoolstat_statistics\"]', '1486516548', '1', '1491883483');
INSERT INTO `role` VALUES ('8', '培训机构招生老师', 'ROLE_TRAINRECRUIT', '[\"newadmin\",\"newadmin_student\",\"newadmin_enroll_message\",\"newadmin_statistics\",\"newadmin_enrollstat_statistics\"]', '1491883640', '1', '0');
INSERT INTO `role` VALUES ('6', '学校招生老师', 'ROLE_SCHOOLRECRUIT', '[\"newadmin\",\"newadmin_student\",\"newadmin_enroll_message\",\"newadmin_statistics\",\"newadmin_enrollstat_statistics\"]', '1487033152', '1', '0');
INSERT INTO `role` VALUES ('7', '培训机构管理员', 'ROLE_TRAIN_ADMIN', '[\"newadmin\",\"newadmin_whole\",\"newadmin_whole_show\",\"newadmin_whole_manage\",\"newadmin_whole_roles\",\"newadmin_site_setting\",\"newadmin_team_manager\",\"newadmin_pay_platform\",\"newadmin_student\",\"newadmin_enroll_message\",\"newadmin_customization_manager\",\"newadmin_audition_manager\",\"newadmin_leaveSchool_manager\",\"newadmin_forSchool_manager\",\"newadmin_school\",\"newadmin_registersc_manager\",\"newadmin_authentication_manager\",\"newadmin_coursesc_manager\",\"newadmin_articlesc_manager\",\"newadmin_statistics\",\"newadmin_schoolst_statistics\",\"newadmin_enrollstat_statistics\",\"newadmin_auditionstat_statistics\",\"newadmin_customizationstat_statistics\",\"newadmin_leaveSchoolstat_statistics\",\"newadmin_forSchoolstat_statistics\"]', '1491882834', '1', '1491883526');

-- ----------------------------
-- Table structure for schools
-- ----------------------------
DROP TABLE IF EXISTS `schools`;
CREATE TABLE `schools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chineseName` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '中文名',
  `englishName` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '英文名',
  `abbreviation` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '简称',
  `type` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '类别',
  `startTime` int(10) DEFAULT '0' COMMENT '创办时间',
  `schoolAddress` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '学校地址',
  `campusHumanities` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '校园人文',
  `campusAmorousFeelings` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '校园风情',
  `smallPicture` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '小图片',
  `middlePicture` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '中图',
  `largePicture` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '大图片',
  `province_id` int(11) DEFAULT '1' COMMENT '省份ID',
  `city_id` int(11) DEFAULT '1' COMMENT '城市ID',
  `status` int(11) DEFAULT '1' COMMENT '状态(0,可见;1,不可见)',
  `institutionsType` int(11) DEFAULT '0' COMMENT '机构类型(0,学校;1,培训机构)',
  `createTime` int(10) DEFAULT '0' COMMENT '学校添加时间',
  `updateTime` int(10) DEFAULT '0' COMMENT '学校最后更新时间',
  `logo` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '学校Logo',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '学校网址',
  `userId` int(11) DEFAULT '0',
  `weight` int(10) DEFAULT '0' COMMENT '权重',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of schools
-- ----------------------------

-- ----------------------------
-- Table structure for school_authentication
-- ----------------------------
DROP TABLE IF EXISTS `school_authentication`;
CREATE TABLE `school_authentication` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '认证ID',
  `school_id` int(11) DEFAULT '0' COMMENT '学校或培训机构ID',
  `registerCertificate` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '民办非企业登记证书',
  `licenseForSchool` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '办学许可证',
  `permitOrProject` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '收费许可证或收费项目公示',
  `annuaInspection` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '年检合格证',
  `approvalForm` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '招生计划审批表',
  `specialProfessional` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '特种专业开办许可证',
  `businessLicense` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '营业执照',
  `type` int(10) DEFAULT '0' COMMENT '类型(0,学校;1,培训机构)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of school_authentication
-- ----------------------------

-- ----------------------------
-- Table structure for session
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `session_id` varchar(255) NOT NULL,
  `session_value` text NOT NULL,
  `session_time` int(11) NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of session
-- ----------------------------

-- ----------------------------
-- Table structure for session2
-- ----------------------------
DROP TABLE IF EXISTS `session2`;
CREATE TABLE `session2` (
  `session_id` varchar(255) NOT NULL,
  `session_value` text NOT NULL,
  `session_time` int(11) NOT NULL,
  `user_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of session2
-- ----------------------------

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `sess_id` varbinary(128) NOT NULL,
  `sess_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sess_data` blob NOT NULL,
  `sess_time` int(10) unsigned NOT NULL,
  `sess_lifetime` mediumint(9) NOT NULL,
  PRIMARY KEY (`sess_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sessions
-- ----------------------------

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统设置ID',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '系统设置名',
  `value` longblob COMMENT '系统设置值',
  `namespace` varchar(255) NOT NULL DEFAULT 'default',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`namespace`)
) ENGINE=MyISAM AUTO_INCREMENT=931 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of setting
-- ----------------------------
INSERT INTO `setting` VALUES ('61', 'menu_hiddens', 0x613A303A7B7D, 'default');
INSERT INTO `setting` VALUES ('68', 'payment', 0x613A383A7B733A373A22656E61626C6564223B733A313A2231223B733A31363A2264697361626C65645F6D657373616765223B733A34383A22E5B09AE69CAAE5BC80E590AFE694AFE4BB98E6A8A1E59D97EFBC8CE697A0E6B395E8B4ADE4B9B0E8AFBEE7A88BE38082223B733A31343A22616C697061795F656E61626C6564223B733A313A2230223B733A31313A22616C697061795F74797065223B733A363A22646972656374223B733A31303A22616C697061795F6B6579223B733A303A22223B733A31333A22616C697061795F736563726574223B733A303A22223B733A31343A22616C697061795F6163636F756E74223B733A303A22223B733A31393A22636C6F73655F74726164655F656E61626C6564223B733A313A2230223B7D, 'default');
INSERT INTO `setting` VALUES ('86', 'group', 0x613A323A7B733A31303A2267726F75705F73686F77223B733A313A2231223B733A31363A2274687265616454696D655F72616E6765223B733A323A223330223B7D, 'default');
INSERT INTO `setting` VALUES ('891', 'classroom', 0x613A323A7B733A343A226E616D65223B733A363A22E5ADA6E6A0A1223B733A31323A22646973636F756E745F627579223B733A313A2231223B7D, 'default');
INSERT INTO `setting` VALUES ('264', 'article', 0x613A323A7B733A343A226E616D65223B733A31323A22E8B584E8AEAFE9A291E98193223B733A383A22706167654E756D73223B733A323A223130223B7D, 'default');
INSERT INTO `setting` VALUES ('580', 'esBar', 0x613A313A7B733A373A22656E61626C6564223B733A313A2231223B7D, 'default');
INSERT INTO `setting` VALUES ('632', 'questions', 0x613A313A7B733A32373A227465737470617065725F616E73776572735F73686F775F6D6F6465223B733A393A227375626D6974746564223B7D, 'default');
INSERT INTO `setting` VALUES ('886', 'mailer', 0x613A383A7B733A373A22656E61626C6564223B733A313A2230223B733A343A22686F7374223B733A31383A22736D74702E65786D61696C2E71712E636F6D223B733A343A22706F7274223B733A323A223235223B733A383A22757365726E616D65223B733A31373A22782E77616E67406B6D6264716E2E636F6D223B733A383A2270617373776F7264223B733A303A22223B733A343A2266726F6D223B733A31373A22782E77616E67406B6D6264716E2E636F6D223B733A343A226E616D65223B733A31323A22E7BD91E7BB9CE8AFBEE5A082223B733A32303A22656D61696C2D73657474696E672D737461747573223B733A303A22223B7D, 'default');
INSERT INTO `setting` VALUES ('653', 'user_default', 0x613A313A7B733A393A22757365725F6E616D65223B733A363A22E5ADA6E59198223B7D, 'default');
INSERT INTO `setting` VALUES ('655', 'auth', 0x613A31393A7B733A31333A2272656769737465725F6D6F6465223B733A353A22656D61696C223B733A31333A22656D61696C5F656E61626C6564223B733A363A22636C6F736564223B733A31323A2273657474696E675F74696D65223B693A313432393737383731303B733A32323A22656D61696C5F61637469766174696F6E5F7469746C65223B733A33333A22E8AFB7E6BF80E6B4BBE682A8E79A847B7B736974656E616D657D7DE8B4A6E58FB7223B733A32313A22656D61696C5F61637469766174696F6E5F626F6479223B733A3338303A2248692C207B7B6E69636B6E616D657D7D0D0A0D0AE6ACA2E8BF8EE58AA0E585A57B7B736974656E616D657D7D210D0A0D0AE8AFB7E782B9E587BBE4B88BE99DA2E79A84E993BEE68EA5E5AE8CE68890E6B3A8E5868CEFBC9A0D0A0D0A7B7B76657269667975726C7D7D0D0A0D0AE5A682E69E9CE4BBA5E4B88AE993BEE68EA5E697A0E6B395E782B9E587BBEFBC8CE8AFB7E5B086E4B88AE99DA2E79A84E59CB0E59D80E5A48DE588B6E588B0E4BDA0E79A84E6B58FE8A788E599A828E5A682494529E79A84E59CB0E59D80E6A08FE4B8ADE68993E5BC80EFBC8CE8AFA5E993BEE68EA5E59CB0E59D803234E5B08FE697B6E58685E68993E5BC80E69C89E69588E380820D0A0D0AE6849FE8B0A2E5AFB97B7B736974656E616D657D7DE79A84E694AFE68C81EFBC810D0A0D0A7B7B736974656E616D657D7D207B7B7369746575726C7D7D0D0A0D0A28E8BF99E698AFE4B880E5B081E887AAE58AA8E4BAA7E7949FE79A84656D61696CEFBC8CE8AFB7E58BBFE59B9EE5A48DE3808229223B733A31353A2277656C636F6D655F656E61626C6564223B733A363A226F70656E6564223B733A31343A2277656C636F6D655F73656E646572223B733A353A2261646D696E223B733A31353A2277656C636F6D655F6D6574686F6473223B613A303A7B7D733A31333A2277656C636F6D655F7469746C65223B733A32343A22E6ACA2E8BF8EE58AA0E585A57B7B736974656E616D657D7D223B733A31323A2277656C636F6D655F626F6479223B733A3133383A22E682A8E5A5BD7B7B6E69636B6E616D657D7DEFBC8CE68891E698AF7B7B736974656E616D657D7DE79A84E7AEA1E79086E59198EFBC8CE6ACA2E8BF8EE58AA0E585A57B7B736974656E616D657D7DEFBC8CE7A59DE682A8E5ADA6E4B9A0E68489E5BFABE38082E5A682E69C89E997AEE9A298EFBC8CE99A8FE697B6E4B88EE68891E88194E7B3BBE38082223B733A31303A22757365725F7465726D73223B733A363A226F70656E6564223B733A31353A22757365725F7465726D735F626F6479223B733A39303A223C703EE58FAFE59CA8E38090E7B3BBE7BB9FE38091EFBC8DE38090E794A8E688B7E8AEBEE7BDAEE38091EFBC8DE38090E6B3A8E5868CE38091E4B8ADE4BFAEE694B9E69C8DE58AA1E69DA1E4BBB6E8AEBEE7BDAE3C2F703E0D0A223B733A31353A22636170746368615F656E61626C6564223B693A313B733A31393A2272656769737465725F70726F74656374697665223B733A333A226C6F77223B733A31363A226E69636B6E616D655F656E61626C6564223B693A303B733A31323A226176617461725F616C657274223B733A343A226E6F6E65223B733A31323A227265676973746572536F7274223B613A313A7B693A303B733A353A22656D61696C223B7D733A32323A2272656769737465724669656C644E616D654172726179223B613A373A7B693A303B733A353A22656D61696C223B693A343B733A383A22747275656E616D65223B693A353B733A363A226D6F62696C65223B693A363B733A363A22696463617264223B693A373B733A363A2267656E646572223B693A383B733A333A226A6F62223B693A393B733A373A22636F6D70616E79223B7D733A31303A225F636C6F75645F736D73223B733A303A22223B7D, 'default');
INSERT INTO `setting` VALUES ('656', 'login_bind', 0x613A32363A7B733A31313A226C6F67696E5F6C696D6974223B733A313A2231223B733A373A22656E61626C6564223B733A313A2230223B733A32323A2274656D706F726172795F6C6F636B5F656E61626C6564223B733A313A2231223B733A32383A2274656D706F726172795F6C6F636B5F616C6C6F7765645F74696D6573223B733A313A2235223B733A33313A2269705F74656D706F726172795F6C6F636B5F616C6C6F7765645F74696D6573223B733A323A223230223B733A32323A2274656D706F726172795F6C6F636B5F6D696E75746573223B733A323A223230223B733A31333A22776569626F5F656E61626C6564223B733A313A2230223B733A393A22776569626F5F6B6579223B733A303A22223B733A31323A22776569626F5F736563726574223B733A303A22223B733A32323A22776569626F5F7365745F66696C6C5F6163636F756E74223B733A313A2230223B733A31303A2271715F656E61626C6564223B733A313A2230223B733A363A2271715F6B6579223B733A303A22223B733A393A2271715F736563726574223B733A303A22223B733A31393A2271715F7365745F66696C6C5F6163636F756E74223B733A313A2230223B733A31343A2272656E72656E5F656E61626C6564223B733A313A2230223B733A31303A2272656E72656E5F6B6579223B733A303A22223B733A31333A2272656E72656E5F736563726574223B733A303A22223B733A32333A2272656E72656E5F7365745F66696C6C5F6163636F756E74223B733A313A2230223B733A31373A2277656978696E7765625F656E61626C6564223B733A313A2230223B733A31333A2277656978696E7765625F6B6579223B733A303A22223B733A31363A2277656978696E7765625F736563726574223B733A303A22223B733A32363A2277656978696E7765625F7365745F66696C6C5F6163636F756E74223B733A313A2230223B733A31373A2277656978696E6D6F625F656E61626C6564223B733A313A2230223B733A31333A2277656978696E6D6F625F6B6579223B733A303A22223B733A31363A2277656978696E6D6F625F736563726574223B733A303A22223B733A31313A227665726966795F636F6465223B733A303A22223B7D, 'default');
INSERT INTO `setting` VALUES ('662', 'operation_course_grids', 0x613A313A7B733A393A22636F75727365496473223B733A383A22312C32302C33302C223B7D, 'default');
INSERT INTO `setting` VALUES ('664', 'theme', 0x613A383A7B733A343A22636F6465223B733A363A226A69616E6D6F223B733A343A226E616D65223B733A363A22E7AE80E5A2A8223B733A363A22617574686F72223B733A31333A22456475536F686FE5AE98E696B9223B733A373A2276657273696F6E223B733A353A22312E302E30223B733A31353A2273757070726F745F76657273696F6E223B733A363A22362E302E302B223B733A343A2264617465223B733A383A22323031352D362D31223B733A353A227468756D62223B733A31333A22696D672F7468656D652E6A7067223B733A333A22757269223B733A363A226A69616E6D6F223B7D, 'default');
INSERT INTO `setting` VALUES ('676', 'operation_mobile', 0x613A32303A7B733A31323A2262616E6E6572436C69636B31223B733A313A2231223B733A31303A2262616E6E657255726C31223B733A32333A22687474703A2F2F7777772E716971697579752E636F6D2F223B733A32313A2262616E6E65724A756D70546F436F75727365496431223B733A313A2220223B733A373A2262616E6E657231223B733A37363A22687474703A2F2F656475736F686F2D64656D6F2E62302E7570616979756E2E636F6D2F66696C65732F73797374656D2F6D6F62696C655F70696374757265313434313532373239362E706E67223B733A31323A2262616E6E6572436C69636B32223B733A313A2230223B733A31303A2262616E6E657255726C32223B733A303A22223B733A32313A2262616E6E65724A756D70546F436F75727365496432223B733A313A2220223B733A373A2262616E6E657232223B733A303A22223B733A31323A2262616E6E6572436C69636B33223B733A313A2230223B733A31303A2262616E6E657255726C33223B733A303A22223B733A32313A2262616E6E65724A756D70546F436F75727365496433223B733A313A2220223B733A373A2262616E6E657233223B733A303A22223B733A31323A2262616E6E6572436C69636B34223B733A313A2230223B733A31303A2262616E6E657255726C34223B733A303A22223B733A32313A2262616E6E65724A756D70546F436F75727365496434223B733A313A2220223B733A373A2262616E6E657234223B733A303A22223B733A31323A2262616E6E6572436C69636B35223B733A313A2230223B733A31303A2262616E6E657255726C35223B733A303A22223B733A32313A2262616E6E65724A756D70546F436F75727365496435223B733A313A2220223B733A373A2262616E6E657235223B733A303A22223B7D, 'default');
INSERT INTO `setting` VALUES ('677', 'mobile', 0x613A32303A7B733A31323A2262616E6E6572436C69636B31223B733A313A2231223B733A31303A2262616E6E657255726C31223B733A32333A22687474703A2F2F7777772E716971697579752E636F6D2F223B733A32313A2262616E6E65724A756D70546F436F75727365496431223B733A313A2220223B733A373A2262616E6E657231223B733A37363A22687474703A2F2F656475736F686F2D64656D6F2E62302E7570616979756E2E636F6D2F66696C65732F73797374656D2F6D6F62696C655F70696374757265313434313532373239362E706E67223B733A31323A2262616E6E6572436C69636B32223B733A313A2230223B733A31303A2262616E6E657255726C32223B733A303A22223B733A32313A2262616E6E65724A756D70546F436F75727365496432223B733A313A2220223B733A373A2262616E6E657232223B733A303A22223B733A31323A2262616E6E6572436C69636B33223B733A313A2230223B733A31303A2262616E6E657255726C33223B733A303A22223B733A32313A2262616E6E65724A756D70546F436F75727365496433223B733A313A2220223B733A373A2262616E6E657233223B733A303A22223B733A31323A2262616E6E6572436C69636B34223B733A313A2230223B733A31303A2262616E6E657255726C34223B733A303A22223B733A32313A2262616E6E65724A756D70546F436F75727365496434223B733A313A2220223B733A373A2262616E6E657234223B733A303A22223B733A31323A2262616E6E6572436C69636B35223B733A313A2230223B733A31303A2262616E6E657255726C35223B733A303A22223B733A32313A2262616E6E65724A756D70546F436F75727365496435223B733A313A2220223B733A373A2262616E6E657235223B733A303A22223B7D, 'default');
INSERT INTO `setting` VALUES ('688', 'refund', 0x613A343A7B733A31333A226D6178526566756E6444617973223B693A31303B733A31373A226170706C794E6F74696669636174696F6E223B733A3130373A22E682A8E5A5BDEFBC8CE682A8E98080E6ACBEE79A847B7B6974656D7D7DEFBC8CE7AEA1E79086E59198E5B7B2E694B6E588B0E682A8E79A84E98080E6ACBEE794B3E8AFB7EFBC8CE8AFB7E88090E5BF83E7AD89E5BE85E98080E6ACBEE5AEA1E6A0B8E7BB93E69E9CE38082223B733A31393A22737563636573734E6F74696669636174696F6E223B733A38323A22E682A8E5A5BDEFBC8CE682A8E794B3E8AFB7E98080E6ACBEE79A847B7B6974656D7D7D20E5AEA1E6A0B8E9809AE8BF87EFBC8CE5B086E4B8BAE682A8E98080E6ACBE7B7B616D6F756E747D7DE58583E38082223B733A31383A226661696C65644E6F74696669636174696F6E223B733A39333A22E682A8E5A5BDEFBC8CE682A8E794B3E8AFB7E98080E6ACBEE79A847B7B6974656D7D7D20E5AEA1E6A0B8E69CAAE9809AE8BF87EFBC8CE8AFB7E4B88EE7AEA1E79086E59198E5868DE58D8FE59586E8A7A3E586B3E7BAA0E7BAB7E38082223B7D, 'default');
INSERT INTO `setting` VALUES ('693', 'post_num_rules', 0x613A313A7B733A353A2272756C6573223B613A323A7B733A363A22746872656164223B613A313A7B733A31343A22666976654D756E69746552756C65223B613A323A7B733A383A22696E74657276616C223B693A3330303B733A373A22706F73744E756D223B693A3130303B7D7D733A31373A227468726561644C6F67696E656455736572223B613A313A7B733A31343A22666976654D756E69746552756C65223B613A323A7B733A383A22696E74657276616C223B693A3330303B733A373A22706F73744E756D223B693A35303B7D7D7D7D, 'default');
INSERT INTO `setting` VALUES ('918', 'site', 0x613A31343A7B733A343A226E616D65223B733A31323A22E5908CE8A880E59CA8E7BABF223B733A363A22736C6F67616E223B733A34323A22E59CA8E7BABFE69599E882B2E5ADA6E4B9A0E58A9FE883BDE5AE8CE5A487E79A84E7BD91E6A0A1EFBC81223B733A333A2275726C223B733A303A22223B733A343A2266696C65223B733A303A22223B733A343A226C6F676F223B733A34363A2266696C65732F73797374656D2F323031372F30312D31382F3039323035353735383161663537353930392E6A7067223B733A373A2266617669636F6E223B733A34363A2266696C65732F73797374656D2F323031362F31322D30312F3039333631316232353832663437323531372E6A7067223B733A31323A2273656F5F6B6579776F726473223B733A32353A22E59CA8E7BABFE69599E882B22CE59CA8E7BABFE69599E5ADA6223B733A31353A2273656F5F6465736372697074696F6E223B733A303A22223B733A31323A226D61737465725F656D61696C223B733A303A22223B733A393A22636F70797269676874223B733A303A22223B733A333A22696370223B733A303A22223B733A393A22616E616C7974696373223B733A303A22223B733A363A22737461747573223B733A343A226F70656E223B733A31313A22636C6F7365645F6E6F7465223B733A303A22223B7D, 'default');
INSERT INTO `setting` VALUES ('883', 'consult', 0x613A393A7B733A373A22656E61626C6564223B733A313A2231223B733A353A22636F6C6F72223B733A373A2264656661756C74223B733A323A227171223B613A313A7B693A303B613A333A7B733A343A226E616D65223B733A393A22E5AEA2E69C8DE4B880223B733A363A226E756D626572223B733A393A22313233343536373839223B733A333A2275726C223B733A38313A22687474703A2F2F7770612E622E71712E636F6D2F6367692F7770612E7068703F6C6E3D31266B65793D587A67774D4441794D7A67324D46387A4E7A45774D7A46664F4441774D44497A4F445977587A4A66223B7D7D733A373A22717167726F7570223B613A313A7B693A303B613A333A7B733A343A226E616D65223B733A393A22E5AE98E696B9E7BEA4223B733A363A226E756D626572223B733A31313A223133313233313233313233223B733A333A2275726C223B733A3233343A223C61207461726765743D225F626C616E6B2220687265663D22687474703A2F2F7777772E71712E636F6D2F7770612F71756E7770613F69646B65793D66626434336439356135643165626330626263613962303739386330663665646135353363386664376631356631666564636566396163663634326439653330223E3C696D6720626F726465723D223022207372633D22687474703A2F2F7075622E69647171696D672E636F6D2F7770612F696D616765732F67726F75702E706E672220616C743D22E5AE98E696B93131E7BEA422207469746C653D22E5AE98E696B93131E7BEA4223E3C2F613E223B7D7D733A383A22776F726B74696D65223B733A31323A22393A3030202D2031383A3030223B733A353A2270686F6E65223B613A333A7B693A303B613A323A7B733A343A226E616D65223B733A32373A22585858E7BD91E7BB9CE7A791E68A80E69C89E99990E585ACE58FB8223B733A363A226E756D626572223B733A31333A22303837312D3238303232333536223B7D693A313B613A323A7B733A343A226E616D65223B733A32373A22585858E7BD91E7BB9CE7A791E68A80E69C89E99990E585ACE58FB8223B733A363A226E756D626572223B733A31333A22303837312D3238303232333537223B7D693A323B613A323A7B733A343A226E616D65223B733A32343A22585858E7BD91E7BB9CE58C97E4BAACE58886E585ACE58FB8223B733A363A226E756D626572223B733A31313A223138383134383831393939223B7D7D733A343A2266696C65223B733A303A22223B733A31303A2277656263686174555249223B733A303A22223B733A353A22656D61696C223B733A31383A2231323332343332353433354051512E636F6D223B7D, 'default');
INSERT INTO `setting` VALUES ('751', 'course_default', 0x613A323A7B733A31323A22636861707465725F6E616D65223B733A333A22E7ABA0223B733A393A22706172745F6E616D65223B733A333A22E88A82223B7D, 'default');
INSERT INTO `setting` VALUES ('752', 'default', 0x613A333A7B733A393A22757365725F6E616D65223B733A363A22E5ADA6E59198223B733A31323A22636861707465725F6E616D65223B733A333A22E7ABA0223B733A393A22706172745F6E616D65223B733A333A22E88A82223B7D, 'default');
INSERT INTO `setting` VALUES ('930', 'live-course', 0x613A323A7B733A31393A226C6976655F636F757273655F656E61626C6564223B733A313A2231223B733A32313A226C6976655F73747564656E745F6361706163697479223B693A303B7D, 'default');
INSERT INTO `setting` VALUES ('929', 'course', 0x613A32323A7B733A32333A2277656C636F6D655F6D6573736167655F656E61626C6564223B733A313A2231223B733A32303A2277656C636F6D655F6D6573736167655F626F6479223B733A34313A227B7B6E69636B6E616D657D7D2CE6ACA2E8BF8EE58AA0E585A5E8AFBEE7A88B7B7B636F757273657D7D223B733A32303A22746561636865725F6D6F646966795F7072696365223B733A313A2231223B733A32303A22746561636865725F7365617263685F6F72646572223B733A313A2231223B733A32323A22746561636865725F6D616E6167655F73747564656E74223B733A313A2231223B733A32323A22746561636865725F6578706F72745F73747564656E74223B733A313A2231223B733A32323A2273747564656E745F646F776E6C6F61645F6D65646961223B733A313A2230223B733A32333A226578706C6F72655F64656661756C745F6F726465724279223B733A363A226C6174657374223B733A32343A22667265655F636F757273655F6E6F6C6F67696E5F76696577223B733A313A2231223B733A31343A2272656C61746564436F7572736573223B733A313A2231223B733A31323A22636F75727365735072696365223B733A313A2230223B733A32313A22616C6C6F77416E6F6E796D6F757350726576696577223B733A313A2231223B733A31323A22636F70795F656E61626C6564223B733A313A2230223B733A32313A22746573747061706572436F70795F656E61626C6564223B733A313A2230223B733A32323A22637573746F6D5F636861707465725F656E61626C6564223B733A313A2231223B733A32343A2273686F775F73747564656E745F6E756D5F656E61626C6564223B733A313A2231223B733A31323A22636861707465725F6E616D65223B733A333A22E7ABA0223B733A393A22706172745F6E616D65223B733A333A22E88A82223B733A31343A2275736572696E666F4669656C6473223B613A303A7B7D733A32323A2275736572696E666F4669656C644E616D654172726179223B613A303A7B7D733A31393A226C6976655F636F757273655F656E61626C6564223B733A313A2231223B733A32313A226C6976655F73747564656E745F6361706163697479223B693A303B7D, 'default');
INSERT INTO `setting` VALUES ('760', 'invite', 0x613A313A7B733A31383A226765745F636F75706F6E5F73657474696E67223B693A313B7D, 'default');
INSERT INTO `setting` VALUES ('765', 'user_partner', 0x613A343A7B733A343A226D6F6465223B733A373A2264656661756C74223B733A31363A226E69636B6E616D655F656E61626C6564223B733A313A2231223B733A31323A226176617461725F616C657274223B733A353A22636C6F7365223B733A31323A22656D61696C5F66696C746572223B733A303A22223B7D, 'default');
INSERT INTO `setting` VALUES ('766', 'magic', 0x613A333A7B733A31383A226578706F72745F616C6C6F775F636F756E74223B693A3130303030303B733A31323A226578706F72745F6C696D6974223B693A31303030303B733A31303A22656E61626C655F6F7267223B693A303B7D, 'default');
INSERT INTO `setting` VALUES ('803', 'cloud_sms', 0x613A313A7B733A31333A2273797374656D5F72656D696E64223B733A323A226F6E223B7D, 'default');
INSERT INTO `setting` VALUES ('859', 'storage', 0x613A31373A7B733A31313A2275706C6F61645F6D6F6465223B733A353A226C6F63616C223B733A31323A22636C6F75645F6275636B6574223B733A303A22223B733A31333A22766964656F5F7175616C697479223B733A333A226C6F77223B733A31393A22766964656F5F617564696F5F7175616C697479223B733A333A226C6F77223B733A31353A22766964656F5F77617465726D61726B223B733A313A2230223B733A32313A22766964656F5F77617465726D61726B5F696D616765223B733A303A22223B733A32373A22766964656F5F656D6265645F77617465726D61726B5F696D616765223B733A303A22223B733A32343A22766964656F5F77617465726D61726B5F706F736974696F6E223B733A383A22746F707269676874223B733A31373A22766964656F5F66696E6765727072696E74223B733A313A2230223B733A31323A22766964656F5F686561646572223B4E3B733A31363A22636C6F75645F6170695F736572766572223B733A32323A22687474703A2F2F6170692E656475736F686F2E6E6574223B733A32303A22636C6F75645F6170695F7475695F736572766572223B733A303A22223B733A32323A22636C6F75645F6170695F6576656E745F736572766572223B733A303A22223B733A32313A22656E61626C655F706C61796261636B5F7261746573223B693A303B733A31363A22636C6F75645F6163636573735F6B6579223B733A33323A2239573442377756396934464C6339346C775938664163706C63614E6943384E4D223B733A31363A22636C6F75645F7365637265745F6B6579223B733A33323A2235526E636F6A6D476E32727A6277564976335935666E727378654B396E785773223B733A31373A22636C6F75645F6B65795F6170706C696564223B693A313B7D, 'default');
INSERT INTO `setting` VALUES ('916', '_app_last_check', 0x693A313438343030393138393B, 'default');
INSERT INTO `setting` VALUES ('856', 'developer', 0x613A383A7B733A353A226465627567223B693A303B733A31313A226170705F6170695F75726C223B733A303A22223B733A31363A22636C6F75645F6170695F736572766572223B733A32323A22687474703A2F2F6170692E656475736F686F2E6E6574223B733A32303A22636C6F75645F6170695F7475695F736572766572223B733A303A22223B733A32323A22636C6F75645F6170695F6576656E745F736572766572223B733A303A22223B733A31333A22636C6F75645F73646B5F63646E223B733A303A22223B733A31333A22686C735F656E63727970746564223B733A313A2231223B733A31353A22776974686F75745F6E6574776F726B223B733A313A2230223B7D, 'default');
INSERT INTO `setting` VALUES ('857', 'crontab_next_executed_time', 0x693A313437373336363531303B, 'default');
INSERT INTO `setting` VALUES ('877', 'cloud_search', 0x613A323A7B733A31343A227365617263685F656E61626C6564223B693A303B733A363A22737461747573223B733A363A22636C6F736564223B7D, 'default');
INSERT INTO `setting` VALUES ('878', 'app_im', 0x613A323A7B733A373A22656E61626C6564223B693A303B733A363A22636F6E764E6F223B733A303A22223B7D, 'default');

-- ----------------------------
-- Table structure for shortcut
-- ----------------------------
DROP TABLE IF EXISTS `shortcut`;
CREATE TABLE `shortcut` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shortcut
-- ----------------------------

-- ----------------------------
-- Table structure for sign_card
-- ----------------------------
DROP TABLE IF EXISTS `sign_card`;
CREATE TABLE `sign_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `cardNum` int(10) unsigned NOT NULL DEFAULT '0',
  `useTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sign_card
-- ----------------------------

-- ----------------------------
-- Table structure for sign_target_statistics
-- ----------------------------
DROP TABLE IF EXISTS `sign_target_statistics`;
CREATE TABLE `sign_target_statistics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统id',
  `targetType` varchar(255) NOT NULL DEFAULT '' COMMENT '签到目标类型',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签到目标id',
  `signedNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签到人数',
  `date` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '统计日期',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sign_target_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for sign_user_log
-- ----------------------------
DROP TABLE IF EXISTS `sign_user_log`;
CREATE TABLE `sign_user_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统id',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `targetType` varchar(255) NOT NULL DEFAULT '' COMMENT '签到目标类型',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签到目标id',
  `rank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签到排名',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签到时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sign_user_log
-- ----------------------------

-- ----------------------------
-- Table structure for sign_user_statistics
-- ----------------------------
DROP TABLE IF EXISTS `sign_user_statistics`;
CREATE TABLE `sign_user_statistics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统id',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `targetType` varchar(255) NOT NULL DEFAULT '' COMMENT '签到目标类型',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签到目标id',
  `keepDays` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '连续签到天数',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sign_user_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for status
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL COMMENT '动态发布的人',
  `courseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程Id',
  `classroomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '班级id',
  `type` varchar(64) NOT NULL COMMENT '动态类型',
  `objectType` varchar(64) NOT NULL DEFAULT '' COMMENT '动态对象的类型',
  `objectId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态对象ID',
  `message` text NOT NULL COMMENT '动态的消息体',
  `properties` text NOT NULL COMMENT '动态的属性',
  `commentNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `likeNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被赞的数量',
  `private` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态发布时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `createdTime` (`createdTime`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of status
-- ----------------------------

-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '学生姓名',
  `nation` varchar(10) CHARACTER SET utf8 DEFAULT '' COMMENT '民族',
  `birthday` int(10) DEFAULT '0' COMMENT '出生日期',
  `height` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '身高',
  `weight` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '体重',
  `phone` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '联系方式',
  `IDcards` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '身份证号',
  `graduateSchool` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '毕业学校',
  `admissionTickerNum` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '准考证号码',
  `graduationTestScore` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '毕业考试分数',
  `address` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '家庭住址',
  `guardianName` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '监护人姓名',
  `guardianPhone` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '监护人联系方式',
  `reportedSchool` int(10) DEFAULT '0' COMMENT '所报学校',
  `reportedCourse` int(10) DEFAULT '0' COMMENT '所报课程',
  `status` int(10) DEFAULT '0' COMMENT '状态(0,可见;1,不可见)',
  `school_id` int(11) DEFAULT '0' COMMENT '学校ID',
  `createTime` int(10) DEFAULT '0' COMMENT '创建时间',
  `updateTime` int(10) DEFAULT '0' COMMENT '更新时间',
  `userId` int(10) DEFAULT '0',
  `courseId` int(10) DEFAULT '0',
  `recommendTeacher` int(10) DEFAULT '0' COMMENT '推荐老师',
  `flag` int(10) DEFAULT '0' COMMENT '标识(0,默认正常;1,退学;2.换校)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of students
-- ----------------------------

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name` varchar(64) NOT NULL COMMENT '标签名称',
  `createdTime` int(10) unsigned NOT NULL COMMENT '标签创建时间',
  `orgId` int(10) unsigned DEFAULT '1',
  `orgCode` varchar(255) DEFAULT '1.' COMMENT '组织机构内部编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('1', '默认标签', '1429260383', '1', '1.');
INSERT INTO `tag` VALUES ('2', '系统设置', '1429270352', '1', '1.');
INSERT INTO `tag` VALUES ('3', '课程', '1429270360', '1', '1.');
INSERT INTO `tag` VALUES ('4', '题库', '1429270366', '1', '1.');
INSERT INTO `tag` VALUES ('5', '教育云', '1429270378', '1', '1.');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '任务标题',
  `description` text COMMENT '任务描述',
  `meta` text COMMENT '任务元信息',
  `userId` int(10) NOT NULL DEFAULT '0',
  `taskType` varchar(100) NOT NULL COMMENT '任务类型',
  `batchId` int(10) NOT NULL DEFAULT '0' COMMENT '批次Id',
  `targetId` int(10) NOT NULL DEFAULT '0' COMMENT '类型id,可以是课时id,作业id等',
  `targetType` varchar(100) DEFAULT NULL COMMENT '类型,可以是课时,作业等',
  `taskStartTime` int(10) NOT NULL DEFAULT '0' COMMENT '任务开始时间',
  `taskEndTime` int(10) NOT NULL DEFAULT '0' COMMENT '任务结束时间',
  `intervalDate` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '历时天数',
  `status` enum('active','completed') NOT NULL DEFAULT 'active',
  `required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为必做任务,0否,1是',
  `completedTime` int(10) NOT NULL DEFAULT '0' COMMENT '任务完成时间',
  `createdTime` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------

-- ----------------------------
-- Table structure for testpaper
-- ----------------------------
DROP TABLE IF EXISTS `testpaper`;
CREATE TABLE `testpaper` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '试卷ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷名称',
  `description` text COMMENT '试卷说明',
  `limitedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '限时(单位：秒)',
  `pattern` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷生成/显示模式',
  `target` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷所属对象',
  `status` varchar(32) NOT NULL DEFAULT 'draft' COMMENT '试卷状态：draft,open,closed',
  `score` float(10,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '总分',
  `passedScore` float(10,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '通过考试的分数线',
  `itemCount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目数量',
  `createdUserId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatedUserId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改人',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `metas` text COMMENT '题型排序',
  `copyId` int(10) NOT NULL DEFAULT '0' COMMENT '复制试卷对应Id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of testpaper
-- ----------------------------

-- ----------------------------
-- Table structure for testpaper_item
-- ----------------------------
DROP TABLE IF EXISTS `testpaper_item`;
CREATE TABLE `testpaper_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '试卷条目ID',
  `testId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属试卷',
  `seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目顺序',
  `questionId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `questionType` varchar(64) NOT NULL DEFAULT '' COMMENT '题目类别',
  `parentId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父题ID',
  `score` float(10,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '分值',
  `missScore` float(10,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '漏选得分',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of testpaper_item
-- ----------------------------

-- ----------------------------
-- Table structure for testpaper_item_result
-- ----------------------------
DROP TABLE IF EXISTS `testpaper_item_result`;
CREATE TABLE `testpaper_item_result` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '试卷题目做题结果ID',
  `itemId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '试卷条目ID',
  `testId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '试卷ID',
  `testPaperResultId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '试卷结果ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '做题人ID',
  `questionId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `status` enum('none','right','partRight','wrong','noAnswer') NOT NULL DEFAULT 'none' COMMENT '结果状态',
  `score` float(10,1) NOT NULL DEFAULT '0.0' COMMENT '得分',
  `answer` text COMMENT '回答',
  `teacherSay` text COMMENT '老师评价',
  `pId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '复制试卷题目Id',
  PRIMARY KEY (`id`),
  KEY `testPaperResultId` (`testPaperResultId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of testpaper_item_result
-- ----------------------------

-- ----------------------------
-- Table structure for testpaper_result
-- ----------------------------
DROP TABLE IF EXISTS `testpaper_result`;
CREATE TABLE `testpaper_result` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '试卷结果ID',
  `paperName` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷名称',
  `testId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '试卷ID',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '做卷人ID',
  `score` float(10,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '总分',
  `objectiveScore` float(10,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '主观题得分',
  `subjectiveScore` float(10,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '客观题得分',
  `teacherSay` text COMMENT '老师评价',
  `rightItemCount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '正确题目数',
  `passedStatus` enum('none','excellent','good','passed','unpassed') NOT NULL DEFAULT 'none' COMMENT '考试通过状态，none表示该考试没有',
  `limitedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '试卷限制时间(秒)',
  `beginTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `endTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` enum('doing','paused','reviewing','finished') NOT NULL COMMENT '状态',
  `target` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷结果所属对象',
  `checkTeacherId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '批卷老师ID',
  `checkedTime` int(11) NOT NULL DEFAULT '0' COMMENT '批卷时间',
  `usedTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of testpaper_result
-- ----------------------------

-- ----------------------------
-- Table structure for theme_config
-- ----------------------------
DROP TABLE IF EXISTS `theme_config`;
CREATE TABLE `theme_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `config` text,
  `confirmConfig` text,
  `allConfig` text,
  `updatedTime` int(11) NOT NULL DEFAULT '0',
  `createdTime` int(11) NOT NULL DEFAULT '0',
  `updatedUserId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of theme_config
-- ----------------------------
INSERT INTO `theme_config` VALUES ('1', '简墨', '{\r\n    \"maincolor\": \"default\",\r\n    \"navigationcolor\": \"default\",\r\n    \"blocks\": {\r\n        \"left\": [\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"12\",\r\n                \"orderBy\": \"latest\",\r\n                \"categoryId\": 0,\r\n                \"code\": \"course-grid-with-condition-index\",\r\n                \"categoryCount\": \"4\",\r\n                \"defaultTitle\": \"网校课程\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"精选网校课程，满足你的学习兴趣。\",\r\n                \"id\": \"latestCourse\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"4\",\r\n                \"code\": \"recommend-classroom\",\r\n                \"defaultTitle\": \"推荐班级\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"班级化学习体系，给你更多的课程相关服务。\",\r\n                \"id\": \"RecommendClassrooms\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"6\",\r\n                \"code\": \"groups\",\r\n                \"defaultTitle\": \"动态\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"参与小组，结交更多同学，关注课程\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"4\",\r\n                \"categoryId\": \"\",\r\n                \"code\": \"recommend-teacher\",\r\n                \"defaultTitle\": \"推荐教师\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"名师汇集，保证教学质量与学习效果。\",\r\n                \"id\": \"RecommendTeachers\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"\",\r\n                \"code\": \"footer-link\",\r\n                \"defaultTitle\": \"底部链接\",\r\n                \"id\": \"footerLink\"\r\n            }\r\n        ]\r\n    },\r\n    \"bottom\": \"simple\"\r\n}', '{\"maincolor\":\"default\",\"navigationcolor\":\"default\",\"blocks\":{\"left\":[{\"title\":\"\",\"count\":\"12\",\"orderBy\":\"latest\",\"categoryId\":0,\"code\":\"course-grid-with-condition-index\",\"categoryCount\":\"4\",\"defaultTitle\":\"\\u7f51\\u6821\\u8bfe\\u7a0b\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u7cbe\\u9009\\u7f51\\u6821\\u8bfe\\u7a0b\\uff0c\\u6ee1\\u8db3\\u4f60\\u7684\\u5b66\\u4e60\\u5174\\u8da3\\u3002\",\"id\":\"latestCourse\"},{\"title\":\"\",\"count\":\"4\",\"categoryId\":\"\",\"code\":\"live-course\",\"defaultTitle\":\"\\u8fd1\\u671f\\u76f4\\u64ad\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u5b9e\\u65f6\\u8ddf\\u8e2a\\u76f4\\u64ad\\u8bfe\\u7a0b\\uff0c\\u907f\\u514d\\u8bfe\\u7a0b\\u9057\\u6f0f\\u3002\",\"id\":\"RecentLiveCourses\"},{\"title\":\"\",\"count\":\"\",\"code\":\"middle-banner\",\"defaultTitle\":\"\\u4e2d\\u90e8banner\",\"id\":\"middle-banner\"},{\"title\":\"\",\"count\":\"4\",\"code\":\"recommend-classroom\",\"defaultTitle\":\"\\u63a8\\u8350\\u73ed\\u7ea7\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u73ed\\u7ea7\\u5316\\u5b66\\u4e60\\u4f53\\u7cfb\\uff0c\\u7ed9\\u4f60\\u66f4\\u591a\\u7684\\u8bfe\\u7a0b\\u76f8\\u5173\\u670d\\u52a1\\u3002\",\"id\":\"RecommendClassrooms\"},{\"title\":\"\",\"count\":\"6\",\"code\":\"groups\",\"defaultTitle\":\"\\u52a8\\u6001\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u53c2\\u4e0e\\u5c0f\\u7ec4\\uff0c\\u7ed3\\u4ea4\\u66f4\\u591a\\u540c\\u5b66\\uff0c\\u5173\\u6ce8\\u8bfe\\u7a0b\\u52a8\\u6001\\u3002\",\"select1\":\"checked\",\"select2\":\"checked\",\"select3\":\"\",\"select4\":\"\",\"id\":\"hotGroups\"},{\"title\":\"\",\"count\":\"4\",\"categoryId\":\"\",\"code\":\"recommend-teacher\",\"defaultTitle\":\"\\u63a8\\u8350\\u6559\\u5e08\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u540d\\u5e08\\u6c47\\u96c6\\uff0c\\u4fdd\\u8bc1\\u6559\\u5b66\\u8d28\\u91cf\\u4e0e\\u5b66\\u4e60\\u6548\\u679c\\u3002\",\"id\":\"RecommendTeachers\"},{\"title\":\"\",\"count\":\"\",\"code\":\"footer-link\",\"defaultTitle\":\"\\u5e95\\u90e8\\u94fe\\u63a5\",\"id\":\"footerLink\"}]},\"bottom\":\"simple\"}', null, '1483927766', '1449218369', '1');
INSERT INTO `theme_config` VALUES ('4', '留做备份的', '{\r\n    \"maincolor\": \"default\",\r\n    \"navigationcolor\": \"default\",\r\n    \"blocks\": {\r\n        \"left\": [\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"12\",\r\n                \"orderBy\": \"latest\",\r\n                \"categoryId\": 0,\r\n                \"code\": \"course-grid-with-condition-index\",\r\n                \"categoryCount\": \"4\",\r\n                \"defaultTitle\": \"网校课程\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"精选网校课程，满足你的学习兴趣。\",\r\n                \"id\": \"latestCourse\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"4\",\r\n                \"categoryId\": \"\",\r\n                \"code\": \"live-course\",\r\n                \"defaultTitle\": \"近期直播\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"实时跟踪直播课程，避免课程遗漏。\",\r\n                \"id\": \"RecentLiveCourses\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"\",\r\n                \"code\": \"middle-banner\",\r\n                \"defaultTitle\": \"中部banner\",\r\n                \"id\": \"middle-banner\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"4\",\r\n                \"code\": \"recommend-classroom\",\r\n                \"defaultTitle\": \"推荐班级\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"班级化学习体系，给你更多的课程相关服务。\",\r\n                \"id\": \"RecommendClassrooms\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"6\",\r\n                \"code\": \"groups\",\r\n                \"defaultTitle\": \"动态\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"参与小组，结交更多同学，关注课程\"\r\n            }\r\n        ]\r\n    }\r\n}', null, null, '0', '0', '0');
INSERT INTO `theme_config` VALUES ('2', '老的原', '{\r\n    \"maincolor\": \"default\",\r\n    \"navigationcolor\": \"default\",\r\n    \"blocks\": {\r\n        \"left\": [\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"12\",\r\n                \"orderBy\": \"latest\",\r\n                \"categoryId\": 0,\r\n                \"code\": \"wx-course-grid-with-condition-index\",\r\n                \"categoryCount\": \"4\",\r\n                \"defaultTitle\": \"网校课程\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"精选网校课程，满足你的学习兴趣。\",\r\n                \"id\": \"latestCourse\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"6\",\r\n                \"code\": \"groups\",\r\n                \"defaultTitle\": \"动态\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"参与小组，结交更多同学，关注课程动态。\",\r\n                \"select1\": \"checked\",\r\n                \"select2\": \"checked\",\r\n                \"select3\": \"\",\r\n                \"select4\": \"\",\r\n                \"id\": \"hotGroups\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"4\",\r\n                \"categoryId\": \"\",\r\n                \"code\": \"recommend-teacher\",\r\n                \"defaultTitle\": \"推荐教师\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"名师汇集，保证教学质量与学习效果。\",\r\n                \"id\": \"RecommendTeachers\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"\",\r\n                \"code\": \"footer-link\",\r\n                \"defaultTitle\": \"底部链接\",\r\n                \"id\": \"footerLink\"\r\n            }\r\n        ]\r\n    },\r\n    \"bottom\": \"simple\"\r\n}', '},{\"title\":\"\",\"count\":\"6\",\"code\":\"groups\",\"defaultTitle\":\"\\u52a8\\u6001\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u53c2\\u4e0e\\u5c0f\\u7ec4\\uff0c\\u7ed3\\u4ea4\\u66f4\\u591a\\u540c\\u5b66\\uff0c\\u5173\\u6ce8\\u8bfe\\u7a0b\\u52a8\\u6001\\u3002\",\"select1\":\"checked\",\"select2\":\"checked\",\"select3\":\"\",\"select4\":\"\",\"id\":\"hotGroups\"},{\"title\":\"\",\"count\":\"4\",\"categoryId\":\"\",\"code\":\"recommend-teacher\",\"defaultTitle\":\"\\u63a8\\u8350\\u6559\\u5e08\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u540d\\u5e08\\u6c47\\u96c6\\uff0c\\u4fdd\\u8bc1\\u6559\\u5b66\\u8d28\\u91cf\\u4e0e\\u5b66\\u4e60\\u6548\\u679c\\u3002\",\"id\":\"RecommendTeachers\"},{\"title\":\"\",\"count\":\"\",\"code\":\"footer-link\",\"defaultTitle\":\"\\u5e95\\u90e8\\u94fe\\u63a5\",\"id\":\"footerLink\"}]},\"bottom\":\"simple\"}', null, '1481697624', '1449218369', '1');
INSERT INTO `theme_config` VALUES ('3', ' 4月改的学校首页', '{\r\n    \"maincolor\": \"default\",\r\n    \"navigationcolor\": \"default\",\r\n    \"blocks\": {\r\n        \"left\": [\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"12\",\r\n                \"orderBy\": \"latest\",\r\n                \"categoryId\": 0,\r\n                \"code\": \"course-grid-with-condition-index\",\r\n                \"categoryCount\": \"4\",\r\n                \"defaultTitle\": \"网校课程\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"精选网校课程，满足你的学习兴趣。\",\r\n                \"id\": \"latestCourse\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"\",\r\n                \"code\": \"middle-banner\",\r\n                \"defaultTitle\": \"u4e2du90e8banner\",\r\n                \"id\": \"middle-banner\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"4\",\r\n                \"categoryId\": \"\",\r\n                \"code\": \"recommend-teacher\",\r\n                \"defaultTitle\": \"推荐教师\",\r\n                \"subTitle\": \"\",\r\n                \"defaultSubTitle\": \"名师汇集，保证教学质量与学习效果。\",\r\n                \"id\": \"RecommendTeachers\"\r\n            },\r\n            {\r\n                \"title\": \"\",\r\n                \"count\": \"\",\r\n                \"code\": \"footer-link\",\r\n                \"defaultTitle\": \"底部链接\",\r\n                \"id\": \"footerLink\"\r\n            }\r\n        ]\r\n    },\r\n    \"bottom\": \"simple\"\r\n}', '{\"maincolor\":\"default\",\"navigationcolor\":\"default\",\"blocks\":{\"left\":[{\"title\":\"\",\"count\":\"12\",\"orderBy\":\"latest\",\"categoryId\":0,\"code\":\"course-grid-with-condition-index\",\"categoryCount\":\"4\",\"defaultTitle\":\"\\u7f51\\u6821\\u8bfe\\u7a0b\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u7cbe\\u9009\\u7f51\\u6821\\u8bfe\\u7a0b\\uff0c\\u6ee1\\u8db3\\u4f60\\u7684\\u5b66\\u4e60\\u5174\\u8da3\\u3002\",\"id\":\"latestCourse\"},{\"title\":\"\",\"count\":\"4\",\"categoryId\":\"\",\"code\":\"live-course\",\"defaultTitle\":\"\\u8fd1\\u671f\\u76f4\\u64ad\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u5b9e\\u65f6\\u8ddf\\u8e2a\\u76f4\\u64ad\\u8bfe\\u7a0b\\uff0c\\u907f\\u514d\\u8bfe\\u7a0b\\u9057\\u6f0f\\u3002\",\"id\":\"RecentLiveCourses\"},{\"title\":\"\",\"count\":\"\",\"code\":\"middle-banner\",\"defaultTitle\":\"\\u4e2d\\u90e8banner\",\"id\":\"middle-banner\"},{\"title\":\"\",\"count\":\"4\",\"code\":\"recommend-classroom\",\"defaultTitle\":\"\\u63a8\\u8350\\u73ed\\u7ea7\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u73ed\\u7ea7\\u5316\\u5b66\\u4e60\\u4f53\\u7cfb\\uff0c\\u7ed9\\u4f60\\u66f4\\u591a\\u7684\\u8bfe\\u7a0b\\u76f8\\u5173\\u670d\\u52a1\\u3002\",\"id\":\"RecommendClassrooms\"},{\"title\":\"\",\"count\":\"6\",\"code\":\"groups\",\"defaultTitle\":\"\\u52a8\\u6001\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u53c2\\u4e0e\\u5c0f\\u7ec4\\uff0c\\u7ed3\\u4ea4\\u66f4\\u591a\\u540c\\u5b66\\uff0c\\u5173\\u6ce8\\u8bfe\\u7a0b\\u52a8\\u6001\\u3002\",\"select1\":\"checked\",\"select2\":\"checked\",\"select3\":\"\",\"select4\":\"\",\"id\":\"hotGroups\"},{\"title\":\"\",\"count\":\"4\",\"categoryId\":\"\",\"code\":\"recommend-teacher\",\"defaultTitle\":\"\\u63a8\\u8350\\u6559\\u5e08\",\"subTitle\":\"\",\"defaultSubTitle\":\"\\u540d\\u5e08\\u6c47\\u96c6\\uff0c\\u4fdd\\u8bc1\\u6559\\u5b66\\u8d28\\u91cf\\u4e0e\\u5b66\\u4e60\\u6548\\u679c\\u3002\",\"id\":\"RecommendTeachers\"},{\"title\":\"\",\"count\":\"\",\"code\":\"footer-link\",\"defaultTitle\":\"\\u5e95\\u90e8\\u94fe\\u63a5\",\"id\":\"footerLink\"}]},\"bottom\":\"simple\"}', null, '1483927766', '1449218369', '1');

-- ----------------------------
-- Table structure for thread
-- ----------------------------
DROP TABLE IF EXISTS `thread`;
CREATE TABLE `thread` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `targetType` varchar(255) NOT NULL DEFAULT 'classroom' COMMENT '所属 类型',
  `targetId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属类型 ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `ats` text COMMENT '@(提)到的人',
  `nice` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加精',
  `sticky` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '置顶',
  `solved` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否有老师回答(已被解决)',
  `lastPostUserId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后回复人ID',
  `lastPostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后回复时间',
  `location` varchar(1024) DEFAULT NULL COMMENT '地点',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT '话题类型',
  `postNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复数',
  `hitNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `memberNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '成员人数',
  `maxUsers` int(10) NOT NULL DEFAULT '0' COMMENT '最大人数',
  `actvityPicture` varchar(255) DEFAULT NULL COMMENT '活动图片',
  `status` enum('open','closed') NOT NULL DEFAULT 'open' COMMENT '状态',
  `startTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `endTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `relationId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '从属ID',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题最后一次被编辑或回复时间',
  PRIMARY KEY (`id`),
  KEY `updateTime` (`updateTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thread
-- ----------------------------

-- ----------------------------
-- Table structure for thread_member
-- ----------------------------
DROP TABLE IF EXISTS `thread_member`;
CREATE TABLE `thread_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统Id',
  `threadId` int(10) unsigned NOT NULL COMMENT '话题Id',
  `userId` int(10) unsigned NOT NULL COMMENT '用户Id',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `truename` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='话题成员表';

-- ----------------------------
-- Records of thread_member
-- ----------------------------

-- ----------------------------
-- Table structure for thread_post
-- ----------------------------
DROP TABLE IF EXISTS `thread_post`;
CREATE TABLE `thread_post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `threadId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题ID',
  `content` text NOT NULL COMMENT '内容',
  `adopted` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否被采纳(是老师回答)',
  `ats` text COMMENT '@(提)到的人',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `parentId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `subposts` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子话题数量',
  `ups` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投票数',
  `targetType` varchar(255) NOT NULL DEFAULT 'classroom' COMMENT '所属 类型',
  `targetId` int(10) unsigned NOT NULL COMMENT '所属 类型ID',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thread_post
-- ----------------------------

-- ----------------------------
-- Table structure for thread_vote
-- ----------------------------
DROP TABLE IF EXISTS `thread_vote`;
CREATE TABLE `thread_vote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `threadId` int(10) unsigned NOT NULL COMMENT '话题ID',
  `postId` int(10) unsigned NOT NULL COMMENT '回帖ID',
  `action` enum('up','down') NOT NULL COMMENT '投票类型',
  `userId` int(10) unsigned NOT NULL COMMENT '投票人ID',
  `createdTime` int(10) unsigned NOT NULL COMMENT '投票时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `postId` (`threadId`,`postId`,`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='话题投票表';

-- ----------------------------
-- Records of thread_vote
-- ----------------------------

-- ----------------------------
-- Table structure for thumbnails
-- ----------------------------
DROP TABLE IF EXISTS `thumbnails`;
CREATE TABLE `thumbnails` (
  `onePic` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '第一张缩略图',
  `twoPic` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '第二张缩略图',
  `threePic` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '第三张缩略图',
  `oneUrl` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '第一张缩略图URL',
  `twoUrl` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '第二张缩略图URL',
  `threeUrl` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '第三张缩略图URL'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of thumbnails
-- ----------------------------

-- ----------------------------
-- Table structure for upgrade_logs
-- ----------------------------
DROP TABLE IF EXISTS `upgrade_logs`;
CREATE TABLE `upgrade_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remoteId` int(11) NOT NULL COMMENT 'packageId',
  `installedId` int(11) DEFAULT NULL COMMENT '本地已安装id',
  `ename` varchar(32) NOT NULL COMMENT '名称',
  `cname` varchar(32) NOT NULL COMMENT '中文名称',
  `fromv` varchar(32) DEFAULT NULL COMMENT '初始版本',
  `tov` varchar(32) NOT NULL COMMENT '目标版本',
  `type` smallint(6) NOT NULL COMMENT '升级类型',
  `dbBackPath` text COMMENT '数据库备份文件',
  `srcBackPath` text COMMENT '源文件备份地址',
  `status` varchar(32) NOT NULL COMMENT '状态(ROLLBACK,ERROR,SUCCESS,RECOVERED)',
  `logtime` int(11) NOT NULL COMMENT '升级时间',
  `uid` int(10) unsigned NOT NULL COMMENT 'uid',
  `ip` varchar(32) DEFAULT NULL COMMENT 'ip',
  `reason` text COMMENT '失败原因',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='本地升级日志表';

-- ----------------------------
-- Records of upgrade_logs
-- ----------------------------

-- ----------------------------
-- Table structure for upgrade_notice
-- ----------------------------
DROP TABLE IF EXISTS `upgrade_notice`;
CREATE TABLE `upgrade_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `code` varchar(100) NOT NULL COMMENT '编码',
  `version` varchar(100) NOT NULL COMMENT '版本号',
  `createdTime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户升级提示查看';

-- ----------------------------
-- Records of upgrade_notice
-- ----------------------------

-- ----------------------------
-- Table structure for upload_files
-- ----------------------------
DROP TABLE IF EXISTS `upload_files`;
CREATE TABLE `upload_files` (
  `id` int(10) unsigned NOT NULL,
  `globalId` varchar(32) NOT NULL DEFAULT '0' COMMENT '云文件ID',
  `hashId` varchar(128) NOT NULL DEFAULT '' COMMENT '文件的HashID',
  `targetId` int(11) NOT NULL COMMENT '所存目标ID',
  `targetType` varchar(64) NOT NULL DEFAULT '' COMMENT '目标类型',
  `useType` varchar(64) DEFAULT NULL COMMENT '文件使用的模块类型',
  `filename` varchar(1024) NOT NULL DEFAULT '' COMMENT '文件名',
  `ext` varchar(12) NOT NULL DEFAULT '' COMMENT '后缀',
  `fileSize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `etag` varchar(256) NOT NULL DEFAULT '' COMMENT 'ETAG',
  `length` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '长度（音视频则为时长，PPT/文档为页数）',
  `description` text,
  `status` enum('uploading','ok') NOT NULL DEFAULT 'ok' COMMENT '文件上传状态',
  `convertHash` varchar(128) NOT NULL DEFAULT '' COMMENT '文件转换时的查询转换进度用的Hash值',
  `convertStatus` enum('none','waiting','doing','success','error') NOT NULL DEFAULT 'none' COMMENT '文件转换状态',
  `convertParams` text COMMENT '文件转换参数',
  `metas` text COMMENT '元信息',
  `metas2` text COMMENT '元信息',
  `type` enum('document','video','audio','image','ppt','other','flash') NOT NULL DEFAULT 'other' COMMENT '文件类型',
  `storage` enum('local','cloud') NOT NULL COMMENT '文件存储方式',
  `isPublic` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否公开文件',
  `canDownload` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否可下载',
  `usedCount` int(10) unsigned NOT NULL DEFAULT '0',
  `updatedUserId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新用户名',
  `updatedTime` int(10) unsigned DEFAULT '0' COMMENT '文件最后更新时间',
  `createdUserId` int(10) unsigned NOT NULL COMMENT '文件上传人',
  `createdTime` int(10) unsigned NOT NULL COMMENT '文件上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `convertHash` (`convertHash`(64)),
  UNIQUE KEY `hashId` (`hashId`(120))
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of upload_files
-- ----------------------------

-- ----------------------------
-- Table structure for upload_files_collection
-- ----------------------------
DROP TABLE IF EXISTS `upload_files_collection`;
CREATE TABLE `upload_files_collection` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` int(10) unsigned NOT NULL COMMENT '文件Id',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏者',
  `createdTime` int(10) unsigned NOT NULL,
  `updatedTime` int(10) unsigned DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件收藏表';

-- ----------------------------
-- Records of upload_files_collection
-- ----------------------------

-- ----------------------------
-- Table structure for upload_files_share
-- ----------------------------
DROP TABLE IF EXISTS `upload_files_share`;
CREATE TABLE `upload_files_share` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sourceUserId` int(10) unsigned NOT NULL COMMENT '上传文件的用户ID',
  `targetUserId` int(10) unsigned NOT NULL COMMENT '文件分享目标用户ID',
  `isActive` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of upload_files_share
-- ----------------------------

-- ----------------------------
-- Table structure for upload_files_share_history
-- ----------------------------
DROP TABLE IF EXISTS `upload_files_share_history`;
CREATE TABLE `upload_files_share_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统ID',
  `sourceUserId` int(10) NOT NULL COMMENT '分享用户的ID',
  `targetUserId` int(10) NOT NULL COMMENT '被分享的用户的ID',
  `isActive` tinyint(4) NOT NULL DEFAULT '0',
  `createdTime` int(10) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of upload_files_share_history
-- ----------------------------

-- ----------------------------
-- Table structure for upload_files_tag
-- ----------------------------
DROP TABLE IF EXISTS `upload_files_tag`;
CREATE TABLE `upload_files_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统ID',
  `fileId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `tagId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '标签ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件与标签的关联表';

-- ----------------------------
-- Records of upload_files_tag
-- ----------------------------

-- ----------------------------
-- Table structure for upload_file_inits
-- ----------------------------
DROP TABLE IF EXISTS `upload_file_inits`;
CREATE TABLE `upload_file_inits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `globalId` varchar(32) NOT NULL DEFAULT '0' COMMENT '云文件ID',
  `status` enum('uploading','ok') NOT NULL DEFAULT 'ok' COMMENT '文件上传状态',
  `hashId` varchar(128) NOT NULL DEFAULT '' COMMENT '文件的HashID',
  `targetId` int(11) NOT NULL COMMENT '所存目标id',
  `targetType` varchar(64) NOT NULL DEFAULT '' COMMENT '目标类型',
  `filename` varchar(1024) NOT NULL DEFAULT '',
  `ext` varchar(12) NOT NULL DEFAULT '' COMMENT '后缀',
  `fileSize` bigint(20) NOT NULL DEFAULT '0',
  `etag` varchar(256) NOT NULL DEFAULT '',
  `length` int(10) unsigned NOT NULL DEFAULT '0',
  `convertHash` varchar(256) NOT NULL DEFAULT '' COMMENT '文件转换时的查询转换进度用的Hash值',
  `convertStatus` enum('none','waiting','doing','success','error') NOT NULL DEFAULT 'none',
  `metas` text,
  `metas2` text,
  `type` enum('document','video','audio','image','ppt','flash','other') NOT NULL DEFAULT 'other',
  `storage` enum('local','cloud') NOT NULL,
  `convertParams` text COMMENT '文件转换参数',
  `updatedUserId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新用户名',
  `updatedTime` int(10) unsigned DEFAULT '0',
  `createdUserId` int(10) unsigned NOT NULL,
  `createdTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashId` (`hashId`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of upload_file_inits
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `email` varchar(128) NOT NULL COMMENT '用户邮箱',
  `verifiedMobile` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL COMMENT '用户密码',
  `salt` varchar(32) NOT NULL COMMENT '密码SALT',
  `payPassword` varchar(64) NOT NULL DEFAULT '' COMMENT '支付密码',
  `payPasswordSalt` varchar(64) NOT NULL DEFAULT '' COMMENT '支付密码Salt',
  `uri` varchar(64) NOT NULL DEFAULT '' COMMENT '用户URI',
  `nickname` varchar(64) NOT NULL COMMENT '昵称',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `tags` varchar(255) NOT NULL DEFAULT '' COMMENT '标签',
  `type` varchar(32) NOT NULL COMMENT 'default默认为网站注册, weibo新浪微薄登录',
  `point` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '金币',
  `schoolId` int(11) DEFAULT '0',
  `smallAvatar` varchar(255) NOT NULL DEFAULT '' COMMENT '小头像',
  `mediumAvatar` varchar(255) NOT NULL DEFAULT '' COMMENT '中头像',
  `largeAvatar` varchar(255) NOT NULL DEFAULT '' COMMENT '大头像',
  `emailVerified` tinyint(1) NOT NULL DEFAULT '0' COMMENT '邮箱是否为已验证',
  `setup` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否初始化设置的，未初始化的可以设置邮箱、昵称。',
  `roles` varchar(255) NOT NULL COMMENT '用户角色',
  `promoted` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为推荐',
  `promotedSeq` int(10) unsigned NOT NULL DEFAULT '0',
  `promotedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐时间',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否被禁止',
  `lockDeadline` int(10) NOT NULL DEFAULT '0' COMMENT '帐号锁定期限',
  `consecutivePasswordErrorTimes` int(11) NOT NULL DEFAULT '0' COMMENT '帐号密码错误次数',
  `lastPasswordFailTime` int(10) NOT NULL DEFAULT '0',
  `loginTime` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `loginIp` varchar(64) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `loginSessionId` varchar(255) NOT NULL DEFAULT '' COMMENT '最后登录会话ID',
  `approvalTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实名认证时间',
  `approvalStatus` enum('unapprove','approving','approved','approve_fail') NOT NULL DEFAULT 'unapprove' COMMENT '实名认证状态',
  `newMessageNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '未读私信数',
  `newNotificationNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '未读消息数',
  `createdIp` varchar(64) NOT NULL DEFAULT '' COMMENT '注册IP',
  `locale` varchar(20) DEFAULT NULL,
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `updatedTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `inviteCode` varchar(255) DEFAULT NULL COMMENT '邀请码',
  `orgId` int(10) unsigned DEFAULT '1',
  `orgCode` varchar(255) DEFAULT '1.' COMMENT '组织机构内部编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nickname` (`nickname`),
  KEY `updatedTime` (`updatedTime`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '2885330810@qq.com', '', 'S23AOSwKoAxjZ8q8eO/9VmYHrlNYzfllYVWGnEks7Bk=', '3in4flj5142s4okg8gkwc4844s80skk', '', '', '', 'admin', '你猜', '', 'default', '0', '0', '0', 'public://user/2016/11-30/181829581f79920127.jpg', 'public://user/2016/11-30/181829579fb0566831.jpg', 'public://user/2016/11-30/181829572a21927309.jpg', '1', '1', '|ROLE_USER|ROLE_TEACHER|ROLE_ADMIN|ROLE_SUPER_ADMIN|', '0', '0', '0', '0', '0', '0', '0', '1496375290', '::1', 'vh02uoelc3c90cf6474l92p456', '0', 'unapprove', '0', '0', '', null, '1480133733', '1496375290', null, '1', '1.');
INSERT INTO `user` VALUES ('15', '119584828@qq.com', '', 'R7ySb1Wo7L5bf2v3xVufDB4hiNpdOqdDO22x4HVf6cs=', '1z3q5ajz9ukg0go88k4cssw0ws4c0g', '', '', '', 'testone', '你猜', '', 'web_email', '0', '0', '5', 'public://user/2017/01-12/1913106106b7274707.jpg', 'public://user/2017/01-12/19131060a44a883456.jpg', 'public://user/2017/01-12/19131060347a455555.jpg', '0', '1', '|ROLE_USER|ROLE_TEACHER|ROLE_ADMIN|', '0', '0', '0', '0', '0', '0', '0', '1495698539', '::1', 'h1kcqmojuog4sl76ohl9kgqv71', '0', 'unapprove', '0', '1', '::1', null, '1481617170', '1495698539', null, '1', '1.');
INSERT INTO `user` VALUES ('16', '469139570@qq.com', '', 'oWM/NnIzJh5JbCTdCo9Yh0wHVdx+Gfhr7h9YERaWqIA=', 'kbyha9mvdz40ogwkwo4ow84ogkccssg', '', '', '', 'testtwo', '', '', 'web_email', '0', '0', '6', '', '', '', '0', '1', '|ROLE_USER|', '0', '0', '0', '0', '0', '0', '0', '1496285331', '::1', '5subjr13pvp1c3n9m8s1ggbob2', '0', 'unapprove', '0', '0', '::1', null, '1484617757', '1496285332', null, '1', '1.');

-- ----------------------------
-- Table structure for user_approval
-- ----------------------------
DROP TABLE IF EXISTS `user_approval`;
CREATE TABLE `user_approval` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户认证ID',
  `userId` int(10) NOT NULL COMMENT '用户ID',
  `idcard` varchar(24) NOT NULL DEFAULT '' COMMENT '身份证号',
  `faceImg` varchar(500) NOT NULL DEFAULT '' COMMENT '认证正面图',
  `backImg` varchar(500) NOT NULL DEFAULT '' COMMENT '认证背面图',
  `truename` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `note` text COMMENT '认证信息',
  `status` enum('unapprove','approving','approved','approve_fail') NOT NULL COMMENT '是否通过：1是 0否',
  `operatorId` int(10) unsigned DEFAULT NULL COMMENT '审核人',
  `createdTime` int(10) NOT NULL DEFAULT '0' COMMENT '申请时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户认证表';

-- ----------------------------
-- Records of user_approval
-- ----------------------------

-- ----------------------------
-- Table structure for user_bind
-- ----------------------------
DROP TABLE IF EXISTS `user_bind`;
CREATE TABLE `user_bind` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户绑定ID',
  `type` varchar(64) NOT NULL COMMENT '用户绑定类型',
  `fromId` varchar(32) NOT NULL COMMENT '来源方用户ID',
  `toId` int(10) unsigned NOT NULL COMMENT '被绑定的用户ID',
  `token` varchar(255) NOT NULL DEFAULT '' COMMENT 'oauth token',
  `refreshToken` varchar(255) NOT NULL DEFAULT '' COMMENT 'oauth refresh token',
  `expiredTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'token过期时间',
  `createdTime` int(10) unsigned NOT NULL COMMENT '绑定时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`fromId`),
  UNIQUE KEY `type_2` (`type`,`toId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_bind
-- ----------------------------

-- ----------------------------
-- Table structure for user_field
-- ----------------------------
DROP TABLE IF EXISTS `user_field`;
CREATE TABLE `user_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fieldName` varchar(100) NOT NULL DEFAULT '',
  `title` varchar(1024) NOT NULL DEFAULT '',
  `seq` int(10) unsigned NOT NULL,
  `enabled` int(10) unsigned NOT NULL DEFAULT '0',
  `createdTime` int(100) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_field
-- ----------------------------

-- ----------------------------
-- Table structure for user_fortune_log
-- ----------------------------
DROP TABLE IF EXISTS `user_fortune_log`;
CREATE TABLE `user_fortune_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `number` int(10) NOT NULL,
  `action` varchar(20) NOT NULL,
  `note` varchar(255) NOT NULL DEFAULT '',
  `createdTime` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_fortune_log
-- ----------------------------

-- ----------------------------
-- Table structure for user_pay_agreement
-- ----------------------------
DROP TABLE IF EXISTS `user_pay_agreement`;
CREATE TABLE `user_pay_agreement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户Id',
  `type` int(8) NOT NULL DEFAULT '0' COMMENT '0:储蓄卡1:信用卡',
  `bankName` varchar(255) NOT NULL COMMENT '银行名称',
  `bankNumber` int(8) NOT NULL COMMENT '银行卡号',
  `userAuth` varchar(225) DEFAULT NULL COMMENT '用户授权',
  `bankAuth` varchar(225) NOT NULL COMMENT '银行授权码',
  `bankId` int(8) NOT NULL COMMENT '对应的银行Id',
  `updatedTime` int(10) NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `createdTime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户授权银行';

-- ----------------------------
-- Records of user_pay_agreement
-- ----------------------------

-- ----------------------------
-- Table structure for user_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `truename` varchar(255) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `idcard` varchar(24) NOT NULL DEFAULT '' COMMENT '身份证号码',
  `gender` enum('male','female','secret') NOT NULL DEFAULT 'secret' COMMENT '性别',
  `iam` varchar(255) NOT NULL DEFAULT '' COMMENT '我是谁',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `city` varchar(64) NOT NULL DEFAULT '' COMMENT '城市',
  `mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '手机',
  `qq` varchar(32) NOT NULL DEFAULT '' COMMENT 'QQ',
  `signature` text COMMENT '签名',
  `about` text COMMENT '自我介绍',
  `nation` varchar(255) NOT NULL DEFAULT '' COMMENT '民族',
  `company` varchar(255) NOT NULL DEFAULT '' COMMENT '公司',
  `job` varchar(255) NOT NULL DEFAULT '' COMMENT '工作',
  `school` varchar(255) NOT NULL DEFAULT '' COMMENT '学校',
  `class` varchar(255) NOT NULL DEFAULT '' COMMENT '班级',
  `weibo` varchar(255) NOT NULL DEFAULT '' COMMENT '微博',
  `weixin` varchar(255) NOT NULL DEFAULT '' COMMENT '微信',
  `isQQPublic` int(11) NOT NULL DEFAULT '0',
  `isWeixinPublic` int(11) NOT NULL DEFAULT '0',
  `isWeiboPublic` int(11) NOT NULL DEFAULT '0',
  `site` varchar(255) NOT NULL DEFAULT '' COMMENT '网站',
  `intField1` int(11) DEFAULT NULL,
  `intField2` int(11) DEFAULT NULL,
  `intField3` int(11) DEFAULT NULL,
  `intField4` int(11) DEFAULT NULL,
  `intField5` int(11) DEFAULT NULL,
  `dateField1` date DEFAULT NULL,
  `dateField2` date DEFAULT NULL,
  `dateField3` date DEFAULT NULL,
  `dateField4` date DEFAULT NULL,
  `dateField5` date DEFAULT NULL,
  `floatField1` float(10,2) DEFAULT NULL,
  `floatField2` float(10,2) DEFAULT NULL,
  `floatField3` float(10,2) DEFAULT NULL,
  `floatField4` float(10,2) DEFAULT NULL,
  `floatField5` float(10,2) DEFAULT NULL,
  `varcharField1` varchar(1024) DEFAULT NULL,
  `varcharField2` varchar(1024) DEFAULT NULL,
  `varcharField3` varchar(1024) DEFAULT NULL,
  `varcharField4` varchar(1024) DEFAULT NULL,
  `varcharField5` varchar(1024) DEFAULT NULL,
  `varcharField6` varchar(1024) DEFAULT NULL,
  `varcharField7` varchar(1024) DEFAULT NULL,
  `varcharField8` varchar(1024) DEFAULT NULL,
  `varcharField9` varchar(1024) DEFAULT NULL,
  `varcharField10` varchar(1024) DEFAULT NULL,
  `textField1` text,
  `textField2` text,
  `textField3` text,
  `textField4` text,
  `textField5` text,
  `textField6` text,
  `textField7` text,
  `textField8` text,
  `textField9` text,
  `textField10` text,
  `height` varchar(50) DEFAULT '' COMMENT '身高',
  `weight` varchar(50) DEFAULT '' COMMENT '体重',
  `graduateSchool` varchar(100) DEFAULT '' COMMENT '毕业学校',
  `graduationTestScores` int(10) DEFAULT NULL COMMENT '毕业考试分数',
  `guardianName` varchar(50) DEFAULT '' COMMENT '监护人姓名',
  `guardianPhone` varchar(50) DEFAULT '' COMMENT '监护人联系方式',
  `admissionTicketNumber` varchar(100) DEFAULT '' COMMENT '准考证号码',
  `reportedSchool` varchar(100) DEFAULT '' COMMENT '所报学校',
  `reportedClass` varchar(100) DEFAULT '' COMMENT '所报课程',
  `role_id` int(10) DEFAULT '1' COMMENT '权限ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_profile
-- ----------------------------
INSERT INTO `user_profile` VALUES ('1', '王五', '223423534', 'male', '', null, '', '13888050193', '2885330810', '', '<p>你猜</p>\r\n', '3434534', '', '3434', '', '', '', '', '0', '0', '0', '', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', null, '', '', '', '', '', '4');
INSERT INTO `user_profile` VALUES ('15', '王三', '522401198709267692', 'male', '', null, '', '13888050193', '', '12312 ', '<p>劳而无功硒鼓</p>\r\n', '23424', 'adf', '教师', '', '', '', '', '0', '0', '0', '', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '170', '80', 'adf', '45', '王老', '13888123456', '12334534654', 'aaaaaaa', 'bbbbbb', '1');
INSERT INTO `user_profile` VALUES ('16', '', '', 'secret', '', null, '', '', '', null, null, '', '', '', '', '', '', '', '0', '0', '0', '', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', null, '', '', '', '', '', '1');

-- ----------------------------
-- Table structure for user_secure_question
-- ----------------------------
DROP TABLE IF EXISTS `user_secure_question`;
CREATE TABLE `user_secure_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `securityQuestionCode` varchar(64) NOT NULL DEFAULT '' COMMENT '问题的code',
  `securityAnswer` varchar(64) NOT NULL DEFAULT '' COMMENT '安全问题的答案',
  `securityAnswerSalt` varchar(64) NOT NULL DEFAULT '' COMMENT '安全问题的答案Salt',
  `createdTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_secure_question
-- ----------------------------

-- ----------------------------
-- Table structure for user_token
-- ----------------------------
DROP TABLE IF EXISTS `user_token`;
CREATE TABLE `user_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'TOKEN编号',
  `token` varchar(64) NOT NULL COMMENT 'TOKEN值',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'TOKEN关联的用户ID',
  `type` varchar(255) NOT NULL COMMENT 'TOKEN类型',
  `data` text NOT NULL COMMENT 'TOKEN数据',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'TOKEN的校验次数限制(0表示不限制)',
  `remainedTimes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'TOKE剩余校验次数',
  `expiredTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'TOKEN过期时间',
  `createdTime` int(10) unsigned NOT NULL COMMENT 'TOKEN创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`(60))
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_token
-- ----------------------------

-- ----------------------------
-- Table structure for weixin
-- ----------------------------
DROP TABLE IF EXISTS `weixin`;
CREATE TABLE `weixin` (
  `id` int(11) NOT NULL,
  `app_id` varchar(50) CHARACTER SET utf8 DEFAULT 'wx426b3015555a46be' COMMENT 'AppID',
  `mch_id` varchar(50) CHARACTER SET utf8 DEFAULT '1900009851' COMMENT '商户号',
  `wx_key` varchar(50) CHARACTER SET utf8 DEFAULT '8934e7d15453e97507ef794cf7b0519d' COMMENT '商户支付密钥',
  `appSecret` varchar(50) CHARACTER SET utf8 DEFAULT '7813490da6f1265e4901ffb80afaa36f' COMMENT '公众账号Secret',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of weixin
-- ----------------------------
INSERT INTO `weixin` VALUES ('1', 'wx426b3015555a46be', '1900009851', '8934e7d15453e97507ef794cf7b0519d', '7813490da6f1265e4901ffb80afaa36f');

-- ----------------------------
-- Procedure structure for proc_insert
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_insert`;
DELIMITER ;;
CREATE DEFINER=`edusoho_root`@`localhost` PROCEDURE `proc_insert`(IN `student_id` int,IN `course_id` int,IN `studentName` varchar(50),IN `courseCost` decimal(10,2),IN `payment` int,IN `createDate` int,IN `user_id` int,IN `school_id` int)
BEGIN
	declare v1 int;
	DECLARE t_error INTEGER DEFAULT 0;  
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error=1;
	/*开启事务*/
	start transaction;
	
	insert into `pay`(`student_id`,`course_id`,`studentName`,`courseCost`,`payment`,`createDate`) values (student_id,course_id,studentName,courseCost,payment,createDate);
	
	SELECT `id` INTO v1
      FROM `pay` WHERE `student_id` = student_id; 
	/*set v1 = select count(LAST_INSERT_ID());*/

	insert into `pay_log`(`student_id`,`user_id`,`pay_id`,`createDate`,`school_id`) values (student_id,user_id,v1,createDate,school_id);
	
	IF t_error = 1 THEN  
      ROLLBACK;  
  ELSE  
      COMMIT;  
  END IF;  
	/*正常提交*/
	commit;
END
;;
DELIMITER ;
