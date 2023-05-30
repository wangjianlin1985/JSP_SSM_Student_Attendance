/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.20 : Database - attsys
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`attsys` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `attsys`;

/*Table structure for table `att` */

DROP TABLE IF EXISTS `att`;

CREATE TABLE `att` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(32) DEFAULT NULL COMMENT '日期',
  `studentid` int(11) DEFAULT NULL COMMENT '学生ID',
  `result` varchar(32) DEFAULT NULL COMMENT '考勤结果',
  `teacherid` int(11) DEFAULT NULL COMMENT '点名的教师ID',
  `periodid` int(11) DEFAULT NULL COMMENT '节次ID',
  `courseid` int(11) DEFAULT NULL COMMENT '课程ID，暂未使用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

/*Data for the table `att` */

insert  into `att`(`id`,`date`,`studentid`,`result`,`teacherid`,`periodid`,`courseid`) values (1,'2018-02-26',7,'早退',5,5,0),(2,'2018-02-26',8,'迟到',5,5,0),(3,'2018-02-26',9,'早退',5,5,0),(4,'2018-02-26',10,'旷课',5,5,0),(5,'2018-02-26',11,'正常',5,5,0),(26,'2018-02-28',7,'迟到',5,4,0),(27,'2018-02-28',8,'正常',5,4,0),(28,'2018-02-28',9,'旷课',5,4,0),(29,'2018-02-28',10,'早退',5,4,0),(30,'2018-02-28',11,'正常',5,4,0),(31,'2018-02-28',7,'迟到',5,4,0),(32,'2018-02-28',8,'正常',5,4,0),(33,'2018-02-28',9,'旷课',5,4,0),(34,'2018-02-28',10,'早退',5,4,0),(35,'2018-02-28',11,'正常',5,4,0),(36,'2018-02-28',7,'迟到',5,4,0),(37,'2018-02-28',8,'迟到',5,4,0),(38,'2018-02-28',9,'早退',5,4,0),(39,'2018-02-28',10,'旷课',5,4,0),(40,'2018-02-28',11,'正常',5,4,0),(41,'2018-02-28',7,'迟到',5,4,0),(42,'2018-02-28',8,'迟到',5,4,0),(43,'2018-02-28',9,'早退',5,4,0),(44,'2018-02-28',10,'旷课',5,4,0),(45,'2018-02-28',117,'',5,4,0),(46,'2018-02-28',8,'迟到',5,4,0),(47,'2018-02-28',9,'早退',5,4,0),(48,'2018-02-28',10,'旷课',5,4,0),(49,'2018-02-28',11,'正常',5,4,0);

/*Table structure for table `classteacher` */

DROP TABLE IF EXISTS `classteacher`;

CREATE TABLE `classteacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `deptId` int(11) DEFAULT NULL COMMENT '班级ID',
  `teacherId` int(11) DEFAULT NULL COMMENT '教师ID',
  `courseId` int(11) DEFAULT NULL COMMENT '教授的课程ID',
  `islead` char(1) DEFAULT NULL COMMENT '是否班主任',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `classteacher` */

insert  into `classteacher`(`id`,`deptId`,`teacherId`,`courseId`,`islead`) values (1,9,4,1,'0'),(2,9,5,2,'1'),(3,12,6,1,'0'),(4,10,5,2,'0'),(5,9,6,3,'0'),(6,10,6,3,'0');

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `course` */

insert  into `course`(`id`,`name`) values (1,'语文'),(2,'数学'),(3,'英语');

/*Table structure for table `dept` */

DROP TABLE IF EXISTS `dept`;

CREATE TABLE `dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(11) DEFAULT NULL COMMENT '上级部门ID',
  `name` varchar(128) DEFAULT NULL COMMENT '部门名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `dept` */

insert  into `dept`(`id`,`pid`,`name`) values (1,0,'XX学校'),(2,1,'教职工'),(3,1,'学生'),(6,3,'2017级'),(7,3,'2016级'),(8,3,'2015级'),(9,8,'1班'),(10,8,'2班'),(11,7,'1班'),(12,6,'1班'),(13,6,'2班'),(14,7,'2班');

