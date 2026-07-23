"""
Script untuk generate password hash dan SQL INSERT siap pakai.
Jalankan sekali saja untuk mendapatkan SQL yang benar.
"""
from werkzeug.security import generate_password_hash

users = [
    ('admin', 'admin123', 'Administrator', 'admin'),
    ('lisna', 'lisna123', 'Lisnawati', 'pic_gudang'),
]

print("-- Paste SQL berikut ke phpMyAdmin atau jalankan via MySQL CLI:")
print("USE cv_gudang;")
print("DELETE FROM tb_user;  -- hapus user lama jika ada")
for username, password, nama, role in users:
    hashed = generate_password_hash(password)
    print(f"INSERT INTO tb_user (username, password, nama, role) VALUES ('{username}', '{hashed}', '{nama}', '{role}');")

print("\n-- Selesai! Password:")
for username, password, nama, role in users:
    print(f"   {username} -> {password}")
