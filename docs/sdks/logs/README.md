# Logs

## Overview

### Available Operations

* [list](#list) - List and filter logs
* [get](#get) - Get log

## list

List logs with filtering by run, procedure, level, date range, unit, and source. Cursor-paginated.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Logs.list('procedureIds', {'value-1', 'value-2'}, 'searchQuery', 'search-term', 'levels', {});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `procedureIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | N/A | search-term |
| `levels` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `timestampAfter` | `string (optional)` | :heavy_minus_sign: | Filter logs recorded at or after this timestamp. | 2026-01-15T10:30:00Z |
| `timestampBefore` | `string (optional)` | :heavy_minus_sign: | Filter logs recorded at or before this timestamp. | 2026-01-15T10:30:00Z |
| `sourceFiles` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `runIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `runOutcomes` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `procedureVersions` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `deploymentIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `environments` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `serialNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `partNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `revisionNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `batchNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `samples` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `createdByStationIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `createdByUserIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `sortBy` | `string` | :heavy_minus_sign: | Field to sort results by. | created_at |
| `sortOrder` | `string` | :heavy_minus_sign: | Sort order direction. | desc |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of logs to return. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | N/A | 0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 408 | 408 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## get

Get a single log entry by ID, with its run and unit context.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Logs.get('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | Unique identifier for the log entry. | 550e8400-e29b-41d4-a716-446655440000 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 408 | 408 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

