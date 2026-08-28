# Stations

## Overview

### Available Operations

* [create](#create) - Create station
* [list](#list) - List and filter stations
* [getCurrent](#getcurrent) - Get current station
* [get](#get) - Get station
* [update](#update) - Update station
* [remove](#remove) - Remove station

## create

Create a station to register production equipment and link it to procedures.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.name = 'Example Name';
req.procedure_id = '550e8400-e29b-41d4-a716-446655440000';
req.metadata = struct();

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
| `metadata` | `string` | :heavy_minus_sign: | Custom metadata to attach to the station (max 50 keys per station). Plain object of key/value pairs; values can be string, number, or boolean. Type is detected from the value. Use it for descriptive fields such as location or asset tag — not for procedure configuration, which belongs to station config. | struct() |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 403 | 403 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## list

List stations. Search by name and filter by status. Cursor-paginated.
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
| `metadata` | `string` | :heavy_minus_sign: | Filter stations by custom metadata. Supports up to 5 keys per request. Per-key operators: string `{in: [...]}`/`{contains: "..."}`, number `{gte, lte, gt, lt, eq}`, bool `{eq: true\|false}`. | struct() |
| `includeMetadata` | `logical (optional)` | :heavy_minus_sign: | When true, includes the custom metadata object on each station in the response. Defaults to false to keep payloads small. | false |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## getCurrent

Get the station the request is authenticated as, with its linked procedures.
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
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## get

Get a station by ID, with its linked procedures and recent activity.
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
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## update

Update a station name and/or image. Pass an empty string for image_id to remove the image.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.name = 'Example Name';
req.image_id = 'example-value';
req.team_id = 'example-value';
req.metadata = struct();

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
| `metadata` | `string` | :heavy_minus_sign: | Custom metadata to upsert on the station. Plain object of key/value pairs. PATCH semantics: keys not present here are preserved. Pass `null` as a value to delete a key. | struct() |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## remove

Remove a station. Deleted if unused; archived (history preserved) if runs reference it.
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
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

