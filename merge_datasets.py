import sys
sys.stdout.reconfigure(encoding="utf-8")

"""
merge_datasets.py
=================
Script profesional untuk menggabungkan dataset_roboflow ke dataset_final.

Fitur:
  - Remap class ID dari roboflow ke class ID standar dataset_final
  - Support format label: Bounding Box (4 angka) & Polygon (banyak titik)
  - Tambah 4 class baru (ID 34-37)
  - Rename file dengan prefix 'roboflow_' agar tidak bentrok
  - Split otomatis: gambar dari test & valid roboflow ke val dataset_final, train ke train
  - Backup data.yaml lama sebelum diupdate
  - Laporan lengkap di akhir eksekusi
  - Safety check: skip file yang gambar/labelnya tidak pasang

Penulis  : Antigravity AI (dibuatkan untuk skripsi Mas Luthfi)
Tanggal  : 2026-07-27
"""

import os
import shutil
import yaml
from pathlib import Path
from collections import defaultdict

# ============================================================
# KONFIGURASI PATH
# ============================================================
BASE_DIR        = Path(__file__).parent
SRC_DIR         = BASE_DIR / "dataset" / "dataset_roboflow"
DST_DIR         = BASE_DIR / "dataset" / "dataset_final"
DST_YAML        = DST_DIR / "data.yaml"
DST_YAML_BACKUP = DST_DIR / "data.yaml.backup"

# ============================================================
# TABEL PEMETAAN CLASS ID: Roboflow → Dataset Final
#   Key   = ID lama di dataset_roboflow
#   Value = ID baru di dataset_final
# ============================================================
CLASS_REMAP = {
    0:  0,   # Bawang Merah Bijian    → Bawang Merah
    1:  0,   # Bawang Merah-Utuh      → Bawang Merah (digabung)
    2:  1,   # Bawang Putih Bijian    → Bawang Putih
    3:  1,   # Bawang Putih-Siung     → Bawang Putih (digabung)
    4:  1,   # Bawang PutihBijian     → Bawang Putih (digabung)
    5:  2,   # Bihun                  → Bihun
    6:  34,  # Bubuk Ayam             → CLASS BARU (ID 34)
    7:  35,  # Bumbu Masak Daisys     → CLASS BARU (ID 35)
    8:  30,  # Bumbu Pecel Sinti      → Sinti Dus
    9:  3,   # Bumbu Rendang Racik    → Bumbu Racik
    10: 22,  # Daun Salam             → Salam
    11: 5,   # Garam                  → Garam
    12: 9,   # Jahe                   → Jahe
    13: 10,  # Kecap                  → Kecap Manis
    14: 11,  # Kencur                 → Kencur
    15: 36,  # Kerupuk Jengkol        → CLASS BARU (ID 36)
    16: 12,  # Kerupuk Makaroni       → Kerupuk Makaroni
    17: 13,  # Kerupuk Rambak         → Kerupuk Rambak
    18: 14,  # Kunyit                 → Kunyit
    19: 15,  # Lada Putih Bubuk       → Lada Putih
    20: 16,  # Lengkuas               → Lengkuas
    21: 19,  # Mie Telur              → Mie Burung Dara
    22: 37,  # Santan Kelapa Kara     → CLASS BARU (ID 37)
    23: 23,  # Santan Kelapa Rose Brand → Santan Rose Brand
    24: 25,  # Sasa                   → Sasa
    25: 26,  # Sasa Bumbu Kaldu       → Sasa Bumbu Kaldu Ayam
    26: 28,  # Saus Cabe              → Saus Cabe
    27: 24,  # Saus Saori             → Saori Saos Tiram
    28: 29,  # Sereh                  → Sereh
}

# Class baru yang akan ditambahkan ke data.yaml
NEW_CLASSES = {
    34: "Bubuk Ayam",
    35: "Bumbu Masak Daisys",
    36: "Kerupuk Jengkol",
    37: "Santan Kelapa Kara",
}

# ============================================================
# FUNGSI UTAMA: REMAP SATU FILE LABEL
# ============================================================
def remap_label_file(src_label_path: Path, dst_label_path: Path) -> dict:
    """
    Membaca file label YOLO (bounding box atau polygon),
    meremap class ID-nya, lalu menyimpan ke path tujuan.
    
    Format YOLO bounding box : class_id x_c y_c w h
    Format YOLO polygon      : class_id x1 y1 x2 y2 x3 y3 ...
    
    Return: dict berisi statistik (jumlah baris, class yang ditemukan, dll)
    """
    stats = {"lines_total": 0, "lines_remapped": 0, "unknown_ids": []}
    
    if not src_label_path.exists():
        return stats
    
    content = src_label_path.read_text(encoding="utf-8").strip()
    if not content:
        # File label kosong → tulis kosong juga
        dst_label_path.write_text("", encoding="utf-8")
        return stats
    
    new_lines = []
    for line in content.splitlines():
        line = line.strip()
        if not line:
            continue
        
        stats["lines_total"] += 1
        parts = line.split()
        
        try:
            old_class_id = int(parts[0])
        except (ValueError, IndexError):
            # Baris tidak valid, lewati
            continue
        
        if old_class_id not in CLASS_REMAP:
            stats["unknown_ids"].append(old_class_id)
            # Tetap tulis dengan ID asli agar tidak hilang, tandai dengan komentar
            new_lines.append(f"# UNKNOWN_ID {line}")
            continue
        
        new_class_id = CLASS_REMAP[old_class_id]
        # Ganti ID pertama, sisanya (koordinat) dibiarkan sama
        new_line = str(new_class_id) + " " + " ".join(parts[1:])
        new_lines.append(new_line)
        stats["lines_remapped"] += 1
    
    dst_label_path.write_text("\n".join(new_lines) + "\n", encoding="utf-8")
    return stats


