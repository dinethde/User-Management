// Copyright (c) 2025 Dineth. All Rights Reserved.
//
// This module defines the REST API service for user management operations.
// Provides CRUD endpoints for user entities with proper HTTP status codes.

import greeter.database as db;

import ballerina/http;
import ballerina/sql;
import ballerinax/mysql.driver as _;

# HTTP listener configured to run on port 9090
listener http:Listener httpListener = new (9090);

# User management REST API service
# Provides endpoints for creating, reading, updating, and deleting users
service / on httpListener {

    # Retrieves all users from the database
    #
    # + return - Array of all users or error if operation fails
    resource function get users() returns db:User[]|error {
        return check db:getAllUsers();
    }

    # Fetches a specific user by their unique ID
    # + id - Unique identifier of the user to retrieve
    # + return - User record or error if user not found or operation fails
    resource function get user/[string id]() returns db:User|error|http:Response {

        http:Response response = new;

        User|sql:Error foundUser = check db:getUserById(id);

        if foundUser is sql:NoRowsError {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload({
                status: "Error",
                messsage: "User not found",
                searchUserId: id
            });

            return response;
        } else if foundUser is sql:Error {
            return error("Error fetching user: " + foundUser.message());
        }

        return foundUser;

    }

    # Searches for a user by name with detailed response
    # + name - Name of the user to search for (query parameter)
    # + return - HTTP response with search results or error
    resource function get user(string name) returns http:Response|error {

        http:Response response = new;

        User|sql:Error foundUser = check db:searchUser(name);

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
    # + user - User data from request payload
    # + return - Created user record or error if operation fails
    resource function post user(@http:Payload db:User user) returns db:User|error {
        return check db:addUser(user);
    }

    # Updates an existing user's information
    #
    # + id - Unique identifier of the user to update
    # + user - Updated user data from request payload
    # + return - HTTP response indicating success/failure or error
    resource function put user/[string id](@http:Payload db:User user) returns http:Response|error {
        http:Response response = new;

        User|sql:Error|sql:ExecutionResult updateResult = check db:updateUser(id, user);

        if updateResult is sql:Error {
            if updateResult is sql:NoRowsError {
                response.statusCode = http:STATUS_NOT_FOUND;
                response.setPayload({
                    status: "error",
                    message: "User not found",
                    searchUserId: id
                });
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
            message: "User updated successfully",
            updatedUser: updateResult
        });
        return response;
    }

    # Deletes a user from the database
    #
    # + id - Unique identifier of the user to delete
    # + return - HTTP response indicating success/failure or error
    resource function delete user/[string id]() returns http:Response|error {

        http:Response response = new;

        User|sql:Error|sql:ExecutionResult deleteUser = check db:deleteUser(id);

        if deleteUser is sql:Error {
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

        response.statusCode = http:STATUS_OK;
        response.setPayload({
            status: "success",
            message: "User updated successfully",
            updatedUser: deleteUser
        });
        return response;
    }
}
