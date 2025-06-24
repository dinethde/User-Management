// This module defines the REST API service for user management operations.
// Provides CRUD endpoints for user entities with proper HTTP status codes.
import User_Management.database as db;

import ballerina/http;
import ballerina/io;
import ballerina/sql;
import ballerinax/mysql.driver as _;

# HTTP listener configured to run on port 9090
listener http:Listener httpListener = new (9090);

// function init() {
//     init();
// }

int portNumber = 5173;

@http:ServiceConfig {
    cors: {
        allowOrigins: [string `http://localhost:${portNumber}`], // Your React app URL
        allowCredentials: true,
        allowHeaders: ["Content-Type", "Authorization"],
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    }
}
service / on httpListener {

    # Retrieves all users from the database
    #
    # + return - Array of all users or an error if the operation fails
    resource function get users() returns db:User[]|error {
        io:print("API REQUEST FOR GET ALL USERS RECIEVED");
        return check db:getAllUsers();
    }

    # Finds a specific user by their unique identifier
    #
    # + id - The unique identifier of the user to retrieve
    # + return - The user data, error response if not found, or error if operation fails
    resource function get user/[int id]() returns db:User|error|http:Response {

        http:Response response = new;

        User|sql:Error|error foundUser = db:getUserById(id);

        if foundUser is sql:NoRowsError {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setJsonPayload({
                status: "error",
                message: "User not found",
                searchUserId: id
            });
            return response;
        } else if foundUser is sql:Error {
            response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
            response.setJsonPayload({
                status: "error",
                message: "Database error occurred",
                details: foundUser.message()
            });
            return response;
        }

        // foundUser is guaranteed to be User type here
        return foundUser;

    }

    # Searches for a user by their name
    #
    # + name - The name to search for
    # + return - HTTP response with user data if found, or error response if not found
    resource function get user(string name) returns http:Response|error {

        http:Response response = new;

        User|sql:Error|error foundUser = db:searchUser(name);

        if foundUser is sql:NoRowsError {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload({
                status: "error",
                message: "User not found",
                searchTerm: name
            });
            return response;
        } else if foundUser is sql:Error {
            return error("Error fetching user: " + foundUser.message());
        }

        response.statusCode = http:STATUS_OK;
        response.setPayload({
            status: "success",
            message: "Users found",
            users: name
        });

        return response;
    }

    # Creates a new user in the database
    #
    # + user - The user data to create (without ID)
    # + return - The newly created user with generated ID, or an error if creation fails
    resource function post user(@http:Payload UpdateUser user) returns db:User|error {
        return check db:addUser(user);
    }

    # Updates an existing user's information
    #
    # + id - The unique identifier of the user to update
    # + user - The updated user data
    # + return - HTTP response indicating success or failure of the update operation
    resource function put user/[int id](@http:Payload UpdateUser user) returns http:Response|error {

        http:Response response = new;

        User|error updateResult = db:updateUser(id, user);

        io:print(updateResult);

        if updateResult is sql:Error {
            if updateResult is sql:NoRowsError {
                response.statusCode = http:STATUS_NOT_FOUND;
                response.setPayload({
                    status: "error",
                    message: "user not found",
                    searchedUserId: id
                });
                return response;
            } else {
                response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                response.setPayload({
                    status: "error",
                    message: "Failed to update user: " + updateResult.message()
                });
            }

            return response;
        }

        response.statusCode = http:STATUS_OK;
        response.setPayload({
            status: "success",
            message: "User updated successfully"
        });
        return response;

    }

    # Removes a user from the database
    #
    # + id - The unique identifier of the user to delete
    # + return - HTTP response with deleted user data or error response if operation fails
    resource function delete user/[int id]() returns http:Response|error|User {

        http:Response response = new;

        User|error deleteUser = db:deleteUser(id);

        if deleteUser is User {
            // response.statusCode = http:STATUS_OK;
            return deleteUser;
        }

        if deleteUser is sql:NoRowsError {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload({
                status: "error",
                message: "user not found",
                searchedUserId: id
            });
            return response;
        } else {
            response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
            response.setPayload({
                status: "error",
                message: "Failed to update user: " + deleteUser.message()
            });
        }

        return response;

    }
}
