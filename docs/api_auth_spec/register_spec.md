## Auth Specification

### Register

Method: **POST**

URL: **/api/v1/auth/register**

Request Body:

```json
{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "password": "password123"
}
```

Response Body (201 Created):

```json
{
  "message": "User registered successfully, check your email for verification"
}
```

Response Body (400 Bad Request):

```json
{
  "status": "error",
  "message": "Invalid request",
  "errors": {
    "name": "Name is required",
    "email": "Email is required",
    "password": "Password is required"
  }
}
```

Response Body (409 Conflict):

```json
{
  "status": "error",
  "message": "User already exists"
}
```
