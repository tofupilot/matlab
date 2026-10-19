# Identity

## Overview

### Available Operations

* [whoami](#whoami) - Who am I

## whoami

The identity the request is authenticated as: the station or the user behind the API key, and its organization. Works with both kinds of key; `type` says which one. Use it before a call that only one kind may make, instead of catching that call's refusal.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Identity.whoami();
```

### Parameters

No parameters required.


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 408 | 408 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

