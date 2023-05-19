CREATE DATABASE  IF NOT EXISTS `twitch_database`;
USE `twitch_database`;

--
-- Table structure for table `about`
--

DROP TABLE IF EXISTS `about`;
CREATE TABLE `about` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `bio` mediumtext,
  `followCount` int NOT NULL,
  `socialLink` json DEFAULT NULL,
  `pannel` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `about`
--

LOCK TABLES `about` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `category-topic`
--

DROP TABLE IF EXISTS `category-topic`;
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

--
-- Dumping data for table `category-topic`
--

LOCK TABLES `category-topic` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `channel`
--

DROP TABLE IF EXISTS `channel`;
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

--
-- Dumping data for table `channel`
--

LOCK TABLES `channel` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
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

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `live`
--

DROP TABLE IF EXISTS `live`;
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

--
-- Dumping data for table `live`
--

LOCK TABLES `live` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `live-category`
--

DROP TABLE IF EXISTS `live-category`;
CREATE TABLE `live-category` (
  `liveId` int NOT NULL,
  `categoryId` int NOT NULL,
  PRIMARY KEY (`liveId`,`categoryId`),
  KEY `fromLiveCategoryToCategory_idx` (`categoryId`),
  CONSTRAINT `fromLiveCategoryToCategory` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fromLiveCategoryToLive` FOREIGN KEY (`liveId`) REFERENCES `live` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `live-category`
--

LOCK TABLES `live-category` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `date` datetime NOT NULL,
  `channelId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FromScheduleToChannel_idx` (`channelId`),
  CONSTRAINT `FromScheduleToChannel` FOREIGN KEY (`channelId`) REFERENCES `channel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `liveId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FromTagToLive_idx` (`liveId`),
  CONSTRAINT `FromTagToLive` FOREIGN KEY (`liveId`) REFERENCES `live` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
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

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `topic-tag`
--

DROP TABLE IF EXISTS `topic-tag`;
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

--
-- Dumping data for table `topic-tag`
--

LOCK TABLES `topic-tag` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `topic-video`
--

DROP TABLE IF EXISTS `topic-video`;
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

--
-- Dumping data for table `topic-video`
--

LOCK TABLES `topic-video` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `video`
--

DROP TABLE IF EXISTS `video`;
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

--
-- Dumping data for table `video`
--

LOCK TABLES `video` WRITE;
UNLOCK TABLES;