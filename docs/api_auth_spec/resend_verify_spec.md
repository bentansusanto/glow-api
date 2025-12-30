### Resend Verification

Method: **POST**

URL: **/api/v1/auth/resend-verification**

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
  "message": "Resend verification email sent successfully, check your email"
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