# ============================================================
# FUNGSI COPY SATU PASANG (gambar + label)
# ============================================================
IMAGE_EXTS = {".jpg", ".jpeg", ".png", ".bmp", ".webp"}

def copy_pair(src_img_dir: Path, src_lbl_dir: Path,
              dst_img_dir: Path, dst_lbl_dir: Path,
              prefix: str = "roboflow_") -> dict:
    """
    Meng-copy semua gambar dari src_img_dir ke dst_img_dir,
    sekaligus meremap file labelnya dari src_lbl_dir ke dst_lbl_dir.
    
    Hanya memproses gambar yang punya file label pasangan.
    """
    results = {
        "copied": 0,
        "skipped_no_label": 0,
        "skipped_duplicate": 0,
        "class_counts": defaultdict(int),
        "all_stats": [],
    }
    
    if not src_img_dir.exists():
        return results
    
    for img_file in sorted(src_img_dir.iterdir()):
        if img_file.suffix.lower() not in IMAGE_EXTS:
            continue
        
        # Cari file label pasangan
        lbl_file = src_lbl_dir / (img_file.stem + ".txt")
        if not lbl_file.exists():
            results["skipped_no_label"] += 1
            continue
        
        # Nama file tujuan dengan prefix agar tidak bentrok
        new_name_stem = prefix + img_file.stem
        dst_img = dst_img_dir / (new_name_stem + img_file.suffix)
        dst_lbl = dst_lbl_dir / (new_name_stem + ".txt")
        
        # Cek duplikat
        if dst_img.exists():
            results["skipped_duplicate"] += 1
            continue
        
        # Copy gambar
        shutil.copy2(img_file, dst_img)
        
        # Remap dan copy label
        stats = remap_label_file(lbl_file, dst_lbl)
        results["all_stats"].append(stats)
        results["copied"] += 1
        
        # Hitung distribusi class (untuk laporan)
        if dst_lbl.exists():
            for line in dst_lbl.read_text().splitlines():
                line = line.strip()
                if line and not line.startswith("#"):
                    try:
                        cls_id = int(line.split()[0])
                        results["class_counts"][cls_id] += 1
                    except (ValueError, IndexError):
                        pass
    
    return results


# ============================================================
# FUNGSI UPDATE data.yaml
# ============================================================
def update_yaml(yaml_path: Path, backup_path: Path):
    """
    Membaca data.yaml yang ada, menambahkan class baru (ID 34-37),
    lalu menyimpannya kembali. Backup file lama dibuat terlebih dahulu.
    """
    # Backup dulu
    shutil.copy2(yaml_path, backup_path)
    print(f"  ✅ Backup data.yaml → {backup_path.name}")
    
    with open(yaml_path, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f)
    
    # Pastikan 'names' adalah dict (bukan list)
    names = data.get("names", {})
    if isinstance(names, list):
        names = {i: v for i, v in enumerate(names)}
    
    # Tambahkan class baru
    added = []
    for cls_id, cls_name in NEW_CLASSES.items():
        if cls_id not in names:
            names[cls_id] = cls_name
            added.append(f"    ID {cls_id}: {cls_name}")
    
    data["names"] = names
    data["nc"] = len(names)
    
    # Update path agar sesuai lokal (diisi pakai relative path)
    data["path"] = "."
    data["train"] = "train/images"
    data["val"] = "val/images"
    
    with open(yaml_path, "w", encoding="utf-8") as f:
        yaml.dump(data, f, allow_unicode=True, sort_keys=False, default_flow_style=False)
    
    return added


