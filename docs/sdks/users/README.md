# Users

## Overview

### Available Operations

* [list](#list) - List users

## list

List users in your organization. Set `current=true` to return only the authenticated user.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Users.list('current', true);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `current` | `logical (optional)` | :heavy_minus_sign: | If true, returns only the current authenticated user | true |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

