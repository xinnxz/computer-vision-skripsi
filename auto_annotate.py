import cv2
import os
from ultralytics import YOLO

def auto_annotate_video(video_path, output_dir, model_path, frames_per_second=1):
    print(f"Mulai memproses video: {video_path}")
    
    # Buat folder output
    images_dir = os.path.join(output_dir, 'images')
    labels_dir = os.path.join(output_dir, 'labels')
    os.makedirs(images_dir, exist_ok=True)
    os.makedirs(labels_dir, exist_ok=True)
    
    # Load model AI kita
    print(f"Memuat model YOLO dari: {model_path}")
    model = YOLO(model_path)
    
    # Buka video
    cap = cv2.VideoCapture(video_path)
    if not cap.isOpened():
        print(f"Error: Tidak bisa membuka video {video_path}")
        return
        
    fps = cap.get(cv2.CAP_PROP_FPS)
    if fps == 0 or fps != fps: # Handle invalid FPS
        fps = 30 
        
    # Hitung berapa frame yang harus di-skip untuk mendapatkan target fps
    frame_skip = int(fps / frames_per_second)
    if frame_skip < 1:
        frame_skip = 1
        
    print(f"Video FPS asli: {fps}. Mengekstrak 1 frame setiap {frame_skip} frame.")
    
    frame_count = 0
    saved_count = 0
    video_name = os.path.splitext(os.path.basename(video_path))[0]
    
    while True:
        ret, frame = cap.read()
        if not ret:
            break
            
        # Hanya ambil frame sesuai interval (misal: 1 per detik)
        if frame_count % frame_skip == 0:
            # Jalankan AI untuk menebak frame ini (confidence rendah agar semua ketangkap, nanti tinggal diedit)
            results = model(frame, conf=0.15, verbose=False)
            
            # Buat nama unik untuk file
            base_filename = f"{video_name}_frame_{saved_count:04d}"
            img_path = os.path.join(images_dir, f"{base_filename}.jpg")
            txt_path = os.path.join(labels_dir, f"{base_filename}.txt")
            
            # Simpan gambar
            cv2.imwrite(img_path, frame)
            
            # Simpan label txt (Format YOLO)
            with open(txt_path, 'w') as f:
                for r in results:
                    boxes = r.boxes
                    for box in boxes:
                        # Dapatkan format x_center, y_center, width, height (sudah dinormalisasi 0-1)
                        # xywhn returns normalized [x_center, y_center, width, height]
                        cls_id = int(box.cls[0])
                        xywhn = box.xywhn[0]
                        x_center, y_center, w, h = xywhn
                        f.write(f"{cls_id} {x_center:.6f} {y_center:.6f} {w:.6f} {h:.6f}\n")
                        
            saved_count += 1
            if saved_count % 10 == 0:
                print(f"Berhasil mengekstrak dan menganotasi {saved_count} frame...")
                
        frame_count += 1
        
    cap.release()
    print(f"SELESAI! {saved_count} gambar dan file txt berhasil dibuat dari {video_name}!")
    print(f"Silakan cek folder: {output_dir}")

if __name__ == "__main__":
    # Path konfigurasi
    VIDEO_DIR = r"E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_gudang"
    OUTPUT_DIR = r"E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_gudang\auto_annotated"
    MODEL_PATH = r"E:\DATA\Ngoding\computer-vision-lisna\best.pt"
    
    videos = ["20260723_125136.mp4", "20260723_125224.mp4"]
    
    for vid in videos:
        vid_path = os.path.join(VIDEO_DIR, vid)
        if os.path.exists(vid_path):
            auto_annotate_video(vid_path, OUTPUT_DIR, MODEL_PATH, frames_per_second=1)
