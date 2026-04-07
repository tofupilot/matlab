# Procedures

## Overview

### Available Operations

* [list](#list) - List and filter procedures
* [create](#create) - Create procedure
* [get](#get) - Get procedure
* [delete](#delete) - Delete procedure
* [update](#update) - Update procedure

## list

Retrieve procedures with optional filtering and search. Returns procedure data including creator and linked repository.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Procedures.list('limit', 20, 'cursor', 0, 'searchQuery', 'search-term');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of procedures to return per page. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | N/A | 0 |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | N/A | search-term |
| `createdAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `createdBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## create

Create a new test procedure that can be used to organize and track test runs. The procedure serves as a template or framework for organizing test execution.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.name = 'Example Name';

response = sdk.Procedures.create(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `name` | `string` | :heavy_check_mark: | Name of the procedure. Must be unique within the organization. | Example Name |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## get

Retrieve a single procedure by ID, including recent test runs, linked stations, and version history.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Procedures.get('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | Unique identifier of the procedure to retrieve. | 550e8400-e29b-41d4-a716-446655440000 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## delete

Permanently delete a procedure, removing all associated runs, phases, measurements, and attachments.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Procedures.delete('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | Unique identifier of the procedure to delete. | 550e8400-e29b-41d4-a716-446655440000 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## update

Update a test procedure's name or configuration. The procedure is identified by its unique ID in the URL path. Only provided fields are modified.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.name = 'Example Name';

response = sdk.Procedures.update('550e8400-e29b-41d4-a716-446655440000', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | Unique identifier of the procedure to update. | 550e8400-e29b-41d4-a716-446655440000 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `name` | `string` | :heavy_check_mark: | New name for the procedure. | Example Name |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

