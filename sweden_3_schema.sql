-- MySQL dump 10.13  Distrib 8.4.10, for Linux (x86_64)
--
-- Host: localhost    Database: sweden_2
-- ------------------------------------------------------
-- Server version	8.4.10-0ubuntu0.25.10.1

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
-- Table structure for table `BP2024`
--

DROP TABLE IF EXISTS `BP2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BP2024` (
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` int NOT NULL DEFAULT '0',
  `Organization number` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal code` int DEFAULT NULL,
  `Company visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `turnovers-interval` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees-interval` int DEFAULT NULL,
  `Turnover` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Result of the year` int DEFAULT NULL,
  `Assests` int DEFAULT NULL,
  `The year of figures` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registered` int DEFAULT NULL,
  `Profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Liquidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Solidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gross profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `2021- Employees` int DEFAULT NULL,
  `2020- Employees` int DEFAULT NULL,
  `2019- Employees` int DEFAULT NULL,
  `2021- Turnover` int DEFAULT NULL,
  `2020- Turnover` int DEFAULT NULL,
  `2019- Turnover` int DEFAULT NULL,
  `2021- Result after financial items` int DEFAULT NULL,
  `2020- Result after financial items` int DEFAULT NULL,
  `2019- Result after financial items` int DEFAULT NULL,
  `2021- Years result` int DEFAULT NULL,
  `2020- Years result` int DEFAULT NULL,
  `2019- Years result` int DEFAULT NULL,
  `2021- Assets` int DEFAULT NULL,
  `2020- Assets` int DEFAULT NULL,
  `2019- Assets` int DEFAULT NULL,
  `Operation description` varchar(5895) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SNI` varchar(317) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `F-tax registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Date for F-tax registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `VAT registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registration date for VAT` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entity type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mother company name` varchar(666) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Owbership type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `County of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Munipality of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  KEY `BP2024_company` (`Organization number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BP2024test`
--

DROP TABLE IF EXISTS `BP2024test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BP2024test` (
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` int NOT NULL DEFAULT '0',
  `Organization number` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal code` int DEFAULT NULL,
  `Company visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `turnovers-interval` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees-interval` int DEFAULT NULL,
  `Turnover` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Result of the year` int DEFAULT NULL,
  `Assests` int DEFAULT NULL,
  `The year of figures` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registered` int DEFAULT NULL,
  `Profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Liquidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Solidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gross profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `2021- Employees` int DEFAULT NULL,
  `2020- Employees` int DEFAULT NULL,
  `2019- Employees` int DEFAULT NULL,
  `2021- Turnover` int DEFAULT NULL,
  `2020- Turnover` int DEFAULT NULL,
  `2019- Turnover` int DEFAULT NULL,
  `2021- Result after financial items` int DEFAULT NULL,
  `2020- Result after financial items` int DEFAULT NULL,
  `2019- Result after financial items` int DEFAULT NULL,
  `2021- Years result` int DEFAULT NULL,
  `2020- Years result` int DEFAULT NULL,
  `2019- Years result` int DEFAULT NULL,
  `2021- Assets` int DEFAULT NULL,
  `2020- Assets` int DEFAULT NULL,
  `2019- Assets` int DEFAULT NULL,
  `Operation description` varchar(5895) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SNI` varchar(317) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `F-tax registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Date for F-tax registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `VAT registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registration date for VAT` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entity type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mother company name` varchar(666) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Owbership type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `County of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Munipality of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `E-post_comp_data`
--

DROP TABLE IF EXISTS `E-post_comp_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `E-post_comp_data` (
  `orgNummer` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Företag` varchar(120) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Beslutsfattare` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `e-post` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Roll` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Bolagsform` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Reg-år` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Omsättning` int DEFAULT NULL,
  `Anställda` int DEFAULT NULL,
  `Stad` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Adress` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Sni` int DEFAULT NULL,
  `Bransch` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Postnummer` int DEFAULT NULL,
  `Län` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Kommun` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Företags email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Telefonnummer` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Adresskälla` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  KEY `org_nummer_index` (`orgNummer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCB202602`
--

DROP TABLE IF EXISTS `SCB202602`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SCB202602` (
  `ForAndrTyp` varchar(10) DEFAULT NULL,
  `COAdress` varchar(255) DEFAULT NULL,
  `Foretagsnamn` varchar(255) DEFAULT NULL,
  `FtgStat` varchar(50) DEFAULT NULL,
  `Gatuadress` varchar(255) DEFAULT NULL,
  `JEStat` varchar(50) DEFAULT NULL,
  `JurForm` varchar(50) DEFAULT NULL,
  `Namn` varchar(255) DEFAULT NULL,
  `Ng1` varchar(255) DEFAULT NULL,
  `Ng2` varchar(255) DEFAULT NULL,
  `Ng3` varchar(255) DEFAULT NULL,
  `Ng4` varchar(255) DEFAULT NULL,
  `Ng5` varchar(255) DEFAULT NULL,
  `PeOrgNr` varchar(20) DEFAULT NULL,
  `PostNr` varchar(20) DEFAULT NULL,
  `PostOrt` varchar(100) DEFAULT NULL,
  `RegDatKtid` varchar(20) DEFAULT NULL,
  `Reklamsparrtyp` varchar(50) DEFAULT NULL,
  `mCOAdress` varchar(255) DEFAULT NULL,
  `mForetagsnamn` varchar(255) DEFAULT NULL,
  `mFtgStat` varchar(50) DEFAULT NULL,
  `mGatuadress` varchar(255) DEFAULT NULL,
  `mJEStat` varchar(50) DEFAULT NULL,
  `mJurForm` varchar(50) DEFAULT NULL,
  `mNamn` varchar(255) DEFAULT NULL,
  `mNg1` varchar(255) DEFAULT NULL,
  `mNg2` varchar(255) DEFAULT NULL,
  `mNg3` varchar(255) DEFAULT NULL,
  `mNg4` varchar(255) DEFAULT NULL,
  `mNg5` varchar(255) DEFAULT NULL,
  `mPostNr` varchar(20) DEFAULT NULL,
  `mPostOrt` varchar(100) DEFAULT NULL,
  `mRegDatKtid` varchar(20) DEFAULT NULL,
  `mReklamsparrtyp` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_All_Enrich`
--

DROP TABLE IF EXISTS `_All_Enrich`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_All_Enrich` (
  `Year Enriched` int DEFAULT NULL,
  `Country` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Organization number` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting address` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal area` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting phone` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Turnover` int DEFAULT NULL,
  `Department` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_number` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ref` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IG link` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Bio Link` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IG user "@"` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Number of Followers` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Industry` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `active_admin_comments`
--

DROP TABLE IF EXISTS `active_admin_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `active_admin_comments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `namespace` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `resource_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_id` bigint DEFAULT NULL,
  `author_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_id` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_active_admin_comments_on_resource` (`resource_type`,`resource_id`),
  KEY `index_active_admin_comments_on_author` (`author_type`,`author_id`),
  KEY `index_active_admin_comments_on_namespace` (`namespace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_roles`
--

DROP TABLE IF EXISTS `admin_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_roles_permissions`
--

DROP TABLE IF EXISTS `admin_roles_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_roles_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_role_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_admin_roles_permissions_on_admin_role_id` (`admin_role_id`),
  KEY `index_admin_roles_permissions_on_permission_id` (`permission_id`),
  CONSTRAINT `fk_rails_243805b879` FOREIGN KEY (`admin_role_id`) REFERENCES `admin_roles` (`id`),
  CONSTRAINT `fk_rails_62d31e4430` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `admin_role_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`),
  UNIQUE KEY `index_admin_users_on_reset_password_token` (`reset_password_token`),
  KEY `index_admin_users_on_admin_role_id` (`admin_role_id`),
  CONSTRAINT `fk_rails_4341034eb9` FOREIGN KEY (`admin_role_id`) REFERENCES `admin_roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `all_company_info`
--

DROP TABLE IF EXISTS `all_company_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `all_company_info` (
  `Eco Id` bigint DEFAULT NULL,
  `Organisation Number` text COLLATE utf8mb4_general_ci,
  `Business Type` double DEFAULT NULL,
  `Popular Name` text COLLATE utf8mb4_general_ci,
  `Legal Name` text COLLATE utf8mb4_general_ci,
  `Street Name` text COLLATE utf8mb4_general_ci,
  `Street Number` text COLLATE utf8mb4_general_ci,
  `Zip Code` text COLLATE utf8mb4_general_ci,
  `Postal Area` text COLLATE utf8mb4_general_ci,
  `Phone` text COLLATE utf8mb4_general_ci,
  `Homepage` text COLLATE utf8mb4_general_ci,
  KEY `organization_nr_index` (`Organisation Number`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city_id` bigint NOT NULL,
  `zip_code` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `municipality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_range` int DEFAULT NULL,
  `municipality_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_areas_on_city_id` (`city_id`),
  KEY `idx_areas_zip_code` (`zip_code`),
  KEY `idx_areas_municipality` (`municipality`),
  KEY `idx_areas_zip_municipality` (`zip_code`,`municipality`),
  KEY `index_areas_on_municipality_id` (`municipality_id`),
  KEY `index_areas_on_municipality_id_and_zip_code` (`municipality_id`,`zip_code`),
  KEY `idx_areas_municipality_zip` (`municipality_id`,`zip_code`),
  CONSTRAINT `fk_rails_0bb70140b1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48952 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `b2c_old`
--

DROP TABLE IF EXISTS `b2c_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `b2c_old` (
  `id` int NOT NULL AUTO_INCREMENT,
  `FName` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gender` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mobile1` varchar(12) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mobile2` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mobile3` varchar(12) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mobile4` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Phone1` varchar(12) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Phone2` varchar(12) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Phone3` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Streetaddress` varchar(55) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Zipcode` char(11) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  `Living` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `LivingArea` varchar(5) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `BuildingYear` varchar(4) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `LandArea` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile1_nix` tinyint(1) DEFAULT '0',
  `mobile2_nix` tinyint(1) DEFAULT '0',
  `mobile3_nix` tinyint(1) DEFAULT '0',
  `mobile4_nix` tinyint(1) DEFAULT '0',
  `phone1_nix` tinyint(1) DEFAULT '0',
  `phone2_nix` tinyint(1) DEFAULT '0',
  `phone3_nix` tinyint(1) DEFAULT '0',
  `housing_type_id` int DEFAULT NULL,
  `town_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_b2c_old_on_housing_type_id` (`housing_type_id`),
  KEY `index_b2c_old_on_town_id` (`town_id`),
  KEY `index_b2c_old_on_Gender` (`Gender`),
  KEY `index_b2c_old_on_Zipcode` (`Zipcode`)
) ENGINE=InnoDB AUTO_INCREMENT=8105036 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bolagsverket`
--

DROP TABLE IF EXISTS `bolagsverket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bolagsverket` (
  `organisationsidentitet` varchar(25) DEFAULT NULL,
  `namnskyddslopnummer` bigint DEFAULT NULL,
  `registreringsland` varchar(25) DEFAULT NULL,
  `organisationsnamn` mediumtext,
  `organisationsform` varchar(25) DEFAULT NULL,
  `avregistreringsdatum` date DEFAULT NULL,
  `avregistreringsorsak` varchar(25) DEFAULT NULL,
  `pagandeAvvecklingsEllerOmstruktureringsforfarande` mediumtext,
  `registreringsdatum` date DEFAULT NULL,
  `verksamhetsbeskrivning` mediumtext,
  `postadress` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_comp_details`
--

DROP TABLE IF EXISTS `business_comp_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_comp_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Organization number` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal code` int DEFAULT NULL,
  `Company visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `turnovers-interval` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees-interval` int DEFAULT NULL,
  `Turnover` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Result of the year` int DEFAULT NULL,
  `Assests` int DEFAULT NULL,
  `The year of figures` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registered` int DEFAULT NULL,
  `Profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Liquidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Solidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gross profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `2021- Employees` int DEFAULT NULL,
  `2020- Employees` int DEFAULT NULL,
  `2019- Employees` int DEFAULT NULL,
  `2021- Turnover` int DEFAULT NULL,
  `2020- Turnover` int DEFAULT NULL,
  `2019- Turnover` int DEFAULT NULL,
  `2021- Result after financial items` int DEFAULT NULL,
  `2020- Result after financial items` int DEFAULT NULL,
  `2019- Result after financial items` int DEFAULT NULL,
  `2021- Years result` int DEFAULT NULL,
  `2020- Years result` int DEFAULT NULL,
  `2019- Years result` int DEFAULT NULL,
  `2021- Assets` int DEFAULT NULL,
  `2020- Assets` int DEFAULT NULL,
  `2019- Assets` int DEFAULT NULL,
  `Operation description` varchar(5895) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SNI` varchar(317) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `F-tax registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Date for F-tax registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `VAT registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registration date for VAT` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entity type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mother company name` varchar(666) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Owbership type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `County of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Munipality of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_company_dm` (`Organization number`,`Company name`),
  KEY `index_business_comp_details_org_nr` (`Organization number`),
  KEY `index_business_comp_details_comp_name` (`Company name`)
) ENGINE=InnoDB AUTO_INCREMENT=2743615 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_comp_people`
--

DROP TABLE IF EXISTS `business_comp_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_comp_people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Organization number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Sector name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Matching Score` int DEFAULT NULL,
  `decision_maker_title_id` bigint DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_email_valid` tinyint(1) DEFAULT NULL,
  `is_decision_maker_email_valid` tinyint(1) DEFAULT NULL,
  `email_validation_date` date DEFAULT NULL,
  `decision_maker_email_validation_date` date DEFAULT NULL,
  `decision_maker_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Reference page` text COLLATE utf8mb4_general_ci,
  `enrichment_item_id` int DEFAULT NULL,
  `is_decision_maker` tinyint(1) DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_company_dm` (`Organization number`,`decision_maker_name`,`Decision maker title`),
  KEY `index_business_comp_people_on_id` (`id`),
  KEY `index_org_nr` (`Organization number`)
) ENGINE=InnoDB AUTO_INCREMENT=3648663 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_comp_people_backup`
--

DROP TABLE IF EXISTS `business_comp_people_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_comp_people_backup` (
  `id` int NOT NULL DEFAULT '0',
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Organization number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Sector name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Matching Score` int DEFAULT NULL,
  `decision_maker_title_id` bigint DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_email_valid` tinyint(1) DEFAULT NULL,
  `is_decision_maker_email_valid` tinyint(1) DEFAULT NULL,
  `email_validation_date` date DEFAULT NULL,
  `decision_maker_email_validation_date` date DEFAULT NULL,
  `decision_maker_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Reference page` text COLLATE utf8mb4_general_ci,
  `enrichment_item_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_legal_forms`
--

DROP TABLE IF EXISTS `business_legal_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_legal_forms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `query_value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `sort_order` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_people`
--

DROP TABLE IF EXISTS `business_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Organization number` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal code` int DEFAULT NULL,
  `Company visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `turnovers-interval` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees-interval` int DEFAULT NULL,
  `Turnover` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Result of the year` int DEFAULT NULL,
  `Assests` int DEFAULT NULL,
  `The year of figures` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registered` int DEFAULT NULL,
  `Profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Liquidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Solidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gross profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `2021- Employees` int DEFAULT NULL,
  `2020- Employees` int DEFAULT NULL,
  `2019- Employees` int DEFAULT NULL,
  `2021- Turnover` int DEFAULT NULL,
  `2020- Turnover` int DEFAULT NULL,
  `2019- Turnover` int DEFAULT NULL,
  `2021- Result after financial items` int DEFAULT NULL,
  `2020- Result after financial items` int DEFAULT NULL,
  `2019- Result after financial items` int DEFAULT NULL,
  `2021- Years result` int DEFAULT NULL,
  `2020- Years result` int DEFAULT NULL,
  `2019- Years result` int DEFAULT NULL,
  `2021- Assets` int DEFAULT NULL,
  `2020- Assets` int DEFAULT NULL,
  `2019- Assets` int DEFAULT NULL,
  `Operation description` varchar(5895) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SNI` varchar(317) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `F-tax registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Date for F-tax registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `VAT registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registration date for VAT` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entity type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mother company name` varchar(666) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Owbership type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `County of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Munipality of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Sector name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Matching Score` int DEFAULT NULL,
  `decision_maker_title_id` bigint DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_email_valid` tinyint(1) DEFAULT NULL,
  `is_decision_maker_email_valid` tinyint(1) DEFAULT NULL,
  `email_validation_date` date DEFAULT NULL,
  `decision_maker_email_validation_date` date DEFAULT NULL,
  `decision_maker_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Reference page` text COLLATE utf8mb4_general_ci,
  `enrichment_item_id` int DEFAULT NULL,
  `employees_intervals` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees_interval` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `turnover_interval` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sniName` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `decision_maker_email_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_business_people_on_decision_maker_title_id` (`decision_maker_title_id`),
  KEY `index_org_nr` (`Organization number`),
  KEY `index_company_name` (`Company name`),
  KEY `idx_bp_visiting_postal_code` (`Company visiting postal code`),
  KEY `idx_bp_municipality_seat` (`Munipality of seat`),
  KEY `idx_bp_company_visit_phone` (`Company visiting phone`),
  KEY `idx_bp_decision_maker_number` (`decision_maker_number`),
  KEY `idx_bp_decision_maker_email` (`decision_maker_email`),
  KEY `idx_bp_email` (`email`),
  KEY `idx_bp_dm_number` (`decision_maker_number`),
  KEY `idx_bp_dm_email` (`decision_maker_email`),
  KEY `idx_bp_dm_title` (`decision_maker_title_id`),
  KEY `idx_bp_email_valid` (`is_decision_maker_email_valid`)
) ENGINE=InnoDB AUTO_INCREMENT=2990745 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_people_backup`
--

DROP TABLE IF EXISTS `business_people_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_people_backup` (
  `id` int NOT NULL DEFAULT '0',
  `Organization number` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal code` int DEFAULT NULL,
  `Company visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `turnovers-interval` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees-interval` int DEFAULT NULL,
  `Turnover` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Result of the year` int DEFAULT NULL,
  `Assests` int DEFAULT NULL,
  `The year of figures` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registered` int DEFAULT NULL,
  `Profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Liquidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Solidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gross profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `2021- Employees` int DEFAULT NULL,
  `2020- Employees` int DEFAULT NULL,
  `2019- Employees` int DEFAULT NULL,
  `2021- Turnover` int DEFAULT NULL,
  `2020- Turnover` int DEFAULT NULL,
  `2019- Turnover` int DEFAULT NULL,
  `2021- Result after financial items` int DEFAULT NULL,
  `2020- Result after financial items` int DEFAULT NULL,
  `2019- Result after financial items` int DEFAULT NULL,
  `2021- Years result` int DEFAULT NULL,
  `2020- Years result` int DEFAULT NULL,
  `2019- Years result` int DEFAULT NULL,
  `2021- Assets` int DEFAULT NULL,
  `2020- Assets` int DEFAULT NULL,
  `2019- Assets` int DEFAULT NULL,
  `Operation description` varchar(5895) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SNI` varchar(317) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `F-tax registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Date for F-tax registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `VAT registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registration date for VAT` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entity type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mother company name` varchar(666) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Owbership type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `County of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Munipality of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Sector name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Matching Score` int DEFAULT NULL,
  `decision_maker_title_id` bigint DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_email_valid` tinyint(1) DEFAULT NULL,
  `is_decision_maker_email_valid` tinyint(1) DEFAULT NULL,
  `email_validation_date` date DEFAULT NULL,
  `decision_maker_email_validation_date` date DEFAULT NULL,
  `decision_maker_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Reference page` text COLLATE utf8mb4_general_ci,
  `enrichment_item_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_people_sni_codes`
--

DROP TABLE IF EXISTS `business_people_sni_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_people_sni_codes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `business_person_id` int DEFAULT NULL,
  `sni_code_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_business_people_sni_codes_on_sni_code_id` (`sni_code_id`),
  KEY `index_business_people_sni_codes_on_business_person_id` (`business_person_id`),
  KEY `idx_sni_to_bp` (`sni_code_id`,`business_person_id`),
  CONSTRAINT `fk_rails_9417903fb0` FOREIGN KEY (`sni_code_id`) REFERENCES `sni_codes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7766810 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `business_people_view`
--

DROP TABLE IF EXISTS `business_people_view`;
/*!50001 DROP VIEW IF EXISTS `business_people_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `business_people_view` AS SELECT 
 1 AS `id`,
 1 AS `Organization number`,
 1 AS `Company name`,
 1 AS `email`,
 1 AS `website`,
 1 AS `Company visiting address`,
 1 AS `Company visiting postal code`,
 1 AS `Company visiting postal area`,
 1 AS `Company visiting county`,
 1 AS `Company visiting phone`,
 1 AS `Company postal address`,
 1 AS `Company postal code`,
 1 AS `Company postal area`,
 1 AS `Office name`,
 1 AS `Office visiting address`,
 1 AS `Office visiting postal code`,
 1 AS `Office visiting postal area`,
 1 AS `Office visiting county`,
 1 AS `Office visiting phone`,
 1 AS `Office postal address`,
 1 AS `Office postal code`,
 1 AS `Office postal area`,
 1 AS `turnovers-interval`,
 1 AS `employees-interval`,
 1 AS `Turnover`,
 1 AS `Profit`,
 1 AS `Result of the year`,
 1 AS `Assests`,
 1 AS `The year of figures`,
 1 AS `Registered`,
 1 AS `Profit margin`,
 1 AS `Liquidity`,
 1 AS `Solidity`,
 1 AS `Gross profit margin`,
 1 AS `2021- Employees`,
 1 AS `2020- Employees`,
 1 AS `2019- Employees`,
 1 AS `2021- Turnover`,
 1 AS `2020- Turnover`,
 1 AS `2019- Turnover`,
 1 AS `2021- Result after financial items`,
 1 AS `2020- Result after financial items`,
 1 AS `2019- Result after financial items`,
 1 AS `2021- Years result`,
 1 AS `2020- Years result`,
 1 AS `2019- Years result`,
 1 AS `2021- Assets`,
 1 AS `2020- Assets`,
 1 AS `2019- Assets`,
 1 AS `Operation description`,
 1 AS `SNI`,
 1 AS `Company status`,
 1 AS `Company registration`,
 1 AS `F-tax registered`,
 1 AS `Date for F-tax registration`,
 1 AS `VAT registered`,
 1 AS `Registration date for VAT`,
 1 AS `Entity type`,
 1 AS `Mother company name`,
 1 AS `Owbership type`,
 1 AS `County of seat`,
 1 AS `Munipality of seat`,
 1 AS `decision_maker_name`,
 1 AS `Decision maker title`,
 1 AS `is_decision_maker`,
 1 AS `Sector name`,
 1 AS `Matching Score`,
 1 AS `decision_maker_title_id`,
 1 AS `decision_maker_email`,
 1 AS `is_email_valid`,
 1 AS `is_decision_maker_email_valid`,
 1 AS `email_validation_date`,
 1 AS `decision_maker_email_validation_date`,
 1 AS `decision_maker_number`,
 1 AS `Reference page`,
 1 AS `enrichment_item_id`,
 1 AS `last_updated`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `business_price_ranges`
--

DROP TABLE IF EXISTS `business_price_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_price_ranges` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `min_amount` int DEFAULT NULL,
  `max_amount` int DEFAULT NULL,
  `is_fixed_price_enabled` tinyint(1) DEFAULT '0',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `price_per_address` float DEFAULT NULL,
  `fixed_price` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_vd_details`
--

DROP TABLE IF EXISTS `business_vd_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_vd_details` (
  `Organization number` text COLLATE utf8mb4_general_ci,
  `Company name` text COLLATE utf8mb4_general_ci,
  `email` text COLLATE utf8mb4_general_ci,
  `website` text COLLATE utf8mb4_general_ci,
  `Company visiting address` text COLLATE utf8mb4_general_ci,
  `Company visiting postal code` double DEFAULT NULL,
  `Company visiting postal area` text COLLATE utf8mb4_general_ci,
  `Company visiting county` text COLLATE utf8mb4_general_ci,
  `Company visiting phone` text COLLATE utf8mb4_general_ci,
  `Company postal address` text COLLATE utf8mb4_general_ci,
  `Company postal code` text COLLATE utf8mb4_general_ci,
  `Company postal area` text COLLATE utf8mb4_general_ci,
  `Office name` text COLLATE utf8mb4_general_ci,
  `Office visiting address` text COLLATE utf8mb4_general_ci,
  `Office visiting postal code` text COLLATE utf8mb4_general_ci,
  `Office visiting postal area` text COLLATE utf8mb4_general_ci,
  `Office visiting county` text COLLATE utf8mb4_general_ci,
  `Office visiting phone` text COLLATE utf8mb4_general_ci,
  `Office postal address` text COLLATE utf8mb4_general_ci,
  `Office postal code` text COLLATE utf8mb4_general_ci,
  `Office postal area` text COLLATE utf8mb4_general_ci,
  `turnovers-interval` text COLLATE utf8mb4_general_ci,
  `employees-interval` double DEFAULT NULL,
  `Turnover` double DEFAULT NULL,
  `Profit` double DEFAULT NULL,
  `Result of the year` double DEFAULT NULL,
  `Assests` double DEFAULT NULL,
  `The year of figures` text COLLATE utf8mb4_general_ci,
  `Registered` double DEFAULT NULL,
  `Profit margin` text COLLATE utf8mb4_general_ci,
  `Liquidity` text COLLATE utf8mb4_general_ci,
  `Solidity` text COLLATE utf8mb4_general_ci,
  `Gross profit margin` text COLLATE utf8mb4_general_ci,
  `2021- Employees` double DEFAULT NULL,
  `2020- Employees` double DEFAULT NULL,
  `2019- Employees` double DEFAULT NULL,
  `2021- Turnover` double DEFAULT NULL,
  `2020- Turnover` double DEFAULT NULL,
  `2019- Turnover` double DEFAULT NULL,
  `2021- Result after financial items` double DEFAULT NULL,
  `2020- Result after financial items` double DEFAULT NULL,
  `2019- Result after financial items` double DEFAULT NULL,
  `2021- Years result` double DEFAULT NULL,
  `2020- Years result` double DEFAULT NULL,
  `2019- Years result` double DEFAULT NULL,
  `2021- Assets` double DEFAULT NULL,
  `2020- Assets` double DEFAULT NULL,
  `2019- Assets` double DEFAULT NULL,
  `Operation description` text COLLATE utf8mb4_general_ci,
  `SNI` text COLLATE utf8mb4_general_ci,
  `Company status` text COLLATE utf8mb4_general_ci,
  `Company registration` text COLLATE utf8mb4_general_ci,
  `F-tax registered` text COLLATE utf8mb4_general_ci,
  `Date for F-tax registration` text COLLATE utf8mb4_general_ci,
  `VAT registered` text COLLATE utf8mb4_general_ci,
  `Registration date for VAT` text COLLATE utf8mb4_general_ci,
  `Entity type` text COLLATE utf8mb4_general_ci,
  `Mother company name` text COLLATE utf8mb4_general_ci,
  `Owbership type` text COLLATE utf8mb4_general_ci,
  `County of seat` text COLLATE utf8mb4_general_ci,
  `Munipality of seat` text COLLATE utf8mb4_general_ci,
  `decision_maker_name` text COLLATE utf8mb4_general_ci,
  `Decision maker title` text COLLATE utf8mb4_general_ci,
  `Sector name` text COLLATE utf8mb4_general_ci,
  `Matching Score` double DEFAULT NULL,
  `decision_maker_title_id` double DEFAULT NULL,
  `decision_maker_email` text COLLATE utf8mb4_general_ci,
  `is_email_valid` text COLLATE utf8mb4_general_ci,
  `is_decision_maker_email_valid` text COLLATE utf8mb4_general_ci,
  `email_validation_date` datetime DEFAULT NULL,
  `decision_maker_email_validation_date` datetime DEFAULT NULL,
  `decision_maker_number` text COLLATE utf8mb4_general_ci,
  `Reference page` text COLLATE utf8mb4_general_ci,
  `enrichment_item_id` text COLLATE utf8mb4_general_ci,
  KEY `index_business_vd_org_nr` (`Organization number`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `business_vd_view`
--

DROP TABLE IF EXISTS `business_vd_view`;
/*!50001 DROP VIEW IF EXISTS `business_vd_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `business_vd_view` AS SELECT 
 1 AS `id`,
 1 AS `Organization number`,
 1 AS `Company name`,
 1 AS `email`,
 1 AS `website`,
 1 AS `Company visiting address`,
 1 AS `Company visiting postal code`,
 1 AS `Company visiting postal area`,
 1 AS `Company visiting county`,
 1 AS `Company visiting phone`,
 1 AS `Company postal address`,
 1 AS `Company postal code`,
 1 AS `Company postal area`,
 1 AS `Office name`,
 1 AS `Office visiting address`,
 1 AS `Office visiting postal code`,
 1 AS `Office visiting postal area`,
 1 AS `Office visiting county`,
 1 AS `Office visiting phone`,
 1 AS `Office postal address`,
 1 AS `Office postal code`,
 1 AS `Office postal area`,
 1 AS `turnovers-interval`,
 1 AS `employees-interval`,
 1 AS `Turnover`,
 1 AS `Profit`,
 1 AS `Result of the year`,
 1 AS `Assests`,
 1 AS `The year of figures`,
 1 AS `Registered`,
 1 AS `Profit margin`,
 1 AS `Liquidity`,
 1 AS `Solidity`,
 1 AS `Gross profit margin`,
 1 AS `2021- Employees`,
 1 AS `2020- Employees`,
 1 AS `2019- Employees`,
 1 AS `2021- Turnover`,
 1 AS `2020- Turnover`,
 1 AS `2019- Turnover`,
 1 AS `2021- Result after financial items`,
 1 AS `2020- Result after financial items`,
 1 AS `2019- Result after financial items`,
 1 AS `2021- Years result`,
 1 AS `2020- Years result`,
 1 AS `2019- Years result`,
 1 AS `2021- Assets`,
 1 AS `2020- Assets`,
 1 AS `2019- Assets`,
 1 AS `Operation description`,
 1 AS `SNI`,
 1 AS `Company status`,
 1 AS `Company registration`,
 1 AS `F-tax registered`,
 1 AS `Date for F-tax registration`,
 1 AS `VAT registered`,
 1 AS `Registration date for VAT`,
 1 AS `Entity type`,
 1 AS `Mother company name`,
 1 AS `Owbership type`,
 1 AS `County of seat`,
 1 AS `Munipality of seat`,
 1 AS `decision_maker_name`,
 1 AS `Decision maker title`,
 1 AS `decision_maker_email`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `municipality_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cities_on_state_id` (`state_id`),
  CONSTRAINT `fk_rails_59b5e22e07` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10828 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ckeditor_assets`
--

DROP TABLE IF EXISTS `ckeditor_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ckeditor_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_file_size` int DEFAULT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `width` int DEFAULT NULL,
  `height` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ckeditor_assets_on_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `type` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_orders`
--

DROP TABLE IF EXISTS `customer_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_query` longtext COLLATE utf8mb4_unicode_ci,
  `filter_params` text COLLATE utf8mb4_unicode_ci,
  `data_amount` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `voucher_id` int DEFAULT NULL,
  `cost` float DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `order_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_unique_name` tinyint(1) DEFAULT '0',
  `selected_fields` text COLLATE utf8mb4_unicode_ci,
  `has_unique_apartment` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=813 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_sheets`
--

DROP TABLE IF EXISTS `data_sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_sheets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` int DEFAULT '0',
  `search_query` longtext COLLATE utf8mb4_unicode_ci,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `sheet_errors` text COLLATE utf8mb4_unicode_ci,
  `customer_order_id` int DEFAULT NULL,
  `is_nix_enabled` tinyint(1) DEFAULT '0',
  `search_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'private_search',
  `build_duration` int DEFAULT NULL,
  `data_amount` int DEFAULT NULL,
  `has_unique_name` tinyint(1) DEFAULT '0',
  `export_all` tinyint(1) DEFAULT '0',
  `has_unique_apartment` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=902 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dead_people`
--

DROP TABLE IF EXISTS `dead_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dead_people` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dead_sheet_id` int DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `careof` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `post_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postort` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `in_db` tinyint(1) DEFAULT '0',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `linked_person_id` int DEFAULT NULL,
  `is_gdpr_enabled` tinyint(1) DEFAULT '0',
  `is_dead` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dead_sheets`
--

DROP TABLE IF EXISTS `dead_sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dead_sheets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `build_duration` int DEFAULT NULL,
  `data_amount` int DEFAULT '0',
  `file` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sheet_errors` text COLLATE utf8mb4_general_ci,
  `status` int DEFAULT '0',
  `records_found` int DEFAULT '0',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `decision_maker_groups`
--

DROP TABLE IF EXISTS `decision_maker_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `decision_maker_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_special` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `decision_maker_titles`
--

DROP TABLE IF EXISTS `decision_maker_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `decision_maker_titles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_group_id` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=622 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emails_validation_sheets`
--

DROP TABLE IF EXISTS `emails_validation_sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emails_validation_sheets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `build_duration` int DEFAULT NULL,
  `file` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sheet_errors` text COLLATE utf8mb4_general_ci,
  `status` int DEFAULT '0',
  `records_found` int DEFAULT '0',
  `data_amount` int DEFAULT '0',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enrichment_items`
--

DROP TABLE IF EXISTS `enrichment_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrichment_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Organization number` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal code` int DEFAULT NULL,
  `Company visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `turnovers-interval` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees-interval` int DEFAULT NULL,
  `Turnover` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Result of the year` int DEFAULT NULL,
  `Assests` int DEFAULT NULL,
  `The year of figures` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registered` int DEFAULT NULL,
  `Profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Liquidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Solidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gross profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `2021- Employees` int DEFAULT NULL,
  `2020- Employees` int DEFAULT NULL,
  `2019- Employees` int DEFAULT NULL,
  `2021- Turnover` int DEFAULT NULL,
  `2020- Turnover` int DEFAULT NULL,
  `2019- Turnover` int DEFAULT NULL,
  `2021- Result after financial items` int DEFAULT NULL,
  `2020- Result after financial items` int DEFAULT NULL,
  `2019- Result after financial items` int DEFAULT NULL,
  `2021- Years result` int DEFAULT NULL,
  `2020- Years result` int DEFAULT NULL,
  `2019- Years result` int DEFAULT NULL,
  `2021- Assets` int DEFAULT NULL,
  `2020- Assets` int DEFAULT NULL,
  `2019- Assets` int DEFAULT NULL,
  `Operation description` varchar(5895) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SNI` varchar(317) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Company status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `F-tax registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Date for F-tax registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `VAT registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registration date for VAT` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entity type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mother company name` varchar(666) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Owbership type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `County of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Munipality of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Sector name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Matching Score` int DEFAULT NULL,
  `decision_maker_title_id` bigint DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_email_valid` tinyint(1) DEFAULT NULL,
  `is_decision_maker_email_valid` tinyint(1) DEFAULT NULL,
  `email_validation_date` date DEFAULT NULL,
  `decision_maker_email_validation_date` date DEFAULT NULL,
  `decision_maker_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Reference page` text COLLATE utf8mb4_general_ci,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `status` int DEFAULT '0',
  `enrichment_sheet_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enrichment_sheets`
--

DROP TABLE IF EXISTS `enrichment_sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrichment_sheets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `build_duration` int DEFAULT NULL,
  `data_amount` int DEFAULT '0',
  `file` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sheet_errors` text COLLATE utf8mb4_general_ci,
  `status` int DEFAULT '0',
  `records_found` int DEFAULT '0',
  `blacklisted_found` int DEFAULT '0',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixed_contents`
--

DROP TABLE IF EXISTS `fixed_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixed_contents` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'private',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hidden_business_people`
--

DROP TABLE IF EXISTS `hidden_business_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hidden_business_people` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Organization number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting postal code` int DEFAULT NULL,
  `Company visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting county` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office visiting phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Office postal area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `turnovers-interval` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employees-interval` int DEFAULT NULL,
  `Turnover` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Result of the year` int DEFAULT NULL,
  `Assests` int DEFAULT NULL,
  `The year of figures` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registered` int DEFAULT NULL,
  `Profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Liquidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Solidity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gross profit margin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `2021- Employees` int DEFAULT NULL,
  `2020- Employees` int DEFAULT NULL,
  `2019- Employees` int DEFAULT NULL,
  `2021- Turnover` int DEFAULT NULL,
  `2020- Turnover` int DEFAULT NULL,
  `2019- Turnover` int DEFAULT NULL,
  `2021- Result after financial items` int DEFAULT NULL,
  `2020- Result after financial items` int DEFAULT NULL,
  `2019- Result after financial items` int DEFAULT NULL,
  `2021- Years result` int DEFAULT NULL,
  `2020- Years result` int DEFAULT NULL,
  `2019- Years result` int DEFAULT NULL,
  `2021- Assets` int DEFAULT NULL,
  `2020- Assets` int DEFAULT NULL,
  `2019- Assets` int DEFAULT NULL,
  `Operation description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `SNI` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Company registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `F-tax registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Date for F-tax registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `VAT registered` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Registration date for VAT` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entity type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Mother company name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Owbership type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `County of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Munipality of seat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Sector name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Matching Score` int DEFAULT NULL,
  `decision_maker_title_id` bigint DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_email_valid` tinyint(1) DEFAULT NULL,
  `is_decision_maker_email_valid` tinyint(1) DEFAULT NULL,
  `email_validation_date` date DEFAULT NULL,
  `decision_maker_email_validation_date` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `decision_maker_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reference_page` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hidden_business_sheets`
--

DROP TABLE IF EXISTS `hidden_business_sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hidden_business_sheets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `build_duration` int DEFAULT NULL,
  `data_amount` int DEFAULT '0',
  `file` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sheet_errors` text COLLATE utf8mb4_general_ci,
  `status` int DEFAULT '0',
  `records_found` int DEFAULT '0',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `housing_types`
--

DROP TABLE IF EXISTS `housing_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housing_types` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `query_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `sort_order` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imported_companies`
--

DROP TABLE IF EXISTS `imported_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imported_companies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `address` text,
  `description` text,
  `deregistration_date` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=267513 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `municipalities`
--

DROP TABLE IF EXISTS `municipalities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `municipalities` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_municipalities_name` (`name`),
  KEY `idx_municipalities_state_id` (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nix_numbers`
--

DROP TABLE IF EXISTS `nix_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nix_numbers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57758940 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nix_private_sheets`
--

DROP TABLE IF EXISTS `nix_private_sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nix_private_sheets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sheet_errors` text COLLATE utf8mb4_unicode_ci,
  `status` int DEFAULT '0',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `result_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sheet_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'template',
  `skip_header` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nix_sheets`
--

DROP TABLE IF EXISTS `nix_sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nix_sheets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` int DEFAULT '0',
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sheet_errors` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_templates`
--

DROP TABLE IF EXISTS `notification_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_templates` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `notification_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `available_dynamic_keys` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization_legal_forms`
--

DROP TABLE IF EXISTS `organization_legal_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_legal_forms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `sort_order` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization_revenues`
--

DROP TABLE IF EXISTS `organization_revenues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_revenues` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `organization_id` bigint NOT NULL,
  `arbetsställe` varchar(255) DEFAULT NULL,
  `bokslut_år` varchar(255) NOT NULL,
  `omsättning_t_sek` int DEFAULT NULL,
  `arets_resultat_t_sek` int DEFAULT NULL,
  `eget_kapital_t_sek` int DEFAULT NULL,
  `balansomslutning_t_sek` int DEFAULT NULL,
  `avkastningsgrad` varchar(255) DEFAULT NULL,
  `soliditetsgrad` varchar(255) DEFAULT NULL,
  `befattningshavare_1` varchar(255) DEFAULT NULL,
  `befattning_1` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_organization_revenues_on_organization_id_and_bokslut_år` (`organization_id`,`bokslut_år`),
  KEY `index_organization_revenues_on_organization_id` (`organization_id`),
  KEY `idx_org_rev_org_year` (`organization_id`,`bokslut_år`),
  CONSTRAINT `fk_rails_8ddcc2cbbf` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=711655 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_number` varchar(255) NOT NULL,
  `name` varchar(2048) DEFAULT NULL,
  `legal_form_code` int DEFAULT NULL,
  `registered_at` date DEFAULT NULL,
  `deregistered_at` date DEFAULT NULL,
  `deregistration_reason_code` varchar(255) DEFAULT NULL,
  `in_liquidation` tinyint(1) NOT NULL DEFAULT '0',
  `activity_status_code` varchar(255) DEFAULT NULL,
  `entity_status_code` varchar(255) DEFAULT NULL,
  `ad_blocking` varchar(255) DEFAULT NULL,
  `sni1` varchar(255) DEFAULT NULL,
  `sni2` varchar(255) DEFAULT NULL,
  `sni3` varchar(255) DEFAULT NULL,
  `sni4` varchar(255) DEFAULT NULL,
  `sni5` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `företagsnamn` varchar(255) DEFAULT NULL,
  `gatuadress` varchar(255) DEFAULT NULL,
  `gatuadress_postnr` varchar(255) DEFAULT NULL,
  `gatuadress_postort` varchar(255) DEFAULT NULL,
  `registration_year` varchar(255) DEFAULT NULL,
  `telefon` varchar(255) DEFAULT NULL,
  `old_telefon` varchar(255) DEFAULT NULL,
  `besöksadress` varchar(255) DEFAULT NULL,
  `besöksadress_postnr` varchar(255) DEFAULT NULL,
  `besöksadress_postort` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `antal_anställda` varchar(255) DEFAULT NULL,
  `befattningshavare_1` varchar(255) DEFAULT NULL,
  `befattning_1` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_organizations_on_org_number` (`org_number`),
  KEY `index_organizations_on_legal_form_code` (`legal_form_code`),
  KEY `index_organizations_on_registered_at` (`registered_at`),
  KEY `idx_org_postnr` (`gatuadress_postnr`),
  KEY `idx_org_postort` (`gatuadress_postort`),
  KEY `idx_org_telefon` (`telefon`),
  KEY `idx_org_email` (`email`),
  KEY `idx_org_org_number` (`org_number`),
  KEY `idx_org_registration_year` (`registration_year`),
  KEY `idx_org_sni1` (`sni1`),
  KEY `idx_org_sni2` (`sni2`),
  KEY `idx_org_sni3` (`sni3`),
  KEY `idx_org_sni4` (`sni4`),
  KEY `idx_org_sni5` (`sni5`),
  KEY `idx_org_postort_postnr` (`gatuadress_postort`,`gatuadress_postnr`),
  KEY `idx_org_zip_lookup` (`gatuadress_postnr`)
) ENGINE=InnoDB AUTO_INCREMENT=34961443 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organizations_sni_codes`
--

DROP TABLE IF EXISTS `organizations_sni_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations_sni_codes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `organization_id` bigint NOT NULL,
  `sni_code_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_organizations_sni_codes_on_organization_id` (`organization_id`),
  KEY `index_organizations_sni_codes_on_sni_code_id` (`sni_code_id`),
  KEY `idx_sni_to_org` (`sni_code_id`,`organization_id`),
  CONSTRAINT `fk_rails_56a782a04a` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `fk_rails_f526d1c3e9` FOREIGN KEY (`sni_code_id`) REFERENCES `sni_codes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4570625 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `package_details`
--

DROP TABLE IF EXISTS `package_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `package_id` bigint NOT NULL,
  `feature` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_package_details_on_package_id` (`package_id`),
  CONSTRAINT `fk_rails_3afad7cfee` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sek` decimal(10,2) DEFAULT NULL,
  `credit` decimal(10,2) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `object_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `price_ranges`
--

DROP TABLE IF EXISTS `price_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price_ranges` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `min_amount` int DEFAULT NULL,
  `max_amount` int DEFAULT NULL,
  `price_per_address` float DEFAULT NULL,
  `is_fixed_price_enabled` tinyint(1) DEFAULT '0',
  `fixed_price` float DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `private_people`
--

DROP TABLE IF EXISTS `private_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `private_people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(80) DEFAULT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `Mobile1` varchar(11) DEFAULT NULL,
  `Mobile2` varchar(11) DEFAULT NULL,
  `Mobile3` varchar(10) DEFAULT NULL,
  `Mobile4` varchar(10) DEFAULT NULL,
  `Phone1` varchar(11) DEFAULT NULL,
  `Phone2` varchar(11) DEFAULT NULL,
  `Streetaddress` varchar(54) DEFAULT NULL,
  `Apartment` varchar(4) DEFAULT NULL,
  `Zipcode` varchar(5) DEFAULT NULL,
  `Town` varchar(17) DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  `Living` varchar(11) DEFAULT NULL,
  `LivingArea` int DEFAULT NULL,
  `BuildingYear` int DEFAULT NULL,
  `LandArea` int DEFAULT NULL,
  `mobile1_nix` tinyint(1) DEFAULT '0',
  `mobile2_nix` tinyint(1) DEFAULT '0',
  `mobile3_nix` tinyint(1) DEFAULT '0',
  `mobile4_nix` tinyint(1) DEFAULT '0',
  `phone1_nix` tinyint(1) DEFAULT '0',
  `phone2_nix` tinyint(1) DEFAULT '0',
  `phone3_nix` tinyint(1) DEFAULT '0',
  `housing_type_id` int DEFAULT NULL,
  `town_id` int DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT '0',
  `is_gdpr_enabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_private_people_on_housing_type_id` (`housing_type_id`),
  KEY `index_private_people_on_town_id` (`town_id`),
  KEY `index_private_people_on_Gender` (`Gender`),
  KEY `index_private_people_on_Zipcode` (`Zipcode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scb`
--

DROP TABLE IF EXISTS `scb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scb` (
  `ForAndrTyp` varchar(255) DEFAULT NULL,
  `COAdress` text,
  `Foretagsnamn` text,
  `FtgStat` varchar(255) DEFAULT NULL,
  `Gatuadress` text,
  `JEStat` varchar(255) DEFAULT NULL,
  `JurForm` varchar(255) DEFAULT NULL,
  `Namn` text,
  `Ng1` varchar(255) DEFAULT NULL,
  `Ng2` varchar(255) DEFAULT NULL,
  `Ng3` varchar(255) DEFAULT NULL,
  `Ng4` varchar(255) DEFAULT NULL,
  `Ng5` varchar(255) DEFAULT NULL,
  `PeOrgNr` varchar(255) DEFAULT NULL,
  `PostNr` varchar(255) DEFAULT NULL,
  `PostOrt` text,
  `RegDatKtid` varchar(255) DEFAULT NULL,
  `Reklamsparrtyp` varchar(255) DEFAULT NULL,
  `mCOAdress` varchar(255) DEFAULT NULL,
  `mForetagsnamn` varchar(255) DEFAULT NULL,
  `mFtgStat` varchar(255) DEFAULT NULL,
  `mGatuadress` varchar(255) DEFAULT NULL,
  `mJEStat` varchar(255) DEFAULT NULL,
  `mJurForm` varchar(255) DEFAULT NULL,
  `mNamn` varchar(255) DEFAULT NULL,
  `mNg1` varchar(255) DEFAULT NULL,
  `mNg2` varchar(255) DEFAULT NULL,
  `mNg3` varchar(255) DEFAULT NULL,
  `mNg4` varchar(255) DEFAULT NULL,
  `mNg5` varchar(255) DEFAULT NULL,
  `mPostNr` varchar(255) DEFAULT NULL,
  `mPostOrt` varchar(255) DEFAULT NULL,
  `mRegDatKtid` varchar(255) DEFAULT NULL,
  `mReklamsparrtyp` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_engine_optimizations`
--

DROP TABLE IF EXISTS `search_engine_optimizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_engine_optimizations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_history_records`
--

DROP TABLE IF EXISTS `search_history_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_history_records` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `search_filters` text COLLATE utf8mb4_unicode_ci,
  `search_query` longtext COLLATE utf8mb4_unicode_ci,
  `search_cost` float DEFAULT NULL,
  `search_amount` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `voucher_id` int DEFAULT NULL,
  `search_type` int DEFAULT '0',
  `has_unique_name` tinyint(1) DEFAULT '0',
  `selected_fields` text COLLATE utf8mb4_unicode_ci,
  `has_unique_apartment` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=264730 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sni_classifications`
--

DROP TABLE IF EXISTS `sni_classifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sni_classifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `section` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `main_group` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sni_codes`
--

DROP TABLE IF EXISTS `sni_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sni_codes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sni_classification_id` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `nested_codes_count` int DEFAULT '0',
  `business_people_sni_codes_count` int DEFAULT '0',
  `organizations_sni_codes_count` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_sni_code` (`code`),
  KEY `idx_sni_codes_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4751 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_states_on_country_id` (`country_id`),
  KEY `idx_states_name` (`name`),
  CONSTRAINT `fk_rails_40bd891262` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5589 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stiftelser_2025_08_23`
--

DROP TABLE IF EXISTS `stiftelser_2025_08_23`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stiftelser_2025_08_23` (
  `id` bigint NOT NULL,
  `namn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orgnr` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coadress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postnr` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ort` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `typ` int DEFAULT NULL,
  `lankod` int DEFAULT NULL,
  `kommunkod` int DEFAULT NULL,
  `andamal` mediumtext COLLATE utf8mb4_unicode_ci,
  `firmateckning` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stiftelser_2025_08_23_firmor`
--

DROP TABLE IF EXISTS `stiftelser_2025_08_23_firmor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stiftelser_2025_08_23_firmor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stiftelse_id` bigint DEFAULT NULL,
  `namn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naringsverksamhet` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_stiftelser_2025_08_23_firmor_stiftelse_id` (`stiftelse_id`),
  CONSTRAINT `fk_stiftelser_2025_08_23_firmor_stiftelse` FOREIGN KEY (`stiftelse_id`) REFERENCES `stiftelser_2025_08_23` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1762 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stiftelser_2025_08_23_roller`
--

DROP TABLE IF EXISTS `stiftelser_2025_08_23_roller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stiftelser_2025_08_23_roller` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stiftelse_id` bigint DEFAULT NULL,
  `typ` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `namn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nummer` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postadress` text COLLATE utf8mb4_unicode_ci,
  `telefon` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `huvudansvarig` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_stiftelser_2025_08_23_roller_stiftelse_id` (`stiftelse_id`),
  CONSTRAINT `fk_stiftelser_2025_08_23_roller_stiftelse` FOREIGN KEY (`stiftelse_id`) REFERENCES `stiftelser_2025_08_23` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87371 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stripe_payments`
--

DROP TABLE IF EXISTS `stripe_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stripe_payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `wallet_charge_request_id` bigint NOT NULL,
  `checkout_session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_intent_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_customer_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_sek` decimal(10,2) DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sek',
  `status` int NOT NULL DEFAULT '0',
  `paid_at` datetime DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_stripe_payments_on_wallet_charge_request_id` (`wallet_charge_request_id`),
  UNIQUE KEY `index_stripe_payments_on_checkout_session_id` (`checkout_session_id`),
  KEY `index_stripe_payments_on_payment_intent_id` (`payment_intent_id`),
  KEY `index_stripe_payments_on_status` (`status`),
  CONSTRAINT `fk_rails_57dc121733` FOREIGN KEY (`wallet_charge_request_id`) REFERENCES `wallet_charge_requests` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `organization_number` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_profiles_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_87a6352e58` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_users_on_provider_and_uid` (`provider`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `validated_emails`
--

DROP TABLE IF EXISTS `validated_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validated_emails` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_valid` tinyint(1) DEFAULT '0',
  `in_db` tinyint(1) DEFAULT '0',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `emails_validation_sheet_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vd_table`
--

DROP TABLE IF EXISTS `vd_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vd_table` (
  `id` int NOT NULL DEFAULT '0',
  `decision_maker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Decision maker title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Organization number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `decision_maker_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vouchers`
--

DROP TABLE IF EXISTS `vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vouchers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `is_unlimited` tinyint(1) DEFAULT '0',
  `use_limit` int DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `skip_base_cost` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wallet_charge_requests`
--

DROP TABLE IF EXISTS `wallet_charge_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_charge_requests` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `amount` decimal(15,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `payment_method` int NOT NULL DEFAULT '0',
  `package_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_wallet_charge_requests_on_user_id` (`user_id`),
  KEY `index_wallet_charge_requests_on_package_id` (`package_id`),
  KEY `index_wallet_charge_requests_on_payment_method` (`payment_method`),
  CONSTRAINT `fk_rails_2b68792b92` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_rails_6f2be6ba9a` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `currency` varchar(255) NOT NULL DEFAULT 'CK',
  `cached_balance` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `last_transaction_at` datetime DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_wallets_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_732f6628c4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wallets_transaction_ledgers`
--

DROP TABLE IF EXISTS `wallets_transaction_ledgers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets_transaction_ledgers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint NOT NULL,
  `transaction_type` int NOT NULL DEFAULT '0',
  `amount` decimal(15,2) NOT NULL,
  `reference_type` varchar(255) NOT NULL,
  `reference_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_wallets_transaction_ledgers_on_wallet_id` (`wallet_id`),
  KEY `index_wallets_transaction_ledgers_on_reference` (`reference_type`,`reference_id`),
  CONSTRAINT `fk_rails_62953b1b66` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `business_people_view`
--

/*!50001 DROP VIEW IF EXISTS `business_people_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`udmybs438957`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `business_people_view` AS select `t1`.`id` AS `id`,`t1`.`Organization number` AS `Organization number`,`t1`.`Company name` AS `Company name`,`t1`.`email` AS `email`,`t1`.`website` AS `website`,`t1`.`Company visiting address` AS `Company visiting address`,`t1`.`Company visiting postal code` AS `Company visiting postal code`,`t1`.`Company visiting postal area` AS `Company visiting postal area`,`t1`.`Company visiting county` AS `Company visiting county`,`t1`.`Company visiting phone` AS `Company visiting phone`,`t1`.`Company postal address` AS `Company postal address`,`t1`.`Company postal code` AS `Company postal code`,`t1`.`Company postal area` AS `Company postal area`,`t1`.`Office name` AS `Office name`,`t1`.`Office visiting address` AS `Office visiting address`,`t1`.`Office visiting postal code` AS `Office visiting postal code`,`t1`.`Office visiting postal area` AS `Office visiting postal area`,`t1`.`Office visiting county` AS `Office visiting county`,`t1`.`Office visiting phone` AS `Office visiting phone`,`t1`.`Office postal address` AS `Office postal address`,`t1`.`Office postal code` AS `Office postal code`,`t1`.`Office postal area` AS `Office postal area`,`t1`.`turnovers-interval` AS `turnovers-interval`,`t1`.`employees-interval` AS `employees-interval`,`t1`.`Turnover` AS `Turnover`,`t1`.`Profit` AS `Profit`,`t1`.`Result of the year` AS `Result of the year`,`t1`.`Assests` AS `Assests`,`t1`.`The year of figures` AS `The year of figures`,`t1`.`Registered` AS `Registered`,`t1`.`Profit margin` AS `Profit margin`,`t1`.`Liquidity` AS `Liquidity`,`t1`.`Solidity` AS `Solidity`,`t1`.`Gross profit margin` AS `Gross profit margin`,`t1`.`2021- Employees` AS `2021- Employees`,`t1`.`2020- Employees` AS `2020- Employees`,`t1`.`2019- Employees` AS `2019- Employees`,`t1`.`2021- Turnover` AS `2021- Turnover`,`t1`.`2020- Turnover` AS `2020- Turnover`,`t1`.`2019- Turnover` AS `2019- Turnover`,`t1`.`2021- Result after financial items` AS `2021- Result after financial items`,`t1`.`2020- Result after financial items` AS `2020- Result after financial items`,`t1`.`2019- Result after financial items` AS `2019- Result after financial items`,`t1`.`2021- Years result` AS `2021- Years result`,`t1`.`2020- Years result` AS `2020- Years result`,`t1`.`2019- Years result` AS `2019- Years result`,`t1`.`2021- Assets` AS `2021- Assets`,`t1`.`2020- Assets` AS `2020- Assets`,`t1`.`2019- Assets` AS `2019- Assets`,`t1`.`Operation description` AS `Operation description`,`t1`.`SNI` AS `SNI`,`t1`.`Company status` AS `Company status`,`t1`.`Company registration` AS `Company registration`,`t1`.`F-tax registered` AS `F-tax registered`,`t1`.`Date for F-tax registration` AS `Date for F-tax registration`,`t1`.`VAT registered` AS `VAT registered`,`t1`.`Registration date for VAT` AS `Registration date for VAT`,`t1`.`Entity type` AS `Entity type`,`t1`.`Mother company name` AS `Mother company name`,`t1`.`Owbership type` AS `Owbership type`,`t1`.`County of seat` AS `County of seat`,`t1`.`Munipality of seat` AS `Munipality of seat`,`t2`.`decision_maker_name` AS `decision_maker_name`,`t2`.`Decision maker title` AS `Decision maker title`,`t2`.`is_decision_maker` AS `is_decision_maker`,`t2`.`Sector name` AS `Sector name`,`t2`.`Matching Score` AS `Matching Score`,`t2`.`decision_maker_title_id` AS `decision_maker_title_id`,`t2`.`decision_maker_email` AS `decision_maker_email`,`t2`.`is_email_valid` AS `is_email_valid`,`t2`.`is_decision_maker_email_valid` AS `is_decision_maker_email_valid`,`t2`.`email_validation_date` AS `email_validation_date`,`t2`.`decision_maker_email_validation_date` AS `decision_maker_email_validation_date`,`t2`.`decision_maker_number` AS `decision_maker_number`,`t2`.`Reference page` AS `Reference page`,`t2`.`enrichment_item_id` AS `enrichment_item_id`,`t2`.`last_updated` AS `last_updated` from (`business_comp_details` `t1` join `business_comp_people` `t2` on((`t1`.`Organization number` = `t2`.`Organization number`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `business_vd_view`
--

/*!50001 DROP VIEW IF EXISTS `business_vd_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`udmybs438957`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `business_vd_view` AS select `t1`.`id` AS `id`,`t1`.`Organization number` AS `Organization number`,`t1`.`Company name` AS `Company name`,`t1`.`email` AS `email`,`t1`.`website` AS `website`,`t1`.`Company visiting address` AS `Company visiting address`,`t1`.`Company visiting postal code` AS `Company visiting postal code`,`t1`.`Company visiting postal area` AS `Company visiting postal area`,`t1`.`Company visiting county` AS `Company visiting county`,`t1`.`Company visiting phone` AS `Company visiting phone`,`t1`.`Company postal address` AS `Company postal address`,`t1`.`Company postal code` AS `Company postal code`,`t1`.`Company postal area` AS `Company postal area`,`t1`.`Office name` AS `Office name`,`t1`.`Office visiting address` AS `Office visiting address`,`t1`.`Office visiting postal code` AS `Office visiting postal code`,`t1`.`Office visiting postal area` AS `Office visiting postal area`,`t1`.`Office visiting county` AS `Office visiting county`,`t1`.`Office visiting phone` AS `Office visiting phone`,`t1`.`Office postal address` AS `Office postal address`,`t1`.`Office postal code` AS `Office postal code`,`t1`.`Office postal area` AS `Office postal area`,`t1`.`turnovers-interval` AS `turnovers-interval`,`t1`.`employees-interval` AS `employees-interval`,`t1`.`Turnover` AS `Turnover`,`t1`.`Profit` AS `Profit`,`t1`.`Result of the year` AS `Result of the year`,`t1`.`Assests` AS `Assests`,`t1`.`The year of figures` AS `The year of figures`,`t1`.`Registered` AS `Registered`,`t1`.`Profit margin` AS `Profit margin`,`t1`.`Liquidity` AS `Liquidity`,`t1`.`Solidity` AS `Solidity`,`t1`.`Gross profit margin` AS `Gross profit margin`,`t1`.`2021- Employees` AS `2021- Employees`,`t1`.`2020- Employees` AS `2020- Employees`,`t1`.`2019- Employees` AS `2019- Employees`,`t1`.`2021- Turnover` AS `2021- Turnover`,`t1`.`2020- Turnover` AS `2020- Turnover`,`t1`.`2019- Turnover` AS `2019- Turnover`,`t1`.`2021- Result after financial items` AS `2021- Result after financial items`,`t1`.`2020- Result after financial items` AS `2020- Result after financial items`,`t1`.`2019- Result after financial items` AS `2019- Result after financial items`,`t1`.`2021- Years result` AS `2021- Years result`,`t1`.`2020- Years result` AS `2020- Years result`,`t1`.`2019- Years result` AS `2019- Years result`,`t1`.`2021- Assets` AS `2021- Assets`,`t1`.`2020- Assets` AS `2020- Assets`,`t1`.`2019- Assets` AS `2019- Assets`,`t1`.`Operation description` AS `Operation description`,`t1`.`SNI` AS `SNI`,`t1`.`Company status` AS `Company status`,`t1`.`Company registration` AS `Company registration`,`t1`.`F-tax registered` AS `F-tax registered`,`t1`.`Date for F-tax registration` AS `Date for F-tax registration`,`t1`.`VAT registered` AS `VAT registered`,`t1`.`Registration date for VAT` AS `Registration date for VAT`,`t1`.`Entity type` AS `Entity type`,`t1`.`Mother company name` AS `Mother company name`,`t1`.`Owbership type` AS `Owbership type`,`t1`.`County of seat` AS `County of seat`,`t1`.`Munipality of seat` AS `Munipality of seat`,`t2`.`decision_maker_name` AS `decision_maker_name`,`t2`.`Decision maker title` AS `Decision maker title`,`t2`.`decision_maker_email` AS `decision_maker_email` from (`business_comp_details` `t1` join `vd_table` `t2` on((`t1`.`Organization number` = `t2`.`Organization number`))) */;
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

-- Dump completed on 2026-10-04  9:14:49
