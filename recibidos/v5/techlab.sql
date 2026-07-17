CREATE DATABASE  IF NOT EXISTS `techlab` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `techlab`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: techlab
-- ------------------------------------------------------
-- Server version	9.7.1

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- Table structure for table `auditorias_usuarios`
--

DROP TABLE IF EXISTS `auditorias_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditorias_usuarios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `accion` enum('DNI_EDITADO','ESTADO_ACTIVO_MODIFICADO','NOMBRE_APELLIDO_EDITADO','OWNER_TRANSFERIDO','PASSWORD_CAMBIADA','PASSWORD_OWNER_RECUPERADA','PASSWORD_RESTABLECIDA','REPORTE_ATENDIDO','REPORTE_CERRADO','REPORTE_CERRADO_AUTOMATICO','REPORTE_CREADO','REPORTE_MODIFICADO','REPORTE_TIEMPO_ELIMINADO','ROL_MODIFICADO','USUARIO_CREADO','USUARIO_ELIMINADO') NOT NULL,
  `detalles` varchar(255) DEFAULT NULL,
  `fecha_accion` datetime(6) NOT NULL,
  `operador_dni` varchar(255) NOT NULL,
  `operador_id` bigint NOT NULL,
  `operador_nombre_completo` varchar(255) NOT NULL,
  `operador_rol` varchar(255) NOT NULL,
  `reporte_espacio_id` bigint DEFAULT NULL,
  `reporte_id` bigint DEFAULT NULL,
  `reporte_tipo` enum('ACCESO_BLOQUEADO','BARRERA_FISICA','DIFICULTAD_ORIENTACION','OTROS','PROBLEMA_SENALETICA') DEFAULT NULL,
  `usuario_afectado_dni` varchar(255) DEFAULT NULL,
  `usuario_afectado_id` bigint DEFAULT NULL,
  `usuario_afectado_nombre_completo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_auditoria_fecha` (`fecha_accion`),
  KEY `idx_auditoria_operador` (`operador_id`),
  KEY `idx_auditoria_afectado` (`usuario_afectado_id`),
  KEY `idx_auditoria_reporte` (`reporte_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditorias_usuarios`
--

LOCK TABLES `auditorias_usuarios` WRITE;
/*!40000 ALTER TABLE `auditorias_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditorias_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conexiones`
--

DROP TABLE IF EXISTS `conexiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conexiones` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `accesible` bit(1) NOT NULL,
  `ancho` double DEFAULT NULL,
  `cumple_ley962` bit(1) DEFAULT NULL,
  `distancia` double NOT NULL,
  `estado` enum('ACTIVA','EN_REVISION','INHABILITADA') NOT NULL,
  `tipo_transito` enum('EXTERIOR','PASILLO','RAMPA','RIPIO') NOT NULL,
  `espacio_destino_id` bigint NOT NULL,
  `espacio_origen_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3iejieqmub54jolxcvnil49sp` (`espacio_destino_id`),
  KEY `FK758cjbyyydp1obpl7ugn5p9rw` (`espacio_origen_id`),
  CONSTRAINT `FK3iejieqmub54jolxcvnil49sp` FOREIGN KEY (`espacio_destino_id`) REFERENCES `espacios` (`id`),
  CONSTRAINT `FK758cjbyyydp1obpl7ugn5p9rw` FOREIGN KEY (`espacio_origen_id`) REFERENCES `espacios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conexiones`
--

LOCK TABLES `conexiones` WRITE;
/*!40000 ALTER TABLE `conexiones` DISABLE KEYS */;
INSERT INTO `conexiones` VALUES (1,_binary '',2.5,_binary '',15,'ACTIVA','EXTERIOR',30,31),(2,_binary '',2.5,_binary '',18,'ACTIVA','EXTERIOR',30,32),(3,_binary '',2.5,_binary '',20,'ACTIVA','EXTERIOR',30,33),(4,_binary '',2.5,_binary '',25,'ACTIVA','EXTERIOR',30,34),(5,_binary '',2.5,_binary '',22,'ACTIVA','EXTERIOR',30,35),(6,_binary '',1.67,_binary '\0',8,'ACTIVA','PASILLO',36,30),(7,_binary '',2.5,_binary '',10,'ACTIVA','EXTERIOR',41,30),(8,_binary '',1.67,_binary '\0',4,'ACTIVA','PASILLO',1,36),(9,_binary '',1.67,_binary '\0',5,'ACTIVA','PASILLO',2,36),(10,_binary '',1.67,_binary '\0',6,'ACTIVA','PASILLO',3,36),(11,_binary '',1.67,_binary '\0',7,'ACTIVA','PASILLO',4,36),(12,_binary '',1.67,_binary '\0',4,'ACTIVA','PASILLO',5,36),(13,_binary '',1.67,_binary '\0',5,'ACTIVA','PASILLO',6,36),(14,_binary '',3,_binary '',6,'ACTIVA','EXTERIOR',7,41),(15,_binary '',3,_binary '',5,'ACTIVA','EXTERIOR',8,41),(16,_binary '',1.5,_binary '\0',5,'ACTIVA','EXTERIOR',37,41),(17,_binary '',1.5,_binary '\0',2,'ACTIVA','PASILLO',9,37),(18,_binary '',1.5,_binary '\0',2,'ACTIVA','PASILLO',10,37),(19,_binary '',1.5,_binary '\0',3,'ACTIVA','PASILLO',11,37),(20,_binary '',1.5,_binary '\0',3,'ACTIVA','PASILLO',12,37),(21,_binary '',1.5,_binary '\0',4,'ACTIVA','PASILLO',13,37),(22,_binary '',1.5,_binary '\0',5,'ACTIVA','PASILLO',14,37),(23,_binary '',1.5,_binary '\0',6,'ACTIVA','PASILLO',15,37),(24,_binary '',1.5,_binary '\0',3,'ACTIVA','PASILLO',16,37),(25,_binary '',1.47,_binary '\0',4,'ACTIVA','PASILLO',38,37),(26,_binary '',1.47,_binary '\0',2,'ACTIVA','PASILLO',17,38),(27,_binary '',4,_binary '',5,'ACTIVA','EXTERIOR',42,37),(28,_binary '',4,_binary '',5,'ACTIVA','EXTERIOR',39,42),(29,_binary '',1.58,_binary '\0',3,'ACTIVA','PASILLO',18,39),(30,_binary '',1.58,_binary '\0',4,'ACTIVA','PASILLO',19,39),(31,_binary '',1.58,_binary '\0',5,'ACTIVA','PASILLO',20,39),(32,_binary '',1.58,_binary '\0',6,'ACTIVA','PASILLO',21,39),(33,_binary '',1.58,_binary '\0',7,'ACTIVA','PASILLO',22,39),(34,_binary '',1.58,_binary '\0',4,'ACTIVA','PASILLO',23,39),(35,_binary '',1.58,_binary '\0',5,'ACTIVA','PASILLO',24,39),(36,_binary '',1.58,_binary '\0',6,'ACTIVA','PASILLO',25,39),(37,_binary '',1.58,_binary '\0',3,'ACTIVA','PASILLO',26,39),(38,_binary '',1.58,_binary '\0',4,'ACTIVA','PASILLO',27,39),(39,_binary '',1.58,_binary '\0',5,'ACTIVA','PASILLO',28,39),(40,_binary '',1.58,_binary '\0',6,'ACTIVA','PASILLO',29,39),(41,_binary '',1.08,_binary '\0',2,'ACTIVA','PASILLO',40,39);
/*!40000 ALTER TABLE `conexiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `espacio_imagenes`
--

