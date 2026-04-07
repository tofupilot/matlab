# Batches

## Overview

### Available Operations

* [get](#get) - Get batch
* [delete](#delete) - Delete batch
* [update](#update) - Update batch
* [list](#list) - List and filter batches
* [create](#create) - Create batch

## get

Retrieve a single batch by its number, including all associated units, serial numbers, and part revisions.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Batches.get('PCB-V2.0');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | Number of the batch to retrieve. | PCB-V2.0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## delete

Permanently delete a batch by number. Units associated with the batch will be disassociated but not deleted. No nested elements are removed.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Batches.delete('PCB-V2.0');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | N/A | PCB-V2.0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## update

Update a batch number. The current batch number is specified in the URL path with case-insensitive matching.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.new_number = 'PCB-V3.0';

response = sdk.Batches.update('PCB-V2.0', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | Current batch number to update. | PCB-V2.0 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `new_number` | `string` | :heavy_check_mark: | New batch number. | PCB-V3.0 |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## list

Retrieve batches with associated units, serial numbers, and part revisions using cursor-based pagination.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Batches.list('ids', {'value-1', 'value-2'}, 'numbers', {'value-1', 'value-2'}, 'createdAfter', '2026-01-15T10:30:00Z');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `ids` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `numbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `createdAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `createdBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of batches to return. Use `cursor` to fetch additional results. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | N/A | 0 |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | N/A | search-term |
| `partNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `revisionNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `sortBy` | `string` | :heavy_minus_sign: | Field to sort results by. | created_at |
| `sortOrder` | `string` | :heavy_minus_sign: | Sort order direction. | desc |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## create

Create a new batch without any units attached. Batch numbers are matched case-insensitively (e.g., "BATCH-001" and "batch-001" are considered the same).
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.number = 'PCB-V2.0';

response = sdk.Batches.create(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | The batch number identifier | PCB-V2.0 |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