/*Table structure for table `leaves` */

DROP TABLE IF EXISTS `leaves`;

CREATE TABLE `leaves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` int(11) DEFAULT NULL COMMENT '学生ID',
  `applystart` varchar(32) DEFAULT NULL COMMENT '开始时间',
  `applyend` varchar(32) DEFAULT NULL COMMENT '结束时间',
  `applytime` varchar(32) DEFAULT NULL COMMENT '申请时间',
  `applyday` int(11) DEFAULT NULL COMMENT '请假天数',
  `type` varchar(32) DEFAULT NULL COMMENT '请假类型',
  `reason` varchar(256) DEFAULT NULL COMMENT '理由',
  `teacherid` int(11) DEFAULT NULL COMMENT '班主任ID',
  `teacherresult` varchar(32) DEFAULT '待审批' COMMENT '教师审批结果，待审批，同意，不同意',
  `teachertime` varchar(32) DEFAULT NULL COMMENT '教师审批时间',
  `teachercommand` varchar(32) DEFAULT NULL COMMENT '教师的意见',
  `leaderid` int(11) DEFAULT NULL COMMENT '院领导ID',
  `leaderresult` varchar(32) DEFAULT '待审批' COMMENT '院领导审批结果',
  `leadertime` varchar(32) DEFAULT NULL COMMENT '院领导审批时间',
  `leadercommand` varchar(256) DEFAULT NULL COMMENT '院领导意见',
  `result` varchar(32) DEFAULT '待审批' COMMENT '总的审批结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `leaves` */

