/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.7.17-log : Database - db_edms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_edms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_edms`;

/*Table structure for table `t_customer` */

DROP TABLE IF EXISTS `t_customer`;

CREATE TABLE `t_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(300) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `t_customer` */

insert  into `t_customer`(`id`,`address`,`contact`,`name`,`number`,`remarks`) values (1,'福州新弯曲5号','小李子','福州艾玛超市','2132-23213421',''),(2,'天津兴达大街888号','小张','天津王大连锁酒店','23432222311','优质客户'),(3,'大凉山妥洛村','小爱','大凉山希望小学','233243211','照顾客户2'),(4,'南通通州新金路888号','王二小','南通通州综艺集团','1832132321','');

/*Table structure for table `t_customer_return_list` */

DROP TABLE IF EXISTS `t_customer_return_list`;

CREATE TABLE `t_customer_return_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount_paid` float NOT NULL,
  `amount_payable` float NOT NULL,
  `customer_return_date` datetime DEFAULT NULL,
  `customer_return_number` varchar(100) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKl0ahdwa8slkocbfe57opembfx` (`customer_id`),
  KEY `FKd55ju83f0ntixagdvdrsmw10c` (`user_id`),
  CONSTRAINT `FKd55ju83f0ntixagdvdrsmw10c` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FKl0ahdwa8slkocbfe57opembfx` FOREIGN KEY (`customer_id`) REFERENCES `t_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_customer_return_list` */

/*Table structure for table `t_customer_return_list_goods` */

DROP TABLE IF EXISTS `t_customer_return_list_goods`;

CREATE TABLE `t_customer_return_list_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `price` float NOT NULL,
  `total` float NOT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `customer_return_list_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtqt67mbn96lxn8hvtl4piblhi` (`customer_return_list_id`),
  KEY `FK4sm5si4swbj3gae46jfk441yx` (`type_id`),
  CONSTRAINT `FK4sm5si4swbj3gae46jfk441yx` FOREIGN KEY (`type_id`) REFERENCES `t_goodstype` (`id`),
  CONSTRAINT `FKtqt67mbn96lxn8hvtl4piblhi` FOREIGN KEY (`customer_return_list_id`) REFERENCES `t_customer_return_list` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_customer_return_list_goods` */

/*Table structure for table `t_damage_list` */

DROP TABLE IF EXISTS `t_damage_list`;

CREATE TABLE `t_damage_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `damage_date` datetime DEFAULT NULL,
  `damage_number` varchar(100) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpn094ma69sch1icjc2gu7xus` (`user_id`),
  CONSTRAINT `FKpn094ma69sch1icjc2gu7xus` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_damage_list` */

/*Table structure for table `t_damage_list_goods` */

DROP TABLE IF EXISTS `t_damage_list_goods`;

CREATE TABLE `t_damage_list_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `price` float NOT NULL,
  `total` float NOT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `damage_list_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbf5m8mm3gctrnuubr9xkjamj8` (`damage_list_id`),
  KEY `FKdbdfmp09hlf2raktincwroe9n` (`type_id`),
  CONSTRAINT `FKbf5m8mm3gctrnuubr9xkjamj8` FOREIGN KEY (`damage_list_id`) REFERENCES `t_damage_list` (`id`),
  CONSTRAINT `FKdbdfmp09hlf2raktincwroe9n` FOREIGN KEY (`type_id`) REFERENCES `t_goodstype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_damage_list_goods` */

/*Table structure for table `t_goods` */

DROP TABLE IF EXISTS `t_goods`;

CREATE TABLE `t_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `inventory_quantity` int(11) NOT NULL,
  `last_purchasing_price` float NOT NULL,
  `min_num` int(11) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `producer` varchar(200) DEFAULT NULL,
  `purchasing_price` float NOT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `selling_price` float NOT NULL,
  `state` int(11) NOT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlxnna5ngumghp4f279mmbjtyo` (`type_id`),
  CONSTRAINT `FKlxnna5ngumghp4f279mmbjtyo` FOREIGN KEY (`type_id`) REFERENCES `t_goodstype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods` */

insert  into `t_goods`(`id`,`code`,`inventory_quantity`,`last_purchasing_price`,`min_num`,`model`,`name`,`producer`,`purchasing_price`,`remarks`,`selling_price`,`state`,`unit`,`type_id`) values (1,'0001',175,8.5,1000,'红色装','陶华碧老干妈香辣脆油辣椒','贵州省贵阳南明老干妈风味食品有限公司',6.32,'好卖',8.5,2,'瓶',10),(2,'0002',51,2220,400,'Note8','华为荣耀Note8','华为计算机系统有限公司',1967.93,'热销',2200,2,'台',16),(11,'0003',2875,23,400,'500g装','野生东北黑木耳','辉南县博康土特产有限公司',23,'够黑2',38,2,'袋',11),(12,'0004',105,13,300,'2斤装','新疆红枣','沧州铭鑫食品有限公司',13,'好吃',25,2,'袋',10),(13,'0005',53,8,1000,'散装500克','麦片燕麦巧克力','福建省麦德好食品工业有限公司',8,'Goods',15,2,'袋',11),(14,'0006',63,5,1999,'300g装','冰糖金桔干','揭西县同心食品有限公司',5.06,'',13,2,'盒',11),(15,'0007',100649,4.5,400,'500g装','吉利人家牛肉味蛋糕','合肥吉利人家食品有限公司',4.5,'good',10,2,'袋',11),(16,'0008',198,3,500,'128g装','奕森奶油桃肉蜜饯果脯果干桃肉干休闲零食品','潮州市潮安区正大食品有限公司',3,'',10,2,'盒',11),(17,'0009',365,20,1000,'240g装','休闲零食坚果特产精品干果无漂白大个开心果','石家庄博群食品有限公司',20,'',33,2,'袋',11),(18,'0010',10,12,300,'250g装','劲仔小鱼干','湖南省华文食品有限公司',12,'',20,2,'袋',11),(19,'0011',11,3.2,300,'198g装','山楂条','临朐县七贤升利食品厂',3.2,'',10,0,'袋',11),(20,'0012',22,20,200,'500g装','大乌梅干','长春市鼎丰真食品有限责任公司',20,'',25,0,'袋',11),(21,'0013',400,3,100,'250g装','手工制作芝麻香酥麻通','桂林兰雨食品有限公司',3,'',8,2,'袋',11),(22,'0014',12,5,200,'250g装','美国青豆原味 蒜香','菲律宾',5,'',8,2,'袋',11),(24,'0015',47,8000,100,'X',' iPhone X','xx2',8000,'xxx2',9500,2,'台',16),(25,'0016',0,100,12,'X','21','32',100,'21',120,0,'盒',3),(26,'0017',-1,3000,100,'ILCE-A6000L','Sony/索尼 ILCE-A6000L WIFI微单数码相机高清单电','xxx',3000,'xxx',3650,2,'台',15),(27,'0018',-1,800,400,'IXUS 285 HS','Canon/佳能 IXUS 285 HS 数码相机 2020万像素高清拍摄','xx',800,'xxx',1299,2,'台',15),(28,'0019',0,60,300,'Q8','Golden Field/金河田 Q8电脑音响台式多媒体家用音箱低音炮重低音','xxxx',60,'',129,0,'台',17),(29,'0020',0,1000,50,'190WDPT','Haier/海尔冰箱BCD-190WDPT双门电冰箱大两门冷藏冷冻','cc',1000,'',1699,0,'台',14),(30,'0021',0,700,320,'4A ','Xiaomi/小米 小米电视4A 32英寸 智能液晶平板电视机','cc',700,'',1199,0,'台',12),(31,'0022',0,400,40,'XQB55-36SP','TCL XQB55-36SP 5.5公斤全自动波轮迷你小型洗衣机家用单脱抗菌','cc',400,'',729,0,'台',13),(32,'0023',0,4,1000,'80g*2','台湾进口膨化零食品张君雅小妹妹日式串烧丸子80g*2','cc',4,'',15,0,'袋',9),(33,'0024',0,168,10,'A字裙','卓图女装立领针织格子印花拼接高腰A字裙2017秋冬新款碎花连衣裙','cc',168,'',298,0,'件',6),(34,'0025',0,189,10,'三件套秋','西服套装男三件套秋季新款商务修身职业正装男士西装新郎结婚礼服','cc',189,'',299,0,'件',7),(35,'0026',0,60,10,'AFS JEEP','加绒加厚正品AFS JEEP/战地吉普男大码长裤植绒保暖男士牛仔裤子','c',60,'',89,0,'条',8),(44,'0029',0,0,31224,'32124','32124','31224',31224,'32124',32124,0,'个',4),(45,'0030',100,60,100,'AB','破洞牛仔','森马',60,'秋季',90,0,'件',8);

