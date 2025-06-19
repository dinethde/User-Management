import greeter.database as db;

import ballerina/http;
// import ballerinax/mysql;
import ballerinax/mysql.driver as _;

listener http:Listener httpListener = new (9090);

service / on httpListener {
    // GET API - Fetch all users    
    resource function get users() returns db:User[]|error {
        return check db:getAllUsers();
    }

    resource function get user/[string id]() returns db:User|error {
        return check db:getUserById(id);
    }

    resource function get user(string name) returns http:Response|error {
        return check db:searchUser(name);
    }

    resource function post user(@http:Payload db:User user) returns db:User|error {
        return check db:addUser(user);
    }

    resource function put user/[string id](@http:Payload db:User user) returns http:Response|error {
        return check db:updateUser(id, user);
    }

    resource function delete user/[string id]() returns http:Response|error {
        return check db:deleteUser(id);
    }
}
