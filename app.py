from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify, Response
import pymysql
import os
import cv2
import numpy as np
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'skripsi_lisna_cv_gudang_2026'

# ============================================================
#  KONFIGURASI DATABASE - sesuaikan jika password beda
# ============================================================
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',          # default XAMPP kosong, isi jika ada password
    'database': 'cv_gudang',
    'cursorclass': pymysql.cursors.DictCursor
}

# ============================================================
#  KONFIGURASI UPLOAD GAMBAR
# ============================================================
UPLOAD_FOLDER = os.path.join('static', 'uploads')
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# ============================================================
#  KONFIGURASI MODEL YOLO
#  Ganti False menjadi True dan isi path model setelah training selesai
# ============================================================
YOLO_MODEL_READY = True      # Ubah jadi True jika model sudah ada
YOLO_MODEL_PATH  = 'model/best.pt'  # Path ke file model hasil training
yolo_model = None

def load_yolo_model():
    """Memuat model YOLOv8 dari file .pt (dipanggil satu kali saat startup)"""
    global yolo_model
    if YOLO_MODEL_READY and os.path.exists(YOLO_MODEL_PATH):
        try:
            from ultralytics import YOLO
            yolo_model = YOLO(YOLO_MODEL_PATH)
            print(f"[INFO] Model YOLOv8 berhasil dimuat dari: {YOLO_MODEL_PATH}")
        except Exception as e:
            print(f"[WARNING] Gagal memuat model YOLO: {e}")
            yolo_model = None
    else:
        print("[INFO] Mode SIMULASI aktif — model YOLO belum tersedia.")


# ============================================================
#  HELPER FUNCTIONS
# ============================================================
def get_db():
    """Mengembalikan koneksi database PyMySQL."""
    return pymysql.connect(**DB_CONFIG)

def allowed_file(filename):
    """Mengecek apakah ekstensi file gambar diizinkan."""
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def login_required(f):
    """Decorator sederhana untuk proteksi route agar hanya bisa diakses setelah login."""
    from functools import wraps
    @wraps(f)
    def decorated(*args, **kwargs):
        if 'loggedin' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated


