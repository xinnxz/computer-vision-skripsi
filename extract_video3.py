import cv2
import os

def extract_frames(video_path, output_dir, frames_per_second=1):
    print(f"Mulai mengekstrak video: {video_path}")
    os.makedirs(output_dir, exist_ok=True)
    
    cap = cv2.VideoCapture(video_path)
    if not cap.isOpened():
        print("Gagal membuka video!")
        return
        
    fps = cap.get(cv2.CAP_PROP_FPS)
    if fps == 0 or fps != fps:
        fps = 30
        
    frame_skip = int(fps / frames_per_second)
    if frame_skip < 1:
        frame_skip = 1
        
    frame_count = 0
    saved_count = 0
    video_name = os.path.splitext(os.path.basename(video_path))[0]
    
    while True:
        ret, frame = cap.read()
        if not ret:
            break
            
        if frame_count % frame_skip == 0:
            img_path = os.path.join(output_dir, f"{video_name}_frame_{saved_count:04d}.jpg")
            cv2.imwrite(img_path, frame)
            saved_count += 1
            if saved_count % 10 == 0:
                print(f"Mengekstrak {saved_count} frame...")
                
        frame_count += 1
        
    cap.release()
    print(f"SELESAI! {saved_count} gambar diekstrak ke {output_dir}")

if __name__ == "__main__":
    vid_path = r"E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_gudang\20260723_125358 (3).mp4"
    out_dir = r"E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_gudang\video3_frames"
    extract_frames(vid_path, out_dir, frames_per_second=1)
