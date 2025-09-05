-- MySQL dump 10.11
--
-- Host: localhost    Database: videoclub
-- ------------------------------------------------------
-- Server version	5.0.51b-community-nt

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
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `actor` (
  `id_actor` int(11) NOT NULL auto_increment,
  `nombre_real` varchar(50) NOT NULL,
  `nombre_artistico` varchar(50) NOT NULL,
  PRIMARY KEY  (`id_actor`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` VALUES (1,'VICTOR MANUEL VAZQUEZ','TOMAS CRUZ'),(2,'SILVIA GUTIERREZ','SILVIA PINAL'),(3,'MARISOL PEREZ','MARISOL SANTACRUZ'),(4,'CINTHYA CANTERA','ANGELA PERALTA'),(5,'GABRIELA ALMENDARO','GABRIELA SPANICA'),(6,'GLORIA  QUINTERO','GLORIA GAYNOR'),(7,'MAURICIO POSTERNAK','MAURICIO GARCES'),(8,'JORGE ARECHIGA','JORGE PINEDO'),(9,'ELIZABETH ZENTENO','ELIZABETH TAYLOR');
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_prestamo`
--

DROP TABLE IF EXISTS `detalle_prestamo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `detalle_prestamo` (
  `id_prestamo` int(11) NOT NULL,
  `id_pelicula` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  KEY `id_prestamo` (`id_prestamo`),
  KEY `id_pelicula` (`id_pelicula`,`consecutivo`),
  CONSTRAINT `detalle_prestamo_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo` (`id_prestamo`),
  CONSTRAINT `detalle_prestamo_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id_pelicula`),
  CONSTRAINT `detalle_prestamo_ibfk_3` FOREIGN KEY (`id_pelicula`, `consecutivo`) REFERENCES `ejemplar` (`id_pelicula`, `consecutivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `detalle_prestamo`
--

LOCK TABLES `detalle_prestamo` WRITE;
/*!40000 ALTER TABLE `detalle_prestamo` DISABLE KEYS */;
INSERT INTO `detalle_prestamo` VALUES (1,1,1),(2,1,2),(5,1,3),(1,2,1),(9,2,2),(3,3,1),(4,3,2),(2,3,3),(7,4,1),(6,4,2),(2,4,3),(8,4,4),(7,5,1),(2,5,2),(7,5,3),(6,5,4),(10,1,5),(10,2,1),(11,1,1),(11,3,5),(11,4,4),(11,5,1),(12,5,2),(13,1,1),(13,4,1);
/*!40000 ALTER TABLE `detalle_prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `devolucion` (
  `id_devolucion` int(11) NOT NULL auto_increment,
  `id_prestamo` int(11) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY  (`id_devolucion`),
  KEY `id_prestamo` (`id_prestamo`),
  CONSTRAINT `devolucion_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo` (`id_prestamo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `devolucion`
--

LOCK TABLES `devolucion` WRITE;
/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
INSERT INTO `devolucion` VALUES (1,1,'2013-01-30'),(2,2,'2013-02-04'),(3,5,'2013-02-08'),(4,9,'2013-03-26'),(5,8,'2013-03-26'),(6,4,'2013-03-28'),(7,12,'2013-04-14');
/*!40000 ALTER TABLE `devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `director`
--

DROP TABLE IF EXISTS `director`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `director` (
  `id_director` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY  (`id_director`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `director`
--

LOCK TABLES `director` WRITE;
/*!40000 ALTER TABLE `director` DISABLE KEYS */;
INSERT INTO `director` VALUES (1,'LARISSA RODRIGUEZ'),(2,'IRMA ROBLES'),(3,'ISABEL JIMENEZ'),(4,'MONICA RODRIGUEZ'),(5,'ROSARIO GARCIA'),(6,'OSKAR ARANDA');
/*!40000 ALTER TABLE `director` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ejemplar`
--

DROP TABLE IF EXISTS `ejemplar`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ejemplar` (
  `id_pelicula` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  PRIMARY KEY  (`id_pelicula`,`consecutivo`),
  CONSTRAINT `ejemplar_ibfk_1` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id_pelicula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ejemplar`
--

LOCK TABLES `ejemplar` WRITE;
/*!40000 ALTER TABLE `ejemplar` DISABLE KEYS */;
INSERT INTO `ejemplar` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(4,1),(4,2),(4,3),(4,4),(5,1),(5,2),(5,3),(5,4);
/*!40000 ALTER TABLE `ejemplar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genero`
--

DROP TABLE IF EXISTS `genero`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `genero` (
  `id_genero` int(11) NOT NULL auto_increment,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY  (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `genero`
--

LOCK TABLES `genero` WRITE;
/*!40000 ALTER TABLE `genero` DISABLE KEYS */;
INSERT INTO `genero` VALUES (1,'Terror'),(2,'Comedia'),(3,'Drama'),(4,'Documental'),(5,'Accion');
/*!40000 ALTER TABLE `genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_espera`
--

DROP TABLE IF EXISTS `lista_espera`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `lista_espera` (
  `id_socio` int(11) NOT NULL,
  `id_pelicula` int(11) NOT NULL,
  `fecha` date NOT NULL,
  KEY `id_socio` (`id_socio`),
  KEY `id_pelicula` (`id_pelicula`),
  CONSTRAINT `lista_espera_ibfk_1` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`),
  CONSTRAINT `lista_espera_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id_pelicula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `lista_espera`
--

LOCK TABLES `lista_espera` WRITE;
/*!40000 ALTER TABLE `lista_espera` DISABLE KEYS */;
INSERT INTO `lista_espera` VALUES (10,1,'2013-01-28');
/*!40000 ALTER TABLE `lista_espera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participa`
--

DROP TABLE IF EXISTS `participa`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `participa` (
  `id_pelicula` int(11) NOT NULL,
  `id_actor` int(11) NOT NULL,
  KEY `id_actor` (`id_actor`),
  KEY `id_pelicula` (`id_pelicula`),
  CONSTRAINT `participa_ibfk_1` FOREIGN KEY (`id_actor`) REFERENCES `actor` (`id_actor`),
  CONSTRAINT `participa_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id_pelicula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `participa`
--

LOCK TABLES `participa` WRITE;
/*!40000 ALTER TABLE `participa` DISABLE KEYS */;
INSERT INTO `participa` VALUES (3,1),(5,1),(1,2),(2,2),(4,2),(5,2),(1,3),(4,3),(1,4),(2,4),(3,4),(2,5),(3,5),(4,5),(5,5),(5,6),(1,7),(2,7),(4,7),(1,8),(1,9),(3,9),(4,9),(5,9);
/*!40000 ALTER TABLE `participa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pelicula`
--

DROP TABLE IF EXISTS `pelicula`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pelicula` (
  `id_pelicula` int(11) NOT NULL auto_increment,
  `titulo` varchar(50) NOT NULL,
  `anio` int(4) NOT NULL,
  `id_genero` int(11) NOT NULL,
  `id_director` int(11) NOT NULL,
  `precio` double default NULL,
  PRIMARY KEY  (`id_pelicula`),
  UNIQUE KEY `titulo` (`titulo`),
  KEY `id_genero` (`id_genero`),
  KEY `id_director` (`id_director`),
  CONSTRAINT `pelicula_ibfk_1` FOREIGN KEY (`id_genero`) REFERENCES `genero` (`id_genero`),
  CONSTRAINT `pelicula_ibfk_2` FOREIGN KEY (`id_director`) REFERENCES `director` (`id_director`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `pelicula`
--

LOCK TABLES `pelicula` WRITE;
/*!40000 ALTER TABLE `pelicula` DISABLE KEYS */;
INSERT INTO `pelicula` VALUES (1,'Lo que el viento se llevo',1975,3,6,18),(2,'RAMBO III',1986,5,2,17.5),(3,'El infierno',2013,1,6,15),(4,'Cazafantasmas',1983,2,4,17.5),(5,'2000: Odisea en el Espacio',1997,4,1,18.5);
/*!40000 ALTER TABLE `pelicula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prestamo` (
  `id_prestamo` int(11) NOT NULL auto_increment,
  `fecha` date NOT NULL,
  `id_socio` int(11) NOT NULL,
  `f_Prog_Dev` date NOT NULL,
  `total` double default NULL,
  PRIMARY KEY  (`id_prestamo`),
  KEY `id_socio` (`id_socio`),
  CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` VALUES (1,'2013-01-26',1,'2013-01-30',35.5),(2,'2013-01-28',1,'2013-02-03',69),(3,'2013-01-28',2,'2013-02-05',15),(4,'2013-01-30',3,'2013-02-05',15),(5,'2013-02-06',4,'2013-02-07',18),(6,'2013-02-10',3,'2013-02-15',36),(7,'2013-02-11',8,'2013-02-17',54.5),(8,'2013-03-16',9,'2013-03-23',17.5),(9,'2013-03-26',7,'2013-04-07',17.5),(10,'2013-03-26',1,'2013-03-30',35.5),(11,'2013-04-01',8,'2013-04-10',69),(12,'2013-04-06',2,'2013-04-15',18.5),(13,'2013-04-16',13,'2013-04-27',35.5);
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socio`
---- MySQL dump 10.11
--
-- Host: localhost    Database: videoclub
-- ------------------------------------------------------
-- Server version	5.0.51b-community-nt

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
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `actor` (
  `id_actor` int(11) NOT NULL auto_increment,
  `nombre_real` varchar(50) NOT NULL,
  `nombre_artistico` varchar(50) NOT NULL,
  PRIMARY KEY  (`id_actor`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` VALUES (1,'VICTOR MANUEL VAZQUEZ','TOMAS CRUZ'),(2,'SILVIA GUTIERREZ','SILVIA PINAL'),(3,'MARISOL PEREZ','MARISOL SANTACRUZ'),(4,'CINTHYA CANTERA','ANGELA PERALTA'),(5,'GABRIELA ALMENDARO','GABRIELA SPANICA'),(6,'GLORIA  QUINTERO','GLORIA GAYNOR'),(7,'MAURICIO POSTERNAK','MAURICIO GARCES'),(8,'JORGE ARECHIGA','JORGE PINEDO'),(9,'ELIZABETH ZENTENO','ELIZABETH TAYLOR');
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_prestamo`
--

DROP TABLE IF EXISTS `detalle_prestamo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `detalle_prestamo` (
  `id_prestamo` int(11) NOT NULL,
  `id_pelicula` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  KEY `id_prestamo` (`id_prestamo`),
  KEY `id_pelicula` (`id_pelicula`,`consecutivo`),
  CONSTRAINT `detalle_prestamo_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo` (`id_prestamo`),
  CONSTRAINT `detalle_prestamo_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id_pelicula`),
  CONSTRAINT `detalle_prestamo_ibfk_3` FOREIGN KEY (`id_pelicula`, `consecutivo`) REFERENCES `ejemplar` (`id_pelicula`, `consecutivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `detalle_prestamo`
--

LOCK TABLES `detalle_prestamo` WRITE;
/*!40000 ALTER TABLE `detalle_prestamo` DISABLE KEYS */;
INSERT INTO `detalle_prestamo` VALUES (1,1,1),(2,1,2),(5,1,3),(1,2,1),(9,2,2),(3,3,1),(4,3,2),(2,3,3),(7,4,1),(6,4,2),(2,4,3),(8,4,4),(7,5,1),(2,5,2),(7,5,3),(6,5,4),(10,1,5),(10,2,1),(11,1,1),(11,3,5),(11,4,4),(11,5,1),(12,5,2),(13,1,1),(13,4,1);
/*!40000 ALTER TABLE `detalle_prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `devolucion` (
  `id_devolucion` int(11) NOT NULL auto_increment,
  `id_prestamo` int(11) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY  (`id_devolucion`),
  KEY `id_prestamo` (`id_prestamo`),
  CONSTRAINT `devolucion_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo` (`id_prestamo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `devolucion`
--

LOCK TABLES `devolucion` WRITE;
/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
INSERT INTO `devolucion` VALUES (1,1,'2013-01-30'),(2,2,'2013-02-04'),(3,5,'2013-02-08'),(4,9,'2013-03-26'),(5,8,'2013-03-26'),(6,4,'2013-03-28'),(7,12,'2013-04-14');
/*!40000 ALTER TABLE `devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `director`
--

DROP TABLE IF EXISTS `director`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `director` (
  `id_director` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY  (`id_director`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `director`
--

LOCK TABLES `director` WRITE;
/*!40000 ALTER TABLE `director` DISABLE KEYS */;
INSERT INTO `director` VALUES (1,'LARISSA RODRIGUEZ'),(2,'IRMA ROBLES'),(3,'ISABEL JIMENEZ'),(4,'MONICA RODRIGUEZ'),(5,'ROSARIO GARCIA'),(6,'OSKAR ARANDA');
/*!40000 ALTER TABLE `director` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ejemplar`
--

DROP TABLE IF EXISTS `ejemplar`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ejemplar` (
  `id_pelicula` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  PRIMARY KEY  (`id_pelicula`,`consecutivo`),
  CONSTRAINT `ejemplar_ibfk_1` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id_pelicula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ejemplar`
--

LOCK TABLES `ejemplar` WRITE;
/*!40000 ALTER TABLE `ejemplar` DISABLE KEYS */;
INSERT INTO `ejemplar` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(4,1),(4,2),(4,3),(4,4),(5,1),(5,2),(5,3),(5,4);
/*!40000 ALTER TABLE `ejemplar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genero`
--

DROP TABLE IF EXISTS `genero`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `genero` (
  `id_genero` int(11) NOT NULL auto_increment,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY  (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `genero`
--

LOCK TABLES `genero` WRITE;
/*!40000 ALTER TABLE `genero` DISABLE KEYS */;
INSERT INTO `genero` VALUES (1,'Terror'),(2,'Comedia'),(3,'Drama'),(4,'Documental'),(5,'Accion');
/*!40000 ALTER TABLE `genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_espera`
--

DROP TABLE IF EXISTS `lista_espera`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `lista_espera` (
  `id_socio` int(11) NOT NULL,
  `id_pelicula` int(11) NOT NULL,
  `fecha` date NOT NULL,
  KEY `id_socio` (`id_socio`),
  KEY `id_pelicula` (`id_pelicula`),
  CONSTRAINT `lista_espera_ibfk_1` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`),
  CONSTRAINT `lista_espera_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id_pelicula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `lista_espera`
--

LOCK TABLES `lista_espera` WRITE;
/*!40000 ALTER TABLE `lista_espera` DISABLE KEYS */;
INSERT INTO `lista_espera` VALUES (10,1,'2013-01-28');
/*!40000 ALTER TABLE `lista_espera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participa`
--

DROP TABLE IF EXISTS `participa`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `participa` (
  `id_pelicula` int(11) NOT NULL,
  `id_actor` int(11) NOT NULL,
  KEY `id_actor` (`id_actor`),
  KEY `id_pelicula` (`id_pelicula`),
  CONSTRAINT `participa_ibfk_1` FOREIGN KEY (`id_actor`) REFERENCES `actor` (`id_actor`),
  CONSTRAINT `participa_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id_pelicula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `participa`
--

LOCK TABLES `participa` WRITE;
/*!40000 ALTER TABLE `participa` DISABLE KEYS */;
INSERT INTO `participa` VALUES (3,1),(5,1),(1,2),(2,2),(4,2),(5,2),(1,3),(4,3),(1,4),(2,4),(3,4),(2,5),(3,5),(4,5),(5,5),(5,6),(1,7),(2,7),(4,7),(1,8),(1,9),(3,9),(4,9),(5,9);
/*!40000 ALTER TABLE `participa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pelicula`
--

DROP TABLE IF EXISTS `pelicula`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pelicula` (
  `id_pelicula` int(11) NOT NULL auto_increment,
  `titulo` varchar(50) NOT NULL,
  `anio` int(4) NOT NULL,
  `id_genero` int(11) NOT NULL,
  `id_director` int(11) NOT NULL,
  `precio` double default NULL,
  PRIMARY KEY  (`id_pelicula`),
  UNIQUE KEY `titulo` (`titulo`),
  KEY `id_genero` (`id_genero`),
  KEY `id_director` (`id_director`),
  CONSTRAINT `pelicula_ibfk_1` FOREIGN KEY (`id_genero`) REFERENCES `genero` (`id_genero`),
  CONSTRAINT `pelicula_ibfk_2` FOREIGN KEY (`id_director`) REFERENCES `director` (`id_director`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `pelicula`
--

LOCK TABLES `pelicula` WRITE;
/*!40000 ALTER TABLE `pelicula` DISABLE KEYS */;
INSERT INTO `pelicula` VALUES (1,'Lo que el viento se llevo',1975,3,6,18),(2,'RAMBO III',1986,5,2,17.5),(3,'El infierno',2013,1,6,15),(4,'Cazafantasmas',1983,2,4,17.5),(5,'2000: Odisea en el Espacio',1997,4,1,18.5);
/*!40000 ALTER TABLE `pelicula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prestamo` (
  `id_prestamo` int(11) NOT NULL auto_increment,
  `fecha` date NOT NULL,
  `id_socio` int(11) NOT NULL,
  `f_Prog_Dev` date NOT NULL,
  `total` double default NULL,
  PRIMARY KEY  (`id_prestamo`),
  KEY `id_socio` (`id_socio`),
  CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` VALUES (1,'2013-01-26',1,'2013-01-30',35.5),(2,'2013-01-28',1,'2013-02-03',69),(3,'2013-01-28',2,'2013-02-05',15),(4,'2013-01-30',3,'2013-02-05',15),(5,'2013-02-06',4,'2013-02-07',18),(6,'2013-02-10',3,'2013-02-15',36),(7,'2013-02-11',8,'2013-02-17',54.5),(8,'2013-03-16',9,'2013-03-23',17.5),(9,'2013-03-26',7,'2013-04-07',17.5),(10,'2013-03-26',1,'2013-03-30',35.5),(11,'2013-04-01',8,'2013-04-10',69),(12,'2013-04-06',2,'2013-04-15',18.5),(13,'2013-04-16',13,'2013-04-27',35.5);
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socio`
--

DROP TABLE IF EXISTS `socio`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `socio` (
  `id_socio` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` int(10) NOT NULL,
  PRIMARY KEY  (`id_socio`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `socio`
--

LOCK TABLES `socio` WRITE;
/*!40000 ALTER TABLE `socio` DISABLE KEYS */;
INSERT INTO `socio` VALUES (1,'DANIEL CRUZ','Cerrada de Torreon #123 Col. Cohauila',2147483647),(2,'BRIANDA LIZET GARCIA','Conocido',2147483647),(3,'DANIEL  GRANADOS','Conocido',2147483647),(4,'JESUS ANTONIO HERNANDEZ','Portales #213 Col. Centro',2147483647),(5,'JUAN CARLOS LEYVA','Av. Central #653 Col. Muzquiz',2147483647),(6,'MGUEL ANGEL LOPEZ','Conocido',2147483647),(7,'JOSE FRANCISCO MARTINEZ','Av. 604 #4563 Col. Aragon',2147483647),(8,'JOSE ANTONIO MARTINEZ','Av. Centenario s/n Col. Campestre',2147483647),(9,'LUIS ISSAC RIOS','Doroteo Arango #6520 Col. Centro',2147483647),(10,'DENISSE STEFANIE MILLAN','Lago de Patzcuaro #57A Col. Campestre',2147483647),(11,'ANGEL LUIS ALEJANDRO REYES','Conocido',2147483647),(12,'ATHALIA SARAI RIOS','Conocido',2147483647),(13,'ALBERTO EDUARDO ROMERO','Av. Siempreviva #100 Col. Aragon',2147483647),(14,'ADALBERTO AVILES','Cerrada de San Antonio #23 Col. Muzquiz',2147483647);
/*!40000 ALTER TABLE `socio` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-26 21:02:05

DROP TABLE IF EXISTS `socio`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `socio` (
  `id_socio` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` int(10) NOT NULL,
  PRIMARY KEY  (`id_socio`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `socio`
--

LOCK TABLES `socio` WRITE;
/*!40000 ALTER TABLE `socio` DISABLE KEYS */;
INSERT INTO `socio` VALUES (1,'DANIEL CRUZ','Cerrada de Torreon #123 Col. Cohauila',2147483647),(2,'BRIANDA LIZET GARCIA','Conocido',2147483647),(3,'DANIEL  GRANADOS','Conocido',2147483647),(4,'JESUS ANTONIO HERNANDEZ','Portales #213 Col. Centro',2147483647),(5,'JUAN CARLOS LEYVA','Av. Central #653 Col. Muzquiz',2147483647),(6,'MGUEL ANGEL LOPEZ','Conocido',2147483647),(7,'JOSE FRANCISCO MARTINEZ','Av. 604 #4563 Col. Aragon',2147483647),(8,'JOSE ANTONIO MARTINEZ','Av. Centenario s/n Col. Campestre',2147483647),(9,'LUIS ISSAC RIOS','Doroteo Arango #6520 Col. Centro',2147483647),(10,'DENISSE STEFANIE MILLAN','Lago de Patzcuaro #57A Col. Campestre',2147483647),(11,'ANGEL LUIS ALEJANDRO REYES','Conocido',2147483647),(12,'ATHALIA SARAI RIOS','Conocido',2147483647),(13,'ALBERTO EDUARDO ROMERO','Av. Siempreviva #100 Col. Aragon',2147483647),(14,'ADALBERTO AVILES','Cerrada de San Antonio #23 Col. Muzquiz',2147483647);
/*!40000 ALTER TABLE `socio` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-26 21:02:05