insert  into `leaves`(`id`,`studentid`,`applystart`,`applyend`,`applytime`,`applyday`,`type`,`reason`,`teacherid`,`teacherresult`,`teachertime`,`teachercommand`,`leaderid`,`leaderresult`,`leadertime`,`leadercommand`,`result`) values (2,7,'2018-03-03 01:07:40','2018-03-07 01:07:43','2018-03-01 01:11:32',2,'婚假','4we2222',5,'不同意','2018-02-26 16:27:21','三四十',NULL,'待审批',NULL,NULL,'不同意'),(3,7,'2018-03-03 01:07:40','2018-03-07 01:07:43','2018-03-01 01:11:23',4,'病假','23',5,'同意','2018-02-26 16:29:42','但是多多',12,'不同意','2018-02-26 16:51:52','个哈哈哈','不同意'),(4,7,'2018-02-28 10:38:36','2018-03-01 10:38:41','2018-02-28 10:39:29',2,'事假','2天同意',5,'同意','2018-02-28 10:43:37','呃3',NULL,'待审批',NULL,NULL,'同意'),(5,7,'2018-02-28 10:39:33','2018-03-02 10:39:35','2018-02-28 10:39:43',2,'病假','2天不同意',5,'不同意','2018-02-28 10:43:30','1',NULL,'待审批',NULL,NULL,'不同意'),(6,7,'2018-02-28 10:39:49','2018-03-06 10:39:50','2018-02-28 10:40:08',4,'丧假','3天及以上的同意',5,'同意','2018-02-28 10:43:24','111',12,'同意','2018-02-28 10:48:19','111','同意'),(7,7,'2018-02-28 10:40:13','2018-03-08 10:40:17','2018-02-28 10:41:28',4,'事假','3天及以上的不同意修改',5,'不同意','2018-02-28 10:43:15','~~~~，',NULL,'待审批',NULL,NULL,'不同意');

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `menuId` int(10) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menuName` varchar(50) DEFAULT NULL COMMENT '名称',
  `menuUrl` varchar(100) DEFAULT NULL COMMENT '方法',
  `parentId` int(11) DEFAULT NULL COMMENT '父ID',
  `menuDescription` varchar(200) DEFAULT NULL COMMENT '描述',
  `state` varchar(20) DEFAULT NULL COMMENT '状态/OPEN/CLOSED',
  `iconCls` varchar(50) DEFAULT NULL COMMENT '图标',
  `seq` int(11) DEFAULT NULL COMMENT '顺序排序',
  PRIMARY KEY (`menuId`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

/*Data for the table `menu` */

insert  into `menu`(`menuId`,`menuName`,`menuUrl`,`parentId`,`menuDescription`,`state`,`iconCls`,`seq`) values (1,'考勤管理系统','',-1,'主菜单','closed','icon-home',1),(2,'系统管理','',1,'','closed','icon-permission',1),(3,'信息管理','',1,'','closed','icon-student',2),(5,'菜单管理','menu/menuIndex.htm',2,'','open','icon-menuManage',4),(6,'用户管理','user/userIndex.htm',2,'','open','icon-489',5),(7,'角色管理','role/roleIndex.htm',2,'','open','icon-486',3),(27,'部门管理','dept/index.htm',2,'','open','icon-',4),(28,'课程管理','course/index.htm',3,'','open','icon-',1),(29,'课程安排','ct/index.htm',3,'','open','icon-',2),(30,'节次安排','period/index.htm',3,'','open','icon-',3),(31,'课表管理','schedular/index.htm',3,'','open','icon-',4),(32,'数据查询','',1,'','closed','icon-',3),(33,'教师课表','schedular/teacherIndex.htm',32,'','open','icon-',1),(34,'考勤查询','att/teacherAttIndex.htm',32,'给授课教师看的考勤','open','icon-',2),(35,'考勤管理','att/teacherLeadAttIndex.htm',32,'专门给班主任看的，可以修改考勤状态','open','icon-',3),(36,'我的考勤','att/stuAttIndex.htm',32,'学生自己看自己的考勤数据','open','icon-',4),(37,'全部考勤','att/schoolAttIndex.htm',32,'给学校领导看的全校学生的考勤','open','icon-',4),(38,'请假管理','',1,'','closed','icon-',4),(39,'学生请假','leave/studentApplyIndex.htm',38,'给学生看的自己的请假明细','open','icon-',1),(40,'待审列表','leave/myTodoIndex.htm',38,'','open','icon-',2),(41,'审批历史','leave/myHisIndex.htm',38,'','open','icon-',3),(42,'异常统计','stats/unusualAttIndex.htm',32,'学校领导查看非正常状态考勤的次数统计','open','icon-',5),(43,'班级考勤统计','stats/deptAttIndex.htm',32,'给学校领导看的各个班级的各考勤状态人数统计','open','icon-',6);

/*Table structure for table `operation` */

DROP TABLE IF EXISTS `operation`;

CREATE TABLE `operation` (
  `operationId` int(11) NOT NULL AUTO_INCREMENT COMMENT '具体的方法',
  `operationName` varchar(100) DEFAULT NULL COMMENT '方法名',
  `menuId` int(11) DEFAULT NULL COMMENT '所属菜单',
  `menuName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`operationId`),
  KEY `menuId` (`menuId`),
  CONSTRAINT `operation_ibfk_1` FOREIGN KEY (`menuId`) REFERENCES `menu` (`menuId`)
) ENGINE=InnoDB AUTO_INCREMENT=10036 DEFAULT CHARSET=utf8 COMMENT='具体的页面按钮上的方法\r\n（此自增ID至少从10000开始）';

/*Data for the table `operation` */

insert  into `operation`(`operationId`,`operationName`,`menuId`,`menuName`) values (10000,'添加',5,'菜单管理'),(10001,'修改',5,'菜单管理'),(10002,'删除',5,'菜单管理'),(10003,'添加',6,'用户管理'),(10004,'修改',6,'用户管理'),(10005,'删除',6,'用户管理'),(10006,'添加',7,'角色管理'),(10007,'修改',7,'角色管理'),(10008,'删除',7,'角色管理'),(10009,'授权',7,'角色管理'),(10014,'按钮管理',5,'菜单管理'),(10016,'添加',27,'部门管理'),(10017,'修改',27,'部门管理'),(10018,'删除',27,'部门管理'),(10019,'添加',28,'课程管理'),(10020,'修改',28,'课程管理'),(10021,'删除',28,'课程管理'),(10022,'添加',29,'课程安排'),(10023,'修改',29,'课程安排'),(10024,'删除',29,'课程安排'),(10025,'添加',30,'节次安排'),(10026,'修改',30,'节次安排'),(10027,'删除',30,'节次安排'),(10028,'添加',31,'课表管理'),(10029,'修改',31,'课表管理'),(10030,'删除',31,'课表管理'),(10031,'修改考勤',35,'学生考勤'),(10032,'添加',39,'学生请假'),(10033,'修改/详情',39,'学生请假'),(10035,'审批',40,'待审列表');

