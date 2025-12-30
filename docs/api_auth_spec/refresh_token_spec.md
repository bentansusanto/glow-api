### Referh Token

Method: **POST**

URL: **/api/v1/auth/refresh-token**

Response Body (200 OK):

```json
{
  "status": "success",
  "message": "Token refreshed successfully",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
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

Response Error (401 Unauthorized):

```json
{
  "status": "error",
  "message": "Unauthorized"
}
```

