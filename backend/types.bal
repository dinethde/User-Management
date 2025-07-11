// Copyright (c) 2025 Dineth. All Rights Reserved.
//
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
