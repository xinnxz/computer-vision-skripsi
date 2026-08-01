import pymysql

try:
    print("Mencoba koneksi ke database cv_gudang...")
    db = pymysql.connect(host='localhost', user='root', password='', database='cv_gudang')
    cursor = db.cursor()
    
    print("Membuat tabel tb_staff jika belum ada...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS `tb_staff` (
      `id_staff` int(11) NOT NULL AUTO_INCREMENT,
      `nama` varchar(100) NOT NULL,
      `role` varchar(50) NOT NULL,
      PRIMARY KEY (`id_staff`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    """)
    db.commit()
    print("Berhasil membuat tabel tb_staff!")
    
    db.close()
except Exception as e:
    print(f"Gagal koneksi ke database. Pastikan XAMPP (MySQL) sudah menyala. Error: {e}")
