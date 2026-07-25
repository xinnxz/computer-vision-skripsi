-- ============================================================
-- FULL UNIFIED SCHEMA DATABASE: cv_gudang (v2.0)
-- Sistem Informasi Gudang - Deteksi Bahan Baku YOLOv8
-- Universitas Suryakancana - Lisnawati (5520122156)
-- ============================================================
-- File ini sudah menggabungkan schema.sql dan migration_v2.sql
-- Cukup import 1 file ini saja di phpMyAdmin!
-- ============================================================

CREATE DATABASE IF NOT EXISTS `cv_gudang` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `cv_gudang`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `tb_deteksi`;
DROP TABLE IF EXISTS `tb_scan`;
DROP TABLE IF EXISTS `tb_bahan_baku`;
DROP TABLE IF EXISTS `tb_lokasi_rak`;
DROP TABLE IF EXISTS `tb_user`;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Tabel Pengguna
CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `role` enum('admin','pic_gudang') NOT NULL DEFAULT 'pic_gudang',
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabel Lokasi Rak
CREATE TABLE `tb_lokasi_rak` (
  `id_lokasi` int(10) NOT NULL AUTO_INCREMENT,
  `nama_rak` varchar(50) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_lokasi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabel Bahan Baku
CREATE TABLE `tb_bahan_baku` (
  `id_bahan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_bahan` varchar(50) NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `id_lokasi` int(10) NOT NULL,
  PRIMARY KEY (`id_bahan`),
  KEY `fk_lokasi_bahan` (`id_lokasi`),
  CONSTRAINT `fk_lokasi_bahan` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Tabel Scan (Metadata Sesi Scan)
CREATE TABLE `tb_scan` (
  `id_scan` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_lokasi` int(10) NOT NULL,
  `gambar` varchar(255) NOT NULL COMMENT 'Nama file gambar yang diupload',
  `gambar_hasil` varchar(255) DEFAULT NULL COMMENT 'Nama file gambar hasil deteksi',
  `waktu_scan` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_scan`),
  KEY `fk_user_scan` (`id_user`),
  KEY `fk_lokasi_scan` (`id_lokasi`),
  CONSTRAINT `fk_user_scan` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `fk_lokasi_scan` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Tabel Riwayat Deteksi
CREATE TABLE `tb_deteksi` (
  `id_deteksi` int(11) NOT NULL AUTO_INCREMENT,
  `id_scan` int(11) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  `id_lokasi` int(10) NOT NULL,
  `id_bahan` int(11) DEFAULT NULL,
  `tanggal_deteksi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confidence` float DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `lokasi_seharusnya` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_deteksi`),
  KEY `fk_scan_deteksi` (`id_scan`),
  KEY `fk_user_deteksi` (`id_user`),
  KEY `fk_lokasi_deteksi` (`id_lokasi`),
  CONSTRAINT `fk_scan_deteksi` FOREIGN KEY (`id_scan`) REFERENCES `tb_scan` (`id_scan`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_deteksi` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `fk_lokasi_deteksi2` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- DATA AWAL (Seed Data)
-- Password: admin123
-- ============================================================
INSERT INTO `tb_user` (`username`, `password`, `nama`, `role`) VALUES
('admin', 'scrypt:32768:8:1$ZHRPgsGs7KYEg9ah$e7b3b314a2db628ef50af1c6ebde6220201979dc0ab37dc23cb3b8eb0b7a9252cff62958ecb0aaecfdfb410c2e787c96daec253710d92fb8fd62ba65f281be70', 'Administrator', 'admin'),
('lisna', 'scrypt:32768:8:1$B1Wv90jkUlf1dErx$dc8c67d33ed1a5575a7d54f54b7e79daeee47a7a31fb18d906967ab92fed9c89129ee78d9fd75caa06e1c1dcf2933f43f508b06ba3bdec53c8edb7d9f2896a9a', 'Lisnawati', 'pic_gudang');

INSERT INTO `tb_lokasi_rak` (`id_lokasi`, `nama_rak`, `keterangan`) VALUES
(1, 'Rak A - Bumbu & Kecap', 'Area penyimpanan bumbu dapur, kecap, saus, dan penyedap rasa'),
(2, 'Rak B - Bahan Pokok & Kering', 'Area penyimpanan minyak goreng, beras, terigu, dan mi kering'),
(3, 'Rak C - Bahan Basah & Segar', 'Area penyimpanan sayuran segar, bawang, daging, dan ikan');

INSERT INTO `tb_bahan_baku` (`nama_bahan`, `kategori`, `id_lokasi`) VALUES
('Kecap Bango', 'Bumbu & Saus', 1),
('Kecap ABC', 'Bumbu & Saus', 1),
('Saus Sambal ABC', 'Bumbu & Saus', 1),
('Masako Sapi', 'Penyedap Rasa', 1),
('Masako Ayam', 'Penyedap Rasa', 1),
('Royco Ayam', 'Penyedap Rasa', 1),
('Sasa Santan', 'Bahan Masak', 1),
('Garam Kapal', 'Bumbu Dapur', 1),
('Gula Pasir', 'Bahan Pokok', 2),
('Minyak Bimoli 2L', 'Minyak Goreng', 2),
('Minyak Fortune 2L', 'Minyak Goreng', 2),
('Tepung Segitiga Biru', 'Tepung', 2),
('Indomie Goreng', 'Mi Kering', 2),
('Indomie Ayam Bawang', 'Mi Kering', 2),
('Bawang Merah', 'Bahan Segar', 3),
('Bawang Putih', 'Bahan Segar', 3),
('Cabai Merah', 'Bahan Segar', 3),
('Telur Ayam', 'Bahan Segar', 3);
