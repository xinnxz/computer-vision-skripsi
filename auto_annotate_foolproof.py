import cv2
import os
import shutil
from ultralytics import YOLO

def auto_annotate_foolproof(video_path, output_dir, model_path, classes_txt_path, frames_per_second=1):
    print(f"Mulai memproses video: {video_path}")
    os.makedirs(output_dir, exist_ok=True)
    
    # Copy classes.txt ke output_dir agar X-AnyLabeling otomatis tahu nama barangnya
    shutil.copy(classes_txt_path, os.path.join(output_dir, "classes.txt"))
    
    # Load model
    print("Memuat AI...")
    model = YOLO(model_path)
    
    cap = cv2.VideoCapture(video_path)
    fps = cap.get(cv2.CAP_PROP_FPS)
    if fps == 0 or fps != fps: fps = 30 
        
    frame_skip = int(fps / frames_per_second)
    if frame_skip < 1: frame_skip = 1
        
    frame_count = 0
    saved_count = 0
    video_name = os.path.splitext(os.path.basename(video_path))[0]
    
    while True:
        ret, frame = cap.read()
        if not ret: break
            
        if frame_count % frame_skip == 0:
            # Tebak pakai AI (confidence sangat rendah agar semua kedetek, biarpun salah sedikit)
            results = model(frame, conf=0.10, iou=0.45, verbose=False)
            
            base_filename = f"{video_name}_frame_{saved_count:04d}"
            img_path = os.path.join(output_dir, f"{base_filename}.jpg")
            txt_path = os.path.join(output_dir, f"{base_filename}.txt")
            
            # Simpan gambar
            cv2.imwrite(img_path, frame)
            
            # Simpan label txt (Di folder yang SAMA dengan gambar agar X-AnyLabeling otomatis baca)
            with open(txt_path, 'w') as f:
                for r in results:
                    for box in r.boxes:
                        cls_id = int(box.cls[0])
                        x_center, y_center, w, h = box.xywhn[0]
                        f.write(f"{cls_id} {x_center:.6f} {y_center:.6f} {w:.6f} {h:.6f}\n")
                        
            saved_count += 1
            if saved_count % 10 == 0: print(f"Berhasil mengotaki {saved_count} frame...")
                
        frame_count += 1
        
    cap.release()
    print(f"SELESAI! {saved_count} gambar dan kotaknya berhasil dibuat dari {video_name}!")

if __name__ == "__main__":
    VIDEO_DIR = r"E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_gudang"
    OUTPUT_DIR = r"E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_gudang\OTOMATIS_FULL"
    MODEL_PATH = r"E:\DATA\Ngoding\computer-vision-lisna\best.pt"
    CLASSES_PATH = r"E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_gudang\classes.txt"
    
    videos = ["20260723_125136.mp4", "20260723_125224.mp4", "20260723_125358 (3).mp4"]
    
    for vid in videos:
        vid_path = os.path.join(VIDEO_DIR, vid)
        if os.path.exists(vid_path):
            auto_annotate_foolproof(vid_path, OUTPUT_DIR, MODEL_PATH, CLASSES_PATH, frames_per_second=1)