/*Table structure for table `period` */

DROP TABLE IF EXISTS `period`;

CREATE TABLE `period` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '课表节次',
  `name` varchar(32) DEFAULT NULL COMMENT '节次名称',
  `start` varchar(32) DEFAULT NULL COMMENT '开始时间',
  `end` varchar(32) DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `period` */

insert  into `period`(`id`,`name`,`start`,`end`) values (1,'第一节','08:00','09:00'),(2,'第二节','09:00','10:00'),(3,'第三节','10:00','11:00'),(4,'第四节','11:00','12:00'),(5,'第五节','14:00','15:00'),(6,'第六节','15:00','16:00'),(7,'第七节','16:00','17:00');

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `roleId` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `roleName` varchar(20) DEFAULT NULL COMMENT '角色名称',
  `menuIds` varchar(200) DEFAULT NULL COMMENT '菜单IDs',
  `operationIds` varchar(200) DEFAULT NULL COMMENT '按钮IDS',
  `roleDescription` varchar(200) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`roleId`,`roleName`,`menuIds`,`operationIds`,`roleDescription`) values (1,'超级管理员','1,2,7,5,27,6,3,28,29,30,31','10006,10007,10008,10009,10000,10001,10002,10014,10016,10017,10018,10003,10004,10005,10019,10020,10021,10022,10023,10024,10025,10026,10027,10028,10029,10030','拥有全部权限的超级管理员角色'),(2,'普通教师','1,32,33,34',NULL,''),(3,'班主任','1,32,33,34,35,38,40,41','10031,10035',NULL),(4,'学校领导','1,32,37,42,43,38,40,41','10035',''),(5,'学生','1,32,36,38,39','10032,10033','');

/*Table structure for table `schedular` */

DROP TABLE IF EXISTS `schedular`;

CREATE TABLE `schedular` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '课表',
  `week` varchar(32) DEFAULT NULL,
  `deptid` int(11) DEFAULT NULL COMMENT '班级ID',
  `ctid` int(11) DEFAULT NULL COMMENT 'IDclassteacher的id',
  `periodid` int(11) DEFAULT NULL COMMENT '节次ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `schedular` */

insert  into `schedular`(`id`,`week`,`deptid`,`ctid`,`periodid`) values (2,'周三',9,2,4),(3,'周三',9,1,3),(4,'周一',9,2,5),(5,'周一',12,3,3),(6,'周一',10,4,1),(7,'周一',10,4,2),(9,'周二',9,5,3);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `userName` varchar(20) DEFAULT NULL COMMENT '用户名',
  `realName` varchar(32) DEFAULT NULL COMMENT '姓名',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  `userType` tinyint(4) DEFAULT NULL COMMENT '用户类型',
  `roleId` int(11) DEFAULT NULL COMMENT '角色ID',
  `userDescription` varchar(200) DEFAULT NULL COMMENT '描述信息',
  `deptId` int(11) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`userId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`userId`,`userName`,`realName`,`password`,`userType`,`roleId`,`userDescription`,`deptId`) values (1,'admin','超管','admin',1,1,'1',1),(4,'t1','教师1','t1',2,2,'',2),(5,'t2','教师2','t2',2,3,'',2),(6,'t3','教师3','t3',2,2,'',2),(7,'s1','学生1','s1',2,5,'',9),(8,'s2','学生2','s2',2,5,'',9),(9,'s3','学生3','s3',2,5,'',9),(10,'s4','学生4','s4',2,5,'',9),(11,'s5','学生5','s5',2,5,'',9),(12,'l1','学校领导1','l1',2,4,'',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
