# 📦 Aplikasi Deteksi Barang Gudang (YOLOv8)

Sistem Deteksi Barang Gudang ini terdiri dari 2 bagian utama yang tergabung dalam satu kesatuan (Monolithic):
1. **Website Dashboard** (dibangun menggunakan Python Flask & HTML/CSS)
2. **Mesin AI Object Detection** (dibangun menggunakan YOLOv8 dari Ultralytics)

---

## 🛠️ A. Kebutuhan Sistem (Prerequisites)

Pastikan komputer/laptop Anda sudah terinstall:
- **Python versi 3.9** atau lebih baru (Penting: Pastikan 'Add to PATH' dicentang saat instalasi)
- **XAMPP** (sebagai penyedia server Apache dan database MySQL lokal)
- **Git** (untuk mengunduh kode sumber aplikasi)
- **Webcam / Kamera Laptop** (untuk fitur Live Detection)

---

## 🗄️ B. Langkah 1: Instalasi dan Persiapan Database

1. Buka aplikasi **XAMPP Control Panel**.
2. Klik tombol **"Start"** pada modul **Apache** dan **MySQL** hingga keduanya berwarna hijau.
3. Buka browser dan akses halaman manajemen database: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
4. Buat database baru dengan nama persis: `cv_gudang`
5. Pilih tab **"Import"**, lalu masukkan/upload file `cv_gudang.sql` (file ini berisi struktur tabel user dan riwayat scan), lalu klik **"Go"** / **"Import"**.

---

## 🚀 C. Langkah 2: Instalasi Aplikasi & Mesin AI (Python)

1. Buka terminal/command prompt, lalu clone (unduh) repository project ini:
   ```bash
   git clone https://github.com/xinnxz/computer-vision-skripsi.git
   cd computer-vision-skripsi
   ```

2. *(Opsional namun disarankan)* Buat Virtual Environment agar library tidak bentrok dengan aplikasi lain:
   ```bash
   python -m venv env
   env\Scripts\activate
   ```

3. Install semua library Python dan dependensi sistem (termasuk Flask, OpenCV, dan mesin YOLOv8) dengan menjalankan perintah:
   ```bash
   pip install -r requirements.txt
   ```
   *(Catatan: Proses ini mungkin memakan waktu bergantung kecepatan internet karena harus mengunduh library PyTorch dan Ultralytics).*

4. **SANGAT PENTING**: Pastikan file model otak AI `best.pt` (hasil training dataset) sudah berada di dalam folder project utama. Jika tidak ada di GitHub (karena ukurannya besar), silakan unduh manual dari penyimpanan (misal: Google Drive) dan letakkan sejajar dengan file `app.py`.

---

## ▶️ D. Langkah 3: Cara Menjalankan Aplikasi

Karena sistem backend dan AI sudah disatukan (terintegrasi) menggunakan Flask, Anda hanya butuh satu terminal saja.

**Menjalankan Aplikasi & Mesin AI:**
1. Pastikan Anda berada di folder utama (`computer-vision-skripsi`)
2. Pastikan XAMPP (Apache & MySQL) dalam keadaan menyala.
3. Jalankan perintah berikut:
   ```bash
   python app.py
   ```
4. Tunggu hingga terminal memunculkan pesan `Running on http://127.0.0.1:5000`
5. Website dan Mesin AI sekarang sudah berjalan bersamaan.
6. Buka browser Anda dan akses aplikasi melalui tautan:
   [http://127.0.0.1:5000](http://127.0.0.1:5000) atau [http://localhost:5000](http://localhost:5000)

🎉 **Selamat! Aplikasi Computer Vision Gudang siap digunakan untuk mendeteksi barang secara Real-Time!**
