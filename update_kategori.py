import pymysql

# Mapping kategori dan rak
# Format: { 'Kategori': (id_lokasi, [daftar_keyword]) }
kategori_map = {
    'Barang Kartonan': (3, ['Dus', 'Masakodus']),
    'Cairan & Botolan': (2, ['Kecap', 'Saus', 'Saostiram', 'Santan', 'Minyak']),
    'Barang Pecah Belah': (2, ['Telur']),
    'Bumbu Dapur Mentah': (1, ['Bawang', 'Kunyit', 'Jahe', 'Kencur', 'Sereh', 'Salam', 'Lengkuas']),
    'Bumbu Kering': (1, ['Garam', 'Gula', 'Lada', 'Kaldu', 'Royco', 'Sasa', 'Masako']),
    'Bahan Makanan Kering': (1, ['Kerupuk', 'Mie', 'Bihun'])
}

conn = pymysql.connect(host='localhost', user='root', password='', database='cv_gudang', cursorclass=pymysql.cursors.DictCursor)
c = conn.cursor()

c.execute("SELECT id_bahan, nama_bahan FROM tb_bahan_baku")
semua_bahan = c.fetchall()

for bahan in semua_bahan:
    nama = bahan['nama_bahan']
    id_bahan = bahan['id_bahan']
    
    kategori_terpilih = 'Belum Diatur'
    id_lokasi_terpilih = 1
    
    # Deteksi berdasarkan keyword
    for kat, (loc, keywords) in kategori_map.items():
        if any(kw.lower() in nama.lower() for kw in keywords):
            kategori_terpilih = kat
            id_lokasi_terpilih = loc
            break
            
    c.execute("UPDATE tb_bahan_baku SET kategori=%s, id_lokasi=%s WHERE id_bahan=%s", (kategori_terpilih, id_lokasi_terpilih, id_bahan))

conn.commit()
conn.close()
print("Update Kategori dan Lokasi Berhasil!")
