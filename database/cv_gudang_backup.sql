DROP TABLE IF EXISTS `tb_bahan_baku`;
CREATE TABLE `tb_bahan_baku` (
  `id_bahan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_bahan` varchar(50) NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `id_lokasi` int(10) NOT NULL,
  PRIMARY KEY (`id_bahan`),
  KEY `fk_lokasi` (`id_lokasi`),
  CONSTRAINT `fk_lokasi` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasi_rak` (`id_lokasi`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (1, 'Bawang merah', 'Bumbu Dapur Segar', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (2, 'Bawang putih', 'Bumbu Dapur Segar', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (3, 'Bihun', 'Bahan Makanan Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (4, 'Bubuk ayam', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (5, 'Bumbu masak daisys', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (6, 'Bumbu racik', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (7, 'Delta foods tongkol', 'Lauk & Protein', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (8, 'Garam', 'Bumbu Dapur Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (9, 'Gula merah', 'Bumbu Dapur Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (10, 'Gula putih', 'Bumbu Dapur Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (11, 'Ikan teri dus', 'Lauk & Protein', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (12, 'Jahe', 'Bumbu Dapur Segar', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (13, 'Kecap manis', 'Saus & Kecap', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (14, 'Kencur', 'Bumbu Dapur Segar', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (15, 'Kerupuk jengkol', 'Bahan Makanan Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (16, 'Kerupuk makaroni', 'Bahan Makanan Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (17, 'Kerupuk rambak', 'Bahan Makanan Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (18, 'Kunyit', 'Bumbu Dapur Segar', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (19, 'Lada putih', 'Bumbu Dapur Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (20, 'Lengkuas', 'Bumbu Dapur Segar', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (21, 'Masako', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (22, 'Masako dus', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (23, 'Mie burung dara', 'Bahan Makanan Kering', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (24, 'Minyak fortune dus', 'Minyak & Lemak', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (25, 'Royco', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (26, 'Salam', 'Bumbu Dapur Segar', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (27, 'Santan kelapa kara', 'Santan Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (28, 'Santan rose brand', 'Santan Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (29, 'Saori saos tiram', 'Saus & Kecap', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (30, 'Sasa', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (31, 'Sasa bumbu kaldu ayam', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (32, 'Sasa santan kelapa', 'Santan Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (33, 'Saus cabe', 'Saus & Kecap', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (34, 'Sereh', 'Bumbu Dapur Segar', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (35, 'Sinti dus', 'Bumbu & Penyedap Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (36, 'Susu realgood dus', 'Minuman Kemasan', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (37, 'Telur', 'Lauk & Protein', 1);
INSERT INTO `tb_bahan_baku` (`id_bahan`, `nama_bahan`, `kategori`, `id_lokasi`) VALUES (38, 'Telur asin', 'Lauk & Protein', 1);

DROP TABLE IF EXISTS `tb_deteksi`;
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
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (1, NULL, 6, 1, 1, '2026-07-21 00:36:09', 0.9659, 'SESUAI', NULL);
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (2, NULL, 6, 1, 2, '2026-07-21 00:36:10', 0.7985, 'SESUAI', NULL);
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (3, NULL, 6, 1, 4, '2026-07-21 00:36:10', 0.8177, 'TIDAK SESUAI', NULL);
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (4, 1, 6, 2, 6, '2026-07-21 04:42:49', 0.883, 'SESUAI', 'Rak B');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (5, 1, 6, 1, 2, '2026-07-21 04:42:49', 0.7729, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (6, 1, 6, 1, 4, '2026-07-21 04:42:49', 0.7102, 'TIDAK SESUAI', 'Rak B');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (7, 2, 6, 2, 7, '2026-07-21 15:10:26', 0.6512, 'TIDAK SESUAI', 'Rak C');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (8, 2, 6, 3, 1, '2026-07-21 15:10:26', 0.8666, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (9, 2, 6, 1, 6, '2026-07-21 15:10:26', 0.8529, 'TIDAK SESUAI', 'Rak B');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (10, 3, 6, 1, 5, '2026-07-21 15:11:58', 0.7994, 'TIDAK SESUAI', 'Rak B');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (11, 3, 6, 2, 1, '2026-07-21 15:11:58', 0.7359, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (12, 3, 6, 1, 3, '2026-07-21 15:11:58', 0.9644, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (13, 8, 6, 3, 11, '2026-07-21 15:42:09', 0.665439, 'SESUAI', 'Rak C');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (14, 10, 6, 3, 21, '2026-07-21 15:44:30', 0.364733, 'SESUAI', 'Rak C');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (15, 10, 6, 3, 1, '2026-07-21 15:44:30', 0.318979, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (16, 11, 6, 2, 1, '2026-07-21 15:48:02', 0.428179, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (17, 11, 6, 3, 28, '2026-07-21 15:48:02', 0.6544, 'TIDAK SESUAI', 'Rak B');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (18, 11, 6, 3, 28, '2026-07-21 15:48:02', 0.484956, 'TIDAK SESUAI', 'Rak B');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (19, 13, 6, 1, 22, '2026-07-21 20:11:42', 0.917691, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (20, 13, 6, 2, 5, '2026-07-21 20:11:42', 0.597972, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (21, 13, 6, 3, 5, '2026-07-21 20:11:42', 0.620863, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (22, 14, 6, 3, 21, '2026-07-21 20:12:27', 0.83231, 'SESUAI', 'Rak C');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (23, 16, 6, 1, 8, '2026-07-22 10:49:22', 0.96613, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (24, 17, 6, 1, 8, '2026-07-22 17:56:53', 0.917423, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (25, 24, 6, 2, 9, '2026-07-22 18:00:08', 0.967913, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (26, 25, 6, 3, 9, '2026-07-22 18:00:28', 0.956883, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (27, 26, 6, 3, 10, '2026-07-22 18:00:44', 0.983921, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (28, 27, 6, 1, 10, '2026-07-22 18:00:53', 0.983921, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (29, 29, 6, 1, NULL, '2026-07-23 09:02:48', 0.96094, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (30, 30, 6, 1, NULL, '2026-07-23 09:02:48', 0.96094, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (31, 31, 6, 1, NULL, '2026-07-23 09:03:22', 0.650389, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (32, 32, 6, 1, NULL, '2026-07-23 09:43:30', 0.650389, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (33, 33, 6, 1, NULL, '2026-07-23 09:47:49', 0.650389, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (34, 33, 6, 1, 24, '2026-07-23 09:47:49', 0.239117, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (35, 34, 6, 3, NULL, '2026-07-23 09:50:38', 0.650389, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (36, 34, 6, 3, 24, '2026-07-23 09:50:38', 0.239117, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (37, 34, 6, 3, NULL, '2026-07-23 09:50:38', 0.0436055, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (38, 34, 6, 3, 10, '2026-07-23 09:50:38', 0.0184287, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (39, 35, 6, 3, NULL, '2026-07-23 09:52:01', 0.0156656, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (40, 37, 6, 3, 9, '2026-07-23 09:53:02', 0.36278, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (41, 37, 6, 3, 10, '2026-07-23 09:53:02', 0.0322544, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (42, 37, 6, 3, 20, '2026-07-23 09:53:02', 0.0317083, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (43, 38, 6, 3, NULL, '2026-07-23 09:53:43', 0.0633244, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (44, 38, 6, 3, 13, '2026-07-23 09:53:43', 0.0379864, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (45, 39, 6, 3, 3, '2026-07-23 09:54:30', 0.941047, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (46, 40, 6, 3, 3, '2026-07-23 09:54:44', 0.735075, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (47, 41, 6, 3, NULL, '2026-07-23 09:55:00', 0.760706, 'TIDAK DIKENAL', '-');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (48, 42, 6, 1, 12, '2026-07-23 09:56:21', 0.974582, 'TIDAK SESUAI', 'Rak C');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (49, 43, 6, 1, 13, '2026-07-23 09:56:33', 0.991848, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (50, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.87, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (51, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.87, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (52, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.86, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (53, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.85, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (54, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.85, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (55, 46, 6, 3, 30, '2026-07-29 08:18:23', 0.85, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (56, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.84, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (57, 46, 6, 3, 30, '2026-07-29 08:18:23', 0.84, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (58, 46, 6, 3, 30, '2026-07-29 08:18:23', 0.84, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (59, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.82, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (60, 46, 6, 3, 33, '2026-07-29 08:18:23', 0.82, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (61, 46, 6, 2, 27, '2026-07-29 08:18:23', 0.8, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (62, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.78, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (63, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.76, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (64, 46, 6, 2, 19, '2026-07-29 08:18:23', 0.76, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (65, 46, 6, 2, 5, '2026-07-29 08:18:23', 0.75, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (66, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.74, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (67, 46, 6, 2, 28, '2026-07-29 08:18:23', 0.72, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (68, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.7, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (69, 46, 6, 3, 13, '2026-07-29 08:18:23', 0.67, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (70, 46, 6, 3, 29, '2026-07-29 08:18:23', 0.6, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (71, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.51, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (72, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.47, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (73, 46, 6, 3, 13, '2026-07-29 08:18:23', 0.47, 'TIDAK SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (74, 46, 6, 1, 3, '2026-07-29 08:18:23', 0.22, 'SESUAI', 'Rak A');
INSERT INTO `tb_deteksi` (`id_deteksi`, `id_scan`, `id_user`, `id_lokasi`, `id_bahan`, `tanggal_deteksi`, `confidence`, `status`, `lokasi_seharusnya`) VALUES (75, 46, 6, 3, 29, '2026-07-29 08:18:23', 0.19, 'TIDAK SESUAI', 'Rak A');

DROP TABLE IF EXISTS `tb_lokasi_rak`;
CREATE TABLE `tb_lokasi_rak` (
  `id_lokasi` int(10) NOT NULL AUTO_INCREMENT,
  `nama_rak` varchar(50) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_lokasi`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `tb_lokasi_rak` (`id_lokasi`, `nama_rak`, `keterangan`) VALUES (1, 'Rak A', 'Bumbu dapur kering (garam, gula, lada)');
INSERT INTO `tb_lokasi_rak` (`id_lokasi`, `nama_rak`, `keterangan`) VALUES (2, 'Rak B', 'Minyak dan bahan cair (minyak goreng, kecap, saus)');
INSERT INTO `tb_lokasi_rak` (`id_lokasi`, `nama_rak`, `keterangan`) VALUES (3, 'Rak C', 'Tepung dan bahan tabur (tepung terigu, maizena)');

DROP TABLE IF EXISTS `tb_scan`;
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (1, 6, NULL, '20260721_044249.jpg', 'result_20260721_044249.jpg', '2026-07-21 04:42:49');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (2, 6, NULL, '20260721_151026.jpg', 'result_20260721_151026.jpg', '2026-07-21 15:10:26');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (3, 6, NULL, '20260721_151158.jpg', 'result_20260721_151158.jpg', '2026-07-21 15:11:58');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (8, 6, NULL, '20260721_154205.png', 'result_20260721_154205.png', '2026-07-21 15:42:09');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (9, 6, NULL, '20260721_154225.png', 'result_20260721_154225.png', '2026-07-21 15:42:26');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (10, 6, NULL, '20260721_154427.png', 'result_20260721_154427.png', '2026-07-21 15:44:30');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (11, 6, NULL, '20260721_154801.png', 'result_20260721_154801.png', '2026-07-21 15:48:02');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (12, 6, NULL, '20260721_201106.jpeg', 'result_20260721_201106.jpeg', '2026-07-21 20:11:12');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (13, 6, NULL, '20260721_201142.jpeg', 'result_20260721_201142.jpeg', '2026-07-21 20:11:42');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (14, 6, NULL, '20260721_201226.jpeg', 'result_20260721_201226.jpeg', '2026-07-21 20:12:27');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (15, 6, NULL, '20260721_202949.jpeg', 'result_20260721_202949.jpeg', '2026-07-21 20:29:50');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (16, 6, 1, '20260722_104919.jpg', 'result_20260722_104919.jpg', '2026-07-22 10:49:22');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (17, 6, 1, '20260722_175649.jpg', 'result_20260722_175649.jpg', '2026-07-22 17:56:53');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (18, 6, 1, '20260722_175704.jpg', 'result_20260722_175704.jpg', '2026-07-22 17:57:05');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (19, 6, 1, '20260722_175711.jpg', 'result_20260722_175711.jpg', '2026-07-22 17:57:12');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (20, 6, 1, '20260722_175717.jpg', 'result_20260722_175717.jpg', '2026-07-22 17:57:18');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (21, 6, 3, '20260722_175723.jpg', 'result_20260722_175723.jpg', '2026-07-22 17:57:24');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (22, 6, 2, '20260722_175727.jpg', 'result_20260722_175727.jpg', '2026-07-22 17:57:28');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (23, 6, 2, '20260722_175750.jpg', 'result_20260722_175750.jpg', '2026-07-22 17:57:51');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (24, 6, 2, '20260722_180007.jpg', 'result_20260722_180007.jpg', '2026-07-22 18:00:08');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (25, 6, 3, '20260722_180027.jpg', 'result_20260722_180027.jpg', '2026-07-22 18:00:28');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (26, 6, 3, '20260722_180044.jpg', 'result_20260722_180044.jpg', '2026-07-22 18:00:44');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (27, 6, 1, '20260722_180053.jpg', 'result_20260722_180053.jpg', '2026-07-22 18:00:53');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (28, 6, 1, '20260722_180542.jpg', 'result_20260722_180542.jpg', '2026-07-22 18:05:43');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (29, 6, 1, '20260723_090243.jpg', 'result_20260723_090243.jpg', '2026-07-23 09:02:48');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (30, 6, 1, '20260723_090246.jpg', 'result_20260723_090246.jpg', '2026-07-23 09:02:48');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (31, 6, 1, '20260723_090322.png', 'result_20260723_090322.png', '2026-07-23 09:03:22');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (32, 6, 1, '20260723_094327.png', 'result_20260723_094327.png', '2026-07-23 09:43:30');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (33, 6, 1, '20260723_094747.png', 'result_20260723_094747.png', '2026-07-23 09:47:49');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (34, 6, 3, '20260723_095035.png', 'result_20260723_095035.png', '2026-07-23 09:50:38');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (35, 6, 3, '20260723_095200.jpeg', 'result_20260723_095200.jpeg', '2026-07-23 09:52:01');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (36, 6, 3, '20260723_095248.jpeg', 'result_20260723_095248.jpeg', '2026-07-23 09:52:48');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (37, 6, 3, '20260723_095301.jpeg', 'result_20260723_095301.jpeg', '2026-07-23 09:53:02');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (38, 6, 3, '20260723_095341.jpeg', 'result_20260723_095341.jpeg', '2026-07-23 09:53:43');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (39, 6, 3, '20260723_095428.jpg', 'result_20260723_095428.jpg', '2026-07-23 09:54:30');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (40, 6, 3, '20260723_095444.jpg', 'result_20260723_095444.jpg', '2026-07-23 09:54:44');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (41, 6, 3, '20260723_095459.jpg', 'result_20260723_095459.jpg', '2026-07-23 09:55:00');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (42, 6, 1, '20260723_095620.jpg', 'result_20260723_095620.jpg', '2026-07-23 09:56:21');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (43, 6, 1, '20260723_095633.jpg', 'result_20260723_095633.jpg', '2026-07-23 09:56:33');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (44, 6, 1, 'live_20260729_080022.jpg', 'live_20260729_080022.jpg', '2026-07-29 08:00:22');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (45, 6, 1, 'live_20260729_081740.jpg', 'live_20260729_081740.jpg', '2026-07-29 08:17:40');
INSERT INTO `tb_scan` (`id_scan`, `id_user`, `id_lokasi`, `gambar`, `gambar_hasil`, `waktu_scan`) VALUES (46, 6, 1, 'live_20260729_081823.jpg', 'live_20260729_081823.jpg', '2026-07-29 08:18:23');

DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `role` enum('admin','pic_gudang') NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `tb_user` (`id_user`, `username`, `password`, `nama`, `role`) VALUES (6, 'admin', 'scrypt:32768:8:1$ZHRPgsGs7KYEg9ah$e7b3b314a2db628ef50af1c6ebde6220201979dc0ab37dc23cb3b8eb0b7a9252cff62958ecb0aaecfdfb410c2e787c96daec253710d92fb8fd62ba65f281be70', 'Administrator', 'admin');
INSERT INTO `tb_user` (`id_user`, `username`, `password`, `nama`, `role`) VALUES (7, 'lisna', 'scrypt:32768:8:1$B1Wv90jkUlf1dErx$dc8c67d33ed1a5575a7d54f54b7e79daeee47a7a31fb18d906967ab92fed9c89129ee78d9fd75caa06e1c1dcf2933f43f508b06ba3bdec53c8edb7d9f2896a9a', 'Lisnawati', 'pic_gudang');
