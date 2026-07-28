import json
import codecs

with codecs.open('YOLOv8_Training_Colab.ipynb', 'r', encoding='utf-8') as f:
    data = json.load(f)

for cell in data['cells']:
    if cell['cell_type'] == 'code':
        source = cell['source']
        for i, line in enumerate(source):
            if "zip_ref.extractall('/content/')" in line:
                # Replace this line with the loop
                source[i] = "    for member in zip_ref.infolist():\n"
                source.insert(i+1, "        member.filename = member.filename.replace('\\\\', '/')\n")
                source.insert(i+2, "        zip_ref.extract(member, '/content/')\n")
                break

with codecs.open('YOLOv8_Training_Colab.ipynb', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=1)

print("Notebook fixed!")
