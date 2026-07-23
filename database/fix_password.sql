-- ============================================================
-- FIX: Update password yang benar ke database
-- Jalankan SQL ini di phpMyAdmin -> tab SQL -> klik Go
-- ============================================================

USE cv_gudang;

-- Hapus user lama yang passwordnya salah
DELETE FROM tb_user;

-- Insert ulang dengan password hash yang benar
-- admin -> password: admin123
-- lisna -> password: lisna123
INSERT INTO `tb_user` (`username`, `password`, `nama`, `role`) VALUES
('admin', 'scrypt:32768:8:1$ZHRPgsGs7KYEg9ah$e7b3b314a2db628ef50af1c6ebde6220201979dc0ab37dc23cb3b8eb0b7a9252cff62958ecb0aaecfdfb410c2e787c96daec253710d92fb8fd62ba65f281be70', 'Administrator', 'admin'),
('lisna', 'scrypt:32768:8:1$B1Wv90jkUlf1dErx$dc8c67d33ed1a5575a7d54f54b7e79daeee47a7a31fb18d906967ab92fed9c89129ee78d9fd75caa06e1c1dcf2933f43f508b06ba3bdec53c8edb7d9f2896a9a', 'Lisnawati', 'pic_gudang');

-- Verifikasi
SELECT id_user, username, nama, role FROM tb_user;
