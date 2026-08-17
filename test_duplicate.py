import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
from app import app, get_db

with app.test_client() as client:
    with client.session_transaction() as sess:
        sess['loggedin'] = True
        sess['id'] = 6
        sess['username'] = 'admin'
        sess['role'] = 'admin'
        sess['nama'] = 'Administrator'

    print("=== TEST 1: Tambah Bahan Baku Duplicate ===")
    # Insert new bahan baku "Gula Pasir Test"
    conn = get_db(); cursor = conn.cursor()
    cursor.execute("DELETE FROM tb_bahan_baku WHERE nama_bahan = 'Gula Pasir Test'")
    conn.commit(); cursor.close(); conn.close()

    # Request 1: Should succeed
    resp1 = client.post('/bahan/tambah', data={
        'nama_bahan': 'Gula Pasir Test',
        'kategori': 'Sembako',
        'id_lokasi': 1
    }, follow_redirects=True)
    text1 = resp1.get_data(as_text=True)
    if 'Bahan baku berhasil ditambahkan' in text1:
        print("1. Insert pertama BERHASIL (Sesuai ekspektasi)")
    else:
        print("1. Insert pertama GAGAL")

    # Request 2: Duplicate, should fail
    resp2 = client.post('/bahan/tambah', data={
        'nama_bahan': 'Gula Pasir Test',
        'kategori': 'Sembako',
        'id_lokasi': 2
    }, follow_redirects=True)
    text2 = resp2.get_data(as_text=True)
    if 'sudah ada di database. Tidak boleh ada data double' in text2:
        print("2. Insert kedua DITOLAK (Sesuai ekspektasi - Validasi duplikat sukses!)")
    else:
        print("2. Insert kedua LOLOS (Gagal memblokir duplikat!)")

    # Clean up
    conn = get_db(); cursor = conn.cursor()
    cursor.execute("DELETE FROM tb_bahan_baku WHERE nama_bahan = 'Gula Pasir Test'")
    conn.commit(); cursor.close(); conn.close()