/*Table structure for table `t_goodstype` */

DROP TABLE IF EXISTS `t_goodstype`;

CREATE TABLE `t_goodstype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(100) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `p_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `t_goodstype` */

insert  into `t_goodstype`(`id`,`icon`,`name`,`p_id`,`state`) values (1,'icon-folderOpen','所有类别',-1,1),(2,'icon-folder','服饰',1,1),(3,'icon-folder','食品',1,1),(4,'icon-folder','家电',1,1),(5,'icon-folder','数码',1,1),(6,'icon-folder','连衣裙',2,0),(7,'icon-folder','男士西装',2,0),(8,'icon-folder','牛仔裤',2,0),(9,'icon-folder','进口食品',3,0),(10,'icon-folder','地方特产',3,0),(11,'icon-folder','休闲食品',3,0),(12,'icon-folder','电视机',4,0),(13,'icon-folder','洗衣机',4,0),(14,'icon-folder','冰箱',4,0),(15,'icon-folder','相机',5,0),(16,'icon-folder','手机',5,0),(17,'icon-folder','音箱',5,0),(21,'icon-folder','测试',1,0),(22,'icon-folder','休闲',2,0);

/*Table structure for table `t_goodsunit` */

DROP TABLE IF EXISTS `t_goodsunit`;

