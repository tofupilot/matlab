# Versions

## Overview

### Available Operations

* [get](#get) - Get procedure version
* [delete](#delete) - Delete procedure version
* [create](#create) - Create procedure version

## get

Retrieve a single procedure version by its tag, including version metadata and configuration details.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Procedures.Versions.get('550e8400-e29b-41d4-a716-446655440000', 'v1.0.0');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `procedure_id` | `string` | :heavy_check_mark: | ID of the procedure that owns this version. | 550e8400-e29b-41d4-a716-446655440000 |
| `tag` | `string` | :heavy_check_mark: | Version tag to retrieve. | v1.0.0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## delete

Permanently delete a procedure version by its tag. This removes the version record and all associated configuration data and cannot be undone.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Procedures.Versions.delete('550e8400-e29b-41d4-a716-446655440000', 'v1.0.0');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `procedure_id` | `string` | :heavy_check_mark: | ID of the procedure that owns this version | 550e8400-e29b-41d4-a716-446655440000 |
| `tag` | `string` | :heavy_check_mark: | Version tag to delete | v1.0.0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## create

Create a new version for an existing test procedure. Versions let you track procedure changes over time and maintain a history of test configurations.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.tag = 'v1.0.0';

response = sdk.Procedures.Versions.create('550e8400-e29b-41d4-a716-446655440000', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `procedure_id` | `string` | :heavy_check_mark: | The ID of the procedure this version belongs to | 550e8400-e29b-41d4-a716-446655440000 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `tag` | `string` | :heavy_check_mark: | The version tag | v1.0.0 |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

