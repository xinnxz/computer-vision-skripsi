import pymysql

conn = pymysql.connect(host='localhost', user='root', password='', database='cv_gudang', cursorclass=pymysql.cursors.DictCursor)
cursor = conn.cursor()
cursor.execute("SELECT id_bahan, nama_bahan, kategori FROM tb_bahan_baku")
print(cursor.fetchall())
