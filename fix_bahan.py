import pymysql
import torch
import os

DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'cv_gudang',
    'cursorclass': pymysql.cursors.DictCursor
}

def fix_bahan():
    if hasattr(torch.serialization, 'add_safe_globals'):
        try:
            from ultralytics.nn.tasks import DetectionModel
            torch.serialization.add_safe_globals([DetectionModel])
        except ImportError:
            pass

    from ultralytics import YOLO
    model = YOLO('model/best-yolov8m.pt')
    
    classes = set()
    for _, raw_name in model.names.items():
        nama_kelas = raw_name.upper()
        nama_kelas = nama_kelas.replace("DATASET_", "")
        nama_kelas = nama_kelas.replace("_", " ").strip()
        nama_kelas = nama_kelas.replace("BAWANGMERAH", "BAWANG MERAH")
        nama_kelas = nama_kelas.replace("BAWANGPUTIH", "BAWANG PUTIH")
        nama_kelas = nama_kelas.replace("SAOSTIRAM", "SAUS TIRAM")
        nama_kelas = nama_kelas.replace("FOTO ", "")
        classes.add(nama_kelas.capitalize())
        
    conn = pymysql.connect(**DB_CONFIG)
    cursor = conn.cursor()
    
    # Kosongkan tabel bahan baku (dan reset ID / auto increment)
    cursor.execute("TRUNCATE TABLE tb_bahan_baku")
    
    # Pastikan ada minimal 1 lokasi rak
    cursor.execute("SELECT id_lokasi FROM tb_lokasi_rak ORDER BY id_lokasi LIMIT 1")
    rak = cursor.fetchone()
    if not rak:
        cursor.execute("INSERT INTO tb_lokasi_rak (nama_rak, keterangan) VALUES ('Rak A', 'Default')")
        conn.commit()
        id_lokasi = cursor.lastrowid
    else:
        id_lokasi = rak['id_lokasi']
        
    inserted_count = 0
    for cls in sorted(list(classes)):
        cursor.execute("INSERT INTO tb_bahan_baku (nama_bahan, id_lokasi) VALUES (%s, %s)", (cls, id_lokasi))
        inserted_count += 1
            
    conn.commit()
    print(f"Berhasil membersihkan tabel dan memasukkan tepat {inserted_count} bahan baku murni dari model YOLO!")
    cursor.close()
    conn.close()

if __name__ == '__main__':
    fix_bahan()