# ============================================================
# MAIN
# ============================================================
def main():
    print("=" * 60)
    print("  DATASET MERGER: dataset_roboflow → dataset_final")
    print("  Skripsi Computer Vision - YOLOv8")
    print("=" * 60)
    
    # Pastikan folder tujuan ada
    for split in ["train", "val"]:
        (DST_DIR / split / "images").mkdir(parents=True, exist_ok=True)
        (DST_DIR / split / "labels").mkdir(parents=True, exist_ok=True)
    
    total_copied = 0
    total_skipped = 0
    total_class_counts = defaultdict(int)
    
    # --- Sumber: train roboflow → train dataset_final ---
    print("\n[1/3] Memproses: train (roboflow) → train (final)...")
    r_train = copy_pair(
        src_img_dir = SRC_DIR / "train" / "images",
        src_lbl_dir = SRC_DIR / "train" / "labels",
        dst_img_dir = DST_DIR / "train" / "images",
        dst_lbl_dir = DST_DIR / "train" / "labels",
        prefix      = "roboflow_",
    )
    print(f"   ✅ Berhasil di-copy : {r_train['copied']} gambar")
    print(f"   ⚠️  Dilewati (no label)    : {r_train['skipped_no_label']}")
    print(f"   ⚠️  Dilewati (duplikat)    : {r_train['skipped_duplicate']}")
    total_copied  += r_train["copied"]
    total_skipped += r_train["skipped_no_label"] + r_train["skipped_duplicate"]
    for k, v in r_train["class_counts"].items():
        total_class_counts[k] += v
    
    # --- Sumber: valid roboflow → val dataset_final ---
    print("\n[2/3] Memproses: valid (roboflow) → val (final)...")
    r_valid = copy_pair(
        src_img_dir = SRC_DIR / "valid" / "images",
        src_lbl_dir = SRC_DIR / "valid" / "labels",
        dst_img_dir = DST_DIR / "val" / "images",
        dst_lbl_dir = DST_DIR / "val" / "labels",
        prefix      = "roboflow_",
    )
    print(f"   ✅ Berhasil di-copy : {r_valid['copied']} gambar")
    print(f"   ⚠️  Dilewati (no label)    : {r_valid['skipped_no_label']}")
    print(f"   ⚠️  Dilewati (duplikat)    : {r_valid['skipped_duplicate']}")
    total_copied  += r_valid["copied"]
    total_skipped += r_valid["skipped_no_label"] + r_valid["skipped_duplicate"]
    for k, v in r_valid["class_counts"].items():
        total_class_counts[k] += v
    
    # --- Sumber: test roboflow → val dataset_final (lebih banyak data validasi) ---
    print("\n[3/3] Memproses: test (roboflow) → val (final)...")
    r_test = copy_pair(
        src_img_dir = SRC_DIR / "test" / "images",
        src_lbl_dir = SRC_DIR / "test" / "labels",
        dst_img_dir = DST_DIR / "val" / "images",
        dst_lbl_dir = DST_DIR / "val" / "labels",
        prefix      = "roboflow_test_",
    )
    print(f"   ✅ Berhasil di-copy : {r_test['copied']} gambar")
    print(f"   ⚠️  Dilewati (no label)    : {r_test['skipped_no_label']}")
    print(f"   ⚠️  Dilewati (duplikat)    : {r_test['skipped_duplicate']}")
    total_copied  += r_test["copied"]
    total_skipped += r_test["skipped_no_label"] + r_test["skipped_duplicate"]
    for k, v in r_test["class_counts"].items():
        total_class_counts[k] += v
    
    # --- Update data.yaml ---
    print("\n[4/4] Update data.yaml...")
    added_classes = update_yaml(DST_YAML, DST_YAML_BACKUP)
    if added_classes:
        print("   ✅ Class baru yang ditambahkan:")
        for c in added_classes:
            print(f"    {c}")
    else:
        print("   ℹ️  Tidak ada class baru yang perlu ditambahkan.")
    
    # --- Hitung total gambar setelah merge ---
    final_train = len(list((DST_DIR / "train" / "images").glob("*.*")))
    final_val   = len(list((DST_DIR / "val"   / "images").glob("*.*")))
    
    # --- LAPORAN AKHIR ---
    print("\n" + "=" * 60)
    print("  ✅ MERGE SELESAI! LAPORAN AKHIR:")
    print("=" * 60)
    print(f"  Gambar baru berhasil ditambahkan : {total_copied}")
    print(f"  Gambar dilewati (total)          : {total_skipped}")
    print(f"\n  TOTAL gambar train (setelah merge) : {final_train}")
    print(f"  TOTAL gambar val   (setelah merge) : {final_val}")
    print(f"  TOTAL gambar keseluruhan          : {final_train + final_val}")
    
    print("\n  Distribusi class baru (dari roboflow) yang ditambahkan:")
    # Muat nama class dari yaml untuk label yang lebih informatif
    with open(DST_YAML, "r", encoding="utf-8") as f:
        yaml_data = yaml.safe_load(f)
    names_map = yaml_data.get("names", {})
    if isinstance(names_map, list):
        names_map = {i: v for i, v in enumerate(names_map)}
    
    for cls_id in sorted(total_class_counts.keys()):
        cls_name = names_map.get(cls_id, f"ID_{cls_id}")
        count    = total_class_counts[cls_id]
        print(f"    [{cls_id:>2}] {cls_name:<30} : {count} objek")
    
    print("\n  ⚠️  CATATAN PENTING:")
    print("  - Format label campuran (Bounding Box + Polygon) DIDUKUNG YOLOv8.")
    print("  - File data.yaml sudah diupdate dengan path lokal (relative).")
    print("  - Backup data.yaml lama tersimpan sebagai 'data.yaml.backup'.")
    print("\n  Langkah selanjutnya:")
    print("  → Jalankan training: yolo train data=dataset/dataset_final/data.yaml model=yolov8n.pt epochs=100")
    print("=" * 60)


if __name__ == "__main__":
    main()
