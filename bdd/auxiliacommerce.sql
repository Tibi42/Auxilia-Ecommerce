-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20260104.b9e50730fc
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 22, 2026 at 02:55 AM
-- Server version: 8.4.3
-- PHP Version: 8.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `auxiliacommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `slug`) VALUES
(19, 'Vins Rouges', 'vins-rouges'),
(20, 'Vins Blancs', 'vins-blancs'),
(21, 'Vins Rosés', 'vins-roses'),
(22, 'Champagnes & Bulles', 'champagnes-bulles'),
(23, 'Épicerie Fine', 'epicerie-fine');

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20260109095134', '2026-01-09 09:51:42', 36),
('DoctrineMigrations\\Version20260109100038', '2026-01-09 10:00:52', 28),
('DoctrineMigrations\\Version20260109132300', '2026-01-09 13:25:52', 38),
('DoctrineMigrations\\Version20260109133937', '2026-01-09 13:39:42', 27),
('DoctrineMigrations\\Version20260109134233', '2026-01-09 13:42:37', 85),
('DoctrineMigrations\\Version20260109135034', '2026-01-09 13:50:59', 38),
('DoctrineMigrations\\Version20260114082716', '2026-01-14 08:27:26', 38),
('DoctrineMigrations\\Version20260115072634', '2026-01-15 07:26:43', 20),
('DoctrineMigrations\\Version20260117082514', NULL, NULL),
('DoctrineMigrations\\Version20260117111234', '2026-01-17 11:12:44', 168),
('DoctrineMigrations\\Version20260118115412', '2026-01-18 11:56:22', 59),
('DoctrineMigrations\\Version20260121043150', '2026-01-21 04:32:06', 737);

-- --------------------------------------------------------

--
-- Table structure for table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `messenger_messages`
--

INSERT INTO `messenger_messages` (`id`, `body`, `headers`, `queue_name`, `created_at`, `available_at`, `delivered_at`) VALUES
(1, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:28:\\\"Symfony\\\\Component\\\\Mime\\\\Email\\\":6:{i:0;N;i:1;N;i:2;s:1329:\\\"<!DOCTYPE html>\n<html>\n	<head>\n		<meta charset=\\\"UTF-8\\\">\n		<style>\n			body {\n				font-family: Arial, sans-serif;\n				line-height: 1.6;\n				color: #333;\n			}\n			.container {\n				max-width: 600px;\n				margin: 0 auto;\n				padding: 20px;\n			}\n			.header {\n				background-color: #2563eb;\n				color: white;\n				padding: 20px;\n				text-align: center;\n				border-radius: 8px 8px 0 0;\n			}\n			.content {\n				background-color: #f5f5f5;\n				padding: 20px;\n				border-radius: 0 0 8px 8px;\n			}\n			.info {\n				background-color: white;\n				padding: 15px;\n				margin: 10px 0;\n				border-radius: 4px;\n				border-left: 4px solid #2563eb;\n			}\n			.label {\n				font-weight: bold;\n				color: #2563eb;\n			}\n		</style>\n	</head>\n	<body>\n		<div class=\\\"container\\\">\n			<div class=\\\"header\\\">\n				<h1>Nouveau message de contact</h1>\n			</div>\n			<div class=\\\"content\\\">\n				<p>Vous avez reçu un nouveau message depuis le formulaire de contact du site.</p>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Nom :</span>\n					tof\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Email :</span>\n					tof@gmail.com\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Sujet :</span>\n					test\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Message :</span><br>\n					testtesttesttesttest\n				</div>\n			</div>\n		</div>\n	</body>\n</html>\n\\\";i:3;s:5:\\\"utf-8\\\";i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:13:\\\"tof@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:29:\\\"contact@auxilia-ecommerce.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:29:\\\"Contact depuis le site : test\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2026-01-20 20:06:47', '2026-01-20 20:06:47', NULL),
(2, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:28:\\\"Symfony\\\\Component\\\\Mime\\\\Email\\\":6:{i:0;N;i:1;N;i:2;s:1325:\\\"<!DOCTYPE html>\n<html>\n	<head>\n		<meta charset=\\\"UTF-8\\\">\n		<style>\n			body {\n				font-family: Arial, sans-serif;\n				line-height: 1.6;\n				color: #333;\n			}\n			.container {\n				max-width: 600px;\n				margin: 0 auto;\n				padding: 20px;\n			}\n			.header {\n				background-color: #2563eb;\n				color: white;\n				padding: 20px;\n				text-align: center;\n				border-radius: 8px 8px 0 0;\n			}\n			.content {\n				background-color: #f5f5f5;\n				padding: 20px;\n				border-radius: 0 0 8px 8px;\n			}\n			.info {\n				background-color: white;\n				padding: 15px;\n				margin: 10px 0;\n				border-radius: 4px;\n				border-left: 4px solid #2563eb;\n			}\n			.label {\n				font-weight: bold;\n				color: #2563eb;\n			}\n		</style>\n	</head>\n	<body>\n		<div class=\\\"container\\\">\n			<div class=\\\"header\\\">\n				<h1>Nouveau message de contact</h1>\n			</div>\n			<div class=\\\"content\\\">\n				<p>Vous avez reçu un nouveau message depuis le formulaire de contact du site.</p>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Nom :</span>\n					tof\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Email :</span>\n					tof@gmail.com\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Sujet :</span>\n					test\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Message :</span><br>\n					essai 1234567890\n				</div>\n			</div>\n		</div>\n	</body>\n</html>\n\\\";i:3;s:5:\\\"utf-8\\\";i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:13:\\\"tof@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:27:\\\"guillaume.pecquet@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:29:\\\"Contact depuis le site : test\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2026-01-20 20:09:08', '2026-01-20 20:09:08', NULL),
(3, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:28:\\\"Symfony\\\\Component\\\\Mime\\\\Email\\\":6:{i:0;N;i:1;N;i:2;s:1325:\\\"<!DOCTYPE html>\n<html>\n	<head>\n		<meta charset=\\\"UTF-8\\\">\n		<style>\n			body {\n				font-family: Arial, sans-serif;\n				line-height: 1.6;\n				color: #333;\n			}\n			.container {\n				max-width: 600px;\n				margin: 0 auto;\n				padding: 20px;\n			}\n			.header {\n				background-color: #2563eb;\n				color: white;\n				padding: 20px;\n				text-align: center;\n				border-radius: 8px 8px 0 0;\n			}\n			.content {\n				background-color: #f5f5f5;\n				padding: 20px;\n				border-radius: 0 0 8px 8px;\n			}\n			.info {\n				background-color: white;\n				padding: 15px;\n				margin: 10px 0;\n				border-radius: 4px;\n				border-left: 4px solid #2563eb;\n			}\n			.label {\n				font-weight: bold;\n				color: #2563eb;\n			}\n		</style>\n	</head>\n	<body>\n		<div class=\\\"container\\\">\n			<div class=\\\"header\\\">\n				<h1>Nouveau message de contact</h1>\n			</div>\n			<div class=\\\"content\\\">\n				<p>Vous avez reçu un nouveau message depuis le formulaire de contact du site.</p>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Nom :</span>\n					tof\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Email :</span>\n					tof@gmail.com\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Sujet :</span>\n					test\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Message :</span><br>\n					test essai 12345\n				</div>\n			</div>\n		</div>\n	</body>\n</html>\n\\\";i:3;s:5:\\\"utf-8\\\";i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:13:\\\"tof@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:27:\\\"guillaume.pecquet@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:29:\\\"Contact depuis le site : test\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2026-01-20 20:31:39', '2026-01-20 20:31:39', NULL),
(4, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:28:\\\"Symfony\\\\Component\\\\Mime\\\\Email\\\":6:{i:0;N;i:1;N;i:2;s:1325:\\\"<!DOCTYPE html>\n<html>\n	<head>\n		<meta charset=\\\"UTF-8\\\">\n		<style>\n			body {\n				font-family: Arial, sans-serif;\n				line-height: 1.6;\n				color: #333;\n			}\n			.container {\n				max-width: 600px;\n				margin: 0 auto;\n				padding: 20px;\n			}\n			.header {\n				background-color: #2563eb;\n				color: white;\n				padding: 20px;\n				text-align: center;\n				border-radius: 8px 8px 0 0;\n			}\n			.content {\n				background-color: #f5f5f5;\n				padding: 20px;\n				border-radius: 0 0 8px 8px;\n			}\n			.info {\n				background-color: white;\n				padding: 15px;\n				margin: 10px 0;\n				border-radius: 4px;\n				border-left: 4px solid #2563eb;\n			}\n			.label {\n				font-weight: bold;\n				color: #2563eb;\n			}\n		</style>\n	</head>\n	<body>\n		<div class=\\\"container\\\">\n			<div class=\\\"header\\\">\n				<h1>Nouveau message de contact</h1>\n			</div>\n			<div class=\\\"content\\\">\n				<p>Vous avez reçu un nouveau message depuis le formulaire de contact du site.</p>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Nom :</span>\n					tof\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Email :</span>\n					tof@gmail.com\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Sujet :</span>\n					test\n				</div>\n\n				<div class=\\\"info\\\">\n					<span class=\\\"label\\\">Message :</span><br>\n					essai test 12345\n				</div>\n			</div>\n		</div>\n	</body>\n</html>\n\\\";i:3;s:5:\\\"utf-8\\\";i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:13:\\\"tof@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:27:\\\"guillaume.pecquet@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:29:\\\"Contact depuis le site : test\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2026-01-20 20:33:04', '2026-01-20 20:33:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `newsletter`
--

CREATE TABLE `newsletter` (
  `id` int NOT NULL,
  `email` varchar(180) NOT NULL,
  `subscribed_at` datetime NOT NULL,
  `is_active` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `newsletter`
--

INSERT INTO `newsletter` (`id`, `email`, `subscribed_at`, `is_active`) VALUES
(1, 'guillaume.pecquet@gmail.com', '2026-01-21 04:32:22', 1);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int NOT NULL,
  `status` varchar(32) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `dateat` datetime NOT NULL,
  `user_id` int NOT NULL,
  `stripe_session_id` varchar(255) DEFAULT NULL,
  `stripe_payment_intent_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `status`, `total`, `dateat`, `user_id`, `stripe_session_id`, `stripe_payment_intent_id`) VALUES
