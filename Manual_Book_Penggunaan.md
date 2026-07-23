# 📖 Manual Book: Sistem Deteksi Kesalahan Penyimpanan Bahan Baku

Buku panduan ini disusun untuk memudahkan tim peneliti (Anda dan rekan Anda) dalam melakukan pengujian, pengoperasian, serta penyusunan laporan Skripsi untuk prototype Sistem Deteksi Kesalahan Penyimpanan Bahan Baku Gudang berbasis Artificial Intelligence (YOLOv8).

---

## 1. Konsep Utama Aplikasi (Wajib Dipahami)

Aplikasi ini **tidak hanya** mendeteksi jenis barang (Image Classification), melainkan mendeteksi **posisi penempatan barang** di lemari rak gudang (Object Detection + Spatial Validation).

- **Sistem Grid Dinamis:** Saat foto lemari rak di-upload, sistem web (Flask) akan otomatis memotong foto secara horizontal menjadi beberapa tingkat (misal: Rak Atas, Rak Tengah, Rak Bawah). Jumlah irisan ini menyesuaikan dengan jumlah rak yang ada di database.
- **Validasi Silang (Cross-Validation):** AI YOLO akan mendeteksi sebuah objek barang dan menemukan letak titik tengah (koordinat Y) dari barang tersebut. Sistem lalu membandingkan letak barang di foto dengan letak *seharusnya* yang ada di Database Master. Jika tidak cocok, sistem akan memberikan peringatan **"SALAH PENEMPATAN"**.

---

## 2. Cara Menjalankan Aplikasi Lokal (Localhost)

1. Buka aplikasi **VS Code**.
2. Buka folder proyek `computer-vision-lisna`.
3. Buka Terminal di VS Code (`Ctrl` + `~`).
4. Ketik perintah sakti berikut, lalu tekan Enter:
   ```bash
   python app.py
   ```
5. Buka Browser (Google Chrome / Edge) dan kunjungi alamat: **`http://127.0.0.1:5000`**

---

## 3. Persiapan Data Master (Penting Sebelum Uji Coba)

Sebelum melakukan pemindaian (Scan), aturan gudang (SOP) harus sudah tercatat rapi di dalam sistem. Jika tidak, AI akan bingung ke mana harus mencocokkan datanya.

1. Masuk ke menu **Kelola Rak**. Pastikan susunan tingkatan rak sudah benar. (Misal: ID 1 untuk Rak A/Atas, ID 2 untuk Rak B/Tengah, ID 3 untuk Rak C/Bawah).
2. Masuk ke menu **Kelola Bahan Baku**.
3. Pastikan ke-34 jenis bahan baku sudah dikelompokkan ke lokasi rak yang **seharusnya** (Aturan mainnya). 

> [!TIP]
> **Praktik Terbaik Penempatan Gudang:** 
> - Barang berat / karton besar (Masakodus, Ikan Tongkol Dus) diletakkan di **Rak Bawah**.
> - Barang botolan / cairan (Kecap, Saus Tiram, Minyak) diletakkan di **Rak Tengah**.
> - Bumbu kering / rempah mentah (Bawang, Merica, Kemiri) diletakkan di **Rak Atas**.

---

## 4. Panduan Melakukan Testing (Menu Scan Rak)

Agar sistem AI dapat memproses gambar dengan akurat, pengambilan foto dari kamera HP harus mengikuti standar berikut:

> [!IMPORTANT]
> **Aturan Pengambilan Foto:**
> - **JANGAN** memotret satu barang terlalu dekat (*close-up*) hingga menutupi seluruh layar HP.
> - **HARUS** memotret lemari rak secara utuh dari depan (terlihat susunan tingkat rak atas, tengah, bawah dalam satu *frame* foto).
> - Pastikan pencahayaan ruangan gudang cukup terang.
> - Gunakan barang/produk asli yang sama dengan yang difoto saat pembuatan Dataset.

**Langkah Testing:**
1. Masuk ke menu **Scan Rak** di sebelah kiri.
2. Klik area *upload* atau seret foto lemari rak hasil jepretan Anda.
3. Klik tombol biru **Mulai Deteksi YOLO**.
4. Tunggu proses komputasi beberapa detik. Sistem akan menampilkan *Bounding Box* (Garis Kotak):
   - 🟩 **Kotak Hijau:** Barang berada di rak yang benar (Sesuai SOP).
   - 🟥 **Kotak Merah:** Barang berada di rak yang salah atau barang tidak terdaftar di database.
5. Scroll ke bawah untuk melihat "Detail Hasil Pemeriksaan". Klik tombol **Simpan Hasil ke Riwayat** untuk diabadikan sebagai data lampiran Bab 4 laporan Skripsi.

---

## 5. Pemecahan Masalah (Troubleshooting)

> [!WARNING]
> **Kenapa suatu barang tidak terdeteksi (Tidak muncul kotaknya)?**
> AI memiliki batas keraguan (*Confidence Threshold*) sebesar 50%. Jika AI tidak yakin kemasan barang di foto tersebut sama dengan kemasan saat ia latihan (training), maka AI akan diam. 
> **Solusi:** Pastikan Anda menggunakan produk asli dari merek yang sama (bukan produk ilustrasi), dan pastikan posisi barang tidak saling menutupi satu sama lain (tertumpuk parah).

> [!CAUTION]
> **Kenapa bayangan tiang atau kardus kosong dideteksi sebagai benda lain?**
> Hal ini disebut *False Positive*. Jika ini terjadi, artinya benda atau tekstur di latar belakang kebetulan sangat mirip dengan pola barang yang dihapal oleh AI. Ini adalah hal yang wajar dalam penelitian *Machine Learning*. 
> **Solusi:** Ambil ulang foto dengan *angle* (sudut) yang sedikit berbeda untuk menghilangkan efek ilusi optik pada bayangan.
