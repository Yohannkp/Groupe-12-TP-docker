CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255)
);

INSERT INTO test_table (message) VALUES ('Bonjour !'), ('Docker fonctionne 🚀'), ('K8s bientôt !');
