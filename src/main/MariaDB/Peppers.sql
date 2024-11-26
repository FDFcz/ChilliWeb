-- --------------------------------------------------------
-- Hostitel:                     127.0.0.1
-- Verze serveru:                11.5.2-MariaDB - mariadb.org binary distribution
-- OS serveru:                   Win64
-- HeidiSQL Verze:               12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Exportování struktury databáze pro
CREATE DATABASE IF NOT EXISTS `chillyWeb` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `chillyWeb`;

-- Exportování struktury pro tabulka chilly.adress
CREATE TABLE IF NOT EXISTS `adress` (
  `adress_ID` int(11) NOT NULL AUTO_INCREMENT,
  `town` varchar(50) NOT NULL DEFAULT '0',
  `street` varchar(50) NOT NULL DEFAULT '0',
  `homeNumber` int(8) NOT NULL DEFAULT 0,
  `post number` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`adress_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportování dat pro tabulku chilly.adress: ~0 rows (přibližně)
DELETE FROM `adress`;

-- Exportování struktury pro tabulka chilly.cron
CREATE TABLE IF NOT EXISTS `cron` (
  `cron_id` int(11) NOT NULL AUTO_INCREMENT,
  `tracota` int(11) DEFAULT NULL,
  `Schedl` int(11) DEFAULT NULL,
  `startTime` int(11) DEFAULT NULL,
  `endTime` int(11) DEFAULT NULL,
  PRIMARY KEY (`cron_id`),
  KEY `tracota` (`tracota`),
  KEY `Schedl` (`Schedl`),
  CONSTRAINT `FK_cron_schedule` FOREIGN KEY (`Schedl`) REFERENCES `schedule` (`schedule_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_cron_terracotta` FOREIGN KEY (`tracota`) REFERENCES `terracotta` (`terracotta_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportování dat pro tabulku chilly.cron: ~6 rows (přibližně)
DELETE FROM `cron`;
INSERT INTO `cron` (`cron_id`, `tracota`, `Schedl`, `startTime`, `endTime`) VALUES
	(145, 49, 145, 5, 23),
	(146, 49, 146, 0, 5),
	(154, 53, 154, 5, 23),
	(155, 53, 155, 0, 5),
	(166, 59, 166, 5, 23),
	(167, 59, 167, 0, 5);

-- Exportování struktury pro tabulka chilly.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `tokenExpiration` datetime DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `tell` varchar(13) DEFAULT NULL,
  `addressID` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `addressID` (`addressID`),
  CONSTRAINT `FK_customer_adress` FOREIGN KEY (`addressID`) REFERENCES `adress` (`adress_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportování dat pro tabulku chilly.customer: ~2 rows (přibližně)
DELETE FROM `customer`;
INSERT INTO `customer` (`customer_id`, `username`, `password`, `token`, `tokenExpiration`, `email`, `tell`, `addressID`) VALUES
	(1, 'Filip', '8d23cf6c86e834a7aa6eded54c26ce2bb2e74903538c61bdd5d2197997ab2f72', 'a4af14020b1e4b54f6c25127a87b1c1d9b7cd02485eeeb4c36e3284a6c4f4a03', '2024-11-25 00:00:00', 'filip@mail', '66666666', NULL),
	(2, 'Bakalar', '8d23cf6c86e834a7aa6eded54c26ce2bb2e74903538c61bdd5d2197997ab2f72', '8596b4396e5fa5ddac0b8cf8621631e4c73605a86dc8a9c7250b7c91ea42686f', '2024-11-23 00:00:00', 'Bakalar@UHK.cz', '777777777', NULL);

-- Exportování struktury pro tabulka chilly.planttype
CREATE TABLE IF NOT EXISTS `planttype` (
  `plantType_id` int(11) NOT NULL AUTO_INCREMENT,
  `plantname` varchar(50) DEFAULT NULL,
  `growtimeindays` int(11) DEFAULT NULL,
  `actual_price` int(11) DEFAULT NULL,
  PRIMARY KEY (`plantType_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportování dat pro tabulku chilly.planttype: ~4 rows (přibližně)
DELETE FROM `planttype`;
INSERT INTO `planttype` (`plantType_id`, `plantname`, `growtimeindays`, `actual_price`) VALUES
	(0, 'Jalapenos', 80, 200),
	(1, 'Poblano', 75, 230),
	(2, 'Habareno', 110, 280),
	(3, 'numex-twilight', 90, 130);

-- Exportování struktury pro tabulka chilly.plc
CREATE TABLE IF NOT EXISTS `plc` (
  `PLC_id` int(11) NOT NULL AUTO_INCREMENT,
  `Online` bit(1) DEFAULT NULL,
  `IPaddress` varchar(39) DEFAULT NULL,
  `OffsetID` int(11) DEFAULT NULL,
  `PLC_OK` bit(1) DEFAULT NULL,
  PRIMARY KEY (`PLC_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportování dat pro tabulku chilly.plc: ~2 rows (přibližně)
DELETE FROM `plc`;
INSERT INTO `plc` (`PLC_id`, `Online`, `IPaddress`, `OffsetID`, `PLC_OK`) VALUES
	(1, b'1', '192.168.10.10', 0, b'1'),
	(2, b'0', '172.17.0.10', 0, b'0');

-- Exportování struktury pro tabulka chilly.schedule
CREATE TABLE IF NOT EXISTS `schedule` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `temp` float DEFAULT NULL,
  `light` bit(1) DEFAULT NULL,
  `humidity` int(11) DEFAULT NULL,
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportování dat pro tabulku chilly.schedule: ~6 rows (přibližně)
DELETE FROM `schedule`;
INSERT INTO `schedule` (`schedule_id`, `temp`, `light`, `humidity`) VALUES
	(145, 19.5, b'0', 70),
	(146, 19.5, b'0', 70),
	(154, 28, b'1', 50),
	(155, 24, b'0', 40),
	(166, 28, b'1', 50),
	(167, 24, b'0', 40);

-- Exportování struktury pro tabulka chilly.terracotta
CREATE TABLE IF NOT EXISTS `terracotta` (
  `terracotta_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `PLC` int(11) DEFAULT NULL,
  `plant` int(11) DEFAULT NULL,
  `planted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`terracotta_id`),
  KEY `owner` (`owner`),
  KEY `PLC` (`PLC`),
  KEY `plant` (`plant`),
  CONSTRAINT `FK_terracotta_customer` FOREIGN KEY (`owner`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_terracotta_planttype` FOREIGN KEY (`plant`) REFERENCES `planttype` (`plantType_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_terracotta_plc` FOREIGN KEY (`PLC`) REFERENCES `plc` (`PLC_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportování dat pro tabulku chilly.terracotta: ~2 rows (přibližně)
DELETE FROM `terracotta`;
INSERT INTO `terracotta` (`terracotta_id`, `name`, `owner`, `PLC`, `plant`, `planted_at`) VALUES
	(49, 'Real_PLC', 1, 1, 0, '2024-10-05 22:00:00'),
	(53, 'he', 1, 1, 0, '2024-10-19 22:00:00'),
	(59, 'ahoj', 1, 1, 0, '2024-11-22 23:00:00');

-- Exportování struktury pro trigger chilly.cron_after_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `cron_after_delete` BEFORE DELETE ON `terracotta` FOR EACH ROW BEGIN
DELETE FROM cron WHERE cron.tracota = OLD.terracotta_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Exportování struktury pro trigger chilly.DeleteSchedule
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `DeleteSchedule` BEFORE DELETE ON `cron` FOR EACH ROW BEGIN
DELETE FROM schedule WHERE schedule_id = OLD.Schedl;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Exportování struktury pro trigger chilly.terracota_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `terracota_before_insert` AFTER INSERT ON `terracotta` FOR EACH ROW BEGIN
INSERT INTO schedule (temp,light,humidity) VALUES (28,TRUE,50);
INSERT INTO cron (tracota,Schedl,startTime,endTime) VALUES (NEW.terracotta_id,LAST_INSERT_ID(),5,23);
INSERT INTO schedule (temp,light,humidity) VALUES (24,FALSE,40);
INSERT INTO cron (tracota,Schedl,startTime,endTime) VALUES (NEW.terracotta_id,LAST_INSERT_ID(),0,5);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
