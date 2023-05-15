CREATE DATABASE  IF NOT EXISTS `twitch_database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `twitch_database`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: twitch_database
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `about`
--

DROP TABLE IF EXISTS `about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `bio` mediumtext,
  `followCount` int NOT NULL,
  `socialLink` json DEFAULT NULL,
  `pannel` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about`
--

LOCK TABLES `about` WRITE;
/*!40000 ALTER TABLE `about` DISABLE KEYS */;
/*!40000 ALTER TABLE `about` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category-topic`
--

DROP TABLE IF EXISTS `category-topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category-topic` (
  `categoryId` int NOT NULL,
  `topicId` int NOT NULL,
  `follow` tinyint DEFAULT '0',
  `subscribe` tinyint DEFAULT '0',
  PRIMARY KEY (`categoryId`,`topicId`),
  KEY `fromCategoryTopicToTopic_idx` (`topicId`),
  CONSTRAINT `fromCategoryTopicToCategory` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`),
  CONSTRAINT `fromCategoryTopicToTopic` FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category-topic`
--

LOCK TABLES `category-topic` WRITE;
/*!40000 ALTER TABLE `category-topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `category-topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel`
--

DROP TABLE IF EXISTS `channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `followCount` int NOT NULL,
  `verification` tinyint NOT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `follow` tinyint NOT NULL DEFAULT '0',
  `subscribe` tinyint NOT NULL DEFAULT '0',
  `liveId` int NOT NULL,
  `aboutId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FromChannelToLive_idx` (`liveId`),
  KEY `FromChannelToAbout` (`aboutId`),
  CONSTRAINT `FromChannelToAbout` FOREIGN KEY (`aboutId`) REFERENCES `about` (`id`),
  CONSTRAINT `FromChannelToLive` FOREIGN KEY (`liveId`) REFERENCES `live` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel`
--

LOCK TABLES `channel` WRITE;
/*!40000 ALTER TABLE `channel` DISABLE KEYS */;
/*!40000 ALTER TABLE `channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `message` mediumtext NOT NULL,
  `badge` json DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `liveId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FromChatToLive_idx` (`liveId`),
  CONSTRAINT `FromChatToLive` FOREIGN KEY (`liveId`) REFERENCES `live` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live`
--

DROP TABLE IF EXISTS `live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `viewLive` int NOT NULL,
  `display` varchar(500) DEFAULT NULL,
  `time` timestamp NOT NULL,
  `follow` tinyint NOT NULL DEFAULT '0',
  `subscribe` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live`
--

LOCK TABLES `live` WRITE;
/*!40000 ALTER TABLE `live` DISABLE KEYS */;
/*!40000 ALTER TABLE `live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live-category`
--

DROP TABLE IF EXISTS `live-category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live-category` (
  `liveId` int NOT NULL,
  `categoryId` int NOT NULL,
  PRIMARY KEY (`liveId`,`categoryId`),
  KEY `fromLiveCategoryToCategory_idx` (`categoryId`),
  CONSTRAINT `fromLiveCategoryToCategory` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fromLiveCategoryToLive` FOREIGN KEY (`liveId`) REFERENCES `live` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live-category`
--

LOCK TABLES `live-category` WRITE;
/*!40000 ALTER TABLE `live-category` DISABLE KEYS */;
/*!40000 ALTER TABLE `live-category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `date` datetime NOT NULL,
  `channelId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FromScheduleToChannel_idx` (`channelId`),
  CONSTRAINT `FromScheduleToChannel` FOREIGN KEY (`channelId`) REFERENCES `channel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `liveId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FromTagToLive_idx` (`liveId`),
  CONSTRAINT `FromTagToLive` FOREIGN KEY (`liveId`) REFERENCES `live` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  `followCount` int NOT NULL,
  `viewLive` int NOT NULL,
  `cover` varchar(500) DEFAULT NULL,
  `follow` tinyint DEFAULT '0',
  `channelId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FromTopicToChannel_idx` (`channelId`),
  CONSTRAINT `FromTopicToChannel` FOREIGN KEY (`channelId`) REFERENCES `channel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic-tag`
--

DROP TABLE IF EXISTS `topic-tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic-tag` (
  `topicId` int NOT NULL,
  `tagId` int NOT NULL,
  `follow` tinyint NOT NULL DEFAULT '0',
  `subscribe` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`topicId`,`tagId`),
  KEY `fromTopicTagToTag_idx` (`tagId`),
  CONSTRAINT `fromTopicTagToTag` FOREIGN KEY (`tagId`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fromTopicTagToTopic` FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic-tag`
--

LOCK TABLES `topic-tag` WRITE;
/*!40000 ALTER TABLE `topic-tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `topic-tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic-video`
--

DROP TABLE IF EXISTS `topic-video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic-video` (
  `topicId` int NOT NULL,
  `videoId` int NOT NULL,
  `follow` tinyint DEFAULT '0',
  `subscribe` tinyint DEFAULT '0',
  PRIMARY KEY (`topicId`,`videoId`),
  KEY `fromTopicVideoToVideo_idx` (`videoId`),
  CONSTRAINT `fromTopicVideoToTopic` FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fromTopicVideoToVideo` FOREIGN KEY (`videoId`) REFERENCES `video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic-video`
--

LOCK TABLES `topic-video` WRITE;
/*!40000 ALTER TABLE `topic-video` DISABLE KEYS */;
/*!40000 ALTER TABLE `topic-video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video`
--

DROP TABLE IF EXISTS `video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `title` mediumtext NOT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `view` int NOT NULL,
  `dateTime` datetime NOT NULL,
  `length` int NOT NULL,
  `channelId` int NOT NULL,
  `scheduleId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FromVideoToChannel_idx` (`channelId`),
  KEY `FromVideoToSchedule_idx` (`scheduleId`),
  CONSTRAINT `FromVideoToChannel` FOREIGN KEY (`channelId`) REFERENCES `channel` (`id`),
  CONSTRAINT `FromVideoToSchedule` FOREIGN KEY (`scheduleId`) REFERENCES `schedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video`
--

LOCK TABLES `video` WRITE;
/*!40000 ALTER TABLE `video` DISABLE KEYS */;
/*!40000 ALTER TABLE `video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'twitch_database'
--

--
-- Dumping routines for database 'twitch_database'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-05 17:32:01
