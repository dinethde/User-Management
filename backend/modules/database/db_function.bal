import ballerina/io;
import ballerina/sql;

# Retrieves all users from the database
#
# + return - Array of users or an error if the operation fails
public isolated function getAllUsers() returns User[]|error {
    stream<User, sql:Error?> userStream = db->query(getAllUsersQueries());

    return from User u in userStream
        select u;
}

# Finds a user by their unique identifier
#
# + id - The unique identifier of the user
# + return - The user if found, or an error if not found or operation fails
public isolated function getUserById(int id) returns error|User {

    User|sql:Error foundUser = db->queryRow(getUserByIdQueries(id));

    return foundUser;
}

# Searches for a user by their name
#
# + name - The name to search for
# + return - The user if found, or an error if not found or operation fails
public isolated function searchUser(string name) returns User|error {

    User|sql:Error foundUser = db->queryRow(searchUserQueries(name));

    return foundUser;
}

# Creates a new user in the database
#
# + user - The user data to create (without ID)
# + return - The newly created user with generated ID, or an error if creation fails
public isolated function addUser(UpdateUser user) returns User|error {
    sql:ExecutionResult addUser = check db->execute(addUserQueries(user));

    int|string? generatedId = addUser.lastInsertId;

    if generatedId is int {
        User newUser = {
            id: generatedId,
            name: user.name,
            age: user.age
        };
        return newUser;
    }

    return error("Failed to generate user ID");

}

# Updates an existing user's information
#
# + id - The unique identifier of the user to update
# + user - The updated user data
# + return - The updated user, or an error if user not found or update fails
public isolated function updateUser(int id, UpdateUser user) returns User|error {

    User|sql:Error foundUser = db->queryRow(findUserQuery(id));
    io:print(foundUser);

    if foundUser is sql:Error {
        return foundUser;
    }

    sql:ExecutionResult|sql:Error updateResult = db->execute(updateUserQueries(id, user));

    if updateResult is sql:Error {
        return error("Failed to update user: " + updateResult.message());
    }

    User updatedUser = {
        id: id,
        name: user.name,
        age: user.age
    };

    return updatedUser;

}

# Removes a user from the database
#
# + id - The unique identifier of the user to delete
# + return - The deleted user's information, or an error if user not found or deletion fails
public isolated function deleteUser(int id) returns User|error {

    User|sql:Error foundUser = db->queryRow(findUserQuery(id));

    if foundUser is sql:Error {
        return foundUser;
    }

    sql:ExecutionResult|sql:Error deleteResult = db->execute(deleteUserQuery(id));

    if deleteResult is sql:Error {
        return deleteResult;
    }

    User deleteUser = {
        id: id,
        name: foundUser.name,
        age: foundUser.age
    };

    return deleteUser;
}
