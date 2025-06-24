// Copyright (c) 2025 Dineth. All Rights Reserved.
//
// This module contains SQL query builders for user operations.
// All queries are parameterized to prevent SQL injection attacks.
import ballerina/sql;

isolated function initiateDb() returns sql:ParameterizedQuery =>
`
CREATE DATABASE IF NOT EXISTS user;

USE user;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age int
);

INSERT INTO users (name, age) VALUES ('Alice', 30);
INSERT INTO users (name, age) VALUES ('Bob', 25);
INSERT INTO users (name, age) VALUES ('Lithika', 45);
`;

# Builds query to retrieve all users from the database
#
# + return - Parameterized SQL query for selecting all users
isolated function getAllUsersQueries() returns sql:ParameterizedQuery =>
`
    SELECT * FROM users
`;

# Builds query to retrieve a specific user by ID
#
# + id - Unique identifier of the user
# + return - Parameterized SQL query for selecting user by ID
isolated function getUserByIdQueries(int id) returns sql:ParameterizedQuery =>
`
SELECT * FROM users WHERE id = ${id}
`;

# Builds query to search for a user by name
#
# + name - Name of the user to search for
# + return - Parameterized SQL query for searching user by name
isolated function searchUserQueries(string name) returns sql:ParameterizedQuery =>
`
SELECT * FROM users WHERE name = ${name}
`;

# Builds query to insert a new user into the database
#
# + user - User record containing user details
# + return - Parameterized SQL query for inserting user
isolated function addUserQueries(UpdateUser user) returns sql:ParameterizedQuery =>
`
INSERT INTO users (name, age) VALUES (${user.name}, ${user.age})
`;

# Builds query to find a user by ID (alias for getUserByIdQueries)
#
# + id - Unique identifier of the user
# + return - Parameterized SQL query for finding user by ID
isolated function findUserQuery(int id) returns sql:ParameterizedQuery => `
SELECT * FROM users WHERE id = ${id}
`;

# Builds query to update an existing user's information
#
# + id - Unique identifier of the user to update
# + user - Updated user details
# + return - Parameterized SQL query for updating user
isolated function updateUserQueries(int id, UpdateUser user) returns sql:ParameterizedQuery => `

        UPDATE users 
        SET name = ${user.name}, 
            age = ${user.age}
        WHERE id = ${id}
    
`;

# Builds query to delete a user from the database
#
# + id - Unique identifier of the user to delete
# + return - Parameterized SQL query for deleting user
isolated function deleteUserQuery(int id) returns sql:ParameterizedQuery => `
DELETE FROM users WHERE id = ${id}`;

