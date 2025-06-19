// Copyright (c) 2025 Dineth. All Rights Reserved.
//
// This module manages the MySQL database connection configuration and client initialization.

import ballerinax/mysql;

# Database host address
configurable string dbHost = "localhost";

# Database port number
configurable int dbPort = 3306;

# Database name
configurable string dbName = "BAL";

# Database username
configurable string dbUser = "root";

# Database password
configurable string dbPassword = "RANsql33@#";

# MySQL database client instance
# Configured with connection parameters for the BAL database
final mysql:Client db = check new (
    host = dbHost,
    port = dbPort,
    database = dbName,
    user = dbUser,
    password = dbPassword
);
