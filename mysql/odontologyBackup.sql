-- MySQL dump 10.13  Distrib 9.4.0, for Linux (x86_64)
--
-- Host: localhost    Database: odontology_mysql
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `Appointment`
--
CREATE DATABASE odontology_mysql;
USE odontology_mysql;
DROP TABLE IF EXISTS `Appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Appointment` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `dentist_id` int NOT NULL,
  `date_time` timestamp NOT NULL,
  `reason` text,
  PRIMARY KEY (`appointment_id`),
  KEY `fk_appointment_patient` (`patient_id`),
  KEY `fk_appointment_dentist` (`dentist_id`),
  CONSTRAINT `fk_appointment_dentist` FOREIGN KEY (`dentist_id`) REFERENCES `Dentist` (`dentist_id`),
  CONSTRAINT `fk_appointment_patient` FOREIGN KEY (`patient_id`) REFERENCES `Patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Appointment`
--

LOCK TABLES `Appointment` WRITE;
/*!40000 ALTER TABLE `Appointment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DentalHistory`
--

DROP TABLE IF EXISTS `DentalHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DentalHistory` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `anamnesis` text,
  PRIMARY KEY (`history_id`),
  UNIQUE KEY `patient_id` (`patient_id`),
  CONSTRAINT `fk_history_patient` FOREIGN KEY (`patient_id`) REFERENCES `Patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DentalHistory`
--

LOCK TABLES `DentalHistory` WRITE;
/*!40000 ALTER TABLE `DentalHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `DentalHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DentalLab`
--

DROP TABLE IF EXISTS `DentalLab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DentalLab` (
  `lab_id` int NOT NULL AUTO_INCREMENT,
  `name` char(100) NOT NULL,
  `phone` char(20) DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DentalLab`
--

LOCK TABLES `DentalLab` WRITE;
/*!40000 ALTER TABLE `DentalLab` DISABLE KEYS */;
/*!40000 ALTER TABLE `DentalLab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DentalProcedure`
--

DROP TABLE IF EXISTS `DentalProcedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DentalProcedure` (
  `procedure_id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int NOT NULL,
  `treatment_id` int NOT NULL,
  `tooth_id` int DEFAULT NULL,
  `procedure_date` date NOT NULL,
  `observations` text,
  PRIMARY KEY (`procedure_id`),
  KEY `fk_procedure_plan` (`plan_id`),
  KEY `fk_procedure_treatment` (`treatment_id`),
  KEY `fk_procedure_tooth` (`tooth_id`),
  CONSTRAINT `fk_procedure_plan` FOREIGN KEY (`plan_id`) REFERENCES `TreatmentPlan` (`plan_id`),
  CONSTRAINT `fk_procedure_tooth` FOREIGN KEY (`tooth_id`) REFERENCES `Tooth` (`tooth_id`),
  CONSTRAINT `fk_procedure_treatment` FOREIGN KEY (`treatment_id`) REFERENCES `Treatment` (`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DentalProcedure`
--

LOCK TABLES `DentalProcedure` WRITE;
/*!40000 ALTER TABLE `DentalProcedure` DISABLE KEYS */;
/*!40000 ALTER TABLE `DentalProcedure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dentist`
--

DROP TABLE IF EXISTS `Dentist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dentist` (
  `dentist_id` int NOT NULL AUTO_INCREMENT,
  `first_name` char(100) NOT NULL,
  `last_name` char(100) NOT NULL,
  `specialty` char(100) DEFAULT NULL,
  PRIMARY KEY (`dentist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dentist`
--

LOCK TABLES `Dentist` WRITE;
/*!40000 ALTER TABLE `Dentist` DISABLE KEYS */;
/*!40000 ALTER TABLE `Dentist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Material`
--

DROP TABLE IF EXISTS `Material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Material` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `name` char(100) NOT NULL,
  `description` text,
  `stock` int DEFAULT NULL,
  PRIMARY KEY (`material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Material`
--

LOCK TABLES `Material` WRITE;
/*!40000 ALTER TABLE `Material` DISABLE KEYS */;
/*!40000 ALTER TABLE `Material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `first_name` char(100) NOT NULL,
  `last_name` char(100) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` char(20) DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` char(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_payment_plan` (`plan_id`),
  CONSTRAINT `fk_payment_plan` FOREIGN KEY (`plan_id`) REFERENCES `TreatmentPlan` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tooth`
--

DROP TABLE IF EXISTS `Tooth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tooth` (
  `tooth_id` int NOT NULL AUTO_INCREMENT,
  `tooth_number` char(10) NOT NULL,
  `description` text,
  PRIMARY KEY (`tooth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tooth`
--

LOCK TABLES `Tooth` WRITE;
/*!40000 ALTER TABLE `Tooth` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tooth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Treatment`
--

DROP TABLE IF EXISTS `Treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Treatment` (
  `treatment_id` int NOT NULL AUTO_INCREMENT,
  `name` char(100) NOT NULL,
  `description` text,
  `cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Treatment`
--

LOCK TABLES `Treatment` WRITE;
/*!40000 ALTER TABLE `Treatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TreatmentMaterial`
--

DROP TABLE IF EXISTS `TreatmentMaterial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TreatmentMaterial` (
  `treatment_id` int NOT NULL,
  `material_id` int NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  PRIMARY KEY (`treatment_id`,`material_id`),
  KEY `fk_tm_material` (`material_id`),
  CONSTRAINT `fk_tm_material` FOREIGN KEY (`material_id`) REFERENCES `Material` (`material_id`),
  CONSTRAINT `fk_tm_treatment` FOREIGN KEY (`treatment_id`) REFERENCES `Treatment` (`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TreatmentMaterial`
--

LOCK TABLES `TreatmentMaterial` WRITE;
/*!40000 ALTER TABLE `TreatmentMaterial` DISABLE KEYS */;
/*!40000 ALTER TABLE `TreatmentMaterial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TreatmentPlan`
--

DROP TABLE IF EXISTS `TreatmentPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TreatmentPlan` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `dentist_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` char(50) DEFAULT NULL,
  PRIMARY KEY (`plan_id`),
  KEY `fk_plan_patient` (`patient_id`),
  KEY `fk_plan_dentist` (`dentist_id`),
  CONSTRAINT `fk_plan_dentist` FOREIGN KEY (`dentist_id`) REFERENCES `Dentist` (`dentist_id`),
  CONSTRAINT `fk_plan_patient` FOREIGN KEY (`patient_id`) REFERENCES `Patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TreatmentPlan`
--

LOCK TABLES `TreatmentPlan` WRITE;
/*!40000 ALTER TABLE `TreatmentPlan` DISABLE KEYS */;
/*!40000 ALTER TABLE `TreatmentPlan` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-02 16:27:59
