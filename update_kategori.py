import pymysql

kategori_map = {
    'Bawang merah': 'Bumbu Dapur Segar',
    'Bawang putih': 'Bumbu Dapur Segar',
    'Jahe': 'Bumbu Dapur Segar',
    'Kencur': 'Bumbu Dapur Segar',
    'Kunyit': 'Bumbu Dapur Segar',
    'Lengkuas': 'Bumbu Dapur Segar',
    'Salam': 'Bumbu Dapur Segar',
    'Sereh': 'Bumbu Dapur Segar',

    'Garam': 'Bumbu Dapur Kering',
    'Gula merah': 'Bumbu Dapur Kering',
    'Gula putih': 'Bumbu Dapur Kering',
    'Lada putih': 'Bumbu Dapur Kering',

    'Bumbu masak daisys': 'Bumbu & Penyedap Kemasan',
    'Bumbu racik': 'Bumbu & Penyedap Kemasan',
    'Masako': 'Bumbu & Penyedap Kemasan',
    'Masako dus': 'Bumbu & Penyedap Kemasan',
    'Royco': 'Bumbu & Penyedap Kemasan',
    'Sasa': 'Bumbu & Penyedap Kemasan',
    'Sasa bumbu kaldu ayam': 'Bumbu & Penyedap Kemasan',
    'Sinti dus': 'Bumbu & Penyedap Kemasan',
    'Bubuk ayam': 'Bumbu & Penyedap Kemasan',

    'Kecap manis': 'Saus & Kecap',
    'Saori saos tiram': 'Saus & Kecap',
    'Saus cabe': 'Saus & Kecap',

    'Minyak fortune dus': 'Minyak & Lemak',

    'Santan kelapa kara': 'Santan Kemasan',
    'Santan rose brand': 'Santan Kemasan',
    'Sasa santan kelapa': 'Santan Kemasan',

    'Bihun': 'Bahan Makanan Kering',
    'Mie burung dara': 'Bahan Makanan Kering',
    'Kerupuk jengkol': 'Bahan Makanan Kering',
    'Kerupuk makaroni': 'Bahan Makanan Kering',
    'Kerupuk rambak': 'Bahan Makanan Kering',

    'Delta foods tongkol': 'Lauk & Protein',
    'Ikan teri dus': 'Lauk & Protein',
    'Telur': 'Lauk & Protein',
    'Telur asin': 'Lauk & Protein',

    'Susu realgood dus': 'Minuman Kemasan'
}

conn = pymysql.connect(host='localhost', user='root', password='', database='cv_gudang')
cursor = conn.cursor()

for nama, kategori in kategori_map.items():
    cursor.execute("UPDATE tb_bahan_baku SET kategori = %s WHERE nama_bahan = %s", (kategori, nama))

conn.commit()
print("Kategori updated!")