CREATE TABLE `t_goodsunit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `t_goodsunit` */

insert  into `t_goodsunit`(`id`,`name`) values (1,'个'),(2,'袋'),(3,'盒'),(4,'箱'),(5,'台'),(6,'包'),(11,'件'),(12,'条'),(15,'新');

/*Table structure for table `t_log` */

DROP TABLE IF EXISTS `t_log`;

CREATE TABLE `t_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `time` datetime DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbvn5yabu3vqwvtjoh32i9r4ip` (`user_id`),
  CONSTRAINT `FKbvn5yabu3vqwvtjoh32i9r4ip` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=utf8;

/*Data for the table `t_log` */

insert  into `t_log`(`id`,`content`,`time`,`type`,`user_id`) values (1,'用户登录','2017-11-17 22:00:36','登录操作',1),(2,'查询用户信息','2017-11-17 22:00:54','查询操作',1),(3,'查询用户信息','2017-11-17 22:00:54','查询操作',1),(4,'查询用户信息','2017-11-17 22:01:37','查询操作',1),(5,'查询用户信息','2017-11-17 22:01:56','查询操作',1),(6,'查询用户信息','2017-11-17 22:01:56','查询操作',1),(7,'查询角色信息','2017-11-17 22:02:16','查询操作',1),(8,'查询角色信息','2017-11-17 22:02:16','查询操作',1),(9,'添加角色信息Role [id=null, name=213, remarks=321]','2017-11-17 22:02:30','添加操作',1),(10,'查询角色信息','2017-11-17 22:02:30','查询操作',1),(11,'修改角色信息Role [id=12, name=2132, remarks=32132]','2017-11-17 22:02:34','更新操作',1),(12,'查询角色信息','2017-11-17 22:02:34','查询操作',1),(13,'删除角色信息Role [id=12, name=2132, remarks=32132]','2017-11-17 22:02:37','删除操作',1),(14,'查询角色信息','2017-11-17 22:02:37','查询操作',1),(15,'添加用户信息User [id=null, userName=32, password=432, trueName=432, remarks=432, roles=null]','2017-11-17 22:02:59','添加操作',1),(16,'查询用户信息','2017-11-17 22:02:59','查询操作',1),(17,'删除用户信息User [id=10, userName=32, password=432, trueName=432, remarks=432, roles=null]','2017-11-17 22:03:02','删除操作',1),(18,'查询用户信息','2017-11-17 22:03:02','查询操作',1),(19,'用户登录','2017-11-17 22:03:47','登录操作',1),(20,'查询用户信息','2017-11-17 22:04:06','查询操作',1),(21,'用户登录','2017-11-18 19:12:03','登录操作',1),(22,'用户登录','2017-11-18 19:15:24','登录操作',1),(23,'用户登录','2017-11-18 22:25:18','登录操作',1),(24,'用户登录','2017-11-18 22:25:52','登录操作',1),(25,'用户登录','2017-11-18 22:27:30','登录操作',1),(26,'用户登录','2017-11-18 22:45:23','登录操作',1),(27,'用户登录','2018-10-18 12:23:41','登录操作',1),(28,'查询用户信息','2018-10-18 12:24:19','查询操作',1),(29,'查询用户信息','2018-10-18 12:24:19','查询操作',1),(30,'查询角色信息','2018-10-18 12:24:22','查询操作',1),(31,'查询角色信息','2018-10-18 12:24:22','查询操作',1),(32,'用户登录','2018-10-18 13:06:43','登录操作',1),(33,'用户注销','2018-10-18 13:07:46','注销操作',1),(34,'用户登录','2018-10-18 13:13:33','登录操作',1),(35,'用户注销','2018-10-18 13:14:33','注销操作',1),(36,'用户登录','2018-10-18 13:15:16','登录操作',1),(37,'用户登录','2018-10-18 13:19:20','登录操作',1),(38,'修改密码','2018-10-18 13:19:36','更新操作',1),(39,'用户注销','2018-10-18 13:19:43','注销操作',1),(40,'用户登录','2018-10-18 13:19:56','登录操作',1),(41,'用户登录','2018-10-18 13:41:48','登录操作',1),(42,'查询供应商信息','2018-10-18 13:41:53','查询操作',1),(43,'查询供应商信息','2018-10-18 13:41:53','查询操作',1),(44,'查询供应商信息','2018-10-18 13:42:44','查询操作',1),(45,'查询供应商信息','2018-10-18 13:42:44','查询操作',1),(46,'用户登录','2018-10-18 13:47:36','登录操作',1),(47,'查询客户信息','2018-10-18 13:47:42','查询操作',1),(48,'查询客户信息','2018-10-18 13:47:42','查询操作',1),(49,'查询客户信息','2018-10-18 13:47:54','查询操作',1),(50,'查询客户信息','2018-10-18 13:47:58','查询操作',1),(51,'查询客户信息','2018-10-18 13:48:06','查询操作',1),(52,'查询客户信息','2018-10-18 13:48:10','查询操作',1),(53,'用户登录','2018-10-18 15:09:31','登录操作',1),(54,'查询所有商品类别信息','2018-10-18 15:09:48','查询操作',1),(55,'查询商品单位信息','2018-10-18 15:09:48','查询操作',1),(56,'查询商品信息','2018-10-18 15:09:48','查询操作',1),(57,'查询商品单位信息','2018-10-18 15:09:48','查询操作',1),(58,'查询商品信息','2018-10-18 15:09:48','查询操作',1),(59,'查询商品信息','2018-10-18 15:10:04','查询操作',1),(60,'添加商品类别信息','2018-10-18 15:10:31','添加操作',1),(61,'查询所有商品类别信息','2018-10-18 15:10:31','查询操作',1),(62,'查询商品信息','2018-10-18 15:10:33','查询操作',1),(63,'查询商品信息','2018-10-18 15:10:43','查询操作',1),(64,'查询商品信息','2018-10-18 15:10:44','查询操作',1),(65,'查询商品信息','2018-10-18 15:10:45','查询操作',1),(66,'查询商品信息','2018-10-18 15:10:46','查询操作',1),(67,'查询商品信息','2018-10-18 15:10:56','查询操作',1),(68,'查询商品信息','2018-10-18 15:10:56','查询操作',1),(69,'用户登录','2018-10-19 18:14:34','登录操作',1),(70,'查询供应商信息','2018-10-19 18:14:39','查询操作',1),(71,'查询供应商信息','2018-10-19 18:14:39','查询操作',1),(72,'查询角色信息','2018-10-19 18:14:43','查询操作',1),(73,'查询角色信息','2018-10-19 18:14:43','查询操作',1),(74,'查询客户信息','2018-10-19 18:15:28','查询操作',1),(75,'查询客户信息','2018-10-19 18:15:28','查询操作',1),(76,'查询所有商品类别信息','2018-10-19 18:15:31','查询操作',1),(77,'查询商品单位信息','2018-10-19 18:15:31','查询操作',1),(78,'查询商品信息','2018-10-19 18:15:31','查询操作',1),(79,'查询商品单位信息','2018-10-19 18:15:31','查询操作',1),(80,'查询商品信息','2018-10-19 18:15:31','查询操作',1),(81,'用户登录','2018-10-22 18:42:59','登录操作',1),(82,'查询角色信息','2018-10-22 18:43:27','查询操作',1),(83,'查询角色信息','2018-10-22 18:43:27','查询操作',1),(84,'查询所有商品类别信息','2018-10-22 18:43:31','查询操作',1),(85,'查询商品单位信息','2018-10-22 18:43:32','查询操作',1),(86,'查询商品信息','2018-10-22 18:43:32','查询操作',1),(87,'查询商品单位信息','2018-10-22 18:43:32','查询操作',1),(88,'查询商品信息','2018-10-22 18:43:32','查询操作',1),(89,'查询商品信息','2018-10-22 18:43:35','查询操作',1),(90,'查询商品信息','2018-10-22 18:43:36','查询操作',1),(91,'查询商品信息','2018-10-22 18:43:37','查询操作',1),(92,'查询商品信息','2018-10-22 18:43:37','查询操作',1),(93,'查询商品信息','2018-10-22 18:43:39','查询操作',1),(94,'查询商品信息','2018-10-22 18:43:40','查询操作',1),(95,'用户登录','2018-10-22 18:54:05','登录操作',1),(96,'查询所有商品类别信息','2018-10-22 18:54:34','查询操作',1),(97,'查询商品信息','2018-10-22 18:54:34','查询操作',1),(98,'查询商品单位信息','2018-10-22 18:54:34','查询操作',1),(99,'查询商品单位信息','2018-10-22 18:54:34','查询操作',1),(100,'查询商品信息','2018-10-22 18:54:34','查询操作',1),(101,'查询商品信息(无库存)','2018-10-22 18:54:36','查询操作',1),(102,'查询商品信息(有库存)','2018-10-22 18:54:37','查询操作',1),(103,'查询商品信息(无库存)','2018-10-22 18:54:48','查询操作',1),(104,'查询商品信息(无库存)','2018-10-22 18:54:48','查询操作',1),(105,'查询商品信息(无库存)','2018-10-22 18:54:48','查询操作',1),(106,'查询商品信息(无库存)','2018-10-22 18:54:48','查询操作',1),(107,'查询商品信息(无库存)','2018-10-22 18:54:49','查询操作',1),(108,'查询商品信息(无库存)','2018-10-22 18:54:49','查询操作',1),(109,'查询商品信息(无库存)','2018-10-22 18:54:49','查询操作',1),(110,'查询商品信息(无库存)','2018-10-22 18:54:51','查询操作',1),(111,'用户登录','2018-10-22 19:02:23','登录操作',1),(112,'查询所有商品类别信息','2018-10-22 19:02:28','查询操作',1),(113,'查询商品单位信息','2018-10-22 19:02:28','查询操作',1),(114,'查询商品信息','2018-10-22 19:02:28','查询操作',1),(115,'查询商品单位信息','2018-10-22 19:02:28','查询操作',1),(116,'查询商品信息','2018-10-22 19:02:28','查询操作',1),(117,'查询商品信息','2018-10-22 19:02:39','查询操作',1),(118,'查询商品信息','2018-10-22 19:02:45','查询操作',1),(119,'添加商品信息Goods [id=null, code=0030, name=破洞牛仔, model=AB, type=GoodsType [id=8, name=null, state=null, icon=null, pId=null], unit=件, lastPurchasingPrice=0.0, purchasingPrice=60.0, sellingPrice=90.0, inventoryQuantity=0, minNum=100, state=0, producer=森马, remarks=秋季]','2018-10-22 19:06:06','添加操作',1),(120,'查询商品信息','2018-10-22 19:06:06','查询操作',1),(121,'查询商品信息(无库存)','2018-10-22 19:06:16','查询操作',1),(122,'查询商品信息(有库存)','2018-10-22 19:06:16','查询操作',1),(123,'查询商品信息(无库存)','2018-10-22 19:06:19','查询操作',1),(124,'查询商品信息(无库存)','2018-10-22 19:06:19','查询操作',1),(125,'查询商品信息(无库存)','2018-10-22 19:06:19','查询操作',1),(126,'查询商品信息(无库存)','2018-10-22 19:06:19','查询操作',1),(127,'用户登录','2018-10-22 19:08:16','登录操作',1),(128,'查询商品信息(无库存)','2018-10-22 19:08:20','查询操作',1),(129,'查询商品信息(无库存)','2018-10-22 19:08:20','查询操作',1),(130,'查询商品信息(有库存)','2018-10-22 19:08:20','查询操作',1),(131,'查询商品信息(有库存)','2018-10-22 19:08:20','查询操作',1),(132,'查询商品信息(无库存)','2018-10-22 19:08:23','查询操作',1),(133,'查询商品信息(无库存)','2018-10-22 19:08:24','查询操作',1),(134,'查询商品信息(无库存)','2018-10-22 19:08:24','查询操作',1),(135,'查询商品信息(无库存)','2018-10-22 19:08:24','查询操作',1),(136,'查询商品信息(无库存)','2018-10-22 19:08:24','查询操作',1),(137,'查询商品信息(无库存)','2018-10-22 19:08:25','查询操作',1),(138,'查询商品信息(无库存)','2018-10-22 19:08:25','查询操作',1),(139,'查询商品信息(无库存)','2018-10-22 19:08:25','查询操作',1),(140,'查询商品信息(无库存)','2018-10-22 19:08:26','查询操作',1),(141,'查询商品信息(无库存)','2018-10-22 19:08:26','查询操作',1),(142,'查询商品信息(无库存)','2018-10-22 19:08:27','查询操作',1),(143,'查询商品信息(无库存)','2018-10-22 19:08:27','查询操作',1),(144,'查询商品信息(无库存)','2018-10-22 19:08:27','查询操作',1),(145,'查询商品信息(无库存)','2018-10-22 19:08:57','查询操作',1),(146,'查询商品信息(有库存)','2018-10-22 19:08:57','查询操作',1),(147,'查询商品信息(无库存)','2018-10-22 19:08:57','查询操作',1),(148,'查询商品信息(有库存)','2018-10-22 19:08:57','查询操作',1),(149,'查询商品信息(无库存)','2018-10-22 19:11:09','查询操作',1),(150,'查询商品信息(有库存)','2018-10-22 19:11:09','查询操作',1),(151,'查询商品信息(无库存)','2018-10-22 19:11:09','查询操作',1),(152,'查询商品信息(有库存)','2018-10-22 19:11:09','查询操作',1),(153,'查询商品信息(无库存)','2018-10-22 19:11:24','查询操作',1),(154,'查询商品信息(无库存)','2018-10-22 19:11:24','查询操作',1),(155,'查询商品信息(无库存)','2018-10-22 19:11:26','查询操作',1),(156,'查询商品信息(无库存)','2018-10-22 19:16:06','查询操作',1),(157,'查询商品信息(有库存)','2018-10-22 19:16:06','查询操作',1),(158,'查询商品信息(无库存)','2018-10-22 19:16:06','查询操作',1),(159,'查询商品信息(有库存)','2018-10-22 19:16:06','查询操作',1),(160,'查询商品信息(无库存)','2018-10-22 19:16:09','查询操作',1),(161,'查询商品信息(无库存)','2018-10-22 19:16:09','查询操作',1),(162,'查询商品信息(无库存)','2018-10-22 19:16:09','查询操作',1),(163,'查询商品信息(无库存)','2018-10-22 19:16:10','查询操作',1),(164,'修改商品信息：Goods [id=45, code=0030, name=破洞牛仔, model=AB, type=GoodsType [id=8, name=牛仔裤, state=0, icon=icon-folder, pId=2], unit=件, lastPurchasingPrice=60.0, purchasingPrice=60.0, sellingPrice=90.0, inventoryQuantity=100, minNum=100, state=0, producer=森马, remarks=秋季]，价格=60.0,库存=100','2018-10-22 19:16:35','更新操作',1),(165,'查询商品信息(无库存)','2018-10-22 19:16:36','查询操作',1),(166,'查询商品信息(有库存)','2018-10-22 19:16:36','查询操作',1),(167,'查询商品信息(无库存)','2018-10-22 19:16:38','查询操作',1),(168,'查询商品信息(无库存)','2018-10-22 19:16:39','查询操作',1),(169,'查询所有商品类别信息','2018-10-22 19:16:45','查询操作',1),(170,'查询商品信息','2018-10-22 19:16:45','查询操作',1),(171,'查询商品单位信息','2018-10-22 19:16:45','查询操作',1),(172,'查询商品单位信息','2018-10-22 19:16:46','查询操作',1),(173,'查询商品信息','2018-10-22 19:16:46','查询操作',1),(174,'查询商品信息','2018-10-22 19:16:49','查询操作',1),(175,'用户登录','2018-10-22 19:48:11','登录操作',1),(176,'查询商品信息','2018-10-22 19:48:24','查询操作',1),(177,'查询商品信息','2018-10-22 19:48:24','查询操作',1),(178,'查询商品信息','2018-10-22 19:50:09','查询操作',1),(179,'查询商品信息','2018-10-22 19:50:09','查询操作',1),(180,'查询商品信息','2018-10-22 19:50:14','查询操作',1),(181,'查询商品信息','2018-10-22 19:50:14','查询操作',1),(182,'查询商品信息','2018-10-22 19:50:25','查询操作',1),(183,'查询商品信息','2018-10-22 19:50:25','查询操作',1),(184,'查询所有商品类别信息','2018-10-22 19:50:53','查询操作',1),(185,'查询所有商品类别信息','2018-10-22 19:51:14','查询操作',1),(186,'查询商品信息','2018-10-22 19:51:31','查询操作',1),(187,'查询商品信息','2018-10-22 19:51:31','查询操作',1),(188,'查询所有商品类别信息','2018-10-22 19:52:48','查询操作',1),(189,'查询供应商信息','2018-10-22 19:55:52','查询操作',1),(190,'查询供应商信息','2018-10-22 19:55:52','查询操作',1),(191,'用户登录','2018-10-22 19:59:36','登录操作',1),(192,'查询商品信息','2018-10-22 19:59:40','查询操作',1),(193,'查询商品信息','2018-10-22 19:59:40','查询操作',1),(194,'查询所有商品类别信息','2018-10-22 19:59:45','查询操作',1),(195,'添加进货单','2018-10-22 20:00:06','添加操作',1),(196,'查询商品信息','2018-10-22 20:00:09','查询操作',1),(197,'查询商品信息','2018-10-22 20:00:09','查询操作',1),(198,'查询所有商品类别信息','2018-10-22 20:00:26','查询操作',1),(199,'查询商品信息','2018-10-22 20:00:26','查询操作',1),(200,'查询商品单位信息','2018-10-22 20:00:26','查询操作',1),(201,'查询商品单位信息','2018-10-22 20:00:26','查询操作',1),(202,'查询商品信息','2018-10-22 20:00:26','查询操作',1),(203,'查询商品信息(无库存)','2018-10-22 20:00:39','查询操作',1),(204,'查询商品信息(有库存)','2018-10-22 20:00:39','查询操作',1),(205,'查询商品信息(无库存)','2018-10-22 20:00:39','查询操作',1),(206,'查询商品信息(有库存)','2018-10-22 20:00:39','查询操作',1),(207,'查询商品信息(有库存)','2018-10-22 20:00:41','查询操作',1),(208,'查询商品信息(有库存)','2018-10-22 20:00:42','查询操作',1),(209,'查询商品信息(有库存)','2018-10-22 20:00:42','查询操作',1),(210,'查询商品信息(有库存)','2018-10-22 20:00:42','查询操作',1),(211,'查询商品信息(有库存)','2018-10-22 20:00:43','查询操作',1),(212,'查询商品信息(有库存)','2018-10-22 20:00:43','查询操作',1),(213,'查询商品信息(有库存)','2018-10-22 20:00:44','查询操作',1),(214,'查询商品信息(有库存)','2018-10-22 20:00:44','查询操作',1),(215,'查询商品信息(有库存)','2018-10-22 20:00:44','查询操作',1),(216,'查询商品信息(有库存)','2018-10-22 20:00:45','查询操作',1),(217,'查询商品信息(有库存)','2018-10-22 20:00:45','查询操作',1),(218,'用户登录','2018-10-23 10:36:39','登录操作',1),(219,'查询商品信息','2018-10-23 10:36:43','查询操作',1),(220,'查询商品信息','2018-10-23 10:36:43','查询操作',1),(221,'查询所有商品类别信息','2018-10-23 10:36:53','查询操作',1),(222,'添加退货单','2018-10-23 10:37:13','添加操作',1),(223,'查询商品信息','2018-10-23 10:37:16','查询操作',1),(224,'查询商品信息','2018-10-23 10:37:16','查询操作',1),(225,'查询商品信息(无库存)','2018-10-23 10:37:20','查询操作',1),(226,'查询商品信息(有库存)','2018-10-23 10:37:20','查询操作',1),(227,'查询商品信息(无库存)','2018-10-23 10:37:20','查询操作',1),(228,'查询商品信息(有库存)','2018-10-23 10:37:20','查询操作',1),(229,'用户登录','2018-10-23 11:00:58','登录操作',1),(230,'查询商品信息','2018-10-23 11:01:30','查询操作',1),(231,'查询商品信息','2018-10-23 11:01:30','查询操作',1),(232,'用户登录','2018-10-23 15:49:04','登录操作',1),(233,'进货单查询','2018-10-23 15:49:22','查询操作',1),(234,'用户登录','2018-11-05 14:18:26','登录操作',1),(235,'用户登录','2018-11-05 14:29:56','登录操作',1),(236,'查询商品信息','2018-11-05 14:30:05','查询操作',1),(237,'查询商品信息','2018-11-05 14:30:05','查询操作',1),(238,'用户登录','2018-11-05 14:49:36','登录操作',1),(239,'查询商品信息','2018-11-05 14:49:40','查询操作',1),(240,'查询商品信息','2018-11-05 14:49:40','查询操作',1),(241,'查询商品信息','2018-11-05 14:49:51','查询操作',1),(242,'查询商品信息','2018-11-05 14:49:51','查询操作',1),(243,'查询所有商品类别信息','2018-11-05 14:49:52','查询操作',1),(244,'查询所有商品类别信息','2018-11-05 14:50:21','查询操作',1),(245,'查询商品信息','2018-11-05 14:50:22','查询操作',1),(246,'查询商品单位信息','2018-11-05 14:50:22','查询操作',1),(247,'查询商品单位信息','2018-11-05 14:50:22','查询操作',1),(248,'查询商品信息','2018-11-05 14:50:22','查询操作',1),(249,'查询商品信息','2018-11-05 14:50:23','查询操作',1),(250,'用户登录','2018-11-05 14:58:18','登录操作',1),(251,'查询商品信息','2018-11-05 14:58:20','查询操作',1),(252,'查询商品信息','2018-11-05 14:58:22','查询操作',1),(253,'查询所有商品类别信息','2018-11-05 14:58:24','查询操作',1),(254,'查询商品信息','2018-11-05 14:58:31','查询操作',1),(255,'用户登录','2018-11-05 15:47:45','登录操作',1),(256,'查询商品信息','2018-11-05 15:47:47','查询操作',1),(257,'查询商品信息','2018-11-05 15:47:59','查询操作',1),(258,'查询商品信息','2018-11-05 15:48:00','查询操作',1),(259,'查询商品信息','2018-11-05 15:48:04','查询操作',1),(260,'查询商品信息','2018-11-05 15:48:05','查询操作',1),(261,'查询所有商品类别信息','2018-11-05 15:48:10','查询操作',1),(262,'查询库存报警商品信息','2018-11-05 15:48:14','查询操作',1),(263,'查询商品信息','2018-11-05 15:48:22','查询操作',1),(264,'用户登录','2018-11-05 16:03:28','登录操作',1),(265,'查询商品信息','2018-11-05 16:03:29','查询操作',1),(266,'退货单查询','2018-11-05 16:03:39','查询操作',1),(267,'进货单查询','2018-11-05 16:03:39','查询操作',1),(268,'进货单查询','2018-11-05 16:03:47','查询操作',1),(269,'退货单查询','2018-11-05 16:03:47','查询操作',1),(270,'退货单查询','2018-11-05 16:03:51','查询操作',1),(271,'进货单查询','2018-11-05 16:03:51','查询操作',1),(272,'用户登录','2018-11-05 16:49:22','登录操作',1),(273,'查询商品信息','2018-11-05 16:49:24','查询操作',1),(274,'用户登录','2018-11-05 16:54:25','登录操作',1),(275,'查询商品信息','2018-11-05 16:54:29','查询操作',1),(276,'客户退货单查询','2018-11-05 16:54:43','查询操作',1),(277,'销售单查询','2018-11-05 16:54:43','查询操作',1),(278,'销售单查询','2018-11-05 16:54:44','查询操作',1),(279,'客户退货单查询','2018-11-05 16:54:44','查询操作',1),(280,'销售单查询','2018-11-05 16:54:55','查询操作',1),(281,'客户退货单查询','2018-11-05 16:54:55','查询操作',1),(282,'销售单查询','2018-11-05 16:55:03','查询操作',1),(283,'客户退货单查询','2018-11-05 16:55:03','查询操作',1),(284,'销售单查询','2018-11-05 16:55:14','查询操作',1),(285,'客户退货单查询','2018-11-05 16:55:14','查询操作',1),(286,'客户退货单查询','2018-11-05 16:55:17','查询操作',1),(287,'销售单查询','2018-11-05 16:55:17','查询操作',1),(288,'商品采购统计查询','2018-11-05 16:55:23','查询操作',1),(289,'商品采购统计查询','2018-11-05 16:55:23','查询操作',1),(290,'商品销售统计查询','2018-11-05 16:55:27','查询操作',1),(291,'商品销售统计查询','2018-11-05 16:55:40','查询操作',1),(292,'用户登录','2018-11-05 17:03:09','登录操作',1),(293,'查询商品信息','2018-11-05 17:03:12','查询操作',1),(294,'客户退货单查询','2018-11-05 17:03:18','查询操作',1),(295,'销售单查询','2018-11-05 17:03:18','查询操作',1),(296,'商品采购统计查询','2018-11-05 17:03:36','查询操作',1),(297,'商品采购统计查询','2018-11-05 17:03:36','查询操作',1),(298,'商品销售统计查询','2018-11-05 17:03:57','查询操作',1),(299,'商品销售统计查询','2018-11-05 17:03:57','查询操作',1),(300,'查询商品信息','2018-11-05 17:04:13','查询操作',1),(301,'查询商品信息','2018-11-05 17:04:13','查询操作',1),(302,'查询所有商品类别信息','2018-11-05 17:05:22','查询操作',1),(303,'添加销售单','2018-11-05 17:05:40','添加操作',1),(304,'查询商品信息','2018-11-05 17:05:45','查询操作',1),(305,'查询商品信息','2018-11-05 17:05:45','查询操作',1),(306,'商品销售统计查询','2018-11-05 17:05:48','查询操作',1),(307,'商品销售统计查询','2018-11-05 17:05:48','查询操作',1),(308,'用户登录','2018-11-05 17:12:23','登录操作',1),(309,'查询商品信息','2018-11-05 17:12:26','查询操作',1),(310,'用户登录','2018-11-05 17:16:42','登录操作',1),(311,'查询商品信息','2018-11-05 17:16:47','查询操作',1);

/*Table structure for table `t_menu` */

DROP TABLE IF EXISTS `t_menu`;

CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(100) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `p_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6051 DEFAULT CHARSET=utf8;

