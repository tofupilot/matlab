# Parts

## Overview

### Available Operations

* [list](#list) - List and filter parts
* [create](#create) - Create part
* [get](#get) - Get part
* [delete](#delete) - Delete part
* [update](#update) - Update part

## list

Retrieve a paginated list of parts and components in your organization. Filter and search by part name, number, or revision number for inventory management.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Parts.list('limit', 20, 'cursor', 0, 'searchQuery', 'search-term');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of parts to return in a single page. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | N/A | 0 |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | N/A | search-term |
| `procedureIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `sortBy` | `string` | :heavy_minus_sign: | Field to sort results by. | created_at |
| `sortOrder` | `string` | :heavy_minus_sign: | Sort order direction. | desc |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## create

Create a new part. Optionally create with a revision. Part numbers are matched case-insensitively (e.g., "PART-001" and "part-001" are considered the same).
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.number = 'PCB-V2.0';
req.name = 'Example Name';
req.revision_number = 'REV-A';

response = sdk.Parts.create(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | Unique identifier number for the part. | PCB-V2.0 |
| `name` | `string (optional)` | :heavy_minus_sign: | Human-readable name for the part. If not provided, a default name will be used. | Example Name |
| `revision_number` | `string (optional)` | :heavy_minus_sign: | Revision identifier for the part version. If not provided, default revision identifier will be used. | REV-A |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## get

Retrieve a single part by its number, including all revisions, metadata, and linked units. Part numbers are matched case-insensitively.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Parts.get('PCB-V2.0');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | Part number of the part to retrieve. | PCB-V2.0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## delete

Permanently delete a part and all its revisions. This removes all associated data and cannot be undone.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Parts.delete('PCB-V2.0');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | Part number to delete. | PCB-V2.0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## update

Update a part's number or name. Identifies the part by its current number in the URL with case-insensitive matching.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.new_number = 'PCB-V3.0';
req.name = 'Example Name';

response = sdk.Parts.update('PCB-V2.0', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | Part number of the part to update. | PCB-V2.0 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `new_number` | `string (optional)` | :heavy_minus_sign: | New unique identifier number for the part. | PCB-V3.0 |
| `name` | `string (optional)` | :heavy_minus_sign: | New human-readable name for the part. | Example Name |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

