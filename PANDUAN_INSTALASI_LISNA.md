# 📘 PANDUAN LENGKAP INSTALASI APLIKASI SKRIPSI DARI NOL (STEP-BY-STEP)
**Aplikasi Deteksi Barang Gudang Berbasis YOLOv8 & Flask Python**

Panduan ini dibuat khusus agar aplikasi bisa dipasang dan dijalankan di laptop baru dari nol (tanpa pengetahuan *coding* yang rumit). Ikuti langkah-langkahnya secara berurutan.

---

## 🛠️ A. PERSIAPAN ALAT & BAHAN (DOWNLOAD DULU)
Sebelum mulai, pastikan sudah mendownload bahan-bahan berikut di laptop:
1. **Python versi 3.10 atau 3.11** (Jangan versi 3.13 karena beberapa library AI belum mendukung).
   👉 Download di: [python.org/downloads](https://www.python.org/downloads/)
2. **XAMPP Windows** (Untuk server database MySQL).
   👉 Download di: [apachefriends.org](https://www.apachefriends.org/download.html)
3. **Visual Studio Code (VS Code)** (Agar mudah membuka terminal & folder aplikasi).
   👉 Download di: [code.visualstudio.com](https://code.visualstudio.com/)
4. **File Otak AI (`best.pt`)** (Karena ukurannya besar, file ini tidak ada di GitHub. Minta file `best.pt` terbaru ke Mas Luthfi / ambil dari Google Drive project).

---

## 🖥️ B. TAHAP 1: INSTALASI PYTHON (SANGAT KRUSIAL!)
Banyak pemula gagal di tahap ini. Harap perhatikan baik-baik!
1. Buka file installer Python yang sudah didownload.
2. **SANGAT PENTING:** Pada layar awal instalasi, **WAJIB CENTANG kotak "Add Python 3.x to PATH"** di pojok kiri bawah! *(Jika lupa dicentang, aplikasi tidak akan bisa dijalankan)*.
3. Klik **Install Now** dan tunggu sampai selesai.
4. Jika muncul pilihan *"Disable path length limit"*, klik saja, lalu pilih **Close**.

---

## 🗄️ C. TAHAP 2: INSTALASI XAMPP & SIAPKAN DATABASE
1. Install XAMPP seperti biasa (Next sampai selesai).
2. Buka aplikasi **XAMPP Control Panel**.
3. Klik tombol **Start** pada baris **Apache** dan **MySQL** sampai keduanya berwarna **HIJAU**.
4. Buka browser (Chrome/Edge) dan ketikkan alamat: `http://localhost/phpmyadmin`
5. Di menu sebelah kiri, klik **New** (Baru) untuk membuat database baru.
6. Beri nama database persis: **`cv_gudang`**, lalu klik **Create** (Buat).
7. Klik database `cv_gudang` yang baru dibuat di menu kiri, lalu pilih tab **Import** di bagian atas.
8. Klik **Choose File**, lalu cari file **`cv_gudang_full.sql`** yang ada di dalam folder `database` pada project ini. (File ini sudah lengkap berisi tabel user, rak, barang, serta riwayat scan).
9. Scroll ke paling bawah dan klik tombol **Go** / **Import**.
10. Jika berhasil, akan muncul semua tabel: `tb_user`, `tb_lokasi_rak`, `tb_bahan_baku`, `tb_scan`, dan `tb_deteksi`.

---

## 📁 D. TAHAP 3: SIAPKAN FOLDER PROJECT & OTAK AI (`best.pt`)
1. Download kodingan project ini (bisa via `git clone https://github.com/xinnxz/computer-vision-skripsi.git` atau download ZIP dari GitHub lalu ekstrak di laptop, misalnya di drive `D:\computer-vision-skripsi`).
2. **MASUKKAN FILE OTAK AI:** Copy file **`best.pt`** yang sudah disiapkan di Awal, lalu **Paste langsung ke dalam folder utama project** (sejajar dengan file `app.py`, `requirements.txt`, dll).

---

## ⚙️ E. TAHAP 4: INSTALL LIBRARY PYTHON (REQUIREMENTS)
1. Buka aplikasi **Visual Studio Code (VS Code)**.
2. Klik menu **File** -> **Open Folder** -> Pilih folder project tadi (`computer-vision-skripsi`).
3. Buka Terminal di dalam VS Code dengan klik menu **Terminal** di atas -> **New Terminal** (atau tekan tombol `Ctrl` + `` ` ``).
4. Di bagian bawah akan muncul terminal. Ketikkan perintah berikut lalu tekan Enter:
   ```bash
   pip install -r requirements.txt
   ```
5. Pastikan laptop terhubung ke internet. Proses ini akan mengunduh library AI (YOLOv8, OpenCV, Flask, dll) dan memakan waktu sekitar 5-15 menit tergantung kecepatan internet.
6. Tunggu sampai tulisan di terminal kembali normal dan tidak ada error merah.

---

## 🚀 F. TAHAP 5: MENJALANKAN APLIKASI
1. Pastikan XAMPP (Apache & MySQL) masih menyala hijau.
2. Di terminal VS Code tadi, ketikkan perintah:
   ```bash
   python app.py
   ```
3. Jika berhasil, terminal akan memunculkan tulisan:
   ```text
   * Running on http://127.0.0.1:5000
   * Running on http://[ip-laptop]:5000
   ```
4. Buka browser dan masukkan alamat: **`http://localhost:5000`**
5. Halaman Login akan muncul! Gunakan akun Admin bawaan:
   * **Username :** `admin`
   * **Password :** `admin123`
6. Selamat! Aplikasi Skripsi sudah bisa digunakan untuk mendeteksi barang lewat foto maupun **Live Camera**! 🎉

---

## 🔄 G. CARA MEMATIKAN & MENJALANKAN ULANG BESOKNYA
**Cara Mematikan Aplikasi:**
* Di terminal VS Code, tekan tombol **`Ctrl` + `C`** pada keyboard.
* Buka XAMPP Control Panel, klik **Stop** pada Apache dan MySQL.

**Cara Menjalankan Ulang di Hari Lain:**
1. Buka XAMPP -> Start Apache & MySQL.
2. Buka VS Code -> Open Folder project ini.
3. Buka Terminal baru -> ketik `python app.py`.
4. Buka `http://localhost:5000` di browser. *(Tidak perlu pip install lagi!)*

---

## ❓ H. SOLUSI JIKA TERJADI ERROR (TROUBLESHOOTING)
* **Error `WinError 1114` / `c10.dll failed to load` saat `python app.py`:**
  Artinya laptop belum terinstall Microsoft Visual C++ Redistributable (wajib untuk menjalankan PyTorch/YOLO di Windows). Solusinya: Download dan install gratis dari Microsoft via link `https://aka.ms/vs/17/release/vc_redist.x64.exe`, lalu restart VS Code.
* **Error `Table 'cv_gudang.tb_scan' doesn't exist`:**
  Artinya di phpMyAdmin salah import file SQL lama. Solusinya: Buka phpMyAdmin, import file **`database/cv_gudang_full.sql`**.
* **Error `pip is not recognized` atau `python is not recognized`:**
  Artinya saat install Python lupa mencentang "Add Python to PATH". Solusinya: Install ulang Python dan wajib centang kotak tersebut.
* **Error `MySQL shutdown unexpectedly` di XAMPP:**
  Artinya database MySQL crash. Solusinya: Masuk ke folder `C:\xampp\mysql`, ganti nama folder `data` jadi `data_old`, buat folder `data` baru, copy isi folder `backup` ke `data` baru, lalu copy folder database `cv_gudang` dan file `ibdata1` dari `data_old` ke folder `data` baru.
* **Error `Model best.pt not found` saat buka web:**
  Artinya file `best.pt` belum ditaruh di dalam folder project, atau salah penamaan file. Pastikan namanya huruf kecil semua: `best.pt`.