/*Data for the table `t_menu` */

insert  into `t_menu`(`id`,`icon`,`name`,`p_id`,`state`,`url`) values (1,'menu-plugin','系统菜单',-1,1,NULL),(10,'menu-1','进货管理',1,1,NULL),(20,'menu-2','销售管理',1,1,NULL),(30,'menu-3','库存管理',1,1,NULL),(40,'menu-4','统计报表',1,1,NULL),(50,'menu-5','基础资料',1,1,NULL),(60,'menu-6','系统管理',1,1,NULL),(1010,'menu-11','进货入库',10,0,'/purchase/purchase.html'),(1020,'menu-12','退货出库',10,0,'/purchase/return.html'),(1030,'menu-13','进货单据查询',10,0,'/purchase/purchaseSearch.html'),(1040,'menu-14','退货单据查询',10,0,'/purchase/returnSearch.html'),(1050,'menu-15','当前库存查询',10,0,'/common/stockSearch.html'),(2010,'menu-21','销售出库',20,0,'/sale/saleout.html'),(2020,'menu-22','客户退货',20,0,'/sale/salereturn.html'),(2030,'menu-23','销售单据查询',20,0,'/sale/saleSearch.html'),(2040,'menu-24','客户退货查询',20,0,'/sale/returnSearch.html'),(2050,'menu-25','当前库存查询',20,0,'/common/stockSearch.html'),(3010,'menu-31','商品报损',30,0,'/stock/damage.html'),(3020,'menu-32','商品报溢',30,0,'/stock/overflow.html'),(3030,'menu-33','库存报警',30,0,'/stock/alarm.html'),(3040,'menu-34','报损报溢查询',30,0,'/stock/damageOverflowSearch.html'),(3050,'menu-35','当前库存查询',30,0,'/common/stockSearch.html'),(4010,'menu-41','供应商统计',40,0,'/count/supplier.html'),(4020,'menu-42','客户统计',40,0,'/count/customer.html'),(4030,'menu-43','商品采购统计',40,0,'/count/purchase.html'),(4040,'menu-44','商品销售统计',40,0,'/count/sale.html'),(4050,'menu-45','按日统计分析',40,0,'/count/saleDay.html'),(4060,'menu-46','按月统计分析',40,0,'/count/saleMonth.html'),(5010,'menu-51','供应商管理',50,0,'/basicData/supplier.html'),(5020,'menu-52','客户管理',50,0,'/basicData/customer.html'),(5030,'menu-53','商品管理',50,0,'/basicData/goods.html'),(5040,'menu-54','期初库存',50,0,'/basicData/stock.html'),(6010,'menu-61','角色管理',60,0,'/power/role.html'),(6020,'menu-62','用户管理',60,0,'/power/user.html'),(6030,'menu-65','系统日志',60,0,'/power/log.html'),(6040,'menu-63','修改密码',60,0,NULL),(6050,'menu-64','安全退出',60,0,NULL);

