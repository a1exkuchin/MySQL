-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: progdb
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contr_type`
--

DROP TABLE IF EXISTS `contr_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contr_type` (
  `id` int NOT NULL,
  `type` enum('договор','агентский договор','дополнительное соглашение','рамочный договор') NOT NULL DEFAULT 'договор',
  `validity` int NOT NULL DEFAULT '1' COMMENT 'Срок действия договора',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Тип договора';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contr_type`
--

LOCK TABLES `contr_type` WRITE;
/*!40000 ALTER TABLE `contr_type` DISABLE KEYS */;
INSERT INTO `contr_type` VALUES (1,'договор',1),(2,'агентский договор',1),(3,'дополнительное соглашение',1),(4,'рамочный договор',1),(5,'договор',3),(6,'рамочный договор',3);
/*!40000 ALTER TABLE `contr_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract` (
  `id` int NOT NULL,
  `date` date NOT NULL COMMENT 'Дата заключения договора',
  `sum` int NOT NULL COMMENT 'Сумма договора',
  `partner_id` int NOT NULL,
  `type_id` int NOT NULL,
  PRIMARY KEY (`id`,`partner_id`,`type_id`),
  KEY `fk_contract_partner1_idx` (`partner_id`),
  KEY `fk_contract_contr_type1_idx` (`type_id`),
  CONSTRAINT `fk_contract_contr_type1` FOREIGN KEY (`type_id`) REFERENCES `contr_type` (`id`),
  CONSTRAINT `fk_contract_partner1` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Информация о договорах';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (1,'2018-06-30',4379158,45,1),(2,'2018-09-01',1297000,44,1),(3,'2018-10-01',232336,43,1),(4,'2018-11-06',1744061,42,1),(5,'2018-12-01',5412960,41,1),(6,'2019-01-01',68800,40,1),(7,'2019-02-01',3000,39,2),(8,'2019-04-01',28512,38,3),(9,'2019-07-01',54000,37,5),(10,'2019-07-25',4000,36,6),(11,'2019-07-29',4379158,35,1),(12,'2019-08-01',1297000,34,1),(13,'2019-09-01',232336,33,2),(14,'2019-09-02',1744061,32,2),(15,'2019-11-01',5412960,31,2),(16,'2019-11-11',225926,30,2),(17,'2019-11-20',7790,29,2),(18,'2019-12-30',75684,28,2),(19,'2020-01-01',30274,27,2),(20,'2020-02-01',497567,26,2),(21,'2020-04-01',17500,25,2),(22,'2020-05-11',27800,24,2),(23,'2020-06-05',8000,23,1),(24,'2020-06-06',11000,22,1),(25,'2020-06-07',48000,21,1),(26,'2020-06-13',4189,20,1),(27,'2020-07-01',135650,19,1),(28,'2020-07-25',2349908,18,1),(29,'2020-08-01',2970,17,1),(30,'2020-08-02',6050,16,1),(31,'2020-09-01',120852,15,1),(32,'2020-09-04',1673340,14,1),(33,'2020-09-21',606670,13,2),(34,'2020-09-22',89922,12,5),(35,'2020-10-01',215822,11,6),(36,'2020-10-03',30963,10,3),(37,'2020-11-09',354260,1,3),(38,'2020-11-13',11000,2,3),(39,'2020-12-01',56000,3,2),(40,'2020-12-28',1252706,4,1);
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `short_name` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Структурные подразделения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Служба корпоративной защиты','СКЗ','Чкалова 1/2'),(2,'Газопромысловое управление','ГПУ','п.Дедуровка-1'),(3,'Управление соединительных продуктопроводов','УЭСП','Терешковой 253'),(4,'Управление транспорта и специальной техники','УТиСТ','60 лет Октября 11'),(5,'Управление материального снабженияя и комплектации','УМТСиК','Донгузская 53'),(6,'Управление связи','УС','Центральная 28'),(7,'Управление эксплуатации зданий и сооружений','УЭЗиС','Дальнореченская 6'),(8,'Военнизированная часть','ВЧ','60 лет Октября 11'),(9,'Администрация общества','АО','Чкалова 1/2'),(10,'Учебно производственный центр','УПЦ','Дзержинского 2');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lic_type`
--

DROP TABLE IF EXISTS `lic_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lic_type` (
  `id` int NOT NULL,
  `description` enum('server','user','concurent') NOT NULL COMMENT 'Тип лицензии',
  `units` enum('proc','kernel','items') DEFAULT NULL COMMENT 'Единицы измерения',
  `perpetual` enum('yes','no') NOT NULL COMMENT 'yes - если лицензия бессрочная, иначе ''no''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Информация о типе лицензии';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lic_type`
--

LOCK TABLES `lic_type` WRITE;
/*!40000 ALTER TABLE `lic_type` DISABLE KEYS */;
INSERT INTO `lic_type` VALUES (1,'server','proc','yes'),(2,'server','kernel','yes'),(3,'user','items','yes'),(4,'user','items','no'),(5,'concurent','items','yes'),(6,'concurent','items','no');
/*!40000 ALTER TABLE `lic_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `license`
--

DROP TABLE IF EXISTS `license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `license` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start` date NOT NULL COMMENT 'Начало действия лицензии',
  `end` date NOT NULL DEFAULT '2040-01-01' COMMENT 'Конец действия лицензии',
  `number` int NOT NULL COMMENT 'Количество лицензий',
  `cost` int NOT NULL COMMENT 'Цена одной лицензии',
  `sum` int GENERATED ALWAYS AS ((`cost` * `number`)) VIRTUAL,
  `lic_type_id` int NOT NULL,
  `soft_id` int NOT NULL,
  `contract_id` int NOT NULL,
  `contract_partner_id` int NOT NULL,
  `contract_type_id` int NOT NULL,
  PRIMARY KEY (`id`,`lic_type_id`,`soft_id`,`contract_id`),
  KEY `fk_license_soft_idx` (`soft_id`),
  KEY `fk_license_lic_type1_idx` (`lic_type_id`),
  KEY `fk_license_contract1_idx` (`contract_id`,`contract_partner_id`,`contract_type_id`),
  CONSTRAINT `fk_license_lic_type1` FOREIGN KEY (`lic_type_id`) REFERENCES `lic_type` (`id`),
  CONSTRAINT `fk_license_soft` FOREIGN KEY (`soft_id`) REFERENCES `soft` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=692 DEFAULT CHARSET=utf8 COMMENT='Информация о лицензиях';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `license`
--

LOCK TABLES `license` WRITE;
/*!40000 ALTER TABLE `license` DISABLE KEYS */;
INSERT INTO `license` (`id`, `start`, `end`, `number`, `cost`, `lic_type_id`, `soft_id`, `contract_id`, `contract_partner_id`, `contract_type_id`) VALUES (1,'2018-06-30','2040-01-01',12,15000,2,2,1,45,1),(105,'2018-07-30','2040-01-01',41,1400,3,7,2,44,1),(106,'2018-08-30','2040-01-01',22,14000,3,2,3,43,1),(649,'2019-01-30','2040-01-01',8,5000,3,5,6,40,1),(650,'2019-03-23','2040-01-01',15,3600,3,8,8,38,3),(651,'2019-04-30','2040-01-01',17,3600,3,9,9,37,5),(652,'2019-05-15','2040-01-01',33,3600,1,11,10,36,6),(653,'2019-06-30','2040-01-01',53,1560,5,13,11,35,1),(654,'2019-07-30','2040-01-01',32,5680,2,14,12,34,1),(655,'2019-08-11','2040-01-01',42,16580,2,15,13,33,2),(656,'2019-09-30','2040-01-01',75,6850,3,18,14,32,2),(657,'2019-10-30','2040-01-01',32,19600,3,19,15,31,2),(658,'2019-11-07','2040-01-01',12,1960,3,23,16,30,2),(659,'2019-12-04','2040-01-01',17,1502,3,25,17,29,2),(660,'2019-06-05','2040-01-01',17,2500,1,26,18,28,2),(661,'2019-07-13','2040-01-01',1,2150,3,27,6,40,1),(662,'2019-06-22','2040-01-01',2,5052,3,28,7,39,2),(663,'2020-01-30','2040-01-01',7,5250,3,29,19,27,2),(664,'2020-01-30','2040-01-01',14,1550,3,30,20,26,2),(665,'2020-02-06','2040-01-01',3,1500,3,31,21,25,2),(666,'2020-03-30','2040-01-01',2,1500,5,32,22,24,2),(667,'2020-03-30','2040-01-01',1,1500,3,33,23,23,1),(668,'2020-03-30','2040-01-01',14,4000,3,34,24,22,1),(669,'2020-04-10','2040-01-01',16,4000,1,34,25,21,1),(670,'2020-04-10','2040-01-01',19,4000,5,36,26,20,1),(671,'2020-05-13','2040-01-01',22,4000,5,13,27,19,1),(672,'2020-05-15','2040-01-01',42,14500,2,14,28,18,1),(673,'2020-06-23','2040-01-01',52,15000,2,15,29,17,1),(674,'2020-06-25','2040-01-01',14,12300,3,18,30,16,1),(675,'2020-06-30','2040-01-01',16,2100,3,19,31,15,1),(676,'2020-07-01','2040-01-01',19,1220,3,23,32,14,1),(677,'2020-07-07','2040-01-01',18,4560,3,25,33,13,2),(678,'2020-08-30','2040-01-01',12,15000,1,26,34,12,5),(679,'2020-09-30','2040-01-01',12,15000,3,27,35,11,6),(680,'2020-10-11','2040-01-01',12,1200,3,28,36,10,3),(681,'2020-10-17','2040-01-01',80,12000,3,29,37,1,3),(682,'2020-11-22','2040-01-01',77,31000,3,30,38,2,3),(683,'2020-11-23','2040-01-01',17,14000,3,31,39,3,2),(684,'2020-11-25','2040-01-01',16,1440,5,32,40,4,1),(685,'2020-11-27','2040-01-01',18,1535,3,33,19,27,2),(686,'2020-11-28','2040-01-01',25,7800,3,34,20,26,2),(687,'2020-12-12','2040-01-01',26,87000,1,34,21,25,2),(688,'2020-12-16','2040-01-01',27,7800,2,2,22,24,2),(689,'2020-12-20','2040-01-01',200,1800,4,30,23,23,1),(690,'2020-12-25','2040-01-01',110,1000,4,31,24,22,1),(691,'2020-12-27','2040-01-01',140,1000,4,32,25,21,1);
/*!40000 ALTER TABLE `license` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mol`
--

DROP TABLE IF EXISTS `mol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mol` (
  `id` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`id`,`department_id`),
  KEY `fk_mol_department1_idx` (`department_id`),
  CONSTRAINT `fk_mol_department1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Информация по материально-ответственным лицам';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mol`
--

LOCK TABLES `mol` WRITE;
/*!40000 ALTER TABLE `mol` DISABLE KEYS */;
INSERT INTO `mol` VALUES (1,'Сергей','Нюхряев','630797',9),(2,'Нурлан','Джусынгалиев','630911',9),(3,'Евгений','Савин','630666',1),(4,'Валерий','Катасонов','632626',5),(5,'Виктор','Скабелкин','633122',2),(6,'Дмитрий','Стеклов','632102',3),(7,'Юрий','Донченко','631212',4),(8,'Денис','Богомолов','633205',6),(9,'Сергей','Нуждин','637206',7),(10,'Андрей','Поспелов','638216',8),(11,'Андрей','Зайцев','632346',10),(12,'Сергей','Трунов','635212',7);
/*!40000 ALTER TABLE `mol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner`
--

DROP TABLE IF EXISTS `partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partner` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('МСБ','КБ') NOT NULL COMMENT 'Малый и средний бизнес, крупный бизнес',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Контрагент';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner`
--

LOCK TABLES `partner` WRITE;
/*!40000 ALTER TABLE `partner` DISABLE KEYS */;
INSERT INTO `partner` VALUES (1,'АО Клинкманн СПБ','МСБ'),(2,'АО ПРАВО.РУ','МСБ'),(3,'ГНПП Гранит-Центр','МСБ'),(4,'ЗАО Галактика Центр','КБ'),(5,'ЗАО Интерфакс','МСБ'),(6,'ЗАО ПФС KБ Контур','МСБ'),(7,'ЗАО СовТИГаз','МСБ'),(8,'ЗАО СофтЛайн Трейд','КБ'),(9,'ПАО Газпром','КБ'),(10,'ОOО Т-Книга','МСБ'),(11,'ОАО АйСиЭл-КПО ВС','КБ'),(12,'ОАО Газавтоматика ОАО Газпром','МСБ'),(13,'ОАО НППГранит-Центр','МСБ'),(14,'ОАО ОПТИМА','МСБ'),(15,'ООО Компания Мехатроника','МСБ'),(16,'ООО Аскон-С','МСБ'),(17,'ООО Газпром информ','МСБ'),(18,'ООО Компания Промторгсервис','МСБ'),(19,'ООО КРИПТО-ПРО','МСБ'),(20,'ООО Лига 56','МСБ'),(21,'ООО Промторгсервис','МСБ'),(22,'ООО Сертум-ПрО','МСБ'),(23,'ООО Софт-сервис','МСБ'),(24,'ООО Спецоператор','МСБ'),(25,'ООО СТП','МСБ'),(26,'ООО Термика','МСБ'),(27,'ООО ФирмаПалитра систем','МСБ'),(28,'ООО ФирмаИнтеграл','МСБ'),(29,'ООО ЦИНТУР','МСБ'),(30,'ООО ЭКО центр','МСБ'),(31,'ООО ЭнергоСофт','МСБ'),(32,'ООО Газпром комплектация','МСБ'),(33,'ООО Гамаюн','МСБ'),(34,'ООО Гештальт','МСБ'),(35,'ООО Документ Менеджмент','МСБ'),(36,'ООО Интелект-Софт','МСБ'),(37,'ООО Информправо-Плюс','МСБ'),(38,'ООО Контур НТТ','МСБ'),(39,'ООО Сименс Бизнес Сервисез','КБ'),(40,'ООО Термика','МСБ'),(41,'ООО ТСО','МСБ'),(42,'ООО Уральский центр систем безопасности','КБ'),(43,'ООО Компания Тензор','МСБ'),(44,'ООО НПКПБагира','МСБ'),(45,'ООО НППЭтна-Информационные технологии','МСБ');
/*!40000 ALTER TABLE `partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `remain`
--

DROP TABLE IF EXISTS `remain`;
/*!50001 DROP VIEW IF EXISTS `remain`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `remain` AS SELECT 
 1 AS `soft_id`,
 1 AS `soft`,
 1 AS `remainder`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `soft`
--

DROP TABLE IF EXISTS `soft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soft` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `vendor_id` int NOT NULL,
  PRIMARY KEY (`id`,`vendor_id`),
  KEY `fk_soft_vendor1_idx` (`vendor_id`),
  CONSTRAINT `fk_soft_vendor1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='Свойства программного обеспечения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soft`
--

LOCK TABLES `soft` WRITE;
/*!40000 ALTER TABLE `soft` DISABLE KEYS */;
INSERT INTO `soft` VALUES (2,'ABBYY Lingvo x5 20 языков','программа для машинного перевода текстов',22),(3,'Acrobat Professional 10 Windows Russian','пакет программ предназначенный для создания и просмотра электронных публикаций в формате PDF',36),(4,'Credo Dat 3.1','камеральная обработка традиционных геодезических измерений',1),(5,'Credo Конвертер 1.0','обработка данных геодезических измерений',1),(6,'Credo Нивелир 1.1','обработка полевых измерений геометрического нивелирования I–IV классов',1),(7,'Credo Топоплан 1.0','создание цифровой модели местности',1),(8,'Credo Транскор 1.1','преобразование геоцентрических геодезических и прямоугольных плоских координат',1),(9,'Credo Трансформ 2.0','обработка и трансформация растровых карт',1),(10,'Exchange Server OpenLicensePack','почтовый сервер',50),(11,'LyncSvrEnt ALNG LicSAPk','медиа сервер',50),(12,'Oracle Database Standard Edition','система управления базами данных',53),(13,'Photoshop CS6 13 Multiple Platforms  Russian','многофункциональный графический редактор',36),(14,'PrjctSvrCAL ALNG LicSAPk','решение для управления портфелями и текущими проектами',50),(15,'SharePointSvr ALNG LicSAPk','набор веб-приложений для организации совместной работы и создания веб-порталов',50),(16,'SQLSvrEnt ALNG LicSAPk','система управления базами данных',50),(17,'VisioPro ALNG LicSAPk','векторный графический редактор, редактор диаграмм и блок-схем',50),(18,'VisioStd ALNG LicSAPk','векторный графический редактор, редактор диаграмм и блок-схем',50),(19,'VSProwMSDN ALNG LicSAPk','интегрированная среда разработки программного обеспечения',50),(20,'WinRmtDsktpSrvcsCAL ALNG LicSAPk','сервер удаленного рабочего стола',50),(21,'Галактика EAM Enterprise','система управления техобслуживанием и ремонтами',3),(22,'Компaс-3D V14','система трехмерного проектирования',1),(23,'Компaс-График V14','система автоматизированного проектирования',1),(24,'Vmware vSphere 6 Standard','платформа виртуализации облачных вычислений',63),(25,'ODAC Professional Edition Team License','библиотека компонентов которая обеспечивает прямое подключение к Oracle',53),(26,'Автограф','система GPS мониторинга автотранспорта',2),(27,'ПО для приборов учета и контроля','программное обеспечение поставляемое совместно с измерительным оборудованием',15),(28,'Программные средства серии Эколог','программы для проведения расчетов и оформления документов по утвержденным формам для экологов',10),(29,'Расходомер ИСО','метрологический контроль и надзор за применением измерительных комплексов',6),(30,'Расходомер-ОМЦ','метрологический контроль и надзор за применением измерительных комплексов',5),(31,'Сверка ИС и Перечней','ПО обеспечения контроля достоверности информации о стаже застрахованных лиц',13),(32,'Система ПАНГЕЯ','предназначена для загрузки и визуализации скважинных данных построения геофизических моделей, построения и редактирования карт',18),(33,'Смета Багира','составление сметной документации',11),(34,'Acronis','средство резервного копирования',23),(36,'ABBYY FineReader 12 Corporate Edition','программа для оптического распознавания символов',22);
/*!40000 ALTER TABLE `soft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `soft_itog`
--

DROP TABLE IF EXISTS `soft_itog`;
/*!50001 DROP VIEW IF EXISTS `soft_itog`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `soft_itog` AS SELECT 
 1 AS `soft_id`,
 1 AS `soft`,
 1 AS `itog`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer` (
  `id` int NOT NULL,
  `data` date NOT NULL,
  `number` int NOT NULL COMMENT 'Количество переданных лицензий',
  `mol_id` int NOT NULL,
  `mol_department_id` int NOT NULL,
  `license_id` int NOT NULL,
  `license_lic_type_id` int NOT NULL,
  `license_soft_id` int NOT NULL,
  `license_contract_id` int NOT NULL,
  PRIMARY KEY (`id`,`license_id`,`license_lic_type_id`,`license_soft_id`,`license_contract_id`),
  KEY `fk_transfer_mol1_idx` (`mol_id`,`mol_department_id`),
  KEY `fk_transfer_license1_idx` (`license_id`,`license_lic_type_id`,`license_soft_id`,`license_contract_id`),
  CONSTRAINT `fk_transfer_license1` FOREIGN KEY (`license_id`, `license_lic_type_id`, `license_soft_id`, `license_contract_id`) REFERENCES `license` (`id`, `lic_type_id`, `soft_id`, `contract_id`),
  CONSTRAINT `fk_transfer_mol1` FOREIGN KEY (`mol_id`, `mol_department_id`) REFERENCES `mol` (`id`, `department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Передача ПО МОЛам в подразделения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer`
--

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
INSERT INTO `transfer` VALUES (1,'2018-06-30',4,2,9,1,2,2,1),(2,'2018-06-30',4,3,1,1,2,2,1),(3,'2018-06-30',4,4,5,1,2,2,1),(4,'2018-07-30',20,7,4,105,3,7,2),(5,'2018-07-30',21,8,6,105,3,7,2),(6,'2018-08-30',10,10,8,106,3,2,3),(7,'2018-08-30',12,11,10,106,3,2,3),(8,'2019-01-30',2,5,2,649,3,5,6),(9,'2019-01-30',2,6,3,649,3,5,6),(10,'2019-01-30',2,7,4,649,3,5,6),(11,'2019-01-30',2,8,6,649,3,5,6),(12,'2019-03-23',10,7,4,650,3,8,8),(13,'2019-03-23',15,8,6,650,3,8,8),(14,'2019-04-30',17,10,8,651,3,9,9),(15,'2019-05-15',33,1,9,652,1,11,10),(16,'2019-06-30',13,1,9,653,5,13,11),(17,'2019-06-30',20,2,9,653,5,13,11),(18,'2019-06-30',20,3,1,653,5,13,11),(19,'2019-07-30',32,4,5,654,2,14,12),(20,'2019-08-11',42,1,9,655,2,15,13),(21,'2019-09-30',75,1,9,656,3,18,14),(22,'2019-10-30',32,1,9,657,3,19,15),(23,'2019-11-07',2,3,1,658,3,23,16),(24,'2019-11-07',2,4,5,658,3,23,16),(25,'2019-11-07',2,5,2,658,3,23,16),(26,'2019-11-07',2,6,3,658,3,23,16),(27,'2019-11-07',4,7,4,658,3,23,16),(28,'2019-12-04',17,10,8,659,3,25,17),(29,'2019-06-05',17,11,10,660,1,26,18),(30,'2019-07-13',1,12,7,661,3,27,6),(31,'2019-06-22',1,2,9,662,3,28,7),(32,'2019-06-22',1,3,1,662,3,28,7),(35,'2020-01-30',3,9,7,663,3,29,19),(36,'2020-01-30',3,10,8,663,3,29,19),(37,'2020-01-30',1,11,10,663,3,29,19),(38,'2020-01-30',2,12,7,664,3,30,20),(39,'2020-01-30',10,5,2,664,3,30,20),(40,'2020-01-30',2,6,3,664,3,30,20),(41,'2020-02-06',3,7,4,665,3,31,21),(42,'2020-03-30',2,1,9,666,5,32,22),(43,'2020-03-30',1,2,9,667,3,33,23),(44,'2020-03-30',14,3,1,668,3,34,24),(45,'2020-04-10',3,4,5,669,1,34,25),(46,'2020-04-10',3,8,6,669,1,34,25),(47,'2020-04-10',3,9,7,669,1,34,25),(48,'2020-04-10',3,10,8,669,1,34,25),(49,'2020-04-10',19,11,10,670,5,36,26),(50,'2020-05-13',22,3,1,671,5,13,27),(51,'2020-05-15',42,4,5,672,2,14,28),(52,'2020-06-23',17,5,2,673,2,15,29),(53,'2020-06-23',17,6,3,673,2,15,29),(54,'2020-06-23',17,10,8,673,2,15,29),(55,'2020-06-25',14,11,10,674,3,18,30),(56,'2020-06-30',5,12,7,675,3,19,31),(57,'2020-06-30',5,2,9,675,3,19,31),(58,'2020-06-30',5,3,1,675,3,19,31),(59,'2020-07-01',19,4,5,676,3,23,32),(60,'2020-07-07',2,7,4,677,3,25,33),(61,'2020-07-07',2,2,9,677,3,25,33),(62,'2020-07-07',2,3,1,677,3,25,33),(63,'2020-07-07',2,4,5,677,3,25,33),(64,'2020-07-07',2,5,2,677,3,25,33),(65,'2020-07-07',2,6,3,677,3,25,33),(66,'2020-07-07',2,7,4,677,3,25,33),(67,'2020-07-07',2,8,6,677,3,25,33),(68,'2020-08-30',12,9,7,678,1,26,34),(69,'2020-09-30',6,10,8,679,3,27,35),(70,'2020-09-30',6,3,1,679,3,27,35),(71,'2020-10-11',12,4,5,680,3,28,36),(72,'2020-10-17',10,7,4,681,3,29,37),(73,'2020-10-17',10,8,6,681,3,29,37),(74,'2020-10-17',10,9,7,681,3,29,37),(75,'2020-10-17',10,10,8,681,3,29,37),(76,'2020-10-17',10,11,10,681,3,29,37),(77,'2020-10-17',10,12,7,681,3,29,37),(78,'2020-10-17',10,1,9,681,3,29,37),(79,'2020-11-22',9,1,9,682,3,30,38),(80,'2020-11-22',9,3,1,682,3,30,38),(81,'2020-11-22',9,4,5,682,3,30,38),(82,'2020-11-22',9,5,2,682,3,30,38),(83,'2020-11-22',9,6,3,682,3,30,38),(84,'2020-11-22',9,7,4,682,3,30,38),(85,'2020-11-22',9,8,6,682,3,30,38),(86,'2020-11-22',9,9,7,682,3,30,38),(87,'2020-11-23',17,10,8,683,3,31,39),(88,'2020-11-25',16,11,10,684,5,32,40),(89,'2020-11-27',18,12,7,685,3,33,19),(90,'2020-11-28',25,2,9,686,3,34,20),(91,'2020-12-12',26,3,1,687,1,34,21),(92,'2020-12-16',27,4,5,688,2,2,22),(93,'2020-12-20',25,5,2,689,4,30,23),(94,'2020-12-20',25,8,6,689,4,30,23),(95,'2020-12-20',25,9,7,689,4,30,23),(96,'2020-12-20',25,10,8,689,4,30,23),(97,'2020-12-20',25,11,10,689,4,30,23),(98,'2020-12-20',25,12,7,689,4,30,23),(99,'2020-12-20',25,1,9,689,4,30,23),(100,'2020-12-20',25,2,9,689,4,30,23),(101,'2020-12-25',17,3,1,690,4,31,24),(102,'2020-12-25',17,4,5,690,4,31,24),(103,'2020-12-25',17,5,2,690,4,31,24),(107,'2020-12-25',17,6,3,690,4,31,24),(108,'2020-12-25',17,7,4,690,4,31,24),(109,'2020-12-25',17,8,6,690,4,31,24),(110,'2020-12-27',35,9,7,691,4,32,25),(111,'2020-12-27',35,10,8,691,4,32,25),(112,'2020-12-27',35,11,10,691,4,32,25),(113,'2020-12-27',35,12,7,691,4,32,25);
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`alex`@`%`*/ /*!50003 TRIGGER `check_remainder` BEFORE INSERT ON `transfer` FOR EACH ROW BEGIN
	IF NEW.number > (SELECT remainder FROM remain WHERE soft_id = NEW.license_soft_id) THEN
		SIGNAL SQLSTATE '45000'	
        SET MESSAGE_TEXT = 'Недостаточно лицензий для передачи.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `transfer_itog`
--

DROP TABLE IF EXISTS `transfer_itog`;
/*!50001 DROP VIEW IF EXISTS `transfer_itog`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `transfer_itog` AS SELECT 
 1 AS `soft_id`,
 1 AS `soft`,
 1 AS `itog`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `import` enum('yes','no') NOT NULL COMMENT 'Если ПО отечественное, то ''no'', если  импортное - то ''yes''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Производитель ПО';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES (1,'Аскон','no'),(2,'Астерос','no'),(3,'Галактика','no'),(4,'Диасофт','no'),(5,'ИнтелТелеком','no'),(6,'Инфобис','no'),(7,'Компас','no'),(8,'Ланит','no'),(9,'Новософт','no'),(10,'НТЦ Аргус','no'),(11,'Полимедиа','no'),(12,'Прогноз','no'),(13,'ПрограмБанк','no'),(14,'ПРОМТ','no'),(15,'Русские навигационные технологии','no'),(16,'Ситроникс','no'),(17,'СКБ Контур','no'),(18,'СофтКлаб','no'),(19,'Террасофт','no'),(20,'Топ Системы','no'),(21,'Яндекс','no'),(22,'ABBYY','no'),(23,'Acronis','no'),(24,'Alawar','no'),(25,'AlternativaGames','no'),(26,'CBOSS','no'),(27,'Cognitive Technologies','no'),(28,'Comexp','no'),(29,'IBS Group','no'),(30,'ICL-КПО ВС','no'),(31,'Itransition Group','no'),(32,'Luxoft','no'),(33,'Mail.ru','no'),(34,'Mapilab','no'),(35,'Naumen','no'),(36,'Adobe','yes'),(37,'Ageia','yes'),(38,'Alphabet','yes'),(39,'Apple','yes'),(40,'Autodesk','yes'),(41,'CA Technologies','yes'),(42,'Cisco','yes'),(43,'Comodo','yes'),(44,'EMC','yes'),(45,'Firebase','yes'),(46,'IBM','yes'),(47,'Kerio Technologies','yes'),(48,'LANDesk','yes'),(49,'McAfee','yes'),(50,'Microsoft','yes'),(51,'MongoDB','yes'),(52,'Nutanix','yes'),(53,'Oracle','yes'),(54,'Palantir','yes'),(55,'Parallels','yes'),(56,'Salesforce','yes'),(57,'SAS','yes'),(58,'Scala','yes'),(59,'Sun Microsystems','yes'),(60,'Sybase','yes'),(61,'Tableau','yes'),(62,'Veritas','yes'),(63,'VMware','yes'),(64,'Xerox','yes');
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `remain`
--

/*!50001 DROP VIEW IF EXISTS `remain`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alex`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `remain` AS select `soft_itog`.`soft_id` AS `soft_id`,`soft_itog`.`soft` AS `soft`,(`soft_itog`.`itog` - `transfer_itog`.`itog`) AS `remainder` from (`soft_itog` left join `transfer_itog` on((`soft_itog`.`soft_id` = `transfer_itog`.`soft_id`))) where ((`soft_itog`.`itog` - `transfer_itog`.`itog`) > 0) order by `soft_itog`.`soft` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `soft_itog`
--

/*!50001 DROP VIEW IF EXISTS `soft_itog`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alex`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `soft_itog` AS select `license`.`soft_id` AS `soft_id`,(select `soft`.`name` from `soft` where (`license`.`soft_id` = `soft`.`id`)) AS `soft`,sum(`license`.`number`) AS `itog` from `license` group by `soft` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `transfer_itog`
--

/*!50001 DROP VIEW IF EXISTS `transfer_itog`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alex`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `transfer_itog` AS select `transfer`.`license_soft_id` AS `soft_id`,(select `soft`.`name` from `soft` where (`transfer`.`license_soft_id` = `soft`.`id`)) AS `soft`,sum(`transfer`.`number`) AS `itog` from `transfer` group by `soft` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-01 19:50:19
