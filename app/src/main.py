from flask import Flask, jsonify
import mysql.connector
import os

app = Flask(__name__)

@app.route('/health')
def health():
    return jsonify({"status": "healthy"}), 200

@app.route("/data")
def data():
    try:
        db = mysql.connector.connect(
            host=os.getenv("MYSQL_HOST", "mysql"),
            user=os.getenv("MYSQL_USER", "root"),
            password=os.getenv("MYSQL_PASSWORD", "root"),
            database=os.getenv("MYSQL_DATABASE", "testdb"),
            port=5655
        )
        cursor = db.cursor()
        cursor.execute("SELECT message FROM test_table;")
        result = cursor.fetchall()
        return jsonify(data=[row[0] for row in result])
    except Exception as e:
        return jsonify(error=str(e)), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4743)
