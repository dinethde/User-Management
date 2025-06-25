// This module contains type definitions for the database entities.

# Represents a user entity in the system
#
# + id - Unique identifier for the user (immutable)
# + name - Full name of the user
# + email - User email
# + age - Age of the user in years
public type User record {
    readonly int id;
    string name;
    string? email;
    int age;
};

public type UpdateUser record {
    string name;
    string? email;
    int age;
};

# Database configuration record for connection parameters
#
# + host - Database server hostname
# + port - Database server port number
# + database - Name of the database to connect to
# + user - Username for database authentication
# + password - Password for database authentication
public type DatabaseConfig record {
    string host;
    int port;
    string database;
    string user;
    string password;
};
