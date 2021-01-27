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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Информация о лицензиях';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `license`
--

LOCK TABLES `license` WRITE;
/*!40000 ALTER TABLE `license` DISABLE KEYS */;
INSERT INTO `license` (`id`, `start`, `end`, `number`, `cost`, `lic_type_id`, `soft_id`, `contract_id`, `contract_partner_id`, `contract_type_id`) VALUES (1,'2018-06-30','2040-01-01',12,15000,2,2,1,45,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='Свойства программного обеспечения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soft`
--

LOCK TABLES `soft` WRITE;
/*!40000 ALTER TABLE `soft` DISABLE KEYS */;
INSERT INTO `soft` VALUES (2,'ABBYY Lingvo x5 20 языков','программа для машинного перевода текстов',22),(3,'Acrobat Professional 10 Windows Russian','пакет программ предназначенный для создания и просмотра электронных публикаций в формате PDF',36),(4,'Credo Dat 3.1','камеральная обработка традиционных геодезических измерений',1),(5,'Credo Конвертер 1.0','обработка данных геодезических измерений',1),(6,'Credo Нивелир 1.1','обработка полевых измерений геометрического нивелирования I–IV классов',1),(7,'Credo Топоплан 1.0','создание цифровой модели местности',1),(8,'Credo Транскор 1.1','преобразование геоцентрических геодезических и прямоугольных плоских координат',1),(9,'Credo Трансформ 2.0','обработка и трансформация растровых карт',1),(10,'Exchange Server OpenLicensePack','почтовый сервер',50),(11,'LyncSvrEnt ALNG LicSAPk','медиа сервер',50),(12,'Oracle Database Standard Edition','система управления базами данных',53),(13,'Photoshop CS6 13 Multiple Platforms  Russian','многофункциональный графический редактор',36),(14,'PrjctSvrCAL ALNG LicSAPk','решение для управления портфелями и текущими проектами',50),(15,'SharePointSvr ALNG LicSAPk','набор веб-приложений для организации совместной работы и создания веб-порталов',50),(16,'SQLSvrEnt ALNG LicSAPk','система управления базами данных',50),(17,'VisioPro ALNG LicSAPk','векторный графический редактор, редактор диаграмм и блок-схем',50),(18,'VisioStd ALNG LicSAPk','векторный графический редактор, редактор диаграмм и блок-схем',50),(19,'VSProwMSDN ALNG LicSAPk','интегрированная среда разработки программного обеспечения',50),(20,'WinRmtDsktpSrvcsCAL ALNG LicSAPk','сервер удаленного рабочего стола',50),(21,'Галактика EAM Enterprise','система управления техобслуживанием и ремонтами',3),(22,'Компaс-3D V14','система трехмерного проектирования',1),(23,'Компaс-График V14','система автоматизированного проектирования',1),(24,'Vmware vSphere 6 Standard','платформа виртуализации облачных вычислений',63),(25,'ODAC Professional Edition Team License','библиотека компонентов которая обеспечивает прямое подключение к Oracle',53),(26,'Автограф','система GPS мониторинга автотранспорта',2),(27,'ПО для приборов учета и контроля','программное обеспечение поставляемое совместно с измерительным оборудованием',15),(28,'Программные средства серии Эколог','программы для проведения расчетов и оформления документов по утвержденным формам для экологов',10),(29,'Расходомер ИСО','метрологический контроль и надзор за применением измерительных комплексов',6),(30,'Расходомер-ОМЦ','метрологический контроль и надзор за применением измерительных комплексов',5),(30,'ABBYY FineReader 12 Corporate Edition','программа для оптического распознавания символов',22),(31,'Сверка ИС и Перечней','ПО обеспечения контроля достоверности информации о стаже застрахованных лиц',13),(32,'Система ПАНГЕЯ','предназначена для загрузки и визуализации скважинных данных построения геофизических моделей, построения и редактирования карт',18),(33,'Смета Багира','составление сметной документации',11),(34,'Acronis','средство резервного копирования',23);
/*!40000 ALTER TABLE `soft` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-27 21:34:06