DROP TABLE IF EXISTS `espacio_imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espacio_imagenes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `url_foto` varchar(255) NOT NULL,
  `espacio_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjguw6wq289si41eaoe6fxi12a` (`espacio_id`),
  CONSTRAINT `FKjguw6wq289si41eaoe6fxi12a` FOREIGN KEY (`espacio_id`) REFERENCES `espacios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espacio_imagenes`
--

LOCK TABLES `espacio_imagenes` WRITE;
/*!40000 ALTER TABLE `espacio_imagenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `espacio_imagenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `espacios`
--

DROP TABLE IF EXISTS `espacios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espacios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `accesible` bit(1) NOT NULL,
  `coordenadax` double DEFAULT NULL,
  `coordenaday` double DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `estado` enum('ACTIVO','EN_MANTENIMIENTO','INHABILITADO') DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `sector` enum('ENTRADAS','SECTOR_1','SECTOR_2','SECTOR_3','SECTOR_4') NOT NULL,
  `tipo` enum('AULA','BANIO_ACCESIBLE','BANIO_FEMENINO','BANIO_MASCULINO','BANIO_MIXTO','ENTRADA_PRINCIPAL_CFP','ENTRADA_PRINCIPAL_PREDIO','ENTRADA_SECUNDARIA','LABORATORIO','OFICINA','PATIO','PUNTO_DE_PASO','SECRETARIA','TALLER') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espacios`
--

LOCK TABLES `espacios` WRITE;
/*!40000 ALTER TABLE `espacios` DISABLE KEYS */;
INSERT INTO `espacios` VALUES (1,_binary '',NULL,NULL,NULL,'ACTIVO','Electricidad','SECTOR_1','TALLER'),(2,_binary '',NULL,NULL,NULL,'ACTIVO','Herreria','SECTOR_1','TALLER'),(3,_binary '',NULL,NULL,NULL,'ACTIVO','Climatizacion','SECTOR_1','TALLER'),(4,_binary '',NULL,NULL,NULL,'ACTIVO','Serigrafia','SECTOR_1','TALLER'),(5,_binary '',NULL,NULL,NULL,'ACTIVO','Bano Sector 1 (grande)','SECTOR_1','BANIO_MIXTO'),(6,_binary '',NULL,NULL,NULL,'ACTIVO','Bano Sector 1 (chico)','SECTOR_1','BANIO_MIXTO'),(7,_binary '',1925,725,NULL,'ACTIVO','Carpinteria','SECTOR_2','TALLER'),(8,_binary '',NULL,NULL,NULL,'ACTIVO','Taller de bicicleteria','SECTOR_2','TALLER'),(9,_binary '',NULL,NULL,NULL,'ACTIVO','Informes - Regencia','SECTOR_3','OFICINA'),(10,_binary '',2545,385,NULL,'ACTIVO','Secretaria - Direccion','SECTOR_3','OFICINA'),(11,_binary '',2530,580,NULL,'ACTIVO','Oficina de estudiantes','SECTOR_3','OFICINA'),(12,_binary '',2310,525,NULL,'ACTIVO','Sala de personal','SECTOR_3','OFICINA'),(13,_binary '',2290,650,NULL,'ACTIVO','Área de talleres dinamicos','SECTOR_3','TALLER'),(14,_binary '',2300,430,NULL,'ACTIVO','Laboratorio de Informatica A','SECTOR_3','LABORATORIO'),(15,_binary '',2505,730,NULL,'ACTIVO','Laboratorio de Informatica B','SECTOR_3','LABORATORIO'),(16,_binary '',NULL,NULL,NULL,'ACTIVO','Archivo institucional','SECTOR_3','OFICINA'),(17,_binary '',2405,735,NULL,'ACTIVO','Espacio tecnologico multidisciplinar','SECTOR_3','TALLER'),(18,_binary '',2715,835,NULL,'ACTIVO','Aula 1','SECTOR_4','AULA'),(19,_binary '',2815,835,NULL,'ACTIVO','Aula 2','SECTOR_4','AULA'),(20,_binary '',2925,835,NULL,'ACTIVO','Aula 3 - SUM','SECTOR_4','AULA'),(21,_binary '',NULL,NULL,NULL,'ACTIVO','Aula 4','SECTOR_4','AULA'),(22,_binary '',NULL,NULL,NULL,'ACTIVO','Aula 5','SECTOR_4','AULA'),(23,_binary '',NULL,NULL,NULL,'ACTIVO','Gastronomia A','SECTOR_4','TALLER'),(24,_binary '',NULL,NULL,NULL,'ACTIVO','Gastronomia B','SECTOR_4','TALLER'),(25,_binary '',NULL,NULL,NULL,'ACTIVO','Gastronomia C','SECTOR_4','TALLER'),(26,_binary '',2905,620,NULL,'ACTIVO','Preceptoria EPS','SECTOR_4','OFICINA'),(27,_binary '',NULL,NULL,NULL,'ACTIVO','EPS - IFTS N5','SECTOR_4','OFICINA'),(28,_binary '',NULL,NULL,NULL,'ACTIVO','Bano Sector 4 (grande)','SECTOR_4','BANIO_MIXTO'),(29,_binary '',NULL,NULL,NULL,'ACTIVO','Bano Sector 4 (mediano)','SECTOR_4','BANIO_MIXTO'),(30,_binary '',2455,200,NULL,'ACTIVO','Entrada Principal CFP7','ENTRADAS','ENTRADA_PRINCIPAL_CFP'),(31,_binary '',NULL,NULL,NULL,'ACTIVO','Dragones','ENTRADAS','ENTRADA_PRINCIPAL_PREDIO'),(32,_binary '',NULL,NULL,NULL,'ACTIVO','Ramsay','ENTRADAS','ENTRADA_SECUNDARIA'),(33,_binary '',NULL,NULL,NULL,'ACTIVO','Juramento','ENTRADAS','ENTRADA_SECUNDARIA'),(34,_binary '',NULL,NULL,NULL,'ACTIVO','Echeverria','ENTRADAS','ENTRADA_SECUNDARIA'),(35,_binary '',NULL,NULL,NULL,'ACTIVO','Olazabal','ENTRADAS','ENTRADA_SECUNDARIA'),(36,_binary '',NULL,NULL,NULL,'ACTIVO','Pasillo Principal Sector 1','SECTOR_1','PUNTO_DE_PASO'),(37,_binary '',NULL,NULL,NULL,'ACTIVO','Pasillo Principal Sector 3','SECTOR_3','PUNTO_DE_PASO'),(38,_binary '',NULL,NULL,NULL,'ACTIVO','Pasillo Lateral Sector 3','SECTOR_3','PUNTO_DE_PASO'),(39,_binary '',NULL,NULL,NULL,'ACTIVO','Pasillo Principal Sector 4','SECTOR_4','PUNTO_DE_PASO'),(40,_binary '',NULL,NULL,NULL,'ACTIVO','Pasillo Lockers Sector 4','SECTOR_4','PUNTO_DE_PASO'),(41,_binary '',NULL,NULL,NULL,'ACTIVO','Patio entre Sector 2 y 3','SECTOR_2','PATIO'),(42,_binary '',NULL,NULL,NULL,'ACTIVO','Patio comunicante Sector 3 y 4','SECTOR_3','PATIO'),(43,_binary '',2455,200,NULL,'ACTIVO','Frente CFP7','ENTRADAS','PUNTO_DE_PASO');
/*!40000 ALTER TABLE `espacios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recorrido_tramos`
--

DROP TABLE IF EXISTS `recorrido_tramos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recorrido_tramos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `orden` int NOT NULL,
  `conexion_id` bigint NOT NULL,
  `recorrido_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKoae1atuksnii8tfwukv62ssxe` (`conexion_id`),
  KEY `FK5tgbrydtpak1q91i0tr9rgr38` (`recorrido_id`),
  CONSTRAINT `FK5tgbrydtpak1q91i0tr9rgr38` FOREIGN KEY (`recorrido_id`) REFERENCES `recorridos` (`id`),
  CONSTRAINT `FKoae1atuksnii8tfwukv62ssxe` FOREIGN KEY (`conexion_id`) REFERENCES `conexiones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recorrido_tramos`
