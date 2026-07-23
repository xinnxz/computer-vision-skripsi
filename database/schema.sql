-- ============================================================
-- Schema Database: cv_gudang
-- Sistem Informasi Gudang - Deteksi Bahan Baku YOLOv8
-- Universitas Suryakancana - Lisnawati (5520122156)
-- ============================================================

CREATE DATABASE IF NOT EXISTS `cv_gudang` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `cv_gudang`;

-- Tabel Pengguna
CREATE TABLE IF NOT EXISTS `tb_user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `role` enum('admin','pic_gudang') NOT NULL DEFAULT 'pic_gudang',
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Lokasi Rak
CREATE TABLE IF NOT EXISTS `tb_lokasi_rak` (
  `id_lokasi` int(10) NOT NULL AUTO_INCREMENT,
  `nama_rak` varchar(50) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_lokasi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Bahan Baku
CREATE TABLE IF NOT EXISTS `tb_bahan_baku` (
  `id_bahan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_bahan` varchar(50) NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `id_lokasi` int(10) NOT NULL,
  PRIMARY KEY (`id_bahan`),
  KEY `fk_lokasi_bahan` (`id_lokasi`),
  CONSTRAINT `fk_lokasi_bahan` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Riwayat Deteksi
CREATE TABLE IF NOT EXISTS `tb_deteksi` (
  `id_deteksi` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_lokasi` int(10) NOT NULL,
  `id_bahan` int(11) DEFAULT NULL,
  `tanggal_deteksi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confidence` float DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id_deteksi`),
  KEY `fk_user_deteksi` (`id_user`),
  KEY `fk_lokasi_deteksi` (`id_lokasi`),
  CONSTRAINT `fk_user_deteksi` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `fk_lokasi_deteksi2` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- DATA AWAL (Seed Data)
-- Password: admin123 (sudah di-hash dengan Werkzeug)
-- ============================================================
INSERT INTO `tb_user` (`username`, `password`, `nama`, `role`) VALUES
('admin', 'scrypt:32768:8:1$ZHRPgsGs7KYEg9ah$e7b3b314a2db628ef50af1c6ebde6220201979dc0ab37dc23cb3b8eb0b7a9252cff62958ecb0aaecfdfb410c2e787c96daec253710d92fb8fd62ba65f281be70', 'Administrator', 'admin'),
('lisna', 'scrypt:32768:8:1$B1Wv90jkUlf1dErx$dc8c67d33ed1a5575a7d54f54b7e79daeee47a7a31fb18d906967ab92fed9c89129ee78d9fd75caa06e1c1dcf2933f43f508b06ba3bdec53c8edb7d9f2896a9a', 'Lisnawati', 'pic_gudang');

-- Contoh data rak
INSERT INTO `tb_lokasi_rak` (`nama_rak`, `keterangan`) VALUES
('Rak A', 'Bumbu dapur kering (garam, gula, lada)'),
('Rak B', 'Minyak dan bahan cair (minyak goreng, kecap, saus)'),
('Rak C', 'Tepung dan bahan tabur (tepung terigu, maizena)');

-- Contoh data bahan baku
INSERT INTO `tb_bahan_baku` (`nama_bahan`, `kategori`, `id_lokasi`) VALUES
('Garam', 'Bumbu Kering', 1),
('Gula Pasir', 'Bumbu Kering', 1),
('Lada Bubuk', 'Bumbu Kering', 1),
('Minyak Goreng', 'Cairan', 2),
('Kecap Manis', 'Cairan', 2),
('Saus Tiram', 'Cairan', 2),
('Tepung Terigu', 'Bahan Tabur', 3),
('Tepung Maizena', 'Bahan Tabur', 3);
