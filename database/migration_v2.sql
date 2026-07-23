-- ============================================================
-- MIGRATION v2: Tambah tabel tb_scan dan update tb_deteksi
-- Sistem Informasi Gudang - Deteksi Bahan Baku YOLOv8
-- ============================================================

USE `cv_gudang`;

-- 1. Buat tabel tb_scan (metadata sesi scan)
CREATE TABLE IF NOT EXISTS `tb_scan` (
  `id_scan` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_lokasi` int(10) NOT NULL,
  `gambar` varchar(255) NOT NULL COMMENT 'Nama file gambar yang diupload',
  `gambar_hasil` varchar(255) DEFAULT NULL COMMENT 'Nama file gambar hasil deteksi (dengan bounding box)',
  `waktu_scan` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_scan`),
  KEY `fk_user_scan` (`id_user`),
  KEY `fk_lokasi_scan` (`id_lokasi`),
  CONSTRAINT `fk_user_scan` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `fk_lokasi_scan` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tambah kolom id_scan dan lokasi_seharusnya pada tb_deteksi
ALTER TABLE `tb_deteksi`
  ADD COLUMN `id_scan` int(11) DEFAULT NULL AFTER `id_deteksi`,
  ADD COLUMN `lokasi_seharusnya` varchar(100) DEFAULT NULL AFTER `status`,
  ADD KEY `fk_scan_deteksi` (`id_scan`),
  ADD CONSTRAINT `fk_scan_deteksi` FOREIGN KEY (`id_scan`) REFERENCES `tb_scan` (`id_scan`) ON DELETE CASCADE;
