-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: ic19cav
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Table structure for table `a_Alumnos`
--

 
CREATE DATABASE ic19cav;

DROP TABLE IF EXISTS `a_Alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `a_Alumnos` (
  `AlumnoID` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `FechaNacimiento` date DEFAULT NULL,
  `Genero` enum('M','F') DEFAULT NULL,
  PRIMARY KEY (`AlumnoID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a_Alumnos`
--

LOCK TABLES `a_Alumnos` WRITE;
/*!40000 ALTER TABLE `a_Alumnos` DISABLE KEYS */;
INSERT INTO `a_Alumnos` VALUES (1,'César Mauricio','2000-02-15','M'),(2,'Jaqueline Emilia','1999-09-23','F'),(3,'Raúl','2000-06-16','M'),(4,'Allan Jair','2000-07-12','M'),(5,'Emanuel Zuriel','2000-01-05','M'),(6,'Eduardo','2000-02-16','M'),(7,'Gaby','2000-10-10','F'),(8,'Jhoana','2000-01-31','F'),(9,'Jorge Emilio','2000-12-21','M'),(10,'Javier','2000-02-14','M');
/*!40000 ALTER TABLE `a_Alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `a_Ausencias`
--

DROP TABLE IF EXISTS `a_Ausencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `a_Ausencias` (
  `AusenciaID` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` date DEFAULT NULL,
  `AlumnoID` int(11) DEFAULT NULL,
  PRIMARY KEY (`AusenciaID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a_Ausencias`
--

LOCK TABLES `a_Ausencias` WRITE;
/*!40000 ALTER TABLE `a_Ausencias` DISABLE KEYS */;
INSERT INTO `a_Ausencias` VALUES (1,'2019-06-14',1),(2,'2019-06-15',1),(3,'2019-06-16',1),(4,'2019-06-17',1),(5,'2019-06-06',1),(6,'2019-09-07',2),(7,'2019-02-12',7),(8,'2019-04-12',5),(9,'2019-04-13',5);
/*!40000 ALTER TABLE `a_Ausencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `a_Calificaciones`
--

DROP TABLE IF EXISTS `a_Calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `a_Calificaciones` (
  `AlumnoID` int(11) NOT NULL,
  `ExamenID` int(11) NOT NULL,
  `Calificacion` decimal(4,2) NOT NULL,
  PRIMARY KEY (`AlumnoID`,`ExamenID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a_Calificaciones`
--

LOCK TABLES `a_Calificaciones` WRITE;
/*!40000 ALTER TABLE `a_Calificaciones` DISABLE KEYS */;
INSERT INTO `a_Calificaciones` VALUES (1,1,9.33),(1,2,7.57),(1,3,7.82),(1,4,10.00),(1,5,5.03),(1,6,6.60),(1,7,6.52),(1,8,6.89),(1,9,5.56),(1,10,7.12),(1,11,7.72),(1,12,5.57),(1,13,8.58),(1,14,7.19),(1,15,6.23),(1,16,6.45),(1,17,6.24),(1,18,5.33),(1,19,9.16),(1,20,8.53),(1,21,5.43),(1,22,6.91),(1,23,5.37),(1,24,7.71),(2,1,9.46),(2,2,5.66),(2,3,9.28),(2,4,7.07),(2,5,6.93),(2,6,5.91),(2,7,7.42),(2,8,5.40),(2,9,8.42),(2,10,5.03),(2,11,7.18),(2,12,8.26),(2,13,7.23),(2,14,5.93),(2,15,7.05),(2,16,7.10),(2,17,5.26),(2,18,9.43),(2,19,8.12),(2,20,8.77),(2,21,6.74),(2,22,9.85),(2,23,6.25),(2,24,7.51),(3,1,9.71),(3,2,6.59),(3,3,5.62),(3,4,8.58),(3,5,6.78),(3,6,5.13),(3,7,7.40),(3,8,5.42),(3,9,9.02),(3,10,5.51),(3,11,5.81),(3,12,8.86),(3,13,8.96),(3,14,5.18),(3,15,5.85),(3,16,7.58),(3,17,5.53),(3,18,7.89),(3,19,7.34),(3,20,5.30),(3,21,6.04),(3,22,5.56),(3,23,9.42),(3,24,6.71),(4,1,9.35),(4,2,5.72),(4,3,5.66),(4,4,9.08),(4,5,6.34),(4,6,7.48),(4,7,6.07),(4,8,8.05),(4,9,6.75),(4,10,9.36),(4,11,7.57),(4,12,9.41),(4,13,5.62),(4,14,9.40),(4,15,9.86),(4,16,7.51),(4,17,8.43),(4,18,9.95),(4,19,5.86),(4,20,8.45),(4,21,7.01),(4,22,5.04),(4,23,5.73),(4,24,8.37),(5,1,9.91),(5,2,9.87),(5,3,6.15),(5,4,9.79),(5,5,7.44),(5,6,8.42),(5,7,9.92),(5,8,9.64),(5,9,5.17),(5,10,8.67),(5,11,5.79),(5,12,8.11),(5,13,6.45),(5,14,9.04),(5,15,8.06),(5,16,8.61),(5,17,9.31),(5,18,9.44),(5,19,7.09),(5,20,6.80),(5,21,7.56),(5,22,9.71),(5,23,6.11),(5,24,6.51),(6,1,7.13),(6,2,7.19),(6,3,9.80),(6,4,7.64),(6,5,9.57),(6,6,5.52),(6,7,7.93),(6,8,6.93),(6,9,6.00),(6,10,7.32),(6,11,5.68),(6,12,7.88),(6,13,5.81),(6,14,7.55),(6,15,8.53),(6,16,6.71),(6,17,6.34),(6,18,8.71),(6,19,8.37),(6,20,8.84),(6,21,7.94),(6,22,9.30),(6,23,6.95),(6,24,9.84),(7,1,7.20),(7,2,8.96),(7,3,8.29),(7,4,9.22),(7,5,9.86),(7,6,8.38),(7,7,6.93),(7,8,7.67),(7,9,5.13),(7,10,7.71),(7,11,9.51),(7,12,5.15),(7,13,9.99),(7,14,8.45),(7,15,7.02),(7,16,8.02),(7,17,9.18),(7,18,8.11),(7,19,5.33),(7,20,9.15),(7,21,7.21),(7,22,7.24),(7,23,9.03),(7,24,7.76),(8,1,9.13),(8,2,6.70),(8,3,5.40),(8,4,5.77),(8,5,6.22),(8,6,8.01),(8,7,6.25),(8,8,7.17),(8,9,5.18),(8,10,7.97),(8,11,6.05),(8,12,7.83),(8,13,8.09),(8,14,8.39),(8,15,9.48),(8,16,6.72),(8,17,8.71),(8,18,7.26),(8,19,8.56),(8,20,9.63),(8,21,6.16),(8,22,6.82),(8,23,6.73),(8,24,6.40),(9,1,9.61),(9,2,8.36),(9,3,5.14),(9,4,7.00),(9,5,9.51),(9,6,7.17),(9,7,6.15),(9,8,5.67),(9,9,8.24),(9,10,6.96),(9,11,6.02),(9,12,9.47),(9,13,6.18),(9,14,9.56),(9,15,6.49),(9,16,6.30),(9,17,7.66),(9,18,7.20),(9,19,5.09),(9,20,8.04),(9,21,8.62),(9,22,7.06),(9,23,6.10),(9,24,5.59),(10,1,9.23),(10,2,8.39),(10,3,5.07),(10,4,9.03),(10,5,7.65),(10,6,8.10),(10,7,8.40),(10,8,9.09),(10,9,7.30),(10,10,6.72),(10,11,5.42),(10,12,5.40),(10,13,8.49),(10,14,7.62),(10,15,7.81),(10,16,6.18),(10,17,9.26),(10,18,7.76),(10,19,9.35),(10,20,7.32),(10,21,9.41),(10,22,7.66),(10,23,8.57),(10,24,6.15);
/*!40000 ALTER TABLE `a_Calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `a_Examenes`
--

DROP TABLE IF EXISTS `a_Examenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `a_Examenes` (
  `ExamenID` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` date NOT NULL,
  `MateriaID` int(11) DEFAULT NULL,
  `TipoID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ExamenID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a_Examenes`
--

LOCK TABLES `a_Examenes` WRITE;
/*!40000 ALTER TABLE `a_Examenes` DISABLE KEYS */;
INSERT INTO `a_Examenes` VALUES (1,'2020-01-10',1,1),(2,'2020-01-20',1,1),(3,'2019-02-15',1,2),(4,'2019-02-08',1,2),(5,'2019-04-16',1,3),(6,'2019-05-29',1,3),(7,'2020-01-14',2,1),(8,'2020-01-27',2,1),(9,'2019-02-21',2,2),(10,'2019-03-19',2,2),(11,'2019-04-12',2,3),(12,'2019-05-02',2,3),(13,'2020-01-03',3,1),(14,'2020-02-29',3,1),(15,'2019-02-05',3,2),(16,'2019-03-17',3,2),(17,'2019-04-30',3,3),(18,'2019-05-01',3,3),(19,'2020-01-04',4,1),(20,'2020-01-10',4,1),(21,'2019-02-25',4,2),(22,'2019-03-08',4,2),(23,'2019-04-27',4,3),(24,'2019-05-07',4,3);
/*!40000 ALTER TABLE `a_Examenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `a_Materias`
--

DROP TABLE IF EXISTS `a_Materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `a_Materias` (
  `MateriaID` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`MateriaID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a_Materias`
--

LOCK TABLES `a_Materias` WRITE;
/*!40000 ALTER TABLE `a_Materias` DISABLE KEYS */;
INSERT INTO `a_Materias` VALUES (1,'Cálculo'),(2,'Sistemas Analógicos'),(3,'Sistemas de Base de Datos'),(4,'Reflexion');
/*!40000 ALTER TABLE `a_Materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `a_TipoExamen`
--

DROP TABLE IF EXISTS `a_TipoExamen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `a_TipoExamen` (
  `TipoID` int(11) NOT NULL AUTO_INCREMENT,
  `Tipo` enum('S','M','F') NOT NULL,
  PRIMARY KEY (`TipoID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a_TipoExamen`
--

LOCK TABLES `a_TipoExamen` WRITE;
/*!40000 ALTER TABLE `a_TipoExamen` DISABLE KEYS */;
INSERT INTO `a_TipoExamen` VALUES (1,'S'),(2,'M'),(3,'F');
/*!40000 ALTER TABLE `a_TipoExamen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presidentes`
--

DROP TABLE IF EXISTS `presidentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presidentes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ap_paterno` varchar(30) DEFAULT NULL,
  `ap_materno` varchar(30) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `ciudad` varchar(30) DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `nacimiento` date NOT NULL,
  `muerte` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presidentes`
--

LOCK TABLES `presidentes` WRITE;
/*!40000 ALTER TABLE `presidentes` DISABLE KEYS */;
INSERT INTO `presidentes` VALUES (1,'Juárez','García','Benito','San Pablo Guelatao','Oaxaca','1806-03-21','1872-07-18'),(2,'Lerdo de Tejada','y Corral','Sebastián','Jalapa','Veracruz','1823-04-24','1889-04-21'),(3,'Iglesias','Inzurruaga','José María','México','D.F.','1823-01-05','1891-12-17'),(4,'Méndez','Sánchez','Juan Nepomuceno','Tetela de Ocampo','Puebla','1820-07-02','1894-11-29'),(5,'González','Flores','Manuel del Refugio','Matamoros','Tamaulipas','1833-06-17','1893-05-08'),(6,'Díaz','Mori','José de la Cruz Porfirio','Oaxaca','Oaxaca','1830-09-15','1915-07-02'),(7,'León','de la Barca','Francisco','Querétaro','Querétaro','1863-06-16','1939-09-23'),(8,'Madero','González','Francisco Ignacio','Parras','Coahuila','1873-10-30','1913-02-22'),(9,'Lascuráin','Paredes','Pedro José Domingo de la Calzada Manuel María','México','D.F.','1858-05-12','1952-06-21'),(10,'Huerta','Márquez','José Victoriano','Colotlán','Jalisco','1845-03-23','1916-01-03'),(11,'Carbajal','','Francisco Sebastián','Campeche','Campeche','1870-12-09','1932-09-30'),(12,'Carranza','Garza','Venustiano','Cuatro Ciénegas','Coahuila','1859-12-29','1920-05-21'),(13,'Gutiérrez','Ortiz','Eulalio','Ramos Arizpe','Coahuila','1881-02-02','1939-08-12'),(14,'González','Garza','Roque','Saltillo','Coahuila','1885-03-23','1962-11-12'),(15,'Lagos','Cházaro','Francisco','Tlacotalpan','Veracruz','1878-09-30','1932-11-13'),(16,'de la Huerta','Marcor','Felipe Adolfo','Hermosillo','Sonora','1881-05-26','1955-07-09'),(17,'Obregón','Salido','Álvaro','Navojoa','Sonora','1880-02-19','1928-07-17'),(18,'Elías','Calles','Plutarco','Guaymas','Sonora','1877-09-25','1945-10-19'),(19,'Portes','Gil','Emilio','Ciudad Victoria','Tamaulipas','1890-10-03','1978-12-10'),(20,'Ortiz','Rubio','Pascual','Morelia','Michoacán','1877-03-10','1963-11-04'),(21,'Rodríguez','Luján','Abelardo','Guaymas','Sonora','1889-05-12','1967-02-13'),(22,'Cárdenas','Del Río','Lázaro','Jiquilpan','Michoacán','1895-05-21','1970-10-19'),(23,'Ávila','Camacho','Manuel','Tezuitlán','Puebla','1897-04-24','1955-10-13'),(24,'Alemán','Valdés','Miguel','Sayula','Veracruz','1903-09-29','1983-05-14'),(25,'Ruiz','Cortines','Adolfo','Veracruz','Veracruz','1890-12-30','1973-12-03'),(26,'López','Mateos','Adolfo','Atizapán','México','1910-05-26','1969-09-22'),(27,'Díaz','Ordaz','Gustavo','Cd. Serdan','Puebla','1911-03-11','1979-07-15'),(28,'Echeverría','Álvarez','Luis','México','D.F.','1922-01-17',NULL),(29,'López','Portillo','José','México','D.F.','1920-06-16','2004-02-17'),(30,'De la Madrid','Hurtado','Miguel','Colima','Colima','1934-12-12','2012-04-01'),(31,'Salinas','de Gortari','Carlos','México','D.F.','1948-04-03',NULL),(32,'Zedillo','Ponce de León','Ernesto','México','D.F.','1951-12-17',NULL),(33,'Fox','Quezada','Vicente','México','D.F.','1942-07-02',NULL),(34,'Calderón','Hinojosa','Felipe','Morelia','Michoacán','1962-08-18',NULL),(35,'Peña','Nieto','Enrique','Atlacomulco','Mexico','1966-07-20',NULL),(36,'López','Obrador','Andrés Manuel','Macuspana','Tabasco','1953-11-13',NULL);
/*!40000 ALTER TABLE `presidentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vestudiantes`
--

DROP TABLE IF EXISTS `vestudiantes`;
/*!50001 DROP VIEW IF EXISTS `vestudiantes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vestudiantes` AS SELECT 
 1 AS `Nombre`,
 1 AS `Calificacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vestudiantes`
--

/*!50001 DROP VIEW IF EXISTS `vestudiantes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ic19cav`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vestudiantes` AS select `a_Alumnos`.`Nombre` AS `Nombre`,`a_Calificaciones`.`Calificacion` AS `Calificacion` from (`a_Alumnos` left join `a_Calificaciones` on((`a_Alumnos`.`AlumnoID` = `a_Calificaciones`.`AlumnoID`))) */;
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

-- Dump completed on 2020-02-27  8:52:08
