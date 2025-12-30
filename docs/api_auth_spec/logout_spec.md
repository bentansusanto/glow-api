### Logout

Method: **POST**

URL: **/api/v1/auth/logout**

Response Body (200 OK):

```json
{
  "status": "success",
  "message": "Logout successful"
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
