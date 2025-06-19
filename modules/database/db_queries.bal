import ballerina/sql;

isolated function getAllUsersQueries() returns sql:ParameterizedQuery =>
`
    SELECT * FROM users
`;

isolated function getUserByIdQueries(string id) returns sql:ParameterizedQuery =>
`
SELECT * FROM users WHERE id = ${id}
`;

isolated function searchUserQueries(string name) returns sql:ParameterizedQuery =>
`
SELECT * FROM users WHERE name = ${name}
`;

isolated function addUserQueries(User user) returns sql:ParameterizedQuery =>
`
INSERT INTO users (id, name, age) VALUES (${user.id}, ${user.name}, ${user.age})
`;

isolated function findUserQuery(string id) returns sql:ParameterizedQuery => `
SELECT * FROM users WHERE id = ${id}
`;

isolated function updateUserQueries(string id, User user) returns sql:ParameterizedQuery => `

        UPDATE users 
        SET name = ${user.name}, 
            age = ${user.age}
        WHERE id = ${id}
    
`;

isolated function deleteUserQuery(string id) returns sql:ParameterizedQuery => `
DELETE FROM users WHERE id = ${id}`;

