// Copyright (c) 2025 Dineth. All Rights Reserved.
//
// This module contains database operations for user management.
// All functions are isolated for concurrent execution safety.

import ballerina/http;
import ballerina/sql;

# Retrieves all users from the database
#
# + return - Array of all users or error if operation fails
public isolated function getAllUsers() returns User[]|error {
    stream<User, sql:Error?> userStream = db->query(getAllUsersQueries());

    return from User u in userStream
        select u;
}

# Fetches a specific user by their unique ID
#
# + id - Unique identifier of the user to retrieve
# + return - User record or error if user not found or operation fails
public isolated function getUserById(string id) returns User|error {
    User|sql:Error foundUser = db->queryRow(getUserByIdQueries(id));

    return foundUser;
}

# Searches for a user by name and returns HTTP response
#
# + name - Name of the user to search for
# + return - HTTP response with search results or error
public isolated function searchUser(string name) returns http:Response|error {
    http:Response response = new;

    User|sql:Error foundUser = db->queryRow(searchUserQueries(name));

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

# Adds a new user to the database
#
# + user - User record containing the new user's details
# + return - Created user record or error if operation fails
public isolated function addUser(User user) returns User|error {
    _ = check db->execute(addUserQueries(user));

    return user;
}

# Updates an existing user's information
#
# + id - Unique identifier of the user to update
# + user - Updated user details
# + return - HTTP response indicating success/failure or error
public isolated function updateUser(string id, User user) returns http:Response|error {

    http:Response response = new;

    User|sql:Error foundUser = db->queryRow(findUserQuery(id));

    if foundUser is sql:NoRowsError {
        response.statusCode = http:STATUS_NOT_FOUND
;
        response.setPayload({
            status: "error",
            message: "User not found",
            searchUserId: id
        });
        return response;
    } else if foundUser is sql:Error {
        return error("Error fetching user: " + foundUser.message());
    }

    // Update the user in the database
    sql:ExecutionResult|sql:Error updateResult = db->execute(updateUserQueries(id, user));

    if updateResult is sql:Error {
        response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
        response.setPayload({
            status: "error",
            message: "Failed to update user: " + updateResult.message()
        });
        return response;
    }

    response.statusCode = http:STATUS_OK;
    response.setPayload({
        status: "success",
        message: "User updated successfully",
        updatedUserId: id,
        affectedRows: updateResult.affectedRowCount
    });
    return response;

}

# Deletes a user from the database
#
# + id - Unique identifier of the user to delete
# + return - HTTP response indicating success/failure or error
public isolated function deleteUser(string id) returns http:Response|error {
    http:Response response = new;

    User|sql:Error foundUser = db->queryRow(findUserQuery(id));

    if foundUser is sql:NoRowsError {
        response.statusCode = http:STATUS_NOT_FOUND;
        response.setPayload({
            status: "error",
            message: "user not found",
            searchedUserId: id
        });
        return response;
    } else if foundUser is sql:Error {
        return error("Error fetching user: " + foundUser.message());
    }

    sql:ExecutionResult|sql:Error deleteResult = db->execute(deleteUserQuery(id));

    if deleteResult is sql:Error {
        response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
        response.setPayload({
            status: "error",
            message: "Failed to delete user: " + deleteResult.message()
        });
        return response;
    }

    response.statusCode = http:STATUS_OK;
    response.setPayload({
        status: "success",
        message: "User deleted successfully",
        deletedUser: "foundUser"
    });
    return response;
}

