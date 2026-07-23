import pymysql

raw_names = [
    "dataset_bawangmerah", "dataset_bawangputih", "dataset_bihun", "dataset_bumbu_kaldu", "Dataset_bumbu_rendang",
    "dataset_foto_kecap", "dataset_foto_saus", "Dataset_Garam", "Dataset_Gula_merah", "Dataset_Gula_putih",
    "Dataset_IkanTongkolDus", "Dataset_Ikan_Teri_Dus", "dataset_jahe", "dataset_kencur", "Dataset_KerupukMakaroni",
    "Dataset_KerupukRambak", "dataset_kunyit", "Dataset_LadaPutih", "dataset_lengkuas", "dataset_masako",
    "Dataset_Masakodus", "dataset_mie", "Dataset_Minyak_Fortunedus", "Dataset_Royco", "dataset_Salam",
    "dataset_santan", "Dataset_SantanRosebrand", "Dataset_Saori_SaosTiram", "Dataset_sasa", "dataset_sereh",
    "Dataset_sinti_Dus", "Dataset_SusuDus", "Dataset_Telur", "Dataset_TelurAsin"
]

clean_names = []
for n in raw_names:
    c = n.upper()
    c = c.replace("DATASET_", "").replace("_", " ").strip()
    c = c.replace("BAWANGMERAH", "BAWANG MERAH").replace("BAWANGPUTIH", "BAWANG PUTIH")
    c = c.replace("SAOSTIRAM", "SAUS TIRAM")
    c = c.replace("FOTO ", "") # Bersihkan kata foto
    
    # Title case biar cantik di web
    c = c.title()
    clean_names.append(c)

conn = pymysql.connect(host='localhost', user='root', password='', database='cv_gudang')
c = conn.cursor()
# Kosongkan tabel dan reset ID
c.execute("DELETE FROM tb_bahan_baku")
c.execute("ALTER TABLE tb_bahan_baku AUTO_INCREMENT = 1")

# Masukkan ke database
for nama in clean_names:
    c.execute("INSERT INTO tb_bahan_baku (nama_bahan, kategori, id_lokasi) VALUES (%s, %s, %s)", (nama, "Belum Diatur", 1))

conn.commit()
conn.close()
print("SELESAI! 34 Bahan Baku berhasil dimasukkan ke database.")
