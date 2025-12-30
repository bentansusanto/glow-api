### Verify Account

Method: **POST**

URL: **/api/v1/auth/verify-account?token={token}**

Response Body (200 OK):

```json
{
  "status": "success",
  "message": "Account verified successfully"
}
```

Response Error (400 Bad Request):

```json
{
  "status": "error",
  "message": "Token is expired or invalid"
}
```

Response Error (404 Not Found):

```json
{
  "status": "error",
  "message": "Token not found"
}
```
