# Stations

## Overview

### Available Operations

* [list](#list) - List and filter stations
* [create](#create) - Create station
* [getCurrent](#getcurrent) - Get current station
* [get](#get) - Get station
* [remove](#remove) - Remove station
* [update](#update) - Update station

## list

Retrieve a paginated list of test stations in your organization. Search by station name and filter by status for station fleet management.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Stations.list('limit', 20, 'cursor', 0, 'searchQuery', 'search-term');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `limit` | `double (optional)` | :heavy_minus_sign: | Number of stations to return per page | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | N/A | 0 |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | N/A | search-term |
| `procedureIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## create

Create a new test station in TofuPilot to register production equipment and link it to test procedures.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.name = 'Example Name';
req.procedure_id = '550e8400-e29b-41d4-a716-446655440000';

response = sdk.Stations.create(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `name` | `string` | :heavy_check_mark: | Name of the station | Example Name |
| `procedure_id` | `string (optional)` | :heavy_minus_sign: | Optional procedure ID to link the station to | 550e8400-e29b-41d4-a716-446655440000 |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 403 | 403 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## getCurrent

Retrieve detailed information about the currently authenticated station including linked procedures and connection status.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Stations.getCurrent();
```

### Parameters

No parameters required.


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 403 | 403 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## get

Retrieve detailed station information including linked procedures, connection status, and recent activity.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Stations.get('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | Unique identifier of the station to retrieve | 550e8400-e29b-41d4-a716-446655440000 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## remove

Remove a test station. Deletes permanently if unused, or archives with preserved historical data if runs exist.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Stations.remove('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | Unique identifier of the station to remove | 550e8400-e29b-41d4-a716-446655440000 |


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

Update station name and/or image. The station ID is specified in the URL path. To remove an image, pass an empty string for image_id.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.name = 'Example Name';
req.image_id = 'example-value';
req.team_id = 'example-value';

response = sdk.Stations.update('550e8400-e29b-41d4-a716-446655440000', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | Unique identifier of the station to update | 550e8400-e29b-41d4-a716-446655440000 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `name` | `string (optional)` | :heavy_minus_sign: | New name for the station | Example Name |
| `image_id` | `string (optional)` | :heavy_minus_sign: | Upload ID for the station image, or empty string to remove image | example-value |
| `team_id` | `string (optional)` | :heavy_minus_sign: | Team ID to assign this station to, or null to unassign | example-value |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

