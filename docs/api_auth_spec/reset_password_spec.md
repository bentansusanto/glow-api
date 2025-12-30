### Reset Password

Method: **POST**

URL: **/api/v1/auth/reset-password?token={token}**

Request Body:

```json
{
  "password": "newpassword123",
  "retry_password": "newpassword123",
  "token": "token"
}
```

Response Body (200 OK):

```json
{
  "status": "success",
  "message": "Password reset successfully"
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
