import os
import cv2
import zipfile
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor

src_dir = r"E:\Downloads\dataset_gudang"
dst_dir = r"E:\Downloads\dataset_gudang_resized"
zip_path = r"E:\Downloads\dataset_gudang_resized.zip"

def process_image(img_path, out_path):
    try:
        os.makedirs(os.path.dirname(out_path), exist_ok=True)
        img = cv2.imread(str(img_path))
        if img is not None:
            resized = cv2.resize(img, (640, 640))
            cv2.imwrite(str(out_path), resized)
            return True
    except Exception as e:
        pass
    return False

def main():
    print("Mulai mengecilkan ukuran gambar...")
    os.makedirs(dst_dir, exist_ok=True)
    
    tasks = []
    for root, _, files in os.walk(src_dir):
        for file in files:
            if file.lower().endswith(('.png', '.jpg', '.jpeg')):
                src_path = Path(root) / file
                rel_path = src_path.relative_to(src_dir)
                dst_path = Path(dst_dir) / rel_path
                tasks.append((src_path, dst_path))
                
    print(f"Total gambar ditemukan: {len(tasks)}")
    
    # Process in parallel
    success_count = 0
    with ThreadPoolExecutor(max_workers=8) as executor:
        results = [executor.submit(process_image, s, d) for s, d in tasks]
        for idx, f in enumerate(results):
            if f.result():
                success_count += 1
            if (idx + 1) % 500 == 0:
                print(f"Progres: {idx + 1} / {len(tasks)}")
                
    print(f"Berhasil diresize: {success_count} gambar. Menyimpan ke dalam ZIP...")
    
    with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, _, files in os.walk(dst_dir):
            for file in files:
                file_path = os.path.join(root, file)
                zipf.write(file_path, os.path.relpath(file_path, dst_dir))
                
    print(f"SELESAI! File ZIP siap diupload: {zip_path}")

if __name__ == '__main__':
    main()
