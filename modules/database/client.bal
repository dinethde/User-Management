import ballerinax/mysql;

configurable string dbHost = "localhost";
configurable int dbPort = 3306;
configurable string dbName = "BAL";
configurable string dbUser = "root";
configurable string dbPassword = "RANsql33@#";

final mysql:Client db = check new (
    host = dbHost,
    port = dbPort,
    database = dbName,
    user = dbUser,
    password = dbPassword
);
