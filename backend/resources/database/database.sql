CREATE DATABASE IF NOT EXISTS user;

USE user;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) ,
    age int
);

INSERT INTO users (name, email, age) VALUES ('Alice', "alice@gmail.com", 30);
INSERT INTO users (name, email, age) VALUES ('Bob', "bob@gmail.com", 25);
INSERT INTO users (name, email, age) VALUES ('Lithika', "lithika@gmail.com", 45);