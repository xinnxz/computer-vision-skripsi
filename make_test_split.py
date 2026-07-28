import os
import shutil
import random
import yaml
from pathlib import Path

# Path folder
BASE_DIR = Path("E:/DATA/Ngoding/computer-vision-lisna/dataset/dataset_final")
VAL_IMG_DIR = BASE_DIR / "val" / "images"
VAL_LBL_DIR = BASE_DIR / "val" / "labels"
TEST_IMG_DIR = BASE_DIR / "test" / "images"
TEST_LBL_DIR = BASE_DIR / "test" / "labels"

def main():
    print("Membagi folder val menjadi val dan test...")
    
    # Buat folder test
    TEST_IMG_DIR.mkdir(parents=True, exist_ok=True)
    TEST_LBL_DIR.mkdir(parents=True, exist_ok=True)
    
    # Ambil semua gambar di val
    val_images = [f for f in os.listdir(VAL_IMG_DIR) if f.endswith(('.jpg', '.png', '.jpeg'))]
    random.seed(42) # Supaya konsisten
    random.shuffle(val_images)
    
    # Ambil setengahnya untuk di-move ke test
    half_idx = len(val_images) // 2
    test_images = val_images[:half_idx]
    
    moved = 0
    for img_name in test_images:
        # Move image
        src_img = VAL_IMG_DIR / img_name
        dst_img = TEST_IMG_DIR / img_name
        shutil.move(src_img, dst_img)
        
        # Move label if exists
        lbl_name = img_name.rsplit('.', 1)[0] + ".txt"
        src_lbl = VAL_LBL_DIR / lbl_name
        dst_lbl = TEST_LBL_DIR / lbl_name
        if src_lbl.exists():
            shutil.move(src_lbl, dst_lbl)
        
        moved += 1
        
    print(f"✅ Berhasil memindahkan {moved} gambar dari val ke test.")
    
    # Update data.yaml
    yaml_file = BASE_DIR / "data.yaml"
    with open(yaml_file, 'r', encoding='utf-8') as f:
        data = yaml.safe_load(f)
        
    data['test'] = 'test/images'
    
    with open(yaml_file, 'w', encoding='utf-8') as f:
        yaml.dump(data, f, sort_keys=False)
    print("✅ data.yaml berhasil di-update dengan parameter 'test'.")
    
    # Rekap akhir
    train_count = len(list((BASE_DIR / "train" / "images").glob("*.*")))
    val_count = len(list(VAL_IMG_DIR.glob("*.*")))
    test_count = len(list(TEST_IMG_DIR.glob("*.*")))
    total = train_count + val_count + test_count
    
    print("\n--- REKAP PEMBAGIAN DATASET BARU ---")
    print(f"TRAIN : {train_count} gambar ({train_count/total*100:.1f}%)")
    print(f"VAL   : {val_count} gambar ({val_count/total*100:.1f}%)")
    print(f"TEST  : {test_count} gambar ({test_count/total*100:.1f}%)")
    print("------------------------------------")

if __name__ == "__main__":
    main()
