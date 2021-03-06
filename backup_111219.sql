-- MySQL dump 10.13  Distrib 8.0.18, for osx10.14 (x86_64)
--
-- Host: localhost    Database: fellowcity
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `buses`
--

DROP TABLE IF EXISTS `buses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bus_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `route` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buses`
--

LOCK TABLES `buses` WRITE;
/*!40000 ALTER TABLE `buses` DISABLE KEYS */;
INSERT INTO `buses` VALUES (1,'BSD Link','BRE','The Breeze - ICE - The Breeze'),(2,'BSD Link','AVA','The Avani - Sektor 1.3 - The Avani'),(3,'BSD Link','GRE','Greenwich Park Office - Sektor 1.3  - Greenwich Park Office'),(4,'BSD Link','DP1','Terminal Intermoda - De Park Rute 1'),(5,'BSD Link','DP2','Terminal Intermoda - De Park Rute 2'),(6,'BSD Link','VAN','Vanya Park - Intermoda - Vanya Park');
/*!40000 ALTER TABLE `buses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commutes`
--

DROP TABLE IF EXISTS `commutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commutes` (
  `time` timestamp NULL DEFAULT NULL,
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `stop_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `direction` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bus_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bus_no` int(11) DEFAULT NULL,
  `stop_id` int(11) DEFAULT NULL,
  `long` decimal(11,8) DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `seat_availability` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_check` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commutes`
--

LOCK TABLES `commutes` WRITE;
/*!40000 ALTER TABLE `commutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `commutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `reminder_id` int(11) DEFAULT NULL,
  `token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_sent` tinyint(1) DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `bus_code` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stop_name` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stop_id` int(11) DEFAULT NULL,
  `direction` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `interval_start` time DEFAULT NULL,
  `interval_stop` time DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `time_before_arrival` int(10) DEFAULT NULL,
  `repeat` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminders`
--

LOCK TABLES `reminders` WRITE;
/*!40000 ALTER TABLE `reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) DEFAULT NULL,
  `stop_id` int(11) DEFAULT NULL,
  `time_arrival` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=698 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,1,1,'09:00:00'),(2,1,2,'09:04:00'),(3,1,3,'09:05:00'),(4,1,4,'09:07:00'),(5,1,5,'09:07:00'),(6,1,6,'09:09:00'),(7,1,7,'09:17:00'),(8,1,8,'09:19:00'),(9,1,9,'09:20:00'),(10,2,10,'09:20:00'),(11,2,11,'09:27:00'),(12,2,12,'09:30:00'),(13,2,13,'09:30:00'),(14,2,14,'09:32:00'),(15,2,15,'09:39:00'),(16,2,16,'09:42:00'),(17,2,17,'09:45:00'),(18,3,1,'09:15:00'),(19,3,2,'09:19:00'),(20,3,3,'09:20:00'),(21,3,4,'09:22:00'),(22,3,5,'09:22:00'),(23,3,6,'09:24:00'),(24,3,7,'09:32:00'),(25,3,8,'09:34:00'),(26,3,9,'09:35:00'),(27,4,10,'09:35:00'),(28,4,11,'09:42:00'),(29,4,12,'09:45:00'),(30,4,13,'09:45:00'),(31,4,14,'09:47:00'),(32,4,15,'09:54:00'),(33,4,16,'09:57:00'),(34,4,17,'10:00:00'),(35,5,1,'09:30:00'),(36,5,2,'09:34:00'),(37,5,3,'09:35:00'),(38,5,4,'09:37:00'),(39,5,5,'09:37:00'),(40,5,6,'09:39:00'),(41,5,7,'09:47:00'),(42,5,8,'09:49:00'),(43,5,9,'09:50:00'),(44,6,10,'09:50:00'),(45,6,11,'09:57:00'),(46,6,12,'10:00:00'),(47,6,13,'10:00:00'),(48,6,14,'10:02:00'),(49,6,15,'10:09:00'),(50,6,16,'10:12:00'),(51,6,17,'10:15:00'),(52,7,1,'09:45:00'),(53,7,2,'09:49:00'),(54,7,3,'09:50:00'),(55,7,4,'09:52:00'),(56,7,5,'09:52:00'),(57,7,6,'09:54:00'),(58,7,7,'10:02:00'),(59,7,8,'10:04:00'),(60,7,9,'10:05:00'),(61,8,10,'10:05:00'),(62,8,11,'10:12:00'),(63,8,12,'10:15:00'),(64,8,13,'10:15:00'),(65,8,14,'10:17:00'),(66,8,15,'10:24:00'),(67,8,16,'10:27:00'),(68,8,17,'10:30:00'),(69,9,1,'10:00:00'),(70,9,2,'10:04:00'),(71,9,3,'10:05:00'),(72,9,4,'10:07:00'),(73,9,5,'10:07:00'),(74,9,6,'10:09:00'),(75,9,7,'10:17:00'),(76,9,8,'10:19:00'),(77,9,9,'10:20:00'),(78,10,10,'10:20:00'),(79,10,11,'10:27:00'),(80,10,12,'10:30:00'),(81,10,13,'10:30:00'),(82,10,14,'10:32:00'),(83,10,15,'10:39:00'),(84,10,16,'10:42:00'),(85,10,17,'10:45:00'),(86,11,1,'10:15:00'),(87,11,2,'10:19:00'),(88,11,3,'10:20:00'),(89,11,4,'10:22:00'),(90,11,5,'10:22:00'),(91,11,6,'10:24:00'),(92,11,7,'10:32:00'),(93,11,8,'10:34:00'),(94,11,9,'10:35:00'),(95,12,10,'10:35:00'),(96,12,11,'10:42:00'),(97,12,12,'10:45:00'),(98,12,13,'10:45:00'),(99,12,14,'10:47:00'),(100,12,15,'10:54:00'),(101,12,16,'10:57:00'),(102,12,17,'11:00:00'),(103,13,1,'10:30:00'),(104,13,2,'10:34:00'),(105,13,3,'10:35:00'),(106,13,4,'10:37:00'),(107,13,5,'10:37:00'),(108,13,6,'10:39:00'),(109,13,7,'10:47:00'),(110,13,8,'10:49:00'),(111,13,9,'10:50:00'),(112,14,10,'10:50:00'),(113,14,11,'10:57:00'),(114,14,12,'11:00:00'),(115,14,13,'11:00:00'),(116,14,14,'11:02:00'),(117,14,15,'11:09:00'),(118,14,16,'11:12:00'),(119,14,17,'11:15:00'),(120,15,1,'10:45:00'),(121,15,2,'10:49:00'),(122,15,3,'10:50:00'),(123,15,4,'10:52:00'),(124,15,5,'10:52:00'),(125,15,6,'10:54:00'),(126,15,7,'11:02:00'),(127,15,8,'11:04:00'),(128,15,9,'11:05:00'),(129,16,10,'11:05:00'),(130,16,11,'11:12:00'),(131,16,12,'11:15:00'),(132,16,13,'11:15:00'),(133,16,14,'11:17:00'),(134,16,15,'11:24:00'),(135,16,16,'11:27:00'),(136,16,17,'11:30:00'),(137,17,1,'11:00:00'),(138,17,2,'11:04:00'),(139,17,3,'11:05:00'),(140,17,4,'11:07:00'),(141,17,5,'11:07:00'),(142,17,6,'11:09:00'),(143,17,7,'11:17:00'),(144,17,8,'11:19:00'),(145,17,9,'11:20:00'),(146,18,10,'11:20:00'),(147,18,11,'11:27:00'),(148,18,12,'11:30:00'),(149,18,13,'11:30:00'),(150,18,14,'11:32:00'),(151,18,15,'11:39:00'),(152,18,16,'11:42:00'),(153,18,17,'11:45:00'),(154,19,1,'11:15:00'),(155,19,2,'11:19:00'),(156,19,3,'11:20:00'),(157,19,4,'11:22:00'),(158,19,5,'11:22:00'),(159,19,6,'11:24:00'),(160,19,7,'11:32:00'),(161,19,8,'11:34:00'),(162,19,9,'11:35:00'),(163,20,10,'11:35:00'),(164,20,11,'11:42:00'),(165,20,12,'11:45:00'),(166,20,13,'11:45:00'),(167,20,14,'11:47:00'),(168,20,15,'11:54:00'),(169,20,16,'11:57:00'),(170,20,17,'12:00:00'),(171,21,1,'11:30:00'),(172,21,2,'11:34:00'),(173,21,3,'11:35:00'),(174,21,4,'11:37:00'),(175,21,5,'11:37:00'),(176,21,6,'11:39:00'),(177,21,7,'11:47:00'),(178,21,8,'11:49:00'),(179,21,9,'11:50:00'),(180,22,10,'11:50:00'),(181,22,11,'11:57:00'),(182,22,12,'12:00:00'),(183,22,13,'12:00:00'),(184,22,14,'12:02:00'),(185,22,15,'12:09:00'),(186,22,16,'12:12:00'),(187,22,17,'12:15:00'),(188,23,1,'11:45:00'),(189,23,2,'11:49:00'),(190,23,3,'11:50:00'),(191,23,4,'11:52:00'),(192,23,5,'11:52:00'),(193,23,6,'11:54:00'),(194,23,7,'12:02:00'),(195,23,8,'12:04:00'),(196,23,9,'12:05:00'),(197,24,10,'12:05:00'),(198,24,11,'12:12:00'),(199,24,12,'12:15:00'),(200,24,13,'12:15:00'),(201,24,14,'12:17:00'),(202,24,15,'12:24:00'),(203,24,16,'12:27:00'),(204,24,17,'12:30:00'),(205,25,1,'12:00:00'),(206,25,2,'12:04:00'),(207,25,3,'12:05:00'),(208,25,4,'12:07:00'),(209,25,5,'12:07:00'),(210,25,6,'12:09:00'),(211,25,7,'12:17:00'),(212,25,8,'12:19:00'),(213,25,9,'12:20:00'),(214,26,10,'12:20:00'),(215,26,11,'12:27:00'),(216,26,12,'12:30:00'),(217,26,13,'12:30:00'),(218,26,14,'12:32:00'),(219,26,15,'12:39:00'),(220,26,16,'12:42:00'),(221,26,17,'12:45:00'),(222,27,1,'12:15:00'),(223,27,2,'12:19:00'),(224,27,3,'12:20:00'),(225,27,4,'12:22:00'),(226,27,5,'12:22:00'),(227,27,6,'12:24:00'),(228,27,7,'12:32:00'),(229,27,8,'12:34:00'),(230,27,9,'12:35:00'),(231,28,10,'12:35:00'),(232,28,11,'12:42:00'),(233,28,12,'12:45:00'),(234,28,13,'12:45:00'),(235,28,14,'12:47:00'),(236,28,15,'12:54:00'),(237,28,16,'12:57:00'),(238,28,17,'13:00:00'),(239,29,1,'12:30:00'),(240,29,2,'12:34:00'),(241,29,3,'12:35:00'),(242,29,4,'12:37:00'),(243,29,5,'12:37:00'),(244,29,6,'12:39:00'),(245,29,7,'12:47:00'),(246,29,8,'12:49:00'),(247,29,9,'12:50:00'),(248,30,10,'12:50:00'),(249,30,11,'12:57:00'),(250,30,12,'13:00:00'),(251,30,13,'13:00:00'),(252,30,14,'13:02:00'),(253,30,15,'13:09:00'),(254,30,16,'13:12:00'),(255,30,17,'13:15:00'),(256,31,1,'12:45:00'),(257,31,2,'12:49:00'),(258,31,3,'12:50:00'),(259,31,4,'12:52:00'),(260,31,5,'12:52:00'),(261,31,6,'12:54:00'),(262,31,7,'13:02:00'),(263,31,8,'13:04:00'),(264,31,9,'13:05:00'),(265,32,10,'13:05:00'),(266,32,11,'13:12:00'),(267,32,12,'13:15:00'),(268,32,13,'13:15:00'),(269,32,14,'13:17:00'),(270,32,15,'13:24:00'),(271,32,16,'13:27:00'),(272,32,17,'13:30:00'),(273,33,1,'13:00:00'),(274,33,2,'13:04:00'),(275,33,3,'13:05:00'),(276,33,4,'13:07:00'),(277,33,5,'13:07:00'),(278,33,6,'13:09:00'),(279,33,7,'13:17:00'),(280,33,8,'13:19:00'),(281,33,9,'13:20:00'),(282,34,10,'13:20:00'),(283,34,11,'13:27:00'),(284,34,12,'13:30:00'),(285,34,13,'13:30:00'),(286,34,14,'13:32:00'),(287,34,15,'13:39:00'),(288,34,16,'13:42:00'),(289,34,17,'13:45:00'),(290,35,1,'13:15:00'),(291,35,2,'13:19:00'),(292,35,3,'13:20:00'),(293,35,4,'13:22:00'),(294,35,5,'13:22:00'),(295,35,6,'13:24:00'),(296,35,7,'13:32:00'),(297,35,8,'13:34:00'),(298,35,9,'13:35:00'),(299,36,10,'13:35:00'),(300,36,11,'13:42:00'),(301,36,12,'13:45:00'),(302,36,13,'13:45:00'),(303,36,14,'13:47:00'),(304,36,15,'13:54:00'),(305,36,16,'13:57:00'),(306,36,17,'14:00:00'),(307,37,1,'13:30:00'),(308,37,2,'13:34:00'),(309,37,3,'13:35:00'),(310,37,4,'13:37:00'),(311,37,5,'13:37:00'),(312,37,6,'13:39:00'),(313,37,7,'13:47:00'),(314,37,8,'13:49:00'),(315,37,9,'13:50:00'),(316,38,10,'13:50:00'),(317,38,11,'13:57:00'),(318,38,12,'14:00:00'),(319,38,13,'14:00:00'),(320,38,14,'14:02:00'),(321,38,15,'14:09:00'),(322,38,16,'14:12:00'),(323,38,17,'14:15:00'),(324,39,1,'13:45:00'),(325,39,2,'13:49:00'),(326,39,3,'13:50:00'),(327,39,4,'13:52:00'),(328,39,5,'13:52:00'),(329,39,6,'13:54:00'),(330,39,7,'14:02:00'),(331,39,8,'14:04:00'),(332,39,9,'14:05:00'),(333,40,10,'14:05:00'),(334,40,11,'14:12:00'),(335,40,12,'14:15:00'),(336,40,13,'14:15:00'),(337,40,14,'14:17:00'),(338,40,15,'14:24:00'),(339,40,16,'14:27:00'),(340,40,17,'14:30:00'),(341,41,1,'14:00:00'),(342,41,2,'14:04:00'),(343,41,3,'14:05:00'),(344,41,4,'14:07:00'),(345,41,5,'14:07:00'),(346,41,6,'14:09:00'),(347,41,7,'14:17:00'),(348,41,8,'14:19:00'),(349,41,9,'14:20:00'),(350,42,10,'14:20:00'),(351,42,11,'14:27:00'),(352,42,12,'14:30:00'),(353,42,13,'14:30:00'),(354,42,14,'14:32:00'),(355,42,15,'14:39:00'),(356,42,16,'14:42:00'),(357,42,17,'14:45:00'),(358,43,1,'14:15:00'),(359,43,2,'14:19:00'),(360,43,3,'14:20:00'),(361,43,4,'14:22:00'),(362,43,5,'14:22:00'),(363,43,6,'14:24:00'),(364,43,7,'14:32:00'),(365,43,8,'14:34:00'),(366,43,9,'14:35:00'),(367,44,10,'14:35:00'),(368,44,11,'14:42:00'),(369,44,12,'14:45:00'),(370,44,13,'14:45:00'),(371,44,14,'14:47:00'),(372,44,15,'14:54:00'),(373,44,16,'14:57:00'),(374,44,17,'15:00:00'),(375,45,1,'14:30:00'),(376,45,2,'14:34:00'),(377,45,3,'14:35:00'),(378,45,4,'14:37:00'),(379,45,5,'14:37:00'),(380,45,6,'14:39:00'),(381,45,7,'14:47:00'),(382,45,8,'14:49:00'),(383,45,9,'14:50:00'),(384,46,10,'14:50:00'),(385,46,11,'14:57:00'),(386,46,12,'15:00:00'),(387,46,13,'15:00:00'),(388,46,14,'15:02:00'),(389,46,15,'15:09:00'),(390,46,16,'15:12:00'),(391,46,17,'15:15:00'),(392,47,1,'14:45:00'),(393,47,2,'14:49:00'),(394,47,3,'14:50:00'),(395,47,4,'14:52:00'),(396,47,5,'14:52:00'),(397,47,6,'14:54:00'),(398,47,7,'15:02:00'),(399,47,8,'15:04:00'),(400,47,9,'15:05:00'),(401,48,10,'15:05:00'),(402,48,11,'15:12:00'),(403,48,12,'15:15:00'),(404,48,13,'15:15:00'),(405,48,14,'15:17:00'),(406,48,15,'15:24:00'),(407,48,16,'15:27:00'),(408,48,17,'15:30:00'),(409,49,1,'15:00:00'),(410,49,2,'15:04:00'),(411,49,3,'15:05:00'),(412,49,4,'15:07:00'),(413,49,5,'15:07:00'),(414,49,6,'15:09:00'),(415,49,7,'15:17:00'),(416,49,8,'15:19:00'),(417,49,9,'15:20:00'),(418,50,10,'15:20:00'),(419,50,11,'15:27:00'),(420,50,12,'15:30:00'),(421,50,13,'15:30:00'),(422,50,14,'15:32:00'),(423,50,15,'15:39:00'),(424,50,16,'15:42:00'),(425,50,17,'15:45:00'),(426,51,1,'15:15:00'),(427,51,2,'15:19:00'),(428,51,3,'15:20:00'),(429,51,4,'15:22:00'),(430,51,5,'15:22:00'),(431,51,6,'15:24:00'),(432,51,7,'15:32:00'),(433,51,8,'15:34:00'),(434,51,9,'15:35:00'),(435,52,10,'15:35:00'),(436,52,11,'15:42:00'),(437,52,12,'15:45:00'),(438,52,13,'15:45:00'),(439,52,14,'15:47:00'),(440,52,15,'15:54:00'),(441,52,16,'15:57:00'),(442,52,17,'16:00:00'),(443,53,1,'15:30:00'),(444,53,2,'15:34:00'),(445,53,3,'15:35:00'),(446,53,4,'15:37:00'),(447,53,5,'15:37:00'),(448,53,6,'15:39:00'),(449,53,7,'15:47:00'),(450,53,8,'15:49:00'),(451,53,9,'15:50:00'),(452,54,10,'15:50:00'),(453,54,11,'15:57:00'),(454,54,12,'16:00:00'),(455,54,13,'16:00:00'),(456,54,14,'16:02:00'),(457,54,15,'16:09:00'),(458,54,16,'16:12:00'),(459,54,17,'16:15:00'),(460,55,1,'15:45:00'),(461,55,2,'15:49:00'),(462,55,3,'15:50:00'),(463,55,4,'15:52:00'),(464,55,5,'15:52:00'),(465,55,6,'15:54:00'),(466,55,7,'16:02:00'),(467,55,8,'16:04:00'),(468,55,9,'16:05:00'),(469,56,10,'16:05:00'),(470,56,11,'16:12:00'),(471,56,12,'16:15:00'),(472,56,13,'16:15:00'),(473,56,14,'16:17:00'),(474,56,15,'16:24:00'),(475,56,16,'16:27:00'),(476,56,17,'16:30:00'),(477,57,1,'16:00:00'),(478,57,2,'16:04:00'),(479,57,3,'16:05:00'),(480,57,4,'16:07:00'),(481,57,5,'16:07:00'),(482,57,6,'16:09:00'),(483,57,7,'16:17:00'),(484,57,8,'16:19:00'),(485,57,9,'16:20:00'),(486,58,10,'16:20:00'),(487,58,11,'16:27:00'),(488,58,12,'16:30:00'),(489,58,13,'16:30:00'),(490,58,14,'16:32:00'),(491,58,15,'16:39:00'),(492,58,16,'16:42:00'),(493,58,17,'16:45:00'),(494,59,1,'16:15:00'),(495,59,2,'16:19:00'),(496,59,3,'16:20:00'),(497,59,4,'16:22:00'),(498,59,5,'16:22:00'),(499,59,6,'16:24:00'),(500,59,7,'16:32:00'),(501,59,8,'16:34:00'),(502,59,9,'16:35:00'),(503,60,10,'16:35:00'),(504,60,11,'16:42:00'),(505,60,12,'16:45:00'),(506,60,13,'16:45:00'),(507,60,14,'16:47:00'),(508,60,15,'16:54:00'),(509,60,16,'16:57:00'),(510,60,17,'17:00:00'),(511,61,1,'16:30:00'),(512,61,2,'16:34:00'),(513,61,3,'16:35:00'),(514,61,4,'16:37:00'),(515,61,5,'16:37:00'),(516,61,6,'16:39:00'),(517,61,7,'16:47:00'),(518,61,8,'16:49:00'),(519,61,9,'16:50:00'),(520,62,10,'16:50:00'),(521,62,11,'16:57:00'),(522,62,12,'17:00:00'),(523,62,13,'17:00:00'),(524,62,14,'17:02:00'),(525,62,15,'17:09:00'),(526,62,16,'17:12:00'),(527,62,17,'17:15:00'),(528,63,1,'16:45:00'),(529,63,2,'16:49:00'),(530,63,3,'16:50:00'),(531,63,4,'16:52:00'),(532,63,5,'16:52:00'),(533,63,6,'16:54:00'),(534,63,7,'17:02:00'),(535,63,8,'17:04:00'),(536,63,9,'17:05:00'),(537,64,10,'17:05:00'),(538,64,11,'17:12:00'),(539,64,12,'17:15:00'),(540,64,13,'17:15:00'),(541,64,14,'17:17:00'),(542,64,15,'17:24:00'),(543,64,16,'17:27:00'),(544,64,17,'17:30:00'),(545,65,1,'17:00:00'),(546,65,2,'17:04:00'),(547,65,3,'17:05:00'),(548,65,4,'17:07:00'),(549,65,5,'17:07:00'),(550,65,6,'17:09:00'),(551,65,7,'17:17:00'),(552,65,8,'17:19:00'),(553,65,9,'17:20:00'),(554,66,10,'17:20:00'),(555,66,11,'17:27:00'),(556,66,12,'17:30:00'),(557,66,13,'17:30:00'),(558,66,14,'17:32:00'),(559,66,15,'17:39:00'),(560,66,16,'17:42:00'),(561,66,17,'17:45:00'),(562,67,1,'17:15:00'),(563,67,2,'17:19:00'),(564,67,3,'17:20:00'),(565,67,4,'17:22:00'),(566,67,5,'17:22:00'),(567,67,6,'17:24:00'),(568,67,7,'17:32:00'),(569,67,8,'17:34:00'),(570,67,9,'17:35:00'),(571,68,10,'17:35:00'),(572,68,11,'17:42:00'),(573,68,12,'17:45:00'),(574,68,13,'17:45:00'),(575,68,14,'17:47:00'),(576,68,15,'17:54:00'),(577,68,16,'17:57:00'),(578,68,17,'18:00:00'),(579,69,1,'17:30:00'),(580,69,2,'17:34:00'),(581,69,3,'17:35:00'),(582,69,4,'17:37:00'),(583,69,5,'17:37:00'),(584,69,6,'17:39:00'),(585,69,7,'17:47:00'),(586,69,8,'17:49:00'),(587,69,9,'17:50:00'),(588,70,10,'17:50:00'),(589,70,11,'17:57:00'),(590,70,12,'18:00:00'),(591,70,13,'18:00:00'),(592,70,14,'18:02:00'),(593,70,15,'18:09:00'),(594,70,16,'18:12:00'),(595,70,17,'18:15:00'),(596,71,1,'18:00:00'),(597,71,2,'18:04:00'),(598,71,3,'18:05:00'),(599,71,4,'18:07:00'),(600,71,5,'18:07:00'),(601,71,6,'18:09:00'),(602,71,7,'18:17:00'),(603,71,8,'18:19:00'),(604,71,9,'18:20:00'),(605,72,10,'18:20:00'),(606,72,11,'18:27:00'),(607,72,12,'18:30:00'),(608,72,13,'18:30:00'),(609,72,14,'18:32:00'),(610,72,15,'18:39:00'),(611,72,16,'18:42:00'),(612,72,17,'18:45:00'),(613,73,1,'18:15:00'),(614,73,2,'18:19:00'),(615,73,3,'18:20:00'),(616,73,4,'18:22:00'),(617,73,5,'18:22:00'),(618,73,6,'18:24:00'),(619,73,7,'18:32:00'),(620,73,8,'18:34:00'),(621,73,9,'18:35:00'),(622,74,10,'18:35:00'),(623,74,11,'18:42:00'),(624,74,12,'18:45:00'),(625,74,13,'18:45:00'),(626,74,14,'18:47:00'),(627,74,15,'18:54:00'),(628,74,16,'18:57:00'),(629,74,17,'19:00:00'),(630,75,1,'19:00:00'),(631,75,2,'19:04:00'),(632,75,3,'19:05:00'),(633,75,4,'19:07:00'),(634,75,5,'19:07:00'),(635,75,6,'19:09:00'),(636,75,7,'19:17:00'),(637,75,8,'19:19:00'),(638,75,9,'19:20:00'),(639,76,10,'19:20:00'),(640,76,11,'19:27:00'),(641,76,12,'19:30:00'),(642,76,13,'19:30:00'),(643,76,14,'19:32:00'),(644,76,15,'19:39:00'),(645,76,16,'19:42:00'),(646,76,17,'19:45:00'),(647,77,1,'19:15:00'),(648,77,2,'19:19:00'),(649,77,3,'19:20:00'),(650,77,4,'19:22:00'),(651,77,5,'19:22:00'),(652,77,6,'19:24:00'),(653,77,7,'19:32:00'),(654,77,8,'19:34:00'),(655,77,9,'19:35:00'),(656,78,10,'19:35:00'),(657,78,11,'19:42:00'),(658,78,12,'19:45:00'),(659,78,13,'19:45:00'),(660,78,14,'19:47:00'),(661,78,15,'19:54:00'),(662,78,16,'19:57:00'),(663,78,17,'20:00:00'),(664,79,1,'20:00:00'),(665,79,2,'20:04:00'),(666,79,3,'20:05:00'),(667,79,4,'20:07:00'),(668,79,5,'20:07:00'),(669,79,6,'20:09:00'),(670,79,7,'20:17:00'),(671,79,8,'20:19:00'),(672,79,9,'20:20:00'),(673,80,10,'20:20:00'),(674,80,11,'20:27:00'),(675,80,12,'20:30:00'),(676,80,13,'20:30:00'),(677,80,14,'20:32:00'),(678,80,15,'20:39:00'),(679,80,16,'20:42:00'),(680,80,17,'20:45:00'),(681,81,1,'20:15:00'),(682,81,2,'20:19:00'),(683,81,3,'20:20:00'),(684,81,4,'20:22:00'),(685,81,5,'20:22:00'),(686,81,6,'20:24:00'),(687,81,7,'20:32:00'),(688,81,8,'20:34:00'),(689,81,9,'20:35:00'),(690,82,10,'20:35:00'),(691,82,11,'20:42:00'),(692,82,12,'20:45:00'),(693,82,13,'20:45:00'),(694,82,14,'20:47:00'),(695,82,15,'20:54:00'),(696,82,16,'20:57:00'),(697,82,17,'21:00:00');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stops`
--

DROP TABLE IF EXISTS `stops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stops` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `bus_id` int(11) DEFAULT NULL,
  `direction` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'depart',
  `stop_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `long` decimal(11,8) DEFAULT NULL,
  `order_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stops`
--

LOCK TABLES `stops` WRITE;
/*!40000 ALTER TABLE `stops` DISABLE KEYS */;
INSERT INTO `stops` VALUES (1,1,'depart','The Breeze',-6.30136553,106.65307177,1),(2,1,'depart','CBD Utara 1',-6.30002622,106.64773265,2),(3,1,'depart','CBD Utara 3',-6.29888359,106.64313723,3),(4,1,'depart','CBD Barat 1',-6.29946909,106.64113062,4),(5,1,'depart','CBD Barat 2',-6.30224406,106.64198799,5),(6,1,'depart','Lobby Aeon Mall',-6.30421672,106.64369181,6),(7,1,'depart','CBD Utara 3',-6.29888359,106.64313723,7),(8,1,'depart','ICE 1',-6.29743769,106.63682672,8),(9,1,'depart','Lobby ICE',-6.29993400,106.63602200,9),(10,1,'return','Lobby ICE',-6.29993400,106.63602200,1),(11,1,'return','ICE 5',-6.29752122,106.63614965,2),(12,1,'return','CBD Barat 1',-6.29946909,106.64113062,3),(13,1,'return','CBD Barat 2',-6.30224406,106.64198799,4),(14,1,'return','Lobby Aeon Mall',-6.30421672,106.64369181,5),(15,1,'return','Nava Park 1',-6.29983110,106.64968281,6),(16,1,'return','Greencove',-6.30019559,106.65998868,7),(17,1,'return','The Breeze',-6.30136553,106.65307177,8);
/*!40000 ALTER TABLE `stops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trips` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `bus_id` int(11) DEFAULT NULL,
  `direction` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `departure_stop` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `arrival_stop` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bus_no` int(11) DEFAULT NULL,
  `is_weekend` tinyint(1) DEFAULT '0',
  `departure_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trips`
--

LOCK TABLES `trips` WRITE;
/*!40000 ALTER TABLE `trips` DISABLE KEYS */;
INSERT INTO `trips` VALUES (1,1,'depart','The Breeze','Lobby Convention Hall',11,0,'09:00:00'),(2,1,'return','Lobby Convention Hall','The Breeze',11,0,'09:20:00'),(3,1,'depart','The Breeze','Lobby Convention Hall',12,0,'09:15:00'),(4,1,'return','Lobby Convention Hall','The Breeze',12,0,'09:35:00'),(5,1,'depart','The Breeze','Lobby Convention Hall',13,0,'09:30:00'),(6,1,'return','Lobby Convention Hall','The Breeze',13,0,'09:50:00'),(7,1,'depart','The Breeze','Lobby Convention Hall',14,0,'09:45:00'),(8,1,'return','Lobby Convention Hall','The Breeze',14,0,'10:05:00'),(9,1,'depart','The Breeze','Lobby Convention Hall',11,0,'10:00:00'),(10,1,'return','Lobby Convention Hall','The Breeze',11,0,'10:20:00'),(11,1,'depart','The Breeze','Lobby Convention Hall',12,0,'10:15:00'),(12,1,'return','Lobby Convention Hall','The Breeze',12,0,'10:35:00'),(13,1,'depart','The Breeze','Lobby Convention Hall',13,0,'10:30:00'),(14,1,'return','Lobby Convention Hall','The Breeze',13,0,'10:50:00'),(15,1,'depart','The Breeze','Lobby Convention Hall',14,0,'10:45:00'),(16,1,'return','Lobby Convention Hall','The Breeze',14,0,'11:05:00'),(17,1,'depart','The Breeze','Lobby Convention Hall',11,0,'11:00:00'),(18,1,'return','Lobby Convention Hall','The Breeze',11,0,'11:20:00'),(19,1,'depart','The Breeze','Lobby Convention Hall',12,0,'11:15:00'),(20,1,'return','Lobby Convention Hall','The Breeze',12,0,'11:35:00'),(21,1,'depart','The Breeze','Lobby Convention Hall',13,0,'11:30:00'),(22,1,'return','Lobby Convention Hall','The Breeze',13,0,'11:50:00'),(23,1,'depart','The Breeze','Lobby Convention Hall',14,0,'11:45:00'),(24,1,'return','Lobby Convention Hall','The Breeze',14,0,'12:05:00'),(25,1,'depart','The Breeze','Lobby Convention Hall',11,0,'12:00:00'),(26,1,'return','Lobby Convention Hall','The Breeze',11,0,'12:20:00'),(27,1,'depart','The Breeze','Lobby Convention Hall',12,0,'12:15:00'),(28,1,'return','Lobby Convention Hall','The Breeze',12,0,'12:35:00'),(29,1,'depart','The Breeze','Lobby Convention Hall',13,0,'12:30:00'),(30,1,'return','Lobby Convention Hall','The Breeze',13,0,'12:50:00'),(31,1,'depart','The Breeze','Lobby Convention Hall',14,0,'12:45:00'),(32,1,'return','Lobby Convention Hall','The Breeze',14,0,'13:05:00'),(33,1,'depart','The Breeze','Lobby Convention Hall',11,0,'13:00:00'),(34,1,'return','Lobby Convention Hall','The Breeze',11,0,'13:20:00'),(35,1,'depart','The Breeze','Lobby Convention Hall',12,0,'13:15:00'),(36,1,'return','Lobby Convention Hall','The Breeze',12,0,'13:35:00'),(37,1,'depart','The Breeze','Lobby Convention Hall',13,0,'13:30:00'),(38,1,'return','Lobby Convention Hall','The Breeze',13,0,'13:50:00'),(39,1,'depart','The Breeze','Lobby Convention Hall',14,0,'13:45:00'),(40,1,'return','Lobby Convention Hall','The Breeze',14,0,'14:05:00'),(41,1,'depart','The Breeze','Lobby Convention Hall',11,0,'14:00:00'),(42,1,'return','Lobby Convention Hall','The Breeze',11,0,'14:20:00'),(43,1,'depart','The Breeze','Lobby Convention Hall',12,0,'14:15:00'),(44,1,'return','Lobby Convention Hall','The Breeze',12,0,'14:35:00'),(45,1,'depart','The Breeze','Lobby Convention Hall',13,0,'14:30:00'),(46,1,'return','Lobby Convention Hall','The Breeze',13,0,'14:50:00'),(47,1,'depart','The Breeze','Lobby Convention Hall',14,0,'14:45:00'),(48,1,'return','Lobby Convention Hall','The Breeze',14,0,'15:05:00'),(49,1,'depart','The Breeze','Lobby Convention Hall',11,0,'15:00:00'),(50,1,'return','Lobby Convention Hall','The Breeze',11,0,'15:20:00'),(51,1,'depart','The Breeze','Lobby Convention Hall',12,0,'15:15:00'),(52,1,'return','Lobby Convention Hall','The Breeze',12,0,'15:35:00'),(53,1,'depart','The Breeze','Lobby Convention Hall',13,0,'15:30:00'),(54,1,'return','Lobby Convention Hall','The Breeze',13,0,'15:50:00'),(55,1,'depart','The Breeze','Lobby Convention Hall',14,0,'15:45:00'),(56,1,'return','Lobby Convention Hall','The Breeze',14,0,'16:05:00'),(57,1,'depart','The Breeze','Lobby Convention Hall',11,0,'16:00:00'),(58,1,'return','Lobby Convention Hall','The Breeze',11,0,'16:20:00'),(59,1,'depart','The Breeze','Lobby Convention Hall',12,0,'16:15:00'),(60,1,'return','Lobby Convention Hall','The Breeze',12,0,'16:35:00'),(61,1,'depart','The Breeze','Lobby Convention Hall',13,0,'16:30:00'),(62,1,'return','Lobby Convention Hall','The Breeze',13,0,'16:50:00'),(63,1,'depart','The Breeze','Lobby Convention Hall',14,0,'16:45:00'),(64,1,'return','Lobby Convention Hall','The Breeze',14,0,'17:05:00'),(65,1,'depart','The Breeze','Lobby Convention Hall',11,0,'17:00:00'),(66,1,'return','Lobby Convention Hall','The Breeze',11,0,'17:20:00'),(67,1,'depart','The Breeze','Lobby Convention Hall',12,0,'17:15:00'),(68,1,'return','Lobby Convention Hall','The Breeze',12,0,'17:35:00'),(69,1,'depart','The Breeze','Lobby Convention Hall',13,1,'17:30:00'),(70,1,'return','Lobby Convention Hall','The Breeze',13,1,'17:50:00'),(71,1,'depart','The Breeze','Lobby Convention Hall',11,1,'18:00:00'),(72,1,'return','Lobby Convention Hall','The Breeze',11,1,'18:20:00'),(73,1,'depart','The Breeze','Lobby Convention Hall',12,0,'18:15:00'),(74,1,'return','Lobby Convention Hall','The Breeze',12,0,'18:35:00'),(75,1,'depart','The Breeze','Lobby Convention Hall',11,1,'19:00:00'),(76,1,'return','Lobby Convention Hall','The Breeze',11,1,'19:20:00'),(77,1,'depart','The Breeze','Lobby Convention Hall',12,0,'19:15:00'),(78,1,'return','Lobby Convention Hall','The Breeze',12,0,'19:35:00'),(79,1,'depart','The Breeze','Lobby Convention Hall',11,0,'20:00:00'),(80,1,'return','Lobby Convention Hall','The Breeze',11,0,'20:20:00'),(81,1,'depart','The Breeze','Lobby Convention Hall',12,0,'20:15:00'),(82,1,'return','Lobby Convention Hall','The Breeze',12,0,'20:35:00');
/*!40000 ALTER TABLE `trips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,NULL,NULL),(2,NULL,NULL,NULL,NULL),(3,NULL,NULL,NULL,NULL),(4,NULL,NULL,NULL,NULL),(5,NULL,NULL,NULL,NULL),(6,NULL,NULL,NULL,NULL),(7,NULL,NULL,NULL,NULL),(8,NULL,NULL,NULL,NULL),(9,NULL,NULL,NULL,NULL),(10,NULL,NULL,NULL,NULL),(11,'12222111','1E302C775EFABA47F576136E54ED9938F45CEFEC52D16B8FC754B543E7E1BD86','reni',NULL),(12,'12222111','1E302C775EFABA47F576136E54ED9938F45CEFEC52D16B8FC754B543E7E1BD86','reni',NULL),(13,'testers','1E302C775EFABA47F576136E54ED9938F45CEFEC52D16B8FC754B543E7E1BD86','reni',NULL),(14,'testers','1E302C775EFABA47F576136E54ED9938F45CEFEC52D16B8FC754B543E7E1BD86','reni',NULL),(15,'apatuu','2022o3o9333','Siti',NULL),(16,'apatuu','2022o3o9333','Siti',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-11 16:56:15