/*Table structure for table `t_overflow_list` */

DROP TABLE IF EXISTS `t_overflow_list`;

CREATE TABLE `t_overflow_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `overflow_date` datetime DEFAULT NULL,
  `overflow_number` varchar(100) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3bu8hj2xniqwbrtg6ls6b8ej2` (`user_id`),
  CONSTRAINT `FK3bu8hj2xniqwbrtg6ls6b8ej2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_overflow_list` */

/*Table structure for table `t_overflow_list_goods` */

DROP TABLE IF EXISTS `t_overflow_list_goods`;

CREATE TABLE `t_overflow_list_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `price` float NOT NULL,
  `total` float NOT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `overflow_list_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd3s9761mgl456tn2xb0d164h7` (`overflow_list_id`),
  KEY `FK8t46iik5kpciki8fnqtiuq5q3` (`type_id`),
  CONSTRAINT `FK8t46iik5kpciki8fnqtiuq5q3` FOREIGN KEY (`type_id`) REFERENCES `t_goodstype` (`id`),
  CONSTRAINT `FKd3s9761mgl456tn2xb0d164h7` FOREIGN KEY (`overflow_list_id`) REFERENCES `t_overflow_list` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_overflow_list_goods` */

/*Table structure for table `t_purchase_list` */

DROP TABLE IF EXISTS `t_purchase_list`;

