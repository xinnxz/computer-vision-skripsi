import os, random, shutil

base_dir = r'E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_gudang'
final_dir = r'E:\DATA\Ngoding\computer-vision-lisna\dataset\dataset_final'

if os.path.exists(final_dir):
    shutil.rmtree(final_dir)

os.makedirs(os.path.join(final_dir, 'train', 'images'))
os.makedirs(os.path.join(final_dir, 'train', 'labels'))
os.makedirs(os.path.join(final_dir, 'val', 'images'))
os.makedirs(os.path.join(final_dir, 'val', 'labels'))

labels_dir = os.path.join(base_dir, 'labels')
valid_labels = [f for f in os.listdir(labels_dir) if f.endswith('.txt')]

images_with_labels = []
for root, _, files in os.walk(base_dir):
    if 'labels' in root: continue
    for f in files:
        if f.endswith('.jpg') or f.endswith('.png'):
            base_name = os.path.splitext(f)[0]
            if base_name + '.txt' in valid_labels:
                images_with_labels.append({
                    'img': os.path.join(root, f),
                    'lbl': os.path.join(labels_dir, base_name + '.txt'),
                    'name': f,
                    'base': base_name
                })

random.shuffle(images_with_labels)
split_idx = int(len(images_with_labels) * 0.8)
train_data = images_with_labels[:split_idx]
val_data = images_with_labels[split_idx:]

for item in train_data:
    shutil.copy(item['img'], os.path.join(final_dir, 'train', 'images', item['name']))
    shutil.copy(item['lbl'], os.path.join(final_dir, 'train', 'labels', item['base'] + '.txt'))

for item in val_data:
    shutil.copy(item['img'], os.path.join(final_dir, 'val', 'images', item['name']))
    shutil.copy(item['lbl'], os.path.join(final_dir, 'val', 'labels', item['base'] + '.txt'))

with open(os.path.join(base_dir, 'classes.txt'), 'r') as f:
    classes = [line.strip() for line in f if line.strip()]

yaml_content = f'path: /content\ntrain: train/images\nval: val/images\n\nnames:\n'
for i, c in enumerate(classes):
    yaml_content += f'  {i}: "{c}"\n'

with open(os.path.join(final_dir, 'data.yaml'), 'w') as f:
    f.write(yaml_content)

shutil.make_archive(r'E:\DATA\Ngoding\computer-vision-lisna\dataset_final', 'zip', final_dir)
print(f'Done! Zipped {len(train_data)} train and {len(val_data)} val images.')
