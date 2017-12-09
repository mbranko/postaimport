-- MySQL dump 10.13  Distrib 5.7.20, for osx10.13 (x86_64)
--
-- Host: localhost    Database: bisis
-- ------------------------------------------------------
-- Server version	5.7.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Bibliotekari`
--

DROP TABLE IF EXISTS `Bibliotekari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bibliotekari` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `ime` varchar(50) DEFAULT NULL,
  `prezime` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `napomena` varchar(250) DEFAULT NULL,
  `obrada` int(11) NOT NULL,
  `cirkulacija` int(11) NOT NULL,
  `administracija` int(11) NOT NULL,
  `context` text NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bibliotekari`
--

LOCK TABLES `Bibliotekari` WRITE;
/*!40000 ALTER TABLE `Bibliotekari` DISABLE KEYS */;
INSERT INTO `Bibliotekari` VALUES ('admin','admin','Bojana','Dimi�','bdimic@uns.ns.ac.yu','napomena',1,1,1,'<?xml version=\"1.0\"?><librarian-context><process-type name=\"Monografske - kompletna obrada\"/><process-type name=\"Serijske - kompletna obrada\"/><default-process-type name=\"Monografske - kompletna obrada\"/><prefixes pref1=\"AU\" pref2=\"TI\" pref3=\"PU\" pref4=\"PY\" pref5=\"KW\"/></librarian-context>'),('circ','circ','Danijela','Tesendic','tesendic@uns.ns.ac.yu','',0,1,0,'<?xml version=\"1.0\"?><librarian-context><process-type name=\"Monografske - kompletna obrada\"/><default-process-type name=\"Monografske - kompletna obrada\"/><prefixes pref1=\"AU\" pref2=\"TI\" pref3=\"PU\" pref4=\"PY\" pref5=\"KW\"/></librarian-context>');
/*!40000 ALTER TABLE `Bibliotekari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Counters`
--

DROP TABLE IF EXISTS `Counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Counters` (
  `counter_name` varchar(50) NOT NULL,
  `counter_value` int(11) NOT NULL,
  PRIMARY KEY (`counter_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Counters`
--

LOCK TABLES `Counters` WRITE;
/*!40000 ALTER TABLE `Counters` DISABLE KEYS */;
INSERT INTO `Counters` VALUES ('godinaid',0),('primerakid',0),('recordid',0),('RN',0),('sveskaid',0);
/*!40000 ALTER TABLE `Counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dostupnost`
--

DROP TABLE IF EXISTS `Dostupnost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dostupnost` (
  `dostupnost_id` char(4) NOT NULL,
  `dostupnost_opis` varchar(255) NOT NULL,
  PRIMARY KEY (`dostupnost_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dostupnost`
--

LOCK TABLES `Dostupnost` WRITE;
/*!40000 ALTER TABLE `Dostupnost` DISABLE KEYS */;
INSERT INTO `Dostupnost` VALUES ('4','Slobodno za izdavanje'),('c','Citaonicki primerak');
/*!40000 ALTER TABLE `Dostupnost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Godine`
--

DROP TABLE IF EXISTS `Godine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Godine` (
  `godina_id` int(11) NOT NULL,
  `povez_id` char(2) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `odeljenje_id` char(2) DEFAULT NULL,
  `IntOzn_id` char(4) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `nacin_id` char(1) DEFAULT NULL,
  `dostupnost_id` char(4) DEFAULT NULL,
  `SigFormat_ID` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `podlokacija_id` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `inv_broj` varchar(25) DEFAULT NULL,
  `datum_racuna` date DEFAULT NULL,
  `broj_racuna` varchar(50) DEFAULT NULL,
  `dobavljac` varchar(255) DEFAULT NULL,
  `cena` decimal(12,2) DEFAULT NULL,
  `finansijer` varchar(255) DEFAULT NULL,
  `sig_dublet` varchar(25) DEFAULT NULL,
  `sig_numerus_curens` varchar(50) DEFAULT NULL,
  `sig_numeracija` varchar(25) DEFAULT NULL,
  `sig_udk` varchar(255) DEFAULT NULL,
  `godiste` varchar(25) DEFAULT NULL,
  `godina` varchar(25) DEFAULT NULL,
  `broj` longtext,
  `datum_inventarisanja` date DEFAULT NULL,
  `inventator` varchar(255) DEFAULT NULL,
  `napomene` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`godina_id`),
  KEY `Relationship_4_FK` (`record_id`),
  KEY `Relationship_5_FK` (`povez_id`),
  KEY `Relationship_6_FK` (`nacin_id`),
  KEY `Relationship_7_FK` (`odeljenje_id`),
  KEY `Relationship_8_FK` (`IntOzn_id`),
  KEY `Relationship_9_FK` (`podlokacija_id`),
  KEY `Relationship_16_FK` (`SigFormat_ID`),
  KEY `Godine_index1` (`inv_broj`),
  KEY `FK_Relationship_19` (`dostupnost_id`),
  CONSTRAINT `FK_Relationship_16` FOREIGN KEY (`SigFormat_ID`) REFERENCES `SigFormat` (`SigFormat_ID`),
  CONSTRAINT `FK_Relationship_19` FOREIGN KEY (`dostupnost_id`) REFERENCES `Dostupnost` (`dostupnost_id`),
  CONSTRAINT `FK_Relationship_4` FOREIGN KEY (`record_id`) REFERENCES `Records` (`record_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Relationship_5` FOREIGN KEY (`povez_id`) REFERENCES `Povez` (`povez_id`),
  CONSTRAINT `FK_Relationship_6` FOREIGN KEY (`nacin_id`) REFERENCES `Nacin_nabavke` (`nacin_id`),
  CONSTRAINT `FK_Relationship_7` FOREIGN KEY (`odeljenje_id`) REFERENCES `Odeljenje` (`odeljenje_id`),
  CONSTRAINT `FK_Relationship_8` FOREIGN KEY (`IntOzn_id`) REFERENCES `Interna_oznaka` (`IntOzn_id`),
  CONSTRAINT `FK_Relationship_9` FOREIGN KEY (`podlokacija_id`) REFERENCES `Podlokacija` (`podlokacija_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Godine`
--

LOCK TABLES `Godine` WRITE;
/*!40000 ALTER TABLE `Godine` DISABLE KEYS */;
/*!40000 ALTER TABLE `Godine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Interna_oznaka`
--

DROP TABLE IF EXISTS `Interna_oznaka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Interna_oznaka` (
  `IntOzn_id` char(4) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `IntOzn_opis` varchar(255) NOT NULL,
  PRIMARY KEY (`IntOzn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Interna_oznaka`
--

LOCK TABLES `Interna_oznaka` WRITE;
/*!40000 ALTER TABLE `Interna_oznaka` DISABLE KEYS */;
INSERT INTO `Interna_oznaka` VALUES ('00','Cela biblioteka');
/*!40000 ALTER TABLE `Interna_oznaka` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Invknj`
--

DROP TABLE IF EXISTS `Invknj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Invknj` (
  `invknj_id` char(2) NOT NULL,
  `invknj_opis` varchar(255) NOT NULL,
  PRIMARY KEY (`invknj_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Invknj`
--

LOCK TABLES `Invknj` WRITE;
/*!40000 ALTER TABLE `Invknj` DISABLE KEYS */;
/*!40000 ALTER TABLE `Invknj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Nacin_nabavke`
--

DROP TABLE IF EXISTS `Nacin_nabavke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Nacin_nabavke` (
  `nacin_id` char(1) NOT NULL,
  `nacin_opis` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nacin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Nacin_nabavke`
--

LOCK TABLES `Nacin_nabavke` WRITE;
/*!40000 ALTER TABLE `Nacin_nabavke` DISABLE KEYS */;
INSERT INTO `Nacin_nabavke` VALUES ('k','Kupovina'),('o','Obavezni primerak'),('p','Poklon'),('r','Razmena');
/*!40000 ALTER TABLE `Nacin_nabavke` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Odeljenje`
--

DROP TABLE IF EXISTS `Odeljenje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Odeljenje` (
  `odeljenje_id` char(2) NOT NULL,
  `odeljenje_naziv` varchar(255) NOT NULL,
  PRIMARY KEY (`odeljenje_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Odeljenje`
--

LOCK TABLES `Odeljenje` WRITE;
/*!40000 ALTER TABLE `Odeljenje` DISABLE KEYS */;
INSERT INTO `Odeljenje` VALUES ('00','Cela biblioteka');
/*!40000 ALTER TABLE `Odeljenje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Podlokacija`
--

DROP TABLE IF EXISTS `Podlokacija`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Podlokacija` (
  `podlokacija_id` char(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `podlokacija_opis` varchar(255) NOT NULL,
  PRIMARY KEY (`podlokacija_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Podlokacija`
--

LOCK TABLES `Podlokacija` WRITE;
/*!40000 ALTER TABLE `Podlokacija` DISABLE KEYS */;
INSERT INTO `Podlokacija` VALUES ('1','Citaonica');
/*!40000 ALTER TABLE `Podlokacija` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Povez`
--

DROP TABLE IF EXISTS `Povez`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Povez` (
  `povez_id` char(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `povez_opis` varchar(255) NOT NULL,
  PRIMARY KEY (`povez_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Povez`
--

LOCK TABLES `Povez` WRITE;
/*!40000 ALTER TABLE `Povez` DISABLE KEYS */;
INSERT INTO `Povez` VALUES ('m','Meki povez'),('n','Nepovezano'),('p','Povezano'),('t','Tvrdi povez'),('x','Nepoznato');
/*!40000 ALTER TABLE `Povez` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Primerci`
--

DROP TABLE IF EXISTS `Primerci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Primerci` (
  `primerak_id` int(11) NOT NULL,
  `podlokacija_id` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SigFormat_ID` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `odeljenje_id` char(2) DEFAULT NULL,
  `IntOzn_id` char(4) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `datum_statusa` date DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `nacin_id` char(1) DEFAULT NULL,
  `povez_id` char(2) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `dostupnost_id` char(4) DEFAULT NULL,
  `inv_broj` varchar(25) NOT NULL,
  `datum_racuna` date DEFAULT NULL,
  `broj_racuna` varchar(50) DEFAULT NULL,
  `dobavljac` varchar(255) DEFAULT NULL,
  `cena` decimal(12,2) DEFAULT NULL,
  `finansijer` varchar(255) DEFAULT NULL,
  `usmeravanje` varchar(255) DEFAULT NULL,
  `sig_dublet` varchar(25) DEFAULT NULL,
  `sig_numerus_curens` varchar(50) DEFAULT NULL,
  `sig_udk` varchar(255) DEFAULT NULL,
  `datum_inventarisanja` date DEFAULT NULL,
  `napomene` varchar(255) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `stanje` int(11) DEFAULT NULL,
  `inventator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`primerak_id`),
  KEY `Relationship_1_FK` (`status_id`),
  KEY `Relationship_2_FK` (`record_id`),
  KEY `Relationship_10_FK` (`povez_id`),
  KEY `Relationship_11_FK` (`nacin_id`),
  KEY `Relationship_12_FK` (`odeljenje_id`),
  KEY `Relationship_13_FK` (`IntOzn_id`),
  KEY `Relationship_14_FK` (`podlokacija_id`),
  KEY `Relationship_17_FK` (`SigFormat_ID`),
  KEY `Relationship_18_FK` (`dostupnost_id`),
  KEY `Primerci_index1` (`inv_broj`),
  CONSTRAINT `FK_Relationship_1` FOREIGN KEY (`status_id`) REFERENCES `Status_Primerka` (`status_id`),
  CONSTRAINT `FK_Relationship_10` FOREIGN KEY (`povez_id`) REFERENCES `Povez` (`povez_id`),
  CONSTRAINT `FK_Relationship_11` FOREIGN KEY (`nacin_id`) REFERENCES `Nacin_nabavke` (`nacin_id`),
  CONSTRAINT `FK_Relationship_12` FOREIGN KEY (`odeljenje_id`) REFERENCES `Odeljenje` (`odeljenje_id`),
  CONSTRAINT `FK_Relationship_13` FOREIGN KEY (`IntOzn_id`) REFERENCES `Interna_oznaka` (`IntOzn_id`),
  CONSTRAINT `FK_Relationship_14` FOREIGN KEY (`podlokacija_id`) REFERENCES `Podlokacija` (`podlokacija_id`),
  CONSTRAINT `FK_Relationship_17` FOREIGN KEY (`SigFormat_ID`) REFERENCES `SigFormat` (`SigFormat_ID`),
  CONSTRAINT `FK_Relationship_18` FOREIGN KEY (`dostupnost_id`) REFERENCES `Dostupnost` (`dostupnost_id`),
  CONSTRAINT `FK_Relationship_2` FOREIGN KEY (`record_id`) REFERENCES `Records` (`record_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Primerci`
--

LOCK TABLES `Primerci` WRITE;
/*!40000 ALTER TABLE `Primerci` DISABLE KEYS */;
/*!40000 ALTER TABLE `Primerci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Records`
--

DROP TABLE IF EXISTS `Records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Records` (
  `record_id` int(11) NOT NULL,
  `pub_type` int(11) NOT NULL,
  `creator` varchar(255) NOT NULL,
  `modifier` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `in_use_by` varchar(255) DEFAULT NULL,
  `content` longtext,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Records`
--

LOCK TABLES `Records` WRITE;
/*!40000 ALTER TABLE `Records` DISABLE KEYS */;
/*!40000 ALTER TABLE `Records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sifarnik_992b`
--

DROP TABLE IF EXISTS `Sifarnik_992b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sifarnik_992b` (
  `id` varchar(20) NOT NULL,
  `naziv` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sifarnik_992b`
--

LOCK TABLES `Sifarnik_992b` WRITE;
/*!40000 ALTER TABLE `Sifarnik_992b` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sifarnik_992b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SigFormat`
--

DROP TABLE IF EXISTS `SigFormat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SigFormat` (
  `SigFormat_ID` char(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Format_opis` varchar(255) NOT NULL,
  PRIMARY KEY (`SigFormat_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SigFormat`
--

LOCK TABLES `SigFormat` WRITE;
/*!40000 ALTER TABLE `SigFormat` DISABLE KEYS */;
INSERT INTO `SigFormat` VALUES ('1','Format I'),('2','Format II'),('3','Format III'),('4','Format IV');
/*!40000 ALTER TABLE `SigFormat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Status_Primerka`
--

DROP TABLE IF EXISTS `Status_Primerka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Status_Primerka` (
  `status_id` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `status_opis` varchar(255) NOT NULL,
  `zaduziv` int(11) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Status_Primerka`
--

LOCK TABLES `Status_Primerka` WRITE;
/*!40000 ALTER TABLE `Status_Primerka` DISABLE KEYS */;
INSERT INTO `Status_Primerka` VALUES ('1','Naruceno',0),('2','U obradi',0),('3','U povezu',0),('4','U reviziji',0),('5','Preusmereno',0),('6','Osteceno',0),('7','Zagubljeno',0),('8','Izgubljeno',0),('9','Otpisano',0),('A','Aktivno',0);
/*!40000 ALTER TABLE `Status_Primerka` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sveske`
--

DROP TABLE IF EXISTS `Sveske`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sveske` (
  `sveska_id` int(11) NOT NULL,
  `status_id` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `datum_statusa` date DEFAULT NULL,
  `godina_id` int(11) DEFAULT NULL,
  `inv_br` varchar(25) NOT NULL,
  `signatura` varchar(255) DEFAULT NULL,
  `broj_sveske` varchar(255) DEFAULT NULL,
  `knjiga` varchar(255) DEFAULT NULL,
  `cena` decimal(12,2) DEFAULT NULL,
  `inventator` varchar(255) DEFAULT NULL,
  `stanje` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`sveska_id`),
  KEY `Relationship_3_FK` (`status_id`),
  KEY `Relationship_15_FK` (`godina_id`),
  KEY `Sveske_index1` (`inv_br`),
  CONSTRAINT `FK_Relationship_15` FOREIGN KEY (`godina_id`) REFERENCES `Godine` (`godina_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Relationship_3` FOREIGN KEY (`status_id`) REFERENCES `Status_Primerka` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sveske`
--

LOCK TABLES `Sveske` WRITE;
/*!40000 ALTER TABLE `Sveske` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sveske` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tipovi_obrade`
--

DROP TABLE IF EXISTS `Tipovi_obrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tipovi_obrade` (
  `tipobr_id` int(11) NOT NULL,
  `tipobr_spec` text NOT NULL,
  PRIMARY KEY (`tipobr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tipovi_obrade`
--

LOCK TABLES `Tipovi_obrade` WRITE;
/*!40000 ALTER TABLE `Tipovi_obrade` DISABLE KEYS */;
INSERT INTO `Tipovi_obrade` VALUES (1,'<?xml version=\"1.0\"?><process-type name=\"Monografske - kompletna obrada\" pubType=\"1\"><initial-subfield name=\"0017\"/><initial-subfield name=\"001c\"/><initial-subfield name=\"001d\"/><initial-subfield name=\"010a\"/><initial-subfield name=\"100b\"/><initial-subfield name=\"100c\"/><initial-subfield name=\"101a\"/><initial-subfield name=\"102a\"/><initial-subfield name=\"200a\"/><initial-subfield name=\"200f\"/><initial-subfield name=\"200g\"/><initial-subfield name=\"200h\"/><initial-subfield name=\"200i\"/><initial-subfield name=\"205a\"/><initial-subfield name=\"210a\"/><initial-subfield name=\"300a\"/><initial-subfield name=\"7004\"/><initial-subfield name=\"700a\"/><initial-subfield name=\"700b\"/><mandatory-subfield name=\"100c\"/><mandatory-subfield name=\"200a\"/></process-type>'),(2,'<?xml version=\"1.0\"?><process-type name=\"Serijske - kompletna obrada\" pubType=\"2\"><initial-subfield name=\"0017\"/><initial-subfield name=\"001c\"/><initial-subfield name=\"001d\"/><initial-subfield name=\"011a\"/><initial-subfield name=\"100b\"/><initial-subfield name=\"100c\"/><initial-subfield name=\"101a\"/><initial-subfield name=\"102a\"/><initial-subfield name=\"110a\"/><initial-subfield name=\"110b\"/><initial-subfield name=\"110c\"/><initial-subfield name=\"200a\"/><initial-subfield name=\"200f\"/><initial-subfield name=\"200g\"/><initial-subfield name=\"200h\"/><initial-subfield name=\"200i\"/><initial-subfield name=\"205a\"/><initial-subfield name=\"210a\"/><initial-subfield name=\"300a\"/><mandatory-subfield name=\"100c\"/><mandatory-subfield name=\"200a\"/></process-type>');
/*!40000 ALTER TABLE `Tipovi_obrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archive`
--

DROP TABLE IF EXISTS `archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_id` int(11) NOT NULL,
  `arch_date` datetime NOT NULL,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive`
--

LOCK TABLES `archive` WRITE;
/*!40000 ALTER TABLE `archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configs`
--

DROP TABLE IF EXISTS `configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configs` (
  `name` varchar(255) NOT NULL,
  `text` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configs`
--

LOCK TABLES `configs` WRITE;
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
INSERT INTO `configs` VALUES ('circ-options','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<opt:options xmlns:opt=\"options\">\n  <client mac=\"default\">\n    <general>\n      <nonCtlgNo>false</nonCtlgNo>\n      <blockedCard>true</blockedCard>\n      <autoReturn>true</autoReturn>\n      <defaultZipCity>true</defaultZipCity>\n      <defaultCity>Novi Sad</defaultCity>\n      <defaultZip>21000</defaultZip>\n      <fontSize>12</fontSize>\n      <maximize>false</maximize>\n      <lookAndFeel>default</lookAndFeel>\n      <theme>com.jgoodies.looks.plastic.theme.LightGray</theme>\n      <location>0</location>\n    </general>\n    <userid>\n      <length>11</length>\n      <prefix>false</prefix>\n      <prefixLength>2</prefixLength>\n      <defaultPrefix>1</defaultPrefix>\n      <separator>false</separator>\n      <separatorSign>/</separatorSign>\n      <inputUserid>1</inputUserid>\n    </userid>\n    <ctlgno>\n      <lengthCtlgno>11</lengthCtlgno>\n      <locationCtlgno>true</locationCtlgno>\n      <locationLength>2</locationLength>\n      <defaultLocation>0</defaultLocation>\n      <book>true</book>\n      <bookLength>2</bookLength>\n      <defaultBook>0</defaultBook>\n      <separators>true</separators>\n      <separator1>/</separator1>\n      <separator2>-</separator2>\n      <inputCtlgno>2</inputCtlgno>\n    </ctlgno>\n    <revers>\n      <libraryName>Biblioteka Departmana za matematiku i informatiku</libraryName>\n      <libraryAddress>Biblioteka Departmana za fiziku</libraryAddress>\n      <selected>true</selected>\n      <height>1</height>\n      <width>1</width>\n      <rowCount>1</rowCount>\n      <count>1</count>\n    </revers>\n  </client>\n</opt:options>'),('circ-validator','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE form-validation PUBLIC \"-//Apache Software Foundation//DTD Commons Validator Rules Configuration 1.3.0//EN\" \"http://jakarta.apache.org/commons/dtds/validator_1_3_0.dtd\">\n<form-validation>\n  <global>\n    <validator name=\"required\" classname=\"com.gint.app.bisis4.client.circ.validator.Validator\" method=\"validateRequired\" methodParams=\"java.lang.Object, org.apache.commons.validator.Field\" msg=\"required.field\"/>\n    <validator name=\"intorblank\" classname=\"com.gint.app.bisis4.client.circ.validator.Validator\" method=\"validateIntOrBlank\" methodParams=\"java.lang.Object, org.apache.commons.validator.Field\" msg=\"int.field\"/>\n    <validator name=\"positiveorblank\" classname=\"com.gint.app.bisis4.client.circ.validator.Validator\" method=\"validatePositiveOrBlank\" methodParams=\"java.lang.Object, org.apache.commons.validator.Field\" msg=\"positive.field\"/>\n    <validator name=\"doubleorblank\" classname=\"com.gint.app.bisis4.client.circ.validator.Validator\" method=\"validateDoubleOrBlank\" methodParams=\"java.lang.Object, org.apache.commons.validator.Field\" msg=\"double.field\"/>\n    <validator name=\"emailorblank\" classname=\"com.gint.app.bisis4.client.circ.validator.Validator\" method=\"validateEmailOrBlank\" methodParams=\"java.lang.Object, org.apache.commons.validator.Field\" msg=\"invalid.email\"/>\n    <validator name=\"dateorblank\" classname=\"com.gint.app.bisis4.client.circ.validator.Validator\" method=\"validateDateOrBlank\" methodParams=\"java.lang.Object, org.apache.commons.validator.Field\" msg=\"invalid.date\"/>\n    <validator name=\"userorblank\" classname=\"com.gint.app.bisis4.client.circ.validator.Validator\" method=\"validateUserIdOrBlank\" methodParams=\"java.lang.Object, org.apache.commons.validator.Field\" msg=\"invalid.userid\"/>\n  </global>\n  <formset>\n    <form name=\"userData\">\n      <field property=\"firstName\" depends=\"required\">\n        <arg key=\"userData.firstname.displayname\"/>\n      </field>\n      <field property=\"lastName\" depends=\"required\">\n        <arg key=\"userData.lastname.displayname\"/>\n      </field>\n      <field property=\"parentName\" depends=\"required\">\n        <arg key=\"userData.parentname.displayname\"/>\n      </field>\n      <field property=\"address\" depends=\"required\">\n        <arg key=\"userData.address.displayname\"/>\n      </field>\n      <field property=\"zip\" depends=\"intorblank,required\">\n        <arg key=\"userData.zip.displayname\"/>\n      </field>\n      <field property=\"city\" depends=\"required\">\n        <arg key=\"userData.city.displayname\"/>\n      </field>\n      <field property=\"phone\" depends=\"\">\n        <arg key=\"userData.phone.displayname\"/>\n      </field>\n      <field property=\"email\" depends=\"emailorblank\">\n        <arg key=\"userData.email.displayname\"/>\n      </field>\n      <field property=\"tmpAddress\" depends=\"\">\n        <arg key=\"userData.tmpaddress.displayname\"/>\n      </field>\n      <field property=\"tmpZip\" depends=\"intorblank\">\n        <arg key=\"userData.tmpzip.displayname\"/>\n      </field>\n      <field property=\"tmpCity\" depends=\"\">\n        <arg key=\"userData.tmpcity.displayname\"/>\n      </field>\n      <field property=\"tmpPhone\" depends=\"\">\n        <arg key=\"userData.tmpphone.displayname\"/>\n      </field>\n      <field property=\"jmbg\" depends=\"\">\n        <arg key=\"userData.jmbg.displayname\"/>\n      </field>\n      <field property=\"docNo\" depends=\"\">\n        <arg key=\"userData.docno.displayname\"/>\n      </field>\n      <field property=\"docCity\" depends=\"\">\n        <arg key=\"userData.doccity.displayname\"/>\n      </field>\n      <field property=\"country\" depends=\"\">\n        <arg key=\"userData.country.displayname\"/>\n      </field>\n      <field property=\"title\" depends=\"\">\n        <arg key=\"userData.title.displayname\"/>\n      </field>\n      <field property=\"occupation\" depends=\"\">\n        <arg key=\"userData.occupation.displayname\"/>\n      </field>\n      <field property=\"organization\" depends=\"\">\n        <arg key=\"userData.organization.displayname\"/>\n      </field>\n      <field property=\"eduLvl\" depends=\"\">\n        <arg key=\"userData.edulvl.displayname\"/>\n      </field>\n      <field property=\"classNo\" depends=\"\">\n        <arg key=\"userData.classno.displayname\"/>\n      </field>\n      <field property=\"indexNo\" depends=\"\">\n        <arg key=\"userData.indexno.displayname\"/>\n      </field>\n      <field property=\"note\" depends=\"\">\n        <arg key=\"userData.note.displayname\"/>\n      </field>\n      <field property=\"interests\" depends=\"\">\n        <arg key=\"userData.interests.displayname\"/>\n      </field>\n      <field property=\"languages\" depends=\"\">\n        <arg key=\"userData.language.displayname\"/>\n      </field>\n      <field property=\"dupDate\" depends=\"\">\n        <var>\n          <var-name>datePattern</var-name>\n          <var-value>dd.MM.yyyy</var-value>\n        </var>\n        <arg key=\"userData.dupdate.displayname\"/>\n      </field>\n      <field property=\"dupNo\" depends=\"intorblank\">\n        <arg key=\"userData.dupno.displayname\"/>\n      </field>\n    </form>\n    <form name=\"mmbrship\">\n      <field property=\"userID\" depends=\"userorblank,required\">\n        <arg key=\"mmbrship.userid.displayname\"/>\n      </field>\n      <field property=\"mmbrshipDate\" depends=\"required\">\n        <var>\n          <var-name>datePattern</var-name>\n          <var-value>dd.MM.yyyy</var-value>\n        </var>\n        <arg key=\"mmbrship.mmbrshipdate.displayname\"/>\n      </field>\n      <field property=\"mmbrshipUntilDate\" depends=\"required\">\n        <var>\n          <var-name>datePattern</var-name>\n          <var-value>dd.MM.yyyy</var-value>\n        </var>\n        <arg key=\"mmbrship.mmbrshipuntildate.displayname\"/>\n      </field>\n      <field property=\"mmbrshipCost\" depends=\"\">\n        <arg key=\"mmbrship.mmbrshipcost.displayname\"/>\n      </field>\n      <field property=\"mmbrshipReceiptId\" depends=\"\">\n        <arg key=\"mmbrship.mmbrshipreceiptid.displayname\"/>\n      </field>\n      <field property=\"mmbrType\" depends=\"required\">\n        <arg key=\"mmbrship.mmbrtype.displayname\"/>\n      </field>\n      <field property=\"userCateg\" depends=\"required\">\n        <arg key=\"mmbrship.usercateg.displayname\"/>\n      </field>\n    </form>\n  </formset>\n</form-validation>');
/*!40000 ALTER TABLE `configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duplicate`
--

DROP TABLE IF EXISTS `duplicate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_id` int(11) NOT NULL,
  `dup_no` int(11) NOT NULL,
  `dup_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `duplicate_FKIndex1` (`sys_id`),
  CONSTRAINT `duplicate_ibfk_1` FOREIGN KEY (`sys_id`) REFERENCES `users` (`sys_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duplicate`
--

LOCK TABLES `duplicate` WRITE;
/*!40000 ALTER TABLE `duplicate` DISABLE KEYS */;
/*!40000 ALTER TABLE `duplicate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_lvl`
--

DROP TABLE IF EXISTS `edu_lvl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_lvl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_lvl`
--

LOCK TABLES `edu_lvl` WRITE;
/*!40000 ALTER TABLE `edu_lvl` DISABLE KEYS */;
/*!40000 ALTER TABLE `edu_lvl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_storage`
--

DROP TABLE IF EXISTS `file_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_storage` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `rn` int(11) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `content_type` varchar(30) NOT NULL,
  `uploader` varchar(255) NOT NULL,
  `web_visibility` int(11) DEFAULT NULL,
  PRIMARY KEY (`file_id`),
  KEY `file_storage_rn` (`rn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_storage`
--

LOCK TABLES `file_storage` WRITE;
/*!40000 ALTER TABLE `file_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `sys_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `inst_name` varchar(255) DEFAULT NULL,
  `sign_date` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `sec_address` varchar(255) DEFAULT NULL,
  `sec_city` varchar(255) DEFAULT NULL,
  `sec_zip` int(11) DEFAULT NULL,
  `sec_phone` varchar(255) DEFAULT NULL,
  `cont_fname` varchar(255) DEFAULT NULL,
  `cont_lname` varchar(255) DEFAULT NULL,
  `cont_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sys_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lending`
--

DROP TABLE IF EXISTS `lending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ctlg_no` varchar(255) NOT NULL,
  `lend_date` datetime NOT NULL,
  `sys_id` int(11) NOT NULL,
  `location` int(11) DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  `resume_date` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `librarian_lend` varchar(255) DEFAULT NULL,
  `librarian_return` varchar(255) DEFAULT NULL,
  `librarian_resume` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lending_FKIndex1` (`sys_id`),
  KEY `lending_FKIndex2` (`location`),
  KEY `lending_index1401` (`ctlg_no`),
  CONSTRAINT `lending_ibfk_1` FOREIGN KEY (`sys_id`) REFERENCES `users` (`sys_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lending_ibfk_2` FOREIGN KEY (`location`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lending`
--

LOCK TABLES `lending` WRITE;
/*!40000 ALTER TABLE `lending` DISABLE KEYS */;
/*!40000 ALTER TABLE `lending` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `last_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership`
--

DROP TABLE IF EXISTS `membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_categ` int(11) NOT NULL,
  `mmbr_type` int(11) NOT NULL,
  `cost` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `membership_FKIndex1` (`user_categ`),
  KEY `membership_FKIndex2` (`mmbr_type`),
  CONSTRAINT `membership_ibfk_1` FOREIGN KEY (`user_categ`) REFERENCES `user_categs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `membership_ibfk_2` FOREIGN KEY (`mmbr_type`) REFERENCES `mmbr_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership`
--

LOCK TABLES `membership` WRITE;
/*!40000 ALTER TABLE `membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mmbr_types`
--

DROP TABLE IF EXISTS `mmbr_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mmbr_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `period` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mmbr_types`
--

LOCK TABLES `mmbr_types` WRITE;
/*!40000 ALTER TABLE `mmbr_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `mmbr_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picturebooks`
--

DROP TABLE IF EXISTS `picturebooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picturebooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_id` int(11) NOT NULL,
  `sdate` datetime NOT NULL,
  `lend_no` int(11) NOT NULL,
  `return_no` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sys_id` (`sys_id`),
  CONSTRAINT `picturebooks_ibfk_1` FOREIGN KEY (`sys_id`) REFERENCES `users` (`sys_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picturebooks`
--

LOCK TABLES `picturebooks` WRITE;
/*!40000 ALTER TABLE `picturebooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `picturebooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `places`
--

DROP TABLE IF EXISTS `places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zip` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `places`
--

LOCK TABLES `places` WRITE;
/*!40000 ALTER TABLE `places` DISABLE KEYS */;
/*!40000 ALTER TABLE `places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registar_autori`
--

DROP TABLE IF EXISTS `registar_autori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registar_autori` (
  `autor` varchar(255) DEFAULT NULL,
  `original` varchar(255) DEFAULT NULL,
  KEY `registar_autori_1` (`autor`),
  KEY `registar_autori_2` (`original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registar_autori`
--

LOCK TABLES `registar_autori` WRITE;
/*!40000 ALTER TABLE `registar_autori` DISABLE KEYS */;
/*!40000 ALTER TABLE `registar_autori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registar_kolektivni`
--

DROP TABLE IF EXISTS `registar_kolektivni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registar_kolektivni` (
  `kolektivac` varchar(255) DEFAULT NULL,
  KEY `registar_kolektivni_1` (`kolektivac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registar_kolektivni`
--

LOCK TABLES `registar_kolektivni` WRITE;
/*!40000 ALTER TABLE `registar_kolektivni` DISABLE KEYS */;
/*!40000 ALTER TABLE `registar_kolektivni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registar_odr`
--

DROP TABLE IF EXISTS `registar_odr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registar_odr` (
  `pojam` varchar(255) DEFAULT NULL,
  KEY `registar_odr_1` (`pojam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registar_odr`
--

LOCK TABLES `registar_odr` WRITE;
/*!40000 ALTER TABLE `registar_odr` DISABLE KEYS */;
/*!40000 ALTER TABLE `registar_odr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registar_pododr`
--

DROP TABLE IF EXISTS `registar_pododr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registar_pododr` (
  `pojam` varchar(255) DEFAULT NULL,
  KEY `registar_pododr_1` (`pojam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registar_pododr`
--

LOCK TABLES `registar_pododr` WRITE;
/*!40000 ALTER TABLE `registar_pododr` DISABLE KEYS */;
/*!40000 ALTER TABLE `registar_pododr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registar_udk`
--

DROP TABLE IF EXISTS `registar_udk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registar_udk` (
  `grupa` varchar(255) DEFAULT NULL,
  `opis` varchar(255) DEFAULT NULL,
  KEY `registar_udk_1` (`grupa`),
  KEY `registar_udk_2` (`opis`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registar_udk`
--

LOCK TABLES `registar_udk` WRITE;
/*!40000 ALTER TABLE `registar_udk` DISABLE KEYS */;
/*!40000 ALTER TABLE `registar_udk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registar_zbirke`
--

DROP TABLE IF EXISTS `registar_zbirke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registar_zbirke` (
  `naziv` varchar(255) DEFAULT NULL,
  KEY `registar_zbirke_1` (`naziv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registar_zbirke`
--

LOCK TABLES `registar_zbirke` WRITE;
/*!40000 ALTER TABLE `registar_zbirke` DISABLE KEYS */;
/*!40000 ALTER TABLE `registar_zbirke` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `signing`
--

DROP TABLE IF EXISTS `signing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sign_date` datetime DEFAULT NULL,
  `sys_id` int(11) NOT NULL,
  `location` int(11) DEFAULT NULL,
  `until_date` datetime DEFAULT NULL,
  `cost` decimal(10,0) DEFAULT NULL,
  `receipt_id` varchar(255) DEFAULT NULL,
  `librarian` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `signing_FKIndex1` (`sys_id`),
  KEY `signing_FKIndex2` (`location`),
  CONSTRAINT `signing_ibfk_1` FOREIGN KEY (`sys_id`) REFERENCES `users` (`sys_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `signing_ibfk_2` FOREIGN KEY (`location`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signing`
--

LOCK TABLES `signing` WRITE;
/*!40000 ALTER TABLE `signing` DISABLE KEYS */;
/*!40000 ALTER TABLE `signing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_categs`
--

DROP TABLE IF EXISTS `user_categs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_categs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `titles_no` int(11) DEFAULT NULL,
  `period` int(11) DEFAULT NULL,
  `max_period` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_categs`
--

LOCK TABLES `user_categs` WRITE;
/*!40000 ALTER TABLE `user_categs` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_categs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `sys_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization` int(11) DEFAULT NULL,
  `languages` int(11) DEFAULT NULL,
  `edu_lvl` int(11) DEFAULT NULL,
  `mmbr_type` int(11) DEFAULT NULL,
  `user_categ` int(11) DEFAULT NULL,
  `groups` int(11) DEFAULT NULL,
  `user_id` varchar(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `parent_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `jmbg` varchar(255) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `doc_no` varchar(255) DEFAULT NULL,
  `doc_city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `age` varchar(1) DEFAULT NULL,
  `sec_address` varchar(255) DEFAULT NULL,
  `sec_zip` int(11) DEFAULT NULL,
  `sec_city` varchar(255) DEFAULT NULL,
  `sec_phone` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `interests` varchar(255) DEFAULT NULL,
  `warning_ind` int(11) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `index_no` varchar(255) DEFAULT NULL,
  `class_no` int(11) DEFAULT NULL,
  `pass` varchar(255) DEFAULT NULL,
  `block_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sys_id`),
  KEY `users_FKIndex1` (`groups`),
  KEY `users_FKIndex2` (`user_categ`),
  KEY `users_FKIndex3` (`mmbr_type`),
  KEY `users_FKIndex4` (`edu_lvl`),
  KEY `users_FKIndex5` (`languages`),
  KEY `users_FKIndex6` (`organization`),
  KEY `users_index1378` (`user_id`),
  KEY `users_index1392` (`first_name`),
  KEY `users_index1393` (`last_name`),
  KEY `users_index1394` (`parent_name`),
  KEY `users_index1395` (`address`),
  KEY `users_index1396` (`city`),
  KEY `users_index1397` (`jmbg`),
  KEY `users_index1398` (`doc_no`),
  KEY `users_index1399` (`index_no`),
  KEY `users_index1400` (`pass`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`groups`) REFERENCES `groups` (`sys_id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`user_categ`) REFERENCES `user_categs` (`id`),
  CONSTRAINT `users_ibfk_3` FOREIGN KEY (`mmbr_type`) REFERENCES `mmbr_types` (`id`),
  CONSTRAINT `users_ibfk_4` FOREIGN KEY (`edu_lvl`) REFERENCES `edu_lvl` (`id`),
  CONSTRAINT `users_ibfk_5` FOREIGN KEY (`languages`) REFERENCES `languages` (`id`),
  CONSTRAINT `users_ibfk_6` FOREIGN KEY (`organization`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warn_counters`
--

DROP TABLE IF EXISTS `warn_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warn_counters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warn_year` int(11) NOT NULL,
  `wtype` int(11) NOT NULL,
  `last_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `warn_counters_FKIndex1` (`wtype`),
  CONSTRAINT `warn_counters_ibfk_1` FOREIGN KEY (`wtype`) REFERENCES `warning_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warn_counters`
--

LOCK TABLES `warn_counters` WRITE;
/*!40000 ALTER TABLE `warn_counters` DISABLE KEYS */;
/*!40000 ALTER TABLE `warn_counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warning_types`
--

DROP TABLE IF EXISTS `warning_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warning_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `wtext` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warning_types`
--

LOCK TABLES `warning_types` WRITE;
/*!40000 ALTER TABLE `warning_types` DISABLE KEYS */;
INSERT INTO `warning_types` VALUES (0,'Opomena','<war:root xmlns:war=\"warning\"><opomena><zaglavlje><naziv>Biblioteka grada Beograda</naziv><biblioteka>BIBLIOTEKA GRADA BEOGRADA</biblioteka><ogranak>Ogranak </ogranak><sifra>Šifra: 01</sifra><adresa>Knez Mihailova 56</adresa><mesto>11000 Beograd</mesto><bropomenetext/><bropomene/><naslov>OPOMENA</naslov><roktext>rok vraćanja:</roktext></zaglavlje><body><textiznad>Uvidom u našu evidenciju ustanovili smo da niste u predviđenom roku vratili pozajmljene knjigu-e:</textiznad><tabelazg><rbr>R.br.</rbr><naslov>Naslov</naslov><autor>Autor</autor><invbroj>Inv.broj</invbroj><signatura>Signatura</signatura><brdana>Br.dana prekoračenja</brdana></tabelazg><textispod>Molimo Vas da svoju obavezu isputnite u roku od 3 (tri) dana kako ne bi došlo do primene drugih predviđenih mera, kao i da prilikom vraćanja knjiga u Biblioteku grada Beograda, ul. Knez Mihailova 56, izvršite obavezu nadoknade troškova u iznosu:</textispod><nadoknada1>nadoknada za prekoračenje roka dnevno po svakoj knjizi:</nadoknada1><nadoknada2>nadoknada za troškove opomene:</nadoknada2><cena1>10</cena1><cena2>100</cena2><din>din.</din><dodatuma>Ukupno do</dodatuma><napomena>Napomena: Obavezno poneti i ovu opomenu.</napomena></body><podaci><prezime/><ime/><roditelj/><imeroditelja/><adresa/><mesto/><zip/><useridtext>br. članske karte:</useridtext><userid/><docno/><docmesto/><jmbg/></podaci><footer><pojedinacno/><trostrukotext/><biblioteka/><direktor/><ime/></footer></opomena><cirilica>0</cirilica></war:root>'),(1,'Opomena pred utuženje','<war:root xmlns:war=\"warning\"><opomena><zaglavlje><naziv>Библиотека града Београда</naziv><biblioteka>БИБЛИОТЕКА ГРАДА БЕОГРАДА</biblioteka><ogranak>Огранак</ogranak><sifra>Шифра: 01</sifra><adresa>Кнез Михаилова 56</adresa><mesto>11000 Београд</mesto><bropomenetext>Бр. опомене:</bropomenetext><bropomene/><naslov>ОПОМЕНА ПРЕД УТУЖЕЊЕ</naslov><roktext>рок враћања:</roktext></zaglavlje><body><textiznad>Увидом у нашу евиденцију установили смо да нисте у предвиђеном року вратили позајмљене књигу-е:</textiznad><tabelazg><rbr>r.br.</rbr><naslov>Naslov</naslov><autor>Autor</autor><invbroj>inv. br.</invbroj><signatura>Signatura</signatura><brdana>br. dana prekoračenja</brdana></tabelazg><textispod>Молимо вас да своју обавезу испуните у року од 3 (три) дана како не би дошло до примене других предвиђених мера, као и да приликом враћања књига у Библиотеку града Београда, ул. Кнез Михаилова 56, извршите обавезу надокнаде трошкова у износу:</textispod><nadoknada1>надокнада за прекорачење рока дневно по свакој књизи:</nadoknada1><nadoknada2>надокнада за трошкове опомене:</nadoknada2><cena1>10</cena1><cena2>200</cena2><din>дин.</din><dodatuma>Укупно до:</dodatuma><napomena/></body><podaci><prezime/><ime/><roditelj>roditelj:</roditelj><imeroditelja/><adresa/><mesto/><zip/><useridtext>br. članske karte:</useridtext><userid/><docno>br. lične karte:</docno><docmesto>mesto izdavanja:</docmesto><jmbg>JMBG:</jmbg></podaci><footer><pojedinacno>Појединачна вредност књига:</pojedinacno><trostrukotext>Трострука вредност књига:</trostrukotext><biblioteka>Библиотека града Београда</biblioteka><direktor>Директор</direktor><ime>Јован Радуловић</ime></footer></opomena><cirilica>0</cirilica></war:root>'),(2,'Opomena pred utuženje - treća lica','<war:root xmlns:war=\"warning\"><opomena><zaglavlje><naziv>Библиотека града Београда</naziv><biblioteka>БИБЛИОТЕКА ГРАДА БЕОГРАДА</biblioteka><ogranak>Огранак</ogranak><sifra>Шифра: 01</sifra><adresa>Кнез Михаилова 56</adresa><mesto>11000 Београд</mesto><bropomenetext>Бр. опомене:</bropomenetext><bropomene/><naslov>ОПОМЕНА ПРЕД УТУЖЕЊЕ</naslov><roktext>рок  враћања:</roktext></zaglavlje><body><textiznad>Увидом у нашу евиденцију установили смо да нисте у предвиђеном року вратили позајмљене књигу-е:</textiznad><tabelazg><rbr>r.br..</rbr><naslov>Naslov</naslov><autor>Autor</autor><invbroj>Inv. br.</invbroj><signatura>Signatura</signatura><brdana>Br. dana prekoračenja</brdana></tabelazg><textispod>Молимо вас да своју обавезу испуните у року од 3 (три) дана како не би дошло до примене других предвиђених мера, као и да приликом враћања књига у Библиотеку града Београда, ул. Кнез Михаилова 56, извршите обавезу надокнаде трошкова у износу:</textispod><nadoknada1>надокнада за прекорачење рока дневно по свакој књизи:</nadoknada1><nadoknada2>надокнада за трошкове опомене:</nadoknada2><cena1>10</cena1><cena2>200</cena2><din>din.</din><dodatuma>Укупно до:</dodatuma><napomena/></body><podaci><prezime/><ime/><roditelj>roditelj:</roditelj><imeroditelja/><adresa/><mesto/><zip/><useridtext>br. članske karte:</useridtext><userid/><docno>br.lične karte:</docno><docmesto>mesto izdavanja:</docmesto><jmbg>JMBG:</jmbg></podaci><footer><pojedinacno/><trostrukotext>Трострука вредност књига:</trostrukotext><biblioteka>Библиотека града Београда</biblioteka><direktor>Директор</direktor><ime>Јован Радуловић</ime></footer></opomena><cirilica>0</cirilica></war:root>');
/*!40000 ALTER TABLE `warning_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warnings`
--

DROP TABLE IF EXISTS `warnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warnings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lending_id` int(11) NOT NULL,
  `wdate` datetime NOT NULL,
  `wtype` int(11) NOT NULL,
  `warn_no` varchar(255) DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `warnings_FKIndex1` (`wtype`),
  KEY `warnings_FKIndex2` (`lending_id`),
  CONSTRAINT `warnings_ibfk_1` FOREIGN KEY (`wtype`) REFERENCES `warning_types` (`id`),
  CONSTRAINT `warnings_ibfk_2` FOREIGN KEY (`lending_id`) REFERENCES `lending` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warnings`
--

LOCK TABLES `warnings` WRITE;
/*!40000 ALTER TABLE `warnings` DISABLE KEYS */;
/*!40000 ALTER TABLE `warnings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-09 14:43:36
