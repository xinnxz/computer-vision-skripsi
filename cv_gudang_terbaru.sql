-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: cv_gudang
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_bahan_baku`
--

DROP TABLE IF EXISTS `tb_bahan_baku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_bahan_baku` (
  `id_bahan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_bahan` varchar(50) NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `id_lokasi` int(10) NOT NULL,
  PRIMARY KEY (`id_bahan`),
  KEY `fk_lokasi` (`id_lokasi`),
  CONSTRAINT `fk_lokasi` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_bahan_baku`
--

LOCK TABLES `tb_bahan_baku` WRITE;
/*!40000 ALTER TABLE `tb_bahan_baku` DISABLE KEYS */;
INSERT INTO `tb_bahan_baku` VALUES (1,'Bawang merah','Bumbu Dapur Segar',1),(2,'Bawang putih','Bumbu Dapur Segar',1),(3,'Bihun','Bahan Makanan Kering',1),(4,'Bubuk ayam','Bumbu & Penyedap Kemasan',1),(5,'Bumbu masak daisys','Bumbu & Penyedap Kemasan',1),(6,'Bumbu racik','Bumbu & Penyedap Kemasan',1),(7,'Delta foods tongkol','Lauk & Protein',1),(8,'Garam','Bumbu Dapur Kering',1),(9,'Gula merah','Bumbu Dapur Kering',1),(10,'Gula putih','Bumbu Dapur Kering',1),(11,'Ikan teri dus','Lauk & Protein',1),(12,'Jahe','Bumbu Dapur Segar',1),(13,'Kecap manis','Saus & Kecap',1),(14,'Kencur','Bumbu Dapur Segar',1),(15,'Kerupuk jengkol','Bahan Makanan Kering',1),(16,'Kerupuk makaroni','Bahan Makanan Kering',1),(17,'Kerupuk rambak','Bahan Makanan Kering',1),(18,'Kunyit','Bumbu Dapur Segar',1),(19,'Lada putih','Bumbu Dapur Kering',1),(20,'Lengkuas','Bumbu Dapur Segar',1),(21,'Masako','Bumbu & Penyedap Kemasan',1),(22,'Masako dus','Bumbu & Penyedap Kemasan',1),(23,'Mie burung dara','Bahan Makanan Kering',1),(24,'Minyak fortune dus','Minyak & Lemak',1),(25,'Royco','Bumbu & Penyedap Kemasan',1),(26,'Salam','Bumbu Dapur Segar',1),(27,'Santan kelapa kara','Santan Kemasan',1),(28,'Santan rose brand','Santan Kemasan',1),(29,'Saori saos tiram','Saus & Kecap',1),(30,'Sasa','Bumbu & Penyedap Kemasan',1),(31,'Sasa bumbu kaldu ayam','Bumbu & Penyedap Kemasan',1),(32,'Sasa santan kelapa','Santan Kemasan',1),(33,'Saus cabe','Saus & Kecap',1),(34,'Sereh','Bumbu Dapur Segar',1),(35,'Sinti dus','Bumbu & Penyedap Kemasan',1),(36,'Susu realgood dus','Minuman Kemasan',1),(37,'Telur','Lauk & Protein',1),(38,'Telur asin','Lauk & Protein',1);
/*!40000 ALTER TABLE `tb_bahan_baku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_deteksi`
--

DROP TABLE IF EXISTS `tb_deteksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_deteksi` (
  `id_deteksi` int(11) NOT NULL AUTO_INCREMENT,
  `id_scan` int(11) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  `id_lokasi` int(10) NOT NULL,
  `id_bahan` int(11) DEFAULT NULL,
  `tanggal_deteksi` datetime NOT NULL DEFAULT current_timestamp(),
  `confidence` float DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `lokasi_seharusnya` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_deteksi`),
  KEY `fk_user` (`id_user`),
  KEY `fk_lokasi_deteksi` (`id_lokasi`),
  KEY `fk_scan_deteksi` (`id_scan`),
  CONSTRAINT `fk_lokasi_deteksi` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE,
  CONSTRAINT `fk_scan_deteksi` FOREIGN KEY (`id_scan`) REFERENCES `tb_scan` (`id_scan`) ON DELETE CASCADE,
  CONSTRAINT `fk_user` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_deteksi`
--

LOCK TABLES `tb_deteksi` WRITE;
/*!40000 ALTER TABLE `tb_deteksi` DISABLE KEYS */;
INSERT INTO `tb_deteksi` VALUES (1,NULL,6,1,1,'2026-07-21 00:36:09',0.9659,'SESUAI',NULL),(2,NULL,6,1,2,'2026-07-21 00:36:10',0.7985,'SESUAI',NULL),(3,NULL,6,1,4,'2026-07-21 00:36:10',0.8177,'TIDAK SESUAI',NULL),(4,1,6,2,6,'2026-07-21 04:42:49',0.883,'SESUAI','Rak B'),(5,1,6,1,2,'2026-07-21 04:42:49',0.7729,'SESUAI','Rak A'),(6,1,6,1,4,'2026-07-21 04:42:49',0.7102,'TIDAK SESUAI','Rak B'),(7,2,6,2,7,'2026-07-21 15:10:26',0.6512,'TIDAK SESUAI','Rak C'),(8,2,6,3,1,'2026-07-21 15:10:26',0.8666,'TIDAK SESUAI','Rak A'),(9,2,6,1,6,'2026-07-21 15:10:26',0.8529,'TIDAK SESUAI','Rak B'),(10,3,6,1,5,'2026-07-21 15:11:58',0.7994,'TIDAK SESUAI','Rak B'),(11,3,6,2,1,'2026-07-21 15:11:58',0.7359,'TIDAK SESUAI','Rak A'),(12,3,6,1,3,'2026-07-21 15:11:58',0.9644,'SESUAI','Rak A'),(13,8,6,3,11,'2026-07-21 15:42:09',0.665439,'SESUAI','Rak C'),(14,10,6,3,21,'2026-07-21 15:44:30',0.364733,'SESUAI','Rak C'),(15,10,6,3,1,'2026-07-21 15:44:30',0.318979,'TIDAK SESUAI','Rak A'),(16,11,6,2,1,'2026-07-21 15:48:02',0.428179,'TIDAK SESUAI','Rak A'),(17,11,6,3,28,'2026-07-21 15:48:02',0.6544,'TIDAK SESUAI','Rak B'),(18,11,6,3,28,'2026-07-21 15:48:02',0.484956,'TIDAK SESUAI','Rak B'),(19,13,6,1,22,'2026-07-21 20:11:42',0.917691,'SESUAI','Rak A'),(20,13,6,2,5,'2026-07-21 20:11:42',0.597972,'TIDAK SESUAI','Rak A'),(21,13,6,3,5,'2026-07-21 20:11:42',0.620863,'TIDAK SESUAI','Rak A'),(22,14,6,3,21,'2026-07-21 20:12:27',0.83231,'SESUAI','Rak C'),(23,16,6,1,8,'2026-07-22 10:49:22',0.96613,'SESUAI','Rak A'),(24,17,6,1,8,'2026-07-22 17:56:53',0.917423,'SESUAI','Rak A'),(25,24,6,2,9,'2026-07-22 18:00:08',0.967913,'TIDAK SESUAI','Rak A'),(26,25,6,3,9,'2026-07-22 18:00:28',0.956883,'TIDAK SESUAI','Rak A'),(27,26,6,3,10,'2026-07-22 18:00:44',0.983921,'TIDAK SESUAI','Rak A'),(28,27,6,1,10,'2026-07-22 18:00:53',0.983921,'SESUAI','Rak A'),(29,29,6,1,NULL,'2026-07-23 09:02:48',0.96094,'TIDAK DIKENAL','-'),(30,30,6,1,NULL,'2026-07-23 09:02:48',0.96094,'TIDAK DIKENAL','-'),(31,31,6,1,NULL,'2026-07-23 09:03:22',0.650389,'TIDAK DIKENAL','-'),(32,32,6,1,NULL,'2026-07-23 09:43:30',0.650389,'TIDAK DIKENAL','-'),(33,33,6,1,NULL,'2026-07-23 09:47:49',0.650389,'TIDAK DIKENAL','-'),(34,33,6,1,24,'2026-07-23 09:47:49',0.239117,'SESUAI','Rak A'),(35,34,6,3,NULL,'2026-07-23 09:50:38',0.650389,'TIDAK DIKENAL','-'),(36,34,6,3,24,'2026-07-23 09:50:38',0.239117,'TIDAK SESUAI','Rak A'),(37,34,6,3,NULL,'2026-07-23 09:50:38',0.0436055,'TIDAK DIKENAL','-'),(38,34,6,3,10,'2026-07-23 09:50:38',0.0184287,'TIDAK SESUAI','Rak A'),(39,35,6,3,NULL,'2026-07-23 09:52:01',0.0156656,'TIDAK DIKENAL','-'),(40,37,6,3,9,'2026-07-23 09:53:02',0.36278,'TIDAK SESUAI','Rak A'),(41,37,6,3,10,'2026-07-23 09:53:02',0.0322544,'TIDAK SESUAI','Rak A'),(42,37,6,3,20,'2026-07-23 09:53:02',0.0317083,'TIDAK SESUAI','Rak A'),(43,38,6,3,NULL,'2026-07-23 09:53:43',0.0633244,'TIDAK DIKENAL','-'),(44,38,6,3,13,'2026-07-23 09:53:43',0.0379864,'TIDAK SESUAI','Rak A'),(45,39,6,3,3,'2026-07-23 09:54:30',0.941047,'TIDAK SESUAI','Rak A'),(46,40,6,3,3,'2026-07-23 09:54:44',0.735075,'TIDAK SESUAI','Rak A'),(47,41,6,3,NULL,'2026-07-23 09:55:00',0.760706,'TIDAK DIKENAL','-'),(48,42,6,1,12,'2026-07-23 09:56:21',0.974582,'TIDAK SESUAI','Rak C'),(49,43,6,1,13,'2026-07-23 09:56:33',0.991848,'SESUAI','Rak A'),(50,46,6,1,3,'2026-07-29 08:18:23',0.87,'SESUAI','Rak A'),(51,46,6,1,3,'2026-07-29 08:18:23',0.87,'SESUAI','Rak A'),(52,46,6,1,3,'2026-07-29 08:18:23',0.86,'SESUAI','Rak A'),(53,46,6,1,3,'2026-07-29 08:18:23',0.85,'SESUAI','Rak A'),(54,46,6,1,3,'2026-07-29 08:18:23',0.85,'SESUAI','Rak A'),(55,46,6,3,30,'2026-07-29 08:18:23',0.85,'TIDAK SESUAI','Rak A'),(56,46,6,1,3,'2026-07-29 08:18:23',0.84,'SESUAI','Rak A'),(57,46,6,3,30,'2026-07-29 08:18:23',0.84,'TIDAK SESUAI','Rak A'),(58,46,6,3,30,'2026-07-29 08:18:23',0.84,'TIDAK SESUAI','Rak A'),(59,46,6,1,3,'2026-07-29 08:18:23',0.82,'SESUAI','Rak A'),(60,46,6,3,33,'2026-07-29 08:18:23',0.82,'TIDAK SESUAI','Rak A'),(61,46,6,2,27,'2026-07-29 08:18:23',0.8,'TIDAK SESUAI','Rak A'),(62,46,6,1,3,'2026-07-29 08:18:23',0.78,'SESUAI','Rak A'),(63,46,6,1,3,'2026-07-29 08:18:23',0.76,'SESUAI','Rak A'),(64,46,6,2,19,'2026-07-29 08:18:23',0.76,'TIDAK SESUAI','Rak A'),(65,46,6,2,5,'2026-07-29 08:18:23',0.75,'TIDAK SESUAI','Rak A'),(66,46,6,1,3,'2026-07-29 08:18:23',0.74,'SESUAI','Rak A'),(67,46,6,2,28,'2026-07-29 08:18:23',0.72,'TIDAK SESUAI','Rak A'),(68,46,6,1,3,'2026-07-29 08:18:23',0.7,'SESUAI','Rak A'),(69,46,6,3,13,'2026-07-29 08:18:23',0.67,'TIDAK SESUAI','Rak A'),(70,46,6,3,29,'2026-07-29 08:18:23',0.6,'TIDAK SESUAI','Rak A'),(71,46,6,1,3,'2026-07-29 08:18:23',0.51,'SESUAI','Rak A'),(72,46,6,1,3,'2026-07-29 08:18:23',0.47,'SESUAI','Rak A'),(73,46,6,3,13,'2026-07-29 08:18:23',0.47,'TIDAK SESUAI','Rak A'),(74,46,6,1,3,'2026-07-29 08:18:23',0.22,'SESUAI','Rak A'),(75,46,6,3,29,'2026-07-29 08:18:23',0.19,'TIDAK SESUAI','Rak A'),(76,47,6,1,3,'2026-08-01 12:32:07',0.778697,'SESUAI','Rak A');
/*!40000 ALTER TABLE `tb_deteksi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_lokasi_rak`
--

DROP TABLE IF EXISTS `tb_lokasi_rak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_lokasi_rak` (
  `id_lokasi` int(10) NOT NULL AUTO_INCREMENT,
  `nama_rak` varchar(50) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_lokasi`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_lokasi_rak`
--

LOCK TABLES `tb_lokasi_rak` WRITE;
/*!40000 ALTER TABLE `tb_lokasi_rak` DISABLE KEYS */;
INSERT INTO `tb_lokasi_rak` VALUES (1,'Rak A','Bumbu dapur kering (garam, gula, lada)'),(2,'Rak B','Minyak dan bahan cair (minyak goreng, kecap, saus)'),(3,'Rak C','Tepung dan bahan tabur (tepung terigu, maizena)');
/*!40000 ALTER TABLE `tb_lokasi_rak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_scan`
--

DROP TABLE IF EXISTS `tb_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_scan` (
  `id_scan` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_lokasi` int(10) DEFAULT NULL,
  `gambar` varchar(255) NOT NULL COMMENT 'Nama file gambar yang diupload',
  `gambar_hasil` varchar(255) DEFAULT NULL COMMENT 'Nama file gambar hasil deteksi (dengan bounding box)',
  `waktu_scan` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_scan`),
  KEY `fk_user_scan` (`id_user`),
  KEY `fk_lokasi_scan` (`id_lokasi`),
  CONSTRAINT `fk_lokasi_scan` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_scan` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_scan`
--

LOCK TABLES `tb_scan` WRITE;
/*!40000 ALTER TABLE `tb_scan` DISABLE KEYS */;
INSERT INTO `tb_scan` VALUES (1,6,NULL,'20260721_044249.jpg','result_20260721_044249.jpg','2026-07-21 04:42:49'),(2,6,NULL,'20260721_151026.jpg','result_20260721_151026.jpg','2026-07-21 15:10:26'),(3,6,NULL,'20260721_151158.jpg','result_20260721_151158.jpg','2026-07-21 15:11:58'),(8,6,NULL,'20260721_154205.png','result_20260721_154205.png','2026-07-21 15:42:09'),(9,6,NULL,'20260721_154225.png','result_20260721_154225.png','2026-07-21 15:42:26'),(10,6,NULL,'20260721_154427.png','result_20260721_154427.png','2026-07-21 15:44:30'),(11,6,NULL,'20260721_154801.png','result_20260721_154801.png','2026-07-21 15:48:02'),(12,6,NULL,'20260721_201106.jpeg','result_20260721_201106.jpeg','2026-07-21 20:11:12'),(13,6,NULL,'20260721_201142.jpeg','result_20260721_201142.jpeg','2026-07-21 20:11:42'),(14,6,NULL,'20260721_201226.jpeg','result_20260721_201226.jpeg','2026-07-21 20:12:27'),(15,6,NULL,'20260721_202949.jpeg','result_20260721_202949.jpeg','2026-07-21 20:29:50'),(16,6,1,'20260722_104919.jpg','result_20260722_104919.jpg','2026-07-22 10:49:22'),(17,6,1,'20260722_175649.jpg','result_20260722_175649.jpg','2026-07-22 17:56:53'),(18,6,1,'20260722_175704.jpg','result_20260722_175704.jpg','2026-07-22 17:57:05'),(19,6,1,'20260722_175711.jpg','result_20260722_175711.jpg','2026-07-22 17:57:12'),(20,6,1,'20260722_175717.jpg','result_20260722_175717.jpg','2026-07-22 17:57:18'),(21,6,3,'20260722_175723.jpg','result_20260722_175723.jpg','2026-07-22 17:57:24'),(22,6,2,'20260722_175727.jpg','result_20260722_175727.jpg','2026-07-22 17:57:28'),(23,6,2,'20260722_175750.jpg','result_20260722_175750.jpg','2026-07-22 17:57:51'),(24,6,2,'20260722_180007.jpg','result_20260722_180007.jpg','2026-07-22 18:00:08'),(25,6,3,'20260722_180027.jpg','result_20260722_180027.jpg','2026-07-22 18:00:28'),(26,6,3,'20260722_180044.jpg','result_20260722_180044.jpg','2026-07-22 18:00:44'),(27,6,1,'20260722_180053.jpg','result_20260722_180053.jpg','2026-07-22 18:00:53'),(28,6,1,'20260722_180542.jpg','result_20260722_180542.jpg','2026-07-22 18:05:43'),(29,6,1,'20260723_090243.jpg','result_20260723_090243.jpg','2026-07-23 09:02:48'),(30,6,1,'20260723_090246.jpg','result_20260723_090246.jpg','2026-07-23 09:02:48'),(31,6,1,'20260723_090322.png','result_20260723_090322.png','2026-07-23 09:03:22'),(32,6,1,'20260723_094327.png','result_20260723_094327.png','2026-07-23 09:43:30'),(33,6,1,'20260723_094747.png','result_20260723_094747.png','2026-07-23 09:47:49'),(34,6,3,'20260723_095035.png','result_20260723_095035.png','2026-07-23 09:50:38'),(35,6,3,'20260723_095200.jpeg','result_20260723_095200.jpeg','2026-07-23 09:52:01'),(36,6,3,'20260723_095248.jpeg','result_20260723_095248.jpeg','2026-07-23 09:52:48'),(37,6,3,'20260723_095301.jpeg','result_20260723_095301.jpeg','2026-07-23 09:53:02'),(38,6,3,'20260723_095341.jpeg','result_20260723_095341.jpeg','2026-07-23 09:53:43'),(39,6,3,'20260723_095428.jpg','result_20260723_095428.jpg','2026-07-23 09:54:30'),(40,6,3,'20260723_095444.jpg','result_20260723_095444.jpg','2026-07-23 09:54:44'),(41,6,3,'20260723_095459.jpg','result_20260723_095459.jpg','2026-07-23 09:55:00'),(42,6,1,'20260723_095620.jpg','result_20260723_095620.jpg','2026-07-23 09:56:21'),(43,6,1,'20260723_095633.jpg','result_20260723_095633.jpg','2026-07-23 09:56:33'),(44,6,1,'live_20260729_080022.jpg','live_20260729_080022.jpg','2026-07-29 08:00:22'),(45,6,1,'live_20260729_081740.jpg','live_20260729_081740.jpg','2026-07-29 08:17:40'),(46,6,1,'live_20260729_081823.jpg','live_20260729_081823.jpg','2026-07-29 08:18:23'),(47,6,1,'20260801_123202.jpg','result_20260801_123202.jpg','2026-08-01 12:32:07');
/*!40000 ALTER TABLE `tb_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_staff`
--

DROP TABLE IF EXISTS `tb_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_staff` (
  `id_staff` int(11) NOT NULL AUTO_INCREMENT,
  `nama_staff` varchar(100) NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  PRIMARY KEY (`id_staff`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_staff`
--

LOCK TABLES `tb_staff` WRITE;
/*!40000 ALTER TABLE `tb_staff` DISABLE KEYS */;
INSERT INTO `tb_staff` VALUES (1,'Siti Aminah','Kepala Gudang');
/*!40000 ALTER TABLE `tb_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `role` enum('admin','pic_gudang') NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (6,'admin','scrypt:32768:8:1$ZHRPgsGs7KYEg9ah$e7b3b314a2db628ef50af1c6ebde6220201979dc0ab37dc23cb3b8eb0b7a9252cff62958ecb0aaecfdfb410c2e787c96daec253710d92fb8fd62ba65f281be70','Administrator','admin'),(7,'lisna','scrypt:32768:8:1$B1Wv90jkUlf1dErx$dc8c67d33ed1a5575a7d54f54b7e79daeee47a7a31fb18d906967ab92fed9c89129ee78d9fd75caa06e1c1dcf2933f43f508b06ba3bdec53c8edb7d9f2896a9a','Lisnawati','pic_gudang');
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-01 12:37:10
