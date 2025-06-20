# Greeter - User Management API

A RESTful user management service built with Ballerina, providing CRUD operations for user entities with MySQL database integration.

## Features

- 🔍 **Retrieve Users**: Get all users or find specific users by ID or name
- ➕ **Add Users**: Create new user records
- ✏️ **Update Users**: Modify existing user information
- ❌ **Delete Users**: Remove users from the system
- 🗄️ **MySQL Integration**: Robust database connectivity with connection pooling
- 📊 **Observability**: Built-in observability features enabled
- 🛡️ **Error Handling**: Comprehensive error responses with proper HTTP status codes

## API Endpoints

| Method | Endpoint              | Description             |
| ------ | --------------------- | ----------------------- |
| GET    | `/users`              | Get all users           |
| GET    | `/user/{id}`          | Get user by ID          |
| GET    | `/user/search/{name}` | Search user by name     |
| POST   | `/user`               | Create a new user       |
| PUT    | `/user/{id}`          | Update an existing user |
| DELETE | `/user/{id}`          | Delete a user           |

## Prerequisites

- [Ballerina](https://ballerina.io/) (v2201.12.7 or later)
- MySQL Server
- Java 21 (required for Ballerina runtime)

## Database Setup

1. Start your MySQL server
2. Run the database initialization script:
   ```sql
   mysql -u root -p < resources/database/database.sql
   ```

This will create:

- A `user` database
- A `users` table with sample data
- Three initial users: Alice (30), Bob (25), and Lithika (45)

## Configuration

Update the database configuration in `Config.toml`:

```toml
[greeter.database.dbConfig]
host = "localhost"
port = 3306
database = "BAL"
user = "root"
password = "your_password"
```

## Running the Service

1. Clone the repository
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   bal pack
   ```
4. Run the service:
   ```bash
   bal run
   ```

The service will start on `http://localhost:9090`

## Example Usage

### Get all users

```bash
curl http://localhost:9090/users
```

### Get user by ID

```bash
curl http://localhost:9090/user/1
```

### Create a new user

```bash
curl -X POST http://localhost:9090/user \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "age": 28}'
```

### Update a user

```bash
curl -X PUT http://localhost:9090/user/1 \
  -H "Content-Type: application/json" \
  -d '{"name": "Jane Doe", "age": 30}'
```

### Delete a user

```bash
curl -X DELETE http://localhost:9090/user/1
```

### Search user by name

```bash
curl http://localhost:9090/user/search/Alice
```

## Project Structure

```
greeter/
├── Ballerina.toml          # Project configuration
├── Config.toml             # Database configuration
├── Dependencies.toml       # Project dependencies
├── service.bal             # Main REST API service
├── types.bal               # Type definitions
├── modules/
│   └── database/
│       ├── client.bal      # Database client setup
│       ├── db_function.bal # Database operations
│       ├── db_queries.bal  # SQL queries
│       └── types.bal       # Database types
└── resources/
    └── database/
        └── database.sql    # Database schema
```

## Response Format

### Success Response

```json
{
  "id": 1,
  "name": "Alice",
  "age": 30
}
```

### Error Response

```json
{
  "status": "error",
  "message": "User not found",
  "searchUserId": 999
}
```

## Building for Production

To build the project:

```bash
bal build
```

The compiled JAR files will be available in the `target/bin/` directory.

## License

Copyright (c) 2025 Dineth. All Rights Reserved.

---

**Note**: This is a demo project for learning Ballerina with database integration.
