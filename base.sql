create database base;
use base;

drop TABLE IF EXISTS crop;
create table crop(
    CropId int 6 PRIMARY KEY UNIQUE NOT NULL,
    CropName varchar 8    
);

drop TABLE IF EXISTS area;
create table area(
    AreaId int 8 PRIMARY KEY UNIQUE NOT NULL,
    AreaName varchar 8
);

drop TABLE IF EXISTS store;
create table store(
    StoreId int 8 PRIMARY KEY UNIQUE NOT NULL,
    StoreName varchar 8,
    AreaId int 8 NOT NULL,
    FOREIGN KEY store(AreaId) REFERENCES area(AreaId)
);

drop TABLE IF EXISTS produce;
create table produce(
    StoreId int 8 NOT NULL,
    CropId int 6 NOT NULL,
    Time Date 8,
    Production int 12,
    Deal int 12,
    UnitPrice double 6,
    UNIQUE P_uniq(StoreId, CropId),
    FOREIGN KEY  produce(StoreId) REFERENCES store(StoreId),
    FOREIGN KEY  produce(CropId) REFERENCES crop(CropId)
);


DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL DEFAULT '0' ,
  `menu_code` varchar(255) DEFAULT '' ,
  `menu_name` varchar(255) DEFAULT '' ,
  `permission_code` varchar(255) DEFAULT ,
  `permission_name` varchar(255) DEFAULT ,
  `required_permission` tinyint(1) DEFAULT ,
  PRIMARY KEY (`id`)
) ;


BEGIN;
INSERT INTO `sys_permission` VALUES (601, 'user', '用户', 'user:list', '列表', 1);
INSERT INTO `sys_permission` VALUES (602, 'user', '用户', 'user:add', '新增', 2);
INSERT INTO `sys_permission` VALUES (603, 'user', '用户', 'user:update', '修改', 2);
INSERT INTO `sys_permission` VALUES (701, 'role', '角色权限', 'role:list', '列表', 1);
INSERT INTO `sys_permission` VALUES (702, 'role', '角色权限', 'role:add', '新增', 2);
INSERT INTO `sys_permission` VALUES (703, 'role', '角色权限', 'role:update', '修改', 2);
INSERT INTO `sys_permission` VALUES (704, 'role', '角色权限', 'role:delete', '删除', 2);
COMMIT;

DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_status` varchar(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ;

BEGIN;
INSERT INTO `sys_role` VALUES (1, '管理员',  '1');
INSERT INTO `sys_role` VALUES (2, '用户',  '1');
COMMIT;

DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL ,
  `permission_id` int(11) DEFAULT NULL ,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_status` varchar(1) DEFAULT '1' ,
  PRIMARY KEY (`id`)
) ;

BEGIN;
INSERT INTO `sys_role_permission` VALUES (1, 2, 101,'1');
COMMIT;

DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL ,
  `password` varchar(255) DEFAULT NULL ,
  `nickname` varchar(255) DEFAULT NULL ,
  `role_id` int(11) DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `delete_status` varchar(1) DEFAULT '1' ,
  PRIMARY KEY (`id`)
) ;

BEGIN;
INSERT INTO `sys_user` VALUES (10003, 'admin', '123456', '超级用户', 2,  '1');
INSERT INTO `sys_user` VALUES (10004, 'user', '123456', '普通用户', 2,  '1');
COMMIT;

DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL ,
  `role_id` int(11) DEFAULT NULL ,
  PRIMARY KEY (`id`)
) ;

BEGIN;
INSERT INTO `sys_user_role` VALUES (3, 10004, 2);
INSERT INTO `sys_user_role` VALUES (4, 10004, 3);
INSERT INTO `sys_user_role` VALUES (9, 10005, 1);
INSERT INTO `sys_user_role` VALUES (10, 10005, 2);
INSERT INTO `sys_user_role` VALUES (11, 10008, 4);
INSERT INTO `sys_user_role` VALUES (12, 10003, 1);
INSERT INTO `sys_user_role` VALUES (13, 10007, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;