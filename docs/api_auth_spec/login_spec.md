### Login

Method: **POST**

URL: **/api/v1/auth/login**

Request Body:

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

Response Body (200 OK):

```json
{
  "status": "success",
  "message": "Login successful",
  "data": {
    "id": "1234567890",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "role_id": "1",
    "is_verified": true,
    "is_active": true,
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
  }
}
```

Response Error (400 Bad Request):

```json
{
  "status": "error",
  "message": "Invalid request",
  "errors": {
    "email": "Email is required",
    "password": "Password is required"
  }
}
```

Response Error (404 Not Found):

```json
{
  "status": "error",
  "message": "User not found"
}
```

Response Error (401 Unauthorized):

```json
{
  "status": "error",
  "message": "Invalid credentials"
}
```