CREATE TABLE `t_purchase_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount_paid` float NOT NULL,
  `amount_payable` float NOT NULL,
  `purchase_date` datetime DEFAULT NULL,
  `purchase_number` varchar(100) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5j2dev8b2b5d0l69nb8vtr4yb` (`supplier_id`),
  KEY `FK69s6eyxr4wwvsywe9hbthef1h` (`user_id`),
  CONSTRAINT `FK5j2dev8b2b5d0l69nb8vtr4yb` FOREIGN KEY (`supplier_id`) REFERENCES `t_supplier` (`id`),
  CONSTRAINT `FK69s6eyxr4wwvsywe9hbthef1h` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `t_purchase_list` */

insert  into `t_purchase_list`(`id`,`amount_paid`,`amount_payable`,`purchase_date`,`purchase_number`,`remarks`,`state`,`supplier_id`,`user_id`) values (6,4442,4442,'2017-12-04 00:00:00','JH201712040001','cc',1,1,1),(7,2220,2220,'2017-12-04 00:00:00','JH201712040002','cc',1,1,1),(8,16,16,'2017-12-04 00:00:00','JH201712040003','',1,2,1),(9,16800,16800,'2017-12-04 00:00:00','JH201712040004','',1,2,1),(10,9000,9000,'2017-12-04 00:00:00','JH201712040005','',1,2,1),(11,22200,22200,'2018-10-22 00:00:00','JH201810220001','',1,12,1);

/*Table structure for table `t_purchase_list_goods` */

DROP TABLE IF EXISTS `t_purchase_list_goods`;

CREATE TABLE `t_purchase_list_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `price` float NOT NULL,
  `total` float NOT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `purchase_list_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfvdvgcebqkkokyn0o00idqnpy` (`purchase_list_id`),
  KEY `FK83ikbi2x3epn49fwcco8jlfwu` (`type_id`),
  CONSTRAINT `FK83ikbi2x3epn49fwcco8jlfwu` FOREIGN KEY (`type_id`) REFERENCES `t_goodstype` (`id`),
  CONSTRAINT `FKfvdvgcebqkkokyn0o00idqnpy` FOREIGN KEY (`purchase_list_id`) REFERENCES `t_purchase_list` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `t_purchase_list_goods` */

