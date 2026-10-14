# Users

## Overview

### Available Operations

* [list](#list) - List users
* [getCurrent](#getcurrent) - Get current user

## list

List users in your organization. For the user behind the key, use GET /v2/users/current.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Users.list();
```

### Parameters

No parameters required.


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 408 | 408 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## getCurrent

Get the user the request is authenticated as. The mirror of GET /v2/stations/current: a station key is refused.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Users.getCurrent();
```

### Parameters

No parameters required.


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 403 | 403 | application/json |
| Error 404 | 404 | application/json |
| Error 408 | 408 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

