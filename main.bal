// import ballerina/http;
// import ballerina/io;
// import ballerina/sql;
// import ballerinax/mysql;
// import ballerinax/mysql.driver as _;

// public type User record {|
//     @sql:Column {name: "id"}
//     readonly string id;
//     @sql:Column {name: "name"}
//     string name;
//     @sql:Column {name: "age"}
//     int age;
// |};

// final mysql:Client db = check new ("localhost", "root", "RANsql33@#", "BAL", 3306);

// function getAllUsers() returns User[]|error {
//     stream<User, sql:Error?> userStream = db->query(`SELECT * FROM users`);

//     return from User u in userStream
//         select u;
// }

// function getUserById(string id) returns User|http:NotFound|error {
//     io:println("Fetching user with id: ", id);

//     User|sql:Error foundUser = db->queryRow(`SELECT * FROM users WHERE id = ${id}`);

//     if foundUser is sql:NoRowsError {
//         return http:NOT_FOUND;
//     } else if foundUser is sql:Error {
//         return error("Error fetching user: " + foundUser.message());
//     } else {
//         return foundUser;
//     }
// }

// function searchUser(string name) returns http:Response|error {
//     io:println("Searching users with name: ", name);
//     http:Response response = new;

//     User|sql:Error foundUser = db->queryRow(`SELECT * FROM users WHERE name = ${name}`);

//     if foundUser is sql:NoRowsError {
//         response.statusCode = http:STATUS_NOT_FOUND;
//         response.setPayload({
//             status: "error",
//             message: "User not found",
//             searchTerm: name
//         });
//         return response;
//     } else if foundUser is sql:Error {
//         return error("Error fetching user: " + foundUser.message());
//     }

//     response.statusCode = http:STATUS_OK;
//     response.setPayload({
//         status: "success",
//         message: "Users found",
//         users: name
//     });

//     return response;
// }

// function addUser(User user) returns User|error {
//     _ = check db->execute(`INSERT INTO users (id, name, age) VALUES (${user.id}, ${user.name}, ${user.age})`);

//     return user;
// }

// function updateUser(string name, User user) returns http:Response|error {
//     io:println("Updating user with name: ", name);
//     http:Response response = new;

//     User|sql:Error foundUser = db->queryRow(`SELECT * FROM users WHERE name = ${name}`);

//     if foundUser is sql:NoRowsError {
//         response.statusCode = http:STATUS_NOT_FOUND;
//         response.setPayload({
//             status: "error",
//             message: "User not found",
//             searchTerm: name
//         });
//         return response;
//     } else if foundUser is sql:Error {
//         return error("Error fetching user: " + foundUser.message());
//     }

//     response.statusCode = http:STATUS_ACCEPTED;
//     response.setPayload({
//         status: "success",
//         message: "User updated",
//         searchTerm: name
//     });
//     return response;
// }

// function deleteUser(string name) returns http:Response|error {
//     io:println("Deleting the user with name : ", name);

//     http:Response response = new;

//     // user[] foundUser = from user u in userTable
//     //     where u.name == name
//     //     select u;

//     User|sql:Error foundUser = db->queryRow(`SELECT * FROM users WHERE name = ${name}`);

//     io:println("Found user: ", foundUser);

//     if foundUser is sql:NoRowsError {
//         io:print("User not found : ", foundUser);
//         response.statusCode = http:STATUS_NOT_FOUND;
//         response.setPayload({
//             status: "error",
//             message: "user not found",
//             searchedItem: name
//         });
//         return response;
//     } else if foundUser is sql:Error {
//         return error("Error fetching user: " + foundUser.message());
//     }

//     response.statusCode = http:STATUS_OK;
//     response.setPayload({
//         status: "success",
//         message: "User deleted successfully",
//         deletedUser: "foundUser"
//     });
//     return response;
// }
