import os
import shutil
import random
import yaml
import zipfile
from pathlib import Path

src_dir = r"E:\Downloads\dataset_gudang_resized"
yolo_dir = r"E:\Downloads\dataset_gudang_yolo"
zip_path = r"E:\Downloads\dataset_gudang_yolo.zip"

def main():
    print("Mulai membuat Auto-Annotation dan mengatur struktur YOLO...")
    
    if os.path.exists(yolo_dir):
        shutil.rmtree(yolo_dir)
        
    # Create YOLO structure
    for split in ['train', 'val']:
        os.makedirs(os.path.join(yolo_dir, 'images', split), exist_ok=True)
        os.makedirs(os.path.join(yolo_dir, 'labels', split), exist_ok=True)
        
    # Get all class names (folder names)
    classes = [d for d in os.listdir(src_dir) if os.path.isdir(os.path.join(src_dir, d))]
    classes.sort()
    
    total_images = 0
    for class_id, class_name in enumerate(classes):
        class_dir = os.path.join(src_dir, class_name)
        images = [f for f in os.listdir(class_dir) if f.lower().endswith(('.png', '.jpg', '.jpeg'))]
        
        # Shuffle for random train/val split
        random.seed(42)
        random.shuffle(images)
        
        split_idx = int(len(images) * 0.8) # 80% train, 20% val
        train_images = images[:split_idx]
        val_images = images[split_idx:]
        
        for img_list, split in [(train_images, 'train'), (val_images, 'val')]:
            for img_name in img_list:
                src_img_path = os.path.join(class_dir, img_name)
                
                # New names with class prefix to avoid collisions
                new_basename = f"{class_name}_{img_name}"
                dst_img_path = os.path.join(yolo_dir, 'images', split, new_basename)
                dst_label_path = os.path.join(yolo_dir, 'labels', split, new_basename.rsplit('.', 1)[0] + '.txt')
                
                # Copy image
                shutil.copy2(src_img_path, dst_img_path)
                
                # Auto-Annotate: Center bounding box covering 80% of the image
                # Format: class_id center_x center_y width height
                with open(dst_label_path, 'w') as f:
                    f.write(f"{class_id} 0.500000 0.500000 0.800000 0.800000\n")
                    
                total_images += 1
                
        print(f"Class {class_id}: {class_name} -> {len(train_images)} train, {len(val_images)} val")

    # Create data.yaml
    yaml_data = {
        'train': 'images/train',
        'val': 'images/val',
        'nc': len(classes),
        'names': classes
    }
    
    yaml_path = os.path.join(yolo_dir, 'data.yaml')
    with open(yaml_path, 'w') as f:
        yaml.dump(yaml_data, f, default_flow_style=False, sort_keys=False)
        
    print(f"\nBerhasil mengatur {total_images} gambar dan membuat data.yaml!")
    print("Sedang mengompres ke dalam ZIP...")
    
    # Zip it
    with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, _, files in os.walk(yolo_dir):
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, yolo_dir)
                zipf.write(file_path, arcname)
                
    print(f"SELESAI! File ZIP siap: {zip_path}")

if __name__ == '__main__':
    main()
