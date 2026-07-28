import os
import yaml
from pathlib import Path
from collections import defaultdict

BASE_DIR = Path("E:/DATA/Ngoding/computer-vision-lisna/dataset/dataset_final")
YAML_FILE = BASE_DIR / "data.yaml"

# Load class names dari data.yaml
with open(YAML_FILE, 'r', encoding='utf-8') as f:
    data = yaml.safe_load(f)

names = data['names']  # dict {id: name}
if isinstance(names, list):
    names = {i: n for i, n in enumerate(names)}

# Hitung per split
splits = ['train', 'val', 'test']
class_count = {split: defaultdict(int) for split in splits}
file_count = {split: 0 for split in splits}
total_annotations = {split: 0 for split in splits}

for split in splits:
    label_dir = BASE_DIR / split / "labels"
    if not label_dir.exists():
        continue
    for txt_file in label_dir.glob("*.txt"):
        file_count[split] += 1
        with open(txt_file, 'r') as f:
            lines = [l.strip() for l in f.readlines() if l.strip()]
            for line in lines:
                parts = line.split()
                if parts:
                    try:
                        class_id = int(parts[0])
                        class_count[split][class_id] += 1
                        total_annotations[split] += 1
                    except ValueError:
                        pass

# Semua class yang ada di seluruh dataset
all_class_ids = set()
for split in splits:
    all_class_ids.update(class_count[split].keys())

print("=" * 80)
print("DEEP ANALYSIS - DATASET FINAL (dataset_final)")
print("=" * 80)
print(f"\nTotal file gambar - Train: {file_count['train']} | Val: {file_count['val']} | Test: {file_count['test']}")
print(f"Total annotasi   - Train: {total_annotations['train']} | Val: {total_annotations['val']} | Test: {total_annotations['test']}")
print(f"\nTotal kelas di data.yaml     : {len(names)}")
print(f"Total kelas ada di label     : {len(all_class_ids)}")
print()

# Cek class di yaml tapi tidak ada di dataset
missing_classes = set(names.keys()) - all_class_ids
empty_classes = []
if missing_classes:
    print(f"[!] KELAS DI YAML TAPI TIDAK ADA DI LABEL FILE:")
    for cid in sorted(missing_classes):
        print(f"    ID {cid:2d}: {names.get(cid, 'Unknown')}")
        empty_classes.append(cid)

# Cek class di label tapi tidak ada di yaml
unknown_classes = all_class_ids - set(names.keys())
if unknown_classes:
    print(f"\n[!] CLASS ID DI LABEL TAPI TIDAK ADA DI YAML:")
    for cid in sorted(unknown_classes):
        print(f"    ID {cid:2d}: (tidak terdaftar)")

print()
print("-" * 80)
print(f"{'ID':>3} | {'Nama Bahan Baku':<30} | {'Train':>6} | {'Val':>5} | {'Test':>5} | {'TOTAL':>6} | Status")
print("-" * 80)

grand_total = 0
active_classes = 0
for cid in sorted(names.keys()):
    name = names[cid]
    t = class_count['train'].get(cid, 0)
    v = class_count['val'].get(cid, 0)
    ts = class_count['test'].get(cid, 0)
    total = t + v + ts
    grand_total += total
    status = "OK" if total > 0 else "KOSONG"
    if total > 0:
        active_classes += 1
    print(f"{cid:>3} | {name:<30} | {t:>6} | {v:>5} | {ts:>5} | {total:>6} | {status}")

print("-" * 80)
t_sum = sum(class_count['train'].values())
v_sum = sum(class_count['val'].values())
ts_sum = sum(class_count['test'].values())
print(f"{'TOTAL':>3} | {'':<30} | {t_sum:>6} | {v_sum:>5} | {ts_sum:>5} | {grand_total:>6} |")
print("=" * 80)
print(f"\nRingkasan: {active_classes} dari {len(names)} kelas memiliki data anotasi.")
if empty_classes:
    print(f"PERINGATAN: {len(empty_classes)} kelas KOSONG (tidak ada anotasi): {[names[c] for c in empty_classes]}")
print()