# ============================================================
#  FUNGSI DETEKSI YOLO
# ============================================================
def jalankan_deteksi(image_path, id_lokasi_pilihan):
    """
    Menjalankan deteksi objek pada gambar menggunakan YOLOv8.
    Jika model belum siap, hasil kosong akan dikembalikan.
    Menerapkan Opsi 1: Gambar utuh (tidak dipotong grid), divalidasi 
    langsung terhadap id_lokasi_pilihan.
    """
    # --- Ambil data bahan baku dari DB untuk validasi ---
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT b.id_bahan, b.nama_bahan, b.id_lokasi, r.nama_rak
        FROM tb_bahan_baku b
        JOIN tb_lokasi_rak r ON b.id_lokasi = r.id_lokasi
    """)
    semua_bahan = cursor.fetchall()
    
    # Ambil info rak yang dipilih
    cursor.execute("SELECT nama_rak FROM tb_lokasi_rak WHERE id_lokasi = %s", (id_lokasi_pilihan,))
    rak_terpilih_row = cursor.fetchone()
    nama_rak_pilihan = rak_terpilih_row['nama_rak'] if rak_terpilih_row else 'Unknown'
    
    cursor.close()
    conn.close()

    # Buat mapping: nama_bahan -> dict bahan
    mapping_bahan = {b['nama_bahan'].upper(): b for b in semua_bahan}

    hasil_deteksi = []
    gambar_hasil_filename = None

    # Baca gambar
    img = cv2.imread(image_path)
    if img is None:
        return [], None
        
    # ---- MODE YOLO ASLI ----
    if yolo_model is not None:
        # Kembalikan ke threshold normal 25% agar tidak halu
        results = yolo_model(img, conf=0.25, iou=0.45, agnostic_nms=True)
        
        img_h, img_w = img.shape[:2]
        thickness = 2
        font_scale = 0.55
        
        for r in results:
            boxes = r.boxes
            for box in boxes:
                nama_kelas_mentah = r.names[int(box.cls[0])].upper()
                
                # --- PEMBERSIH TEKS OTOMATIS ---
                nama_kelas = nama_kelas_mentah.replace("DATASET_", "")
                nama_kelas = nama_kelas.replace("_", " ").strip()
                nama_kelas = nama_kelas.replace("BAWANGMERAH", "BAWANG MERAH")
                nama_kelas = nama_kelas.replace("BAWANGPUTIH", "BAWANG PUTIH")
                nama_kelas = nama_kelas.replace("SAOSTIRAM", "SAUS TIRAM")
                nama_kelas = nama_kelas.replace("FOTO ", "")
                # -------------------------------
                confidence = float(box.conf[0])
                
                x1, y1, x2, y2 = map(int, box.xyxy[0])
                
                # Validasi posisi
                if nama_kelas in mapping_bahan:
                    bahan_info = mapping_bahan[nama_kelas]
                    status = 'SESUAI' if str(bahan_info['id_lokasi']) == str(id_lokasi_pilihan) else 'TIDAK SESUAI'
                    lokasi_seharusnya = bahan_info['nama_rak'] if status == 'TIDAK SESUAI' else nama_rak_pilihan
                else:
                    status = 'TIDAK DIKENAL'
                    lokasi_seharusnya = '-'
                
                # Gambar bounding box di atas gambar utuh
                warna = (0, 255, 0) if status == 'SESUAI' else (0, 0, 255)
                cv2.rectangle(img, (x1, y1), (x2, y2), warna, thickness)
                label = f"{nama_kelas} {confidence:.0%} ({nama_rak_pilihan})"
                cv2.putText(img, label, (x1, max(y1 - 10, 20)), cv2.FONT_HERSHEY_SIMPLEX, font_scale, warna, thickness)
                
                hasil_deteksi.append({
                    'nama_bahan': nama_kelas.capitalize(),
                    'confidence': confidence,
                    'status': status,
                    'lokasi_seharusnya': lokasi_seharusnya,
                    'lokasi_terdeteksi': nama_rak_pilihan
                })

    # Simpan gambar hasil
    gambar_hasil_filename = 'result_' + os.path.basename(image_path)
    hasil_path = os.path.join(app.config['UPLOAD_FOLDER'], gambar_hasil_filename)
    cv2.imwrite(hasil_path, img)

    return hasil_deteksi, gambar_hasil_filename


# ============================================================
#  ROUTES: AUTHENTICATION
# ============================================================
@app.route('/')
def index():
    return redirect(url_for('dashboard') if 'loggedin' in session else url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        try:
            conn = get_db()
            cursor = conn.cursor()
            cursor.execute('SELECT * FROM tb_user WHERE username = %s', (username,))
            user = cursor.fetchone()
            cursor.close()
            conn.close()
            if user and check_password_hash(user['password'], password):
                session['loggedin'] = True
                session['id']       = user['id_user']
                session['username'] = user['username']
                session['nama']     = user['nama']
                session['role']     = user['role']
                return redirect(url_for('dashboard'))
            else:
                flash('Username atau password salah!', 'danger')
        except Exception as e:
            flash(f'Gagal terhubung ke database: {e}', 'danger')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))


# ============================================================
#  ROUTES: DASHBOARD
# ============================================================
@app.route('/dashboard')
@login_required
def dashboard():
    stats = {'total_bahan': 0, 'total_rak': 0, 'total_deteksi': 0, 'total_staff': 0, 'sesuai': 0, 'tidak_sesuai': 0}
    try:
        conn = get_db()
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) as c FROM tb_bahan_baku"); stats['total_bahan'] = cursor.fetchone()['c']
        cursor.execute("SELECT COUNT(*) as c FROM tb_lokasi_rak"); stats['total_rak'] = cursor.fetchone()['c']
        cursor.execute("SELECT COUNT(*) as c FROM tb_deteksi"); stats['total_deteksi'] = cursor.fetchone()['c']
        cursor.execute("SELECT COUNT(*) as c FROM tb_user WHERE role='pic_gudang'"); stats['total_staff'] = cursor.fetchone()['c']
        cursor.execute("SELECT COUNT(*) as c FROM tb_deteksi WHERE status='SESUAI'"); stats['sesuai'] = cursor.fetchone()['c']
        cursor.execute("SELECT COUNT(*) as c FROM tb_deteksi WHERE status='TIDAK SESUAI'"); stats['tidak_sesuai'] = cursor.fetchone()['c']
        cursor.close(); conn.close()
    except: pass
    return render_template('dashboard.html', stats=stats, yolo_ready=YOLO_MODEL_READY)


# ============================================================
#  ROUTES: PROFIL PENGGUNA
# ============================================================
@app.route('/profil')
@login_required
def profil():
    return render_template('profil.html')

# ============================================================
#  ROUTES: KELOLA RAK
# ============================================================
@app.route('/rak')
@login_required
def kelola_rak():
    rak_list = []
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("SELECT * FROM tb_lokasi_rak ORDER BY id_lokasi")
        rak_list = cursor.fetchall()
        cursor.close(); conn.close()
    except: pass
    return render_template('kelola_rak.html', rak_list=rak_list)

@app.route('/rak/tambah', methods=['POST'])
@login_required
def tambah_rak():
    nama_rak = request.form['nama_rak']
    keterangan = request.form.get('keterangan', '')
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("INSERT INTO tb_lokasi_rak (nama_rak, keterangan) VALUES (%s, %s)", (nama_rak, keterangan))
        conn.commit(); cursor.close(); conn.close()
        flash('Rak berhasil ditambahkan!', 'success')
    except Exception as e:
        flash(f'Gagal menambah rak: {e}', 'danger')
    return redirect(url_for('kelola_rak'))

@app.route('/rak/edit/<int:id>', methods=['POST'])
@login_required
def edit_rak(id):
    nama_rak = request.form['nama_rak']
    keterangan = request.form.get('keterangan', '')
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("UPDATE tb_lokasi_rak SET nama_rak=%s, keterangan=%s WHERE id_lokasi=%s", (nama_rak, keterangan, id))
        conn.commit(); cursor.close(); conn.close()
        flash('Data rak berhasil diperbarui!', 'success')
    except Exception as e:
        flash(f'Gagal memperbarui rak: {e}', 'danger')
    return redirect(url_for('kelola_rak'))

@app.route('/rak/hapus/<int:id>')
@login_required
def hapus_rak(id):
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("DELETE FROM tb_lokasi_rak WHERE id_lokasi=%s", (id,))
        conn.commit(); cursor.close(); conn.close()
        flash('Rak berhasil dihapus!', 'success')
    except Exception as e:
        flash(f'Gagal menghapus rak: {e}', 'danger')
    return redirect(url_for('kelola_rak'))


# ============================================================
#  ROUTES: KELOLA BAHAN BAKU
# ============================================================
@app.route('/bahan')
@login_required
def kelola_bahan():
    bahan_list, rak_list = [], []
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("""
            SELECT b.*, r.nama_rak FROM tb_bahan_baku b
            JOIN tb_lokasi_rak r ON b.id_lokasi = r.id_lokasi
            ORDER BY b.id_bahan
        """)
        bahan_list = cursor.fetchall()
        cursor.execute("SELECT * FROM tb_lokasi_rak ORDER BY id_lokasi")
        rak_list = cursor.fetchall()
        cursor.close(); conn.close()
    except: pass
    return render_template('kelola_bahan.html', bahan_list=bahan_list, rak_list=rak_list)

@app.route('/bahan/tambah', methods=['POST'])
@login_required
def tambah_bahan():
    nama_bahan = request.form['nama_bahan']
    kategori   = request.form.get('kategori', '')
    id_lokasi  = request.form['id_lokasi']
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("INSERT INTO tb_bahan_baku (nama_bahan, kategori, id_lokasi) VALUES (%s, %s, %s)", (nama_bahan, kategori, id_lokasi))
        conn.commit(); cursor.close(); conn.close()
        flash('Bahan baku berhasil ditambahkan!', 'success')
    except Exception as e:
        flash(f'Gagal menambah bahan baku: {e}', 'danger')
    return redirect(url_for('kelola_bahan'))

@app.route('/bahan/edit/<int:id>', methods=['POST'])
@login_required
def edit_bahan(id):
    nama_bahan = request.form['nama_bahan']
    kategori   = request.form.get('kategori', '')
    id_lokasi  = request.form['id_lokasi']
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("UPDATE tb_bahan_baku SET nama_bahan=%s, kategori=%s, id_lokasi=%s WHERE id_bahan=%s", (nama_bahan, kategori, id_lokasi, id))
        conn.commit(); cursor.close(); conn.close()
        flash('Bahan baku berhasil diperbarui!', 'success')
    except Exception as e:
        flash(f'Gagal memperbarui bahan baku: {e}', 'danger')
    return redirect(url_for('kelola_bahan'))

@app.route('/bahan/hapus/<int:id>')
@login_required
def hapus_bahan(id):
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("DELETE FROM tb_bahan_baku WHERE id_bahan=%s", (id,))
        conn.commit(); cursor.close(); conn.close()
        flash('Bahan baku berhasil dihapus!', 'success')
    except Exception as e:
        flash(f'Gagal menghapus bahan baku: {e}', 'danger')
    return redirect(url_for('kelola_bahan'))


# ============================================================
#  ROUTES: SCAN RAK + DETEKSI YOLO
# ============================================================
@app.route('/scan')
@login_required
def scan_rak():
    daftar_rak = []
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("SELECT * FROM tb_lokasi_rak ORDER BY id_lokasi")
        daftar_rak = cursor.fetchall()
        cursor.close(); conn.close()
    except: pass
    return render_template('scan_rak.html', daftar_rak=daftar_rak)

@app.route('/deteksi', methods=['POST'])
@login_required
def deteksi():
    """
    Endpoint utama untuk menerima gambar dari frontend,
    menjalankan deteksi YOLOv8 (Opsi 2: Grid/ROI), memvalidasi posisi,
    menyimpan hasil ke database, dan mengembalikan JSON.
    """
    if 'gambar' not in request.files:
        return jsonify({'error': 'Tidak ada file gambar yang dikirim.'}), 400
    
    file = request.files['gambar']
    id_lokasi = request.form.get('id_lokasi')
    
    if not id_lokasi:
        return jsonify({'error': 'Harap pilih rak terlebih dahulu!'}), 400

    # Cek file ada dan tidak kosong
    if not file or file.filename == '':
        return jsonify({'error': 'Tidak ada file yang dipilih.'}), 400

    # Simpan file gambar ke folder uploads
    original_name = secure_filename(file.filename) if file.filename else 'upload.jpg'
    if not original_name or '.' not in original_name:
        original_name = 'upload.jpg'

    ext = original_name.rsplit('.', 1)[-1].lower()
    if ext not in {'png', 'jpg', 'jpeg', 'webp', 'gif', 'bmp'}:
        ext = 'jpg'

    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    filename  = f"{timestamp}.{ext}"
    filepath  = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(filepath)

    # Jalankan deteksi dengan metode Opsi 1
    hasil_deteksi, gambar_hasil = jalankan_deteksi(filepath, int(id_lokasi))

    # Simpan sesi scan dan setiap hasil deteksi ke database
    try:
        conn = get_db(); cursor = conn.cursor()

        # 1. Simpan metadata sesi scan ke tb_scan
        cursor.execute("""
            INSERT INTO tb_scan (id_user, id_lokasi, gambar, gambar_hasil, waktu_scan)
            VALUES (%s, %s, %s, %s, NOW())
        """, (session['id'], id_lokasi, filename, gambar_hasil))
        id_scan = cursor.lastrowid

        # 2. Simpan setiap item deteksi ke tb_deteksi
        for item in hasil_deteksi:
            cursor.execute("SELECT id_bahan FROM tb_bahan_baku WHERE nama_bahan = %s LIMIT 1", (item['nama_bahan'],))
            bahan_row = cursor.fetchone()
            id_bahan  = bahan_row['id_bahan'] if bahan_row else None

            # Dapatkan id_lokasi terdeteksi dari nama rak
            cursor.execute("SELECT id_lokasi FROM tb_lokasi_rak WHERE nama_rak = %s LIMIT 1", (item.get('lokasi_terdeteksi'),))
            rak_row = cursor.fetchone()
            id_lokasi_terdeteksi = rak_row['id_lokasi'] if rak_row else None

            cursor.execute("""
                INSERT INTO tb_deteksi (id_scan, id_user, id_lokasi, id_bahan, tanggal_deteksi, confidence, status, lokasi_seharusnya)
                VALUES (%s, %s, %s, %s, NOW(), %s, %s, %s)
            """, (id_scan, session['id'], id_lokasi_terdeteksi, id_bahan, item['confidence'], item['status'], item.get('lokasi_seharusnya', '-')))
        conn.commit(); cursor.close(); conn.close()
    except Exception as e:
        print(f"[WARNING] Gagal menyimpan hasil deteksi ke DB: {e}")

    return jsonify({
        'sukses': True,
        'gambar_hasil': gambar_hasil,
        'deteksi': hasil_deteksi,
        'total': len(hasil_deteksi),
        'mode': 'YOLO' if yolo_model else 'SIMULASI'
    })


# ============================================================
#  ROUTES: RIWAYAT DETEKSI
# ============================================================
@app.route('/riwayat')
@login_required
def riwayat():
    riwayat_list = []
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("""
            SELECT d.id_deteksi, d.tanggal_deteksi, d.confidence, d.status,
                   d.lokasi_seharusnya, r.nama_rak, b.nama_bahan, u.nama AS nama_user
            FROM tb_deteksi d
            JOIN tb_lokasi_rak r ON d.id_lokasi = r.id_lokasi
            JOIN tb_user u ON d.id_user = u.id_user
            LEFT JOIN tb_bahan_baku b ON d.id_bahan = b.id_bahan
            ORDER BY d.tanggal_deteksi DESC
        """)
        riwayat_list = cursor.fetchall()
        cursor.close(); conn.close()
    except: pass
    return render_template('riwayat.html', riwayat=riwayat_list)


# ============================================================
#  ROUTES: KELOLA PENGGUNA
# ============================================================
@app.route('/pengguna')
@login_required
def kelola_pengguna():
    if session.get('role') != 'admin':
        flash('Akses ditolak. Hanya admin yang bisa mengelola pengguna.', 'danger')
        return redirect(url_for('dashboard'))
    user_list = []
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("SELECT id_user, username, nama, role FROM tb_user ORDER BY id_user")
        user_list = cursor.fetchall()
        cursor.close(); conn.close()
    except: pass
    return render_template('kelola_pengguna.html', user_list=user_list)

@app.route('/pengguna/tambah', methods=['POST'])
@login_required
def tambah_user():
    if session.get('role') != 'admin':
        return redirect(url_for('dashboard'))
    nama     = request.form['nama']
    username = request.form['username']
    password = generate_password_hash(request.form['password'])
    role     = request.form['role']
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("INSERT INTO tb_user (username, password, nama, role) VALUES (%s, %s, %s, %s)", (username, password, nama, role))
        conn.commit(); cursor.close(); conn.close()
        flash('Pengguna berhasil ditambahkan!', 'success')
    except Exception as e:
        flash(f'Gagal menambah pengguna: {e}', 'danger')
    return redirect(url_for('kelola_pengguna'))

@app.route('/pengguna/hapus/<int:id>')
@login_required
def hapus_user(id):
    if session.get('role') != 'admin':
        return redirect(url_for('dashboard'))
    if id == session.get('id'):
        flash('Tidak bisa menghapus akun yang sedang aktif!', 'danger')
        return redirect(url_for('kelola_pengguna'))
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("DELETE FROM tb_user WHERE id_user=%s", (id,))
        conn.commit(); cursor.close(); conn.close()
        flash('Pengguna berhasil dihapus!', 'success')
    except Exception as e:
        flash(f'Gagal menghapus pengguna: {e}', 'danger')
    return redirect(url_for('kelola_pengguna'))

@app.route('/pengguna/edit/<int:id>', methods=['POST'])
@login_required
def edit_user(id):
    if session.get('role') != 'admin':
        return redirect(url_for('dashboard'))
    nama     = request.form['nama']
    username = request.form['username']
    role     = request.form['role']
    try:
        conn = get_db(); cursor = conn.cursor()
        # Cek apakah password diubah
        new_password = request.form.get('password', '').strip()
        if new_password:
            hashed = generate_password_hash(new_password)
            cursor.execute("UPDATE tb_user SET nama=%s, username=%s, password=%s, role=%s WHERE id_user=%s",
                           (nama, username, hashed, role, id))
        else:
            cursor.execute("UPDATE tb_user SET nama=%s, username=%s, role=%s WHERE id_user=%s",
                           (nama, username, role, id))
        conn.commit(); cursor.close(); conn.close()
        flash('Pengguna berhasil diperbarui!', 'success')
    except Exception as e:
        flash(f'Gagal memperbarui pengguna: {e}', 'danger')
    return redirect(url_for('kelola_pengguna'))


# ============================================================
#  ROUTES: KELOLA STAFF
#  (Opsi A: Filter dari tb_user WHERE role = 'pic_gudang')
# ============================================================
@app.route('/staff')
@login_required
def kelola_staff():
    if session.get('role') != 'admin':
        flash('Akses ditolak. Hanya admin yang bisa mengelola staff.', 'danger')
        return redirect(url_for('dashboard'))
    staff_list = []
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("SELECT id_user, username, nama, role FROM tb_user WHERE role = 'pic_gudang' ORDER BY id_user")
        staff_list = cursor.fetchall()
        cursor.close(); conn.close()
    except: pass
    return render_template('kelola_staff.html', staff_list=staff_list)

@app.route('/staff/tambah', methods=['POST'])
@login_required
def tambah_staff():
    if session.get('role') != 'admin':
        return redirect(url_for('dashboard'))
    nama     = request.form['nama']
    username = request.form['username']
    password = generate_password_hash(request.form['password'])
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("INSERT INTO tb_user (username, password, nama, role) VALUES (%s, %s, %s, 'pic_gudang')",
                       (username, password, nama))
        conn.commit(); cursor.close(); conn.close()
        flash('Staff berhasil ditambahkan!', 'success')
    except Exception as e:
        flash(f'Gagal menambah staff: {e}', 'danger')
    return redirect(url_for('kelola_staff'))

@app.route('/staff/edit/<int:id>', methods=['POST'])
@login_required
def edit_staff(id):
    if session.get('role') != 'admin':
        return redirect(url_for('dashboard'))
    nama = request.form['nama']
    try:
        conn = get_db(); cursor = conn.cursor()
        new_password = request.form.get('password', '').strip()
        if new_password:
            hashed = generate_password_hash(new_password)
            cursor.execute("UPDATE tb_user SET nama=%s, password=%s WHERE id_user=%s AND role='pic_gudang'",
                           (nama, hashed, id))
        else:
            cursor.execute("UPDATE tb_user SET nama=%s WHERE id_user=%s AND role='pic_gudang'",
                           (nama, id))
        conn.commit(); cursor.close(); conn.close()
        flash('Staff berhasil diperbarui!', 'success')
    except Exception as e:
        flash(f'Gagal memperbarui staff: {e}', 'danger')
    return redirect(url_for('kelola_staff'))

@app.route('/staff/hapus/<int:id>')
@login_required
def hapus_staff(id):
    if session.get('role') != 'admin':
        return redirect(url_for('dashboard'))
    if id == session.get('id'):
        flash('Tidak bisa menghapus akun yang sedang aktif!', 'danger')
        return redirect(url_for('kelola_staff'))
    try:
        conn = get_db(); cursor = conn.cursor()
        cursor.execute("DELETE FROM tb_user WHERE id_user=%s AND role='pic_gudang'", (id,))
        conn.commit(); cursor.close(); conn.close()
        flash('Staff berhasil dihapus!', 'success')
    except Exception as e:
        flash(f'Gagal menghapus staff: {e}', 'danger')
    return redirect(url_for('kelola_staff'))


# ============================================================
#  LIVE CAMERA REAL-TIME
# ============================================================
def gen_frames():
    camera = cv2.VideoCapture(0)  # Gunakan kamera default (laptop atau virtual camera seperti DroidCam)
    while True:
        success, frame = camera.read()
        if not success:
            break
        else:
            # Lakukan deteksi YOLO
            if yolo_model is not None:
                # Gunakan threshold 15% untuk live cam agar optimal
                results = yolo_model(frame, conf=0.15, iou=0.45, agnostic_nms=True)
                
                img_h, img_w = frame.shape[:2]
                thickness = 2
                font_scale = 0.55
                
                for r in results:
                    boxes = r.boxes
                    for box in boxes:
                        x1, y1, x2, y2 = map(int, box.xyxy[0])
                        cls_id = int(box.cls[0])
                        conf = float(box.conf[0])
                        nama_kelas = r.names[cls_id].upper()
                        
                        # Atur warna (Merah jika salah satu kelas tertentu, tapi kita samakan saja dulu jadi hijau/merah)
                        # Biar mudah, kita pakai hijau untuk semua di live cam, atau merah
                        color = (0, 0, 255) # BGR: Merah
                        
                        # Gambar kotak
                        cv2.rectangle(frame, (x1, y1), (x2, y2), color, thickness)
                        
                        # Gambar teks
                        label = f"{nama_kelas} {int(conf*100)}%"
                        (tw, th), _ = cv2.getTextSize(label, cv2.FONT_HERSHEY_SIMPLEX, font_scale, thickness)
                        cv2.rectangle(frame, (x1, max(0, y1 - th - 10)), (x1 + tw + 10, y1), color, -1)
                        cv2.putText(frame, label, (x1 + 5, max(0, y1 - 5)), cv2.FONT_HERSHEY_SIMPLEX, font_scale, (255, 255, 255), thickness)

            # Encode frame ke JPEG
            ret, buffer = cv2.imencode('.jpg', frame)
            frame_bytes = buffer.tobytes()
            
            # Yield untuk streaming HTTP multipart
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n')

@app.route('/live_cam')
@login_required
def live_cam():
    return render_template('live_cam.html')

@app.route('/video_feed')
@login_required
def video_feed():
    # Return the response generated along with the specific media type (mime type)
    return Response(gen_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

# ============================================================
#  STARTUP
# ============================================================
if __name__ == '__main__':
    load_yolo_model()
    app.run(debug=True, host='0.0.0.0', port=5000)