--

LOCK TABLES `recorrido_tramos` WRITE;
/*!40000 ALTER TABLE `recorrido_tramos` DISABLE KEYS */;
/*!40000 ALTER TABLE `recorrido_tramos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recorridos`
--

DROP TABLE IF EXISTS `recorridos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recorridos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `accesible` bit(1) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recorridos`
--

LOCK TABLES `recorridos` WRITE;
/*!40000 ALTER TABLE `recorridos` DISABLE KEYS */;
/*!40000 ALTER TABLE `recorridos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportes`
--

DROP TABLE IF EXISTS `reportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` enum('EN_REVISION','PENDIENTE','RESUELTO') NOT NULL,
  `fecha_atencion` datetime(6) DEFAULT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `fecha_vencimiento` datetime(6) DEFAULT NULL,
  `minutos_estimados` int DEFAULT NULL,
  `tipo` enum('ACCESO_BLOQUEADO','BARRERA_FISICA','DIFICULTAD_ORIENTACION','OTROS','PROBLEMA_SENALETICA') NOT NULL,
  `atendido_por` bigint NOT NULL,
  `espacio_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reporte_estado_tipo` (`estado`,`tipo`),
  KEY `FKln9pamf7beds9txihg9m626oh` (`atendido_por`),
  KEY `FK2yvwjwkljwjxavu7h6fsevg23` (`espacio_id`),
  CONSTRAINT `FK2yvwjwkljwjxavu7h6fsevg23` FOREIGN KEY (`espacio_id`) REFERENCES `espacios` (`id`),
  CONSTRAINT `FKln9pamf7beds9txihg9m626oh` FOREIGN KEY (`atendido_por`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportes`
--

LOCK TABLES `reportes` WRITE;
/*!40000 ALTER TABLE `reportes` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `activo` bit(1) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `eliminado` bit(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `rol` enum('ADMIN','CHANGE_PASSWORD','OWNER','PERSONAL','SYSTEM') NOT NULL,
  `rol_original` enum('ADMIN','CHANGE_PASSWORD','OWNER','PERSONAL','SYSTEM') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKggd9d47p8x7m0ajavk1ayuyqs` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,_binary '','PROCESO','SYSTEM01',_binary '\0','2026-07-16 15:17:34.047976','SISTEMA','SISTEMA_NO_LOGUEABLE','SYSTEM',NULL),(2,_binary '','Fernández','11112222',_binary '\0','2026-07-16 15:17:34.167028','Martín','$2a$10$gpHw1r3Qs5UxHze0W1tPS.yaFoWZWxr8Wnf5HvswC/4rtjiYifXce','OWNER',NULL),(3,_binary '','Rodríguez','12345678',_binary '\0','2026-07-16 15:17:34.236025','Sofía','$2a$10$wXzU37frA8acfTxApbKsl.lroUwNTjse.AXl3GvDXomDvPt2BIM86','ADMIN',NULL),(4,_binary '','Gómez','23456789',_binary '\0','2026-07-16 15:17:34.316026','Diego Alejandro','$2a$10$ibGv65rGdp0kQl72EBbN2uOUBRrfplxrnKWiVQwMk/x7MULuuN68.','PERSONAL',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-16 15:18:57