insert  into `t_purchase_list_goods`(`id`,`code`,`goods_id`,`model`,`name`,`num`,`price`,`total`,`unit`,`purchase_list_id`,`type_id`) values (10,'0002',2,'Note8','华为荣耀Note8',2,2220,4440,'台',NULL,16),(11,'0008',16,'128g装','奕森奶油桃肉蜜饯果脯果干桃肉干休闲零食品',1,2,2,'盒',NULL,11),(12,'0002',2,'Note8','华为荣耀Note8',1,2220,2220,'台',NULL,16),(13,'0006',14,'300g装','冰糖金桔干',4,4,16,'盒',NULL,11),(14,'0024',33,'A字裙','卓图女装立领针织格子印花拼接高腰A字裙2017秋冬新款碎花连衣裙',100,168,16800,'件',NULL,6),(15,'0024',33,'A字裙','卓图女装立领针织格子印花拼接高腰A字裙2017秋冬新款碎花连衣裙',50,180,9000,'件',NULL,6),(16,'0002',2,'Note8','华为荣耀Note8',10,2220,22200,'台',NULL,16);

/*Table structure for table `t_return_list` */

DROP TABLE IF EXISTS `t_return_list`;

CREATE TABLE `t_return_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount_paid` float NOT NULL,
  `amount_payable` float NOT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  `return_number` varchar(100) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4qxjj8bvj2etne243xluni0vn` (`supplier_id`),
  KEY `FK904juw2v1hm2av0ig26gae9jb` (`user_id`),
  CONSTRAINT `FK4qxjj8bvj2etne243xluni0vn` FOREIGN KEY (`supplier_id`) REFERENCES `t_supplier` (`id`),
  CONSTRAINT `FK904juw2v1hm2av0ig26gae9jb` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `t_return_list` */

insert  into `t_return_list`(`id`,`amount_paid`,`amount_payable`,`remarks`,`return_date`,`return_number`,`state`,`supplier_id`,`user_id`) values (1,222000,222000,'','2018-10-23 00:00:00','TH201810230001',1,1,1);

/*Table structure for table `t_return_list_goods` */

DROP TABLE IF EXISTS `t_return_list_goods`;

CREATE TABLE `t_return_list_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `price` float NOT NULL,
  `total` float NOT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `return_list_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKemclu281vyvyk063c3foafq1w` (`return_list_id`),
  KEY `FKa1prpd96fcs0x2oe0omny9vio` (`type_id`),
  CONSTRAINT `FKa1prpd96fcs0x2oe0omny9vio` FOREIGN KEY (`type_id`) REFERENCES `t_goodstype` (`id`),
  CONSTRAINT `FKemclu281vyvyk063c3foafq1w` FOREIGN KEY (`return_list_id`) REFERENCES `t_return_list` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `t_return_list_goods` */

insert  into `t_return_list_goods`(`id`,`code`,`goods_id`,`model`,`name`,`num`,`price`,`total`,`unit`,`return_list_id`,`type_id`) values (1,'0002',2,'Note8','华为荣耀Note8',100,2220,222000,'台',NULL,16);

/*Table structure for table `t_role` */

DROP TABLE IF EXISTS `t_role`;

CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `t_role` */

insert  into `t_role`(`id`,`name`,`remarks`) values (1,'系统管理员 最高权限','管理员'),(2,'主管','主管'),(4,'采购员','采购员'),(5,'销售经理','销售经理'),(7,'仓库管理员','仓库管理员'),(9,'总经理','总经理'),(13,'测试员','测试员'),(14,'开发','开发工程师');

/*Table structure for table `t_role_menu` */

DROP TABLE IF EXISTS `t_role_menu`;

CREATE TABLE `t_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhayg4ib6v7h1wyeyxhq6xlddq` (`menu_id`),
  KEY `FKsonb0rbt2u99hbrqqvv3r0wse` (`role_id`),
  CONSTRAINT `FKhayg4ib6v7h1wyeyxhq6xlddq` FOREIGN KEY (`menu_id`) REFERENCES `t_menu` (`id`),
  CONSTRAINT `FKsonb0rbt2u99hbrqqvv3r0wse` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

/*Data for the table `t_role_menu` */

