import sqlite3
conn = sqlite3.connect('database.db')
cursor = conn.cursor()
cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
print("Tables:", cursor.fetchall())
try:
    cursor.execute("SELECT * FROM bahan")
    print("bahan:", cursor.fetchall())
except Exception as e:
    print(e)
