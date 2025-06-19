CREATE DATABASE IF NOT EXISTS user;

USE user;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age int,
);

INSERT INTO users (id, name, age) VALUES (1, 'Alice', 30);
INSERT INTO users (id, name, age) VALUES (2, 'Bob', 25);
INSERT INTO users (id, name, age) VALUES (3, 'Lithika', 45);