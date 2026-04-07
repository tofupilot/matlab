# User

## Overview

### Available Operations

* [list](#list) - List users

## list

Retrieve a list of users in your organization. Use the current parameter to get only the authenticated user profile and permissions.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.User.list('current', true);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `current` | `logical (optional)` | :heavy_minus_sign: | If true, returns only the current authenticated user | true |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