insert  into `t_role_menu`(`id`,`menu_id`,`role_id`) values (2,1,1),(3,10,1),(4,20,1),(5,30,1),(6,40,1),(7,50,1),(8,60,1),(9,1010,1),(10,1020,1),(11,1030,1),(12,1040,1),(13,1050,1),(14,2010,1),(15,2020,1),(16,2030,1),(17,2040,1),(18,2050,1),(19,3010,1),(20,3020,1),(21,3030,1),(22,3040,1),(23,3050,1),(24,4010,1),(25,4020,1),(26,4030,1),(27,4040,1),(28,4050,1),(29,4060,1),(30,5010,1),(31,5020,1),(32,5030,1),(33,5040,1),(34,6010,1),(35,6020,1),(36,10,2),(37,1010,2),(38,1020,2),(39,1030,2),(40,1040,2),(41,1050,2),(42,1,2),(43,6030,1),(44,6040,1),(45,1,4),(46,20,4),(47,2010,4),(48,1,5),(49,30,5),(50,3010,5),(55,1,9),(56,30,9),(57,3040,9),(58,3050,9),(59,50,9),(60,5010,9),(61,5020,9),(62,5030,9),(63,5040,9),(64,6050,1),(65,1,7),(66,10,7),(67,1010,7),(68,1020,7),(69,1030,7),(70,1040,7),(71,1050,7),(72,20,7),(73,2010,7),(74,2020,7),(75,2030,7),(76,40,7),(77,4010,7),(78,4020,7),(110,1,13),(111,10,13),(112,1010,13),(113,1020,13),(114,1030,13),(115,1040,13),(116,1050,13),(117,20,13),(118,2010,13),(119,2020,13),(120,2030,13),(121,2040,13),(122,2050,13),(123,30,13),(124,3010,13),(125,3020,13),(126,3030,13),(127,3040,13),(128,3050,13),(129,1,14),(130,10,14),(131,1010,14),(132,1020,14),(133,1030,14),(134,1040,14),(135,1050,14),(136,20,14),(137,2010,14),(138,2020,14),(139,2030,14),(140,2040,14),(141,2050,14),(142,30,14),(143,3010,14),(144,3020,14),(145,3030,14),(146,3040,14),(147,40,14),(148,4010,14),(149,4020,14),(150,4030,14),(151,4040,14),(152,4050,14),(153,4060,14),(154,50,14),(155,5010,14),(156,5020,14),(157,5030,14),(158,5040,14),(159,60,14),(160,6010,14),(161,6020,14),(162,6030,14),(163,6040,14),(164,6050,14);

/*Table structure for table `t_sale_list` */

DROP TABLE IF EXISTS `t_sale_list`;

CREATE TABLE `t_sale_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount_paid` float NOT NULL,
  `amount_payable` float NOT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `sale_date` datetime DEFAULT NULL,
  `sale_number` varchar(100) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKox4qfs87eu3fvwdmrvelqhi8e` (`customer_id`),
  KEY `FK34bnujemrdqimbhg133enp8k8` (`user_id`),
  CONSTRAINT `FK34bnujemrdqimbhg133enp8k8` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FKox4qfs87eu3fvwdmrvelqhi8e` FOREIGN KEY (`customer_id`) REFERENCES `t_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `t_sale_list` */

insert  into `t_sale_list`(`id`,`amount_paid`,`amount_payable`,`remarks`,`sale_date`,`sale_number`,`state`,`customer_id`,`user_id`) values (1,5550,5550,'','2018-11-05 00:00:00','XS201811050001',1,3,1);

/*Table structure for table `t_sale_list_goods` */

DROP TABLE IF EXISTS `t_sale_list_goods`;

CREATE TABLE `t_sale_list_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `price` float NOT NULL,
  `total` float NOT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `sale_list_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK20ehd6ta9geyql4hxtdsnhbox` (`sale_list_id`),
  KEY `FKn9i5p1d8f0gek5x7q45cq8ibw` (`type_id`),
  CONSTRAINT `FK20ehd6ta9geyql4hxtdsnhbox` FOREIGN KEY (`sale_list_id`) REFERENCES `t_sale_list` (`id`),
  CONSTRAINT `FKn9i5p1d8f0gek5x7q45cq8ibw` FOREIGN KEY (`type_id`) REFERENCES `t_goodstype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `t_sale_list_goods` */

insert  into `t_sale_list_goods`(`id`,`code`,`goods_id`,`model`,`name`,`num`,`price`,`total`,`unit`,`sale_list_id`,`type_id`) values (1,'0004',12,'2斤装','新疆红枣',222,25,5550,'袋',NULL,10);

/*Table structure for table `t_supplier` */

DROP TABLE IF EXISTS `t_supplier`;

CREATE TABLE `t_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(300) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `t_supplier` */

insert  into `t_supplier`(`id`,`address`,`contact`,`name`,`number`,`remarks`) values (1,'上海市金山区张堰镇松金公路2072号6607室','小张','上海福桂食品有限公司','0773-7217175','失信供应商'),(2,'安徽省合肥市肥西县桃花工业园合派路','小王','安徽麦堡食品工业有限公司','0773-7217275',NULL),(3,'晋江市罗山后林西区41号','小李','福建省晋江市罗山惠康食品有限公司','1273-1217175','优质供应商'),(4,'南京市江宁区科学园竹山路565号1幢','小丽','南京含羞草食品有限公司','2121-7217175',NULL),(5,'南京市高淳县阳江镇新桥村下桥278号','王大狗','南京禾乃美工贸有限公司','2133-7217125',NULL),(6,'开平市水口镇东埠路６号','小七','开平广合腐乳有限公司','3332-7217175','2'),(7,'汕头市跃进路２３号利鸿基中心大厦写字楼２座','刘钩子','汕头市金茂食品有限公司','0723-7232175',NULL),(8,'南京市溧水区经济开发区','七枷社','南京喜之郎食品有限公司','1773-7217175',NULL),(9,'深圳市罗湖区翠竹北路中深石化区厂房B栋6楼','小蔡','深圳昌信实业有限公司','1773-7217175',NULL),(10,'南京市下关区金陵小区6村27-2-203室','小路','南京市下关区红鹰调味品商行','2132-7217175',NULL),(11,'荔浦县荔塔路１６－３６号','亲亲','桂林阜康食品工业有限公司','2123-7217175',NULL),(12,'南京鼓楼区世纪大楼123号','小二','南京大王科技','0112-1426789','123'),(13,'南京将军路800号','小吴','南京大陆食品公司','1243-2135487','cc');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(50) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `true_name` varchar(50) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`password`,`remarks`,`true_name`,`user_name`) values (1,'12345','管理员','王大陆','admin'),(2,'123','主管','王大锤','jack'),(3,'123','销售经理','玛丽','marry'),(8,'123','','张三','tom'),(9,'123','','李四','mark'),(10,'123','开发','王五','tony');

/*Table structure for table `t_user_role` */

DROP TABLE IF EXISTS `t_user_role`;

CREATE TABLE `t_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKa9c8iiy6ut0gnx491fqx4pxam` (`role_id`),
  KEY `FKq5un6x7ecoef5w1n39cop66kl` (`user_id`),
  CONSTRAINT `FKa9c8iiy6ut0gnx491fqx4pxam` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `FKq5un6x7ecoef5w1n39cop66kl` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

/*Data for the table `t_user_role` */

insert  into `t_user_role`(`id`,`role_id`,`user_id`) values (1,1,1),(19,2,2),(20,4,2),(21,5,2),(28,2,3),(29,4,3),(30,5,3),(31,7,3),(34,2,8),(35,4,8),(36,13,9),(37,14,10);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
