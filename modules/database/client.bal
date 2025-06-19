// Copyright (c) 2025 Dineth. All Rights Reserved.
import ballerinax/mysql;

configurable DatabaseConfig dbConfig = ?;

# MySQL database client instance
# Configured with connection parameters for the BAL database
final mysql:Client db = check new (
    host = dbConfig.host,
    port = dbConfig.port,
    database = dbConfig.database,
    user = dbConfig.user,
    password = dbConfig.password
);
