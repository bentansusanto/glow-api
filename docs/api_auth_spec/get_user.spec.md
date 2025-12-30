### Get User

Method: **GET**

URL: **/api/v1/auth/get-user**

Response Body (200 OK):

```json
{
  "status": "success",
  "message": "User retrieved successfully",
  "data": {
    "id": "1234567890",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "role_id": "1",
    "role" : {
      "id": "1",
      "name": "Admin",
      "code": "admin"
    },
    "is_verified": true,
    "is_active": true,
    "created_at": "2022-01-01T00:00:00.000Z",
    "updated_at": "2022-01-01T00:00:00.000Z"
  }
}
```

Response Error (400 Bad Request):

```json
{
  "status": "error",
  "message": "Invalid request"
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
  "message": "Unauthorized"
}
```
