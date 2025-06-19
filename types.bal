// Copyright (c) 2025 Dineth. All Rights Reserved.
//
// This module contains type definitions for the database entities.

# Represents a user entity in the system
#
# + id - Unique identifier for the user (immutable)
# + name - Full name of the user
# + age - Age of the user in years
public type User record {
    readonly string id;
    string name;
    int age;
};