(24, 'cancelled', 210.60, '2026-01-20 02:18:38', 21, NULL, NULL),
(25, 'cancelled', 27.60, '2026-01-19 02:02:38', 21, NULL, NULL),
(26, 'pending', 112.30, '2026-01-20 04:55:38', 22, NULL, NULL),
(27, 'shipped', 268.80, '2025-12-29 04:05:38', 23, NULL, NULL),
(28, 'delivered', 64.60, '2025-12-30 21:20:38', 23, NULL, NULL),
(29, 'shipped', 25.50, '2025-12-29 03:09:38', 23, NULL, NULL),
(30, 'cancelled', 127.80, '2026-01-03 01:35:38', 24, NULL, NULL),
(31, 'delivered', 150.50, '2026-01-10 01:45:38', 24, NULL, NULL),
(32, 'shipped', 124.00, '2026-01-04 16:04:38', 25, NULL, NULL),
(33, 'cancelled', 94.00, '2026-01-20 00:16:38', 25, NULL, NULL),
(34, 'cancelled', 8.50, '2026-01-21 04:41:58', 21, NULL, NULL),
(35, 'cancelled', 8.50, '2026-01-21 04:42:08', 21, NULL, NULL),
(36, 'cancelled', 8.50, '2026-01-21 04:47:58', 21, NULL, NULL),
(37, 'cancelled', 34.00, '2026-01-21 04:51:49', 21, NULL, NULL),
(38, 'cancelled', 34.00, '2026-01-21 04:56:42', 21, NULL, NULL),
(39, 'cancelled', 34.00, '2026-01-21 04:57:34', 21, NULL, NULL),
(40, 'cancelled', 34.00, '2026-01-21 04:59:13', 21, NULL, NULL),
(41, 'cancelled', 34.00, '2026-01-21 04:59:23', 21, NULL, NULL),
(42, 'cancelled', 34.00, '2026-01-21 05:00:19', 21, NULL, NULL),
(43, 'cancelled', 34.00, '2026-01-21 05:01:13', 21, NULL, NULL),
(44, 'cancelled', 34.00, '2026-01-21 05:01:22', 21, NULL, NULL),
(45, 'cancelled', 51.00, '2026-01-21 05:04:31', 21, NULL, NULL),
(46, 'cancelled', 17.00, '2026-01-21 05:28:49', 21, NULL, NULL),
(47, 'paid', 85.00, '2026-01-21 07:43:41', 21, NULL, NULL),
(48, 'paid', 1.00, '2026-01-21 09:27:50', 21, NULL, NULL),
(49, 'pending', 9.90, '2026-01-21 10:57:36', 21, NULL, NULL),
(50, 'pending', 9.90, '2026-01-21 11:04:13', 21, NULL, NULL),
(51, 'cancelled', 9.90, '2026-01-21 11:04:48', 21, NULL, NULL),
(52, 'cancelled', 9.90, '2026-01-21 11:04:56', 21, NULL, NULL),
(53, 'cancelled', 9.90, '2026-01-21 11:20:37', 21, NULL, NULL),
(54, 'cancelled', 9.90, '2026-01-21 11:22:40', 21, NULL, NULL),
(55, 'cancelled', 9.90, '2026-01-21 12:08:49', 21, NULL, NULL),
(56, 'cancelled', 9.90, '2026-01-21 12:09:42', 21, NULL, NULL),
(57, 'cancelled', 9.90, '2026-01-21 12:09:54', 21, NULL, NULL),
(58, 'pending', 9.90, '2026-01-21 12:10:26', 21, NULL, NULL),
(59, 'pending', 9.90, '2026-01-21 12:12:58', 21, NULL, NULL),
(60, 'pending', 9.90, '2026-01-21 12:14:38', 21, NULL, NULL),
(61, 'pending', 9.90, '2026-01-21 12:15:07', 21, NULL, NULL),
(62, 'pending', 9.90, '2026-01-21 12:17:28', 21, NULL, NULL),
(63, 'cancelled', 9.90, '2026-01-21 12:18:19', 21, NULL, NULL),
(64, 'pending', 9.90, '2026-01-21 12:19:39', 21, NULL, NULL),
(65, 'pending', 9.90, '2026-01-21 12:22:01', 21, NULL, NULL),
(66, 'cancelled', 9.90, '2026-01-21 12:26:34', 21, NULL, NULL),
(67, 'cancelled', 9.90, '2026-01-21 12:26:40', 21, NULL, NULL),
(68, 'cancelled', 9.90, '2026-01-21 12:27:11', 21, NULL, NULL),
(69, 'cancelled', 9.90, '2026-01-21 12:28:13', 21, NULL, NULL),
(70, 'paid', 9.90, '2026-01-21 12:29:11', 21, NULL, NULL),
(71, 'paid', 9.90, '2026-01-21 12:31:12', 21, NULL, NULL),
(72, 'paid', 8.50, '2026-01-21 12:33:08', 21, NULL, NULL),
(73, 'paid', 8.50, '2026-01-21 12:40:58', 21, NULL, NULL),
(74, 'paid', 1.00, '2026-01-21 12:43:48', 21, NULL, NULL),
(75, 'paid', 1.00, '2026-01-21 12:48:37', 21, NULL, NULL),
(76, 'paid', 1.00, '2026-01-21 13:06:03', 21, NULL, NULL),
(77, 'paid', 1.00, '2026-01-21 13:35:54', 21, 'cs_test_a1KHrupc4xCRRKtkjF99ja0Xuz0HqZ3mZPKBfCZEQhVblKExGnqsYVAdj8', NULL),
(78, 'paid', 1.00, '2026-01-21 15:03:12', 22, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `order_ref_id` int NOT NULL,
  `product_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`id`, `quantity`, `price`, `product_name`, `total`, `order_ref_id`, `product_id`) VALUES
(45, 2, 19.90, 'Huile d\'Olive de Propriété', 39.80, 24, 91),
(46, 2, 19.90, 'Huile d\'Olive de Propriété', 39.80, 24, 91),
(47, 3, 24.50, 'Château Grand Terroir 2020', 73.50, 24, 80),
(48, 1, 42.00, 'Grand Cru \"Montagne Bleue\"', 42.00, 24, 86),
(49, 1, 15.50, 'Bordeaux Supérieur - Réserve', 15.50, 24, 83),
(50, 2, 13.80, 'Rosé de Provence \"Mistral\"', 27.60, 25, 87),
(51, 3, 16.50, 'Crémant de Loire \"Perle de Nuit\"', 49.50, 26, 90),
(52, 2, 19.90, 'Huile d\'Olive de Propriété', 39.80, 26, 91),
(53, 2, 11.50, 'Sauvignon Blanc \"Vallée Verte\"', 23.00, 26, 85),
(54, 3, 42.00, 'Grand Cru \"Montagne Bleue\"', 126.00, 27, 86),
(55, 2, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 19.80, 27, 88),
(56, 3, 16.50, 'Crémant de Loire \"Perle de Nuit\"', 49.50, 27, 90),
(57, 3, 24.50, 'Château Grand Terroir 2020', 73.50, 27, 80),
(58, 2, 15.50, 'Bordeaux Supérieur - Réserve', 31.00, 28, 83),
(59, 1, 13.80, 'Rosé de Provence \"Mistral\"', 13.80, 28, 87),
(60, 2, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 19.80, 28, 88),
(61, 3, 8.50, 'Vinaigre de Vin Vieux', 25.50, 29, 92),
(62, 1, 15.50, 'Bordeaux Supérieur - Réserve', 15.50, 30, 83),
(63, 2, 15.50, 'Bordeaux Supérieur - Réserve', 31.00, 30, 83),
(64, 2, 18.90, 'Pinot Noir \"Vieilles Vignes\"', 37.80, 30, 81),
(65, 1, 35.00, 'Champagne Brut \"Héritage\"', 35.00, 30, 89),
(66, 1, 8.50, 'Vinaigre de Vin Vieux', 8.50, 30, 92),
(67, 1, 42.00, 'Grand Cru \"Montagne Bleue\"', 42.00, 31, 86),
(68, 2, 42.00, 'Grand Cru \"Montagne Bleue\"', 84.00, 31, 86),
(69, 1, 24.50, 'Château Grand Terroir 2020', 24.50, 31, 80),
(70, 2, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 19.80, 32, 88),
(71, 1, 16.50, 'Crémant de Loire \"Perle de Nuit\"', 16.50, 32, 90),
(72, 3, 18.90, 'Pinot Noir \"Vieilles Vignes\"', 56.70, 32, 81),
(73, 2, 15.50, 'Bordeaux Supérieur - Réserve', 31.00, 32, 83),
(74, 1, 8.50, 'Vinaigre de Vin Vieux', 8.50, 33, 92),
(75, 1, 12.00, 'Cuvée des Vignerons - Syrah', 12.00, 33, 82),
(76, 3, 24.50, 'Château Grand Terroir 2020', 73.50, 33, 80),
(77, 1, 8.50, 'Vinaigre de Vin Vieux', 8.50, 34, 92),
(78, 1, 8.50, 'Vinaigre de Vin Vieux', 8.50, 35, 92),
(79, 1, 8.50, 'Vinaigre de Vin Vieux', 8.50, 36, 92),
(80, 4, 8.50, 'Vinaigre de Vin Vieux', 34.00, 37, 92),
(81, 4, 8.50, 'Vinaigre de Vin Vieux', 34.00, 38, 92),
(82, 4, 8.50, 'Vinaigre de Vin Vieux', 34.00, 39, 92),
(83, 4, 8.50, 'Vinaigre de Vin Vieux', 34.00, 40, 92),
(84, 4, 8.50, 'Vinaigre de Vin Vieux', 34.00, 41, 92),
(85, 4, 8.50, 'Vinaigre de Vin Vieux', 34.00, 42, 92),
(86, 4, 8.50, 'Vinaigre de Vin Vieux', 34.00, 43, 92),
(87, 4, 8.50, 'Vinaigre de Vin Vieux', 34.00, 44, 92),
(88, 6, 8.50, 'Vinaigre de Vin Vieux', 51.00, 45, 92),
(89, 2, 8.50, 'Vinaigre de Vin Vieux', 17.00, 46, 92),
(90, 10, 8.50, 'Vinaigre de Vin Vieux', 85.00, 47, 92),
(91, 1, 1.00, 'test', 1.00, 48, 93),
(92, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 49, 88),
(93, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 50, 88),
(94, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 51, 88),
(95, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 52, 88),
(96, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 53, 88),
(97, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 54, 88),
(98, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 55, 88),
(99, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 56, 88),
(100, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 57, 88),
(101, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 58, 88),
(102, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 59, 88),
(103, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 60, 88),
(104, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 61, 88),
(105, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 62, 88),
(106, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 63, 88),
(107, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 64, 88),
(108, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 65, 88),
(109, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 66, 88),
(110, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 67, 88),
(111, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 68, 88),
(112, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 69, 88),
(113, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 70, 88),
(114, 1, 9.90, 'Gris de Gris \"Sable d\'Aragon\"', 9.90, 71, 88),
(115, 1, 8.50, 'Vinaigre de Vin Vieux', 8.50, 72, 92),
(116, 1, 8.50, 'Vinaigre de Vin Vieux', 8.50, 73, 92),
(117, 1, 1.00, 'test', 1.00, 74, 93),
(118, 1, 1.00, 'test', 1.00, 75, 93),
(119, 1, 1.00, 'test', 1.00, 76, 93),
(120, 1, 1.00, 'test', 1.00, 77, 93),
(121, 1, 1.00, 'test', 1.00, 78, 93);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int DEFAULT NULL,
  `category` varchar(255) NOT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `is_featured` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `price`, `stock`, `category`, `image_name`, `is_featured`) VALUES
(80, 'Château Grand Terroir 2020', 'Un vin rouge puissant et élégant aux notes de fruits noirs et d\'épices. Idéal pour accompagner vos viandes rouges et gibiers. Cépages : Merlot, Cabernet Sauvignon.', 24.50, 120, 'Vins Rouges', 'red-wine.png', 0),
(81, 'Pinot Noir \"Vieilles Vignes\"', 'Toute la finesse du Pinot Noir dans cette cuvée équilibrée. Arômes de cerise griotte et notes boisées subtiles. Finale longue et soyeuse.', 18.90, 85, 'Vins Rouges', 'red-wine.png', 0),
(82, 'Cuvée des Vignerons - Syrah', 'Un vin de caractère avec des notes de poivre noir et de violette. Une structure tannique présente mais bien fondue.', 12.00, 200, 'Vins Rouges', 'red-wine.png', 0),
(83, 'Bordeaux Supérieur - Réserve', 'Un classique indémodable. Élevé en fûts de chêne pendant 12 mois. Notes de vanille et de fruits mûrs.', 15.50, 150, 'Vins Rouges', 'red-wine.png', 1),
(84, 'Chardonnay \"Lumière d\'Été\"', 'Un blanc frais et minéral avec des notes de fleurs blanches et d\'agrumes. Parfait pour l\'apéritif ou les poissons grillés.', 14.20, 90, 'Vins Blancs', 'white-wine.png', 1),
(85, 'Sauvignon Blanc \"Vallée Verte\"', 'Une explosion aromatique ! Notes de bourgeon de cassis et de pamplemousse rose. Une belle vivacité en bouche.', 11.50, 110, 'Vins Blancs', 'white-wine.png', 0),
(86, 'Grand Cru \"Montagne Bleue\"', 'Un vin d\'exception. Riche, onctueux avec des notes de miel et de noisettes grillées. Un potentiel de garde remarquable.', 42.00, 7, 'Vins Blancs', 'red-wine.png', 1),
(87, 'Rosé de Provence \"Mistral\"', 'La robe pâle caractéristique de la Provence. Notes de petits fruits rouges et de pêche. Frais et désaltérant.', 13.80, 180, 'Vins Rosés', 'rose-wine.png', 0),
(88, 'Gris de Gris \"Sable d\'Aragon\"', 'Un rosé tout en légèreté, idéal pour vos soirées d\'été et vos grillades. Notes salines en finale.', 9.90, 250, 'Vins Rosés', 'rose-wine.png', 0),
(89, 'Champagne Brut \"Héritage\"', 'Le fleuron de notre coopérative. Des bulles fines, une bouche vive et des arômes de brioche chaude et de pomme verte.', 35.00, 60, 'Champagnes & Bulles', 'champagne.png', 1),
(90, 'Crémant de Loire \"Perle de Nuit\"', 'L\'alternative parfaite au Champagne. Un rapport qualité-prix imbattable. Fruit pimpant et fraîcheur cristalline.', 16.50, 120, 'Champagnes & Bulles', 'champagne.png', 0),
(91, 'Huile d\'Olive de Propriété', 'Huile d\'olive vierge extra extraite à froid de nos propres vergers. Goût fruité intense et notes d\'herbe coupée.', 19.90, 45, 'Épicerie Fine', 'red-wine.png', 0),
(92, 'Vinaigre de Vin Vieux', 'Élaboré selon la méthode traditionnelle orléanaise. Vieillissement lent en fûts de bois.', 8.50, 50, 'Épicerie Fine', 'vinegar.png', 0),
(93, 'test', 'test', 1.00, 10, 'Champagnes & Bulles', 'Capture-d-ecran-2024-07-16-162627-69707d9c72ca5.png', 0);

-- --------------------------------------------------------

--
-- Table structure for table `testimonial`
--

CREATE TABLE `testimonial` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `rating` int NOT NULL,
  `created_at` datetime NOT NULL,
  `is_approved` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `testimonial`
--

INSERT INTO `testimonial` (`id`, `name`, `email`, `content`, `rating`, `created_at`, `is_approved`) VALUES
(2, 'test', 'guillaume.pecquet@gmail.com', 'essai&é\"\'(-è_çà', 4, '2026-01-20 21:42:55', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `reset_token` varchar(100) DEFAULT NULL,
  `reset_token_expires_at` datetime DEFAULT NULL,
  `cart` json DEFAULT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `first_name`, `last_name`, `phone`, `address`, `postal_code`, `city`, `country`, `reset_token`, `reset_token_expires_at`, `cart`, `is_active`) VALUES
(21, 'admin@auxilia-ecommerce.com', '[\"ROLE_ADMIN\", \"ROLE_USER\"]', '$2y$13$kBd4JnXT5I7vDu8m3SgxSODzF06hGpWZKeZztCh.5Jqz/BjcNTGa2', 'guillaume', 'pecquet', '0651424447', '105 rue Saint Denis', '75001', 'PARIS', 'France', NULL, NULL, '{\"88\": 1}', 1),
(22, 'user1@example.com', '[\"ROLE_USER\"]', '$2y$13$d5t1mlKqQYrrOMzQdTRJtexiwMMmlNwmZ6sfHcVN9Y2WNRbbwVNmu', 'guillaume', 'pecquet', '0651424447', '105 rue Saint Denis', '75001', 'PARIS', 'France', '59db5903073fcb0e13593e1e5cae9d37db6b3a0ac8be381bfae70a447194f1fb', '2026-01-20 20:59:21', '[]', 1),
(23, 'user2@example.com', '[\"ROLE_USER\"]', '$2y$13$A9Ef0gwDCUzs3zU2dGn.7uJM8i9ZCye8EP38n5B.ZWK9nmdIdEdgW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', 1),
(24, 'marie.dupont@example.com', '[\"ROLE_USER\"]', '$2y$13$c1Vxu43IidsmqKWvzWpO3uXLhVVfcXLHYT8QktK8a7g6iaZ3sn1ru', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', 1),
(25, 'jean.martin@example.com', '[\"ROLE_USER\"]', '$2y$13$rmwUVMuZYHx9tGhcYTj6n.kUDau9EiiYYCps0hPlF1lF14ifY3Hm.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', 1),
(26, 'guillaume.pecquet@gmail.com', '{\"1\": \"ROLE_ADMIN\"}', '$2y$13$M0gX75CmVpbd7GXjVruAIetza6eJSyfIbxDMUEFd9heZ7RKz72eBq', 'guillaume', 'pecquet', '0651424447', '8 rue des Lombards', '75004', 'PARIS', 'France', NULL, NULL, '[]', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category_name` (`name`),
  ADD KEY `idx_category_slug` (`slug`);

--
-- Indexes for table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`);

--
-- Indexes for table `newsletter`
--
ALTER TABLE `newsletter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_7E8585C8E7927C74` (`email`),
  ADD KEY `idx_newsletter_email` (`email`),
  ADD KEY `idx_newsletter_subscribed_at` (`subscribed_at`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F5299398A76ED395` (`user_id`),
  ADD KEY `idx_order_status` (`status`),
  ADD KEY `idx_order_date` (`dateat`),
  ADD KEY `idx_order_user_date` (`user_id`,`dateat`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_52EA1F09E238517C` (`order_ref_id`),
  ADD KEY `IDX_52EA1F094584665A` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product_category` (`category`),
  ADD KEY `idx_product_featured` (`is_featured`),
  ADD KEY `idx_product_price` (`price`),
  ADD KEY `idx_product_name` (`name`),
  ADD KEY `idx_product_category_featured` (`category`,`is_featured`);

--
-- Indexes for table `testimonial`
--
ALTER TABLE `testimonial`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `newsletter`
--
ALTER TABLE `newsletter`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `testimonial`
--
ALTER TABLE `testimonial`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `FK_52EA1F094584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_52EA1F09E238517C` FOREIGN KEY (`order_ref_id`) REFERENCES `order` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
