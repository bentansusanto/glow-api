### Forgot Password

Method: **POST**

URL: **/api/v1/auth/forgot-password**

Request Body:

```json
{
  "email": "user@example.com"
}
```

Response Body (200 OK):

```json
{
  "status": "success",
  "message": "Reset password email sent successfully, check your email"
}
```

Response Error (400 Bad Request):

```json
{
  "status": "error",
  "message": "Invalid request or not verified"
}
```

Response Error (404 Not Found):

```json
{
  "status": "error",
  "message": "User not found"
}
```
