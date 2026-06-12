# Measurements

## Overview

### Available Operations

* [list](#list) - List and filter measurements
* [get](#get) - Get measurement

## list

List measurements for a procedure with filtering by phase, measurement, value, outcome, date range, unit, and run details. Cursor-paginated.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Measurements.list('procedureId', '550e8400-e29b-41d4-a716-446655440000', 'phaseName', 'example-value', 'measurementName', 'example-value');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `procedureId` | `string` | :heavy_check_mark: | Procedure to list measurements for. Required: measurements are scoped to a single procedure. | 550e8400-e29b-41d4-a716-446655440000 |
| `phaseName` | `string (optional)` | :heavy_minus_sign: | N/A | example-value |
| `measurementName` | `string (optional)` | :heavy_minus_sign: | N/A | example-value |
| `phaseNames` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `outcomes` | `cell array of string` | :heavy_minus_sign: | N/A | {'PASS', 'FAIL'} |
| `ids` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `durationMin` | `string (optional)` | :heavy_minus_sign: | N/A | example-value |
| `durationMax` | `string (optional)` | :heavy_minus_sign: | N/A | example-value |
| `deploymentIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `procedureVersions` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `environments` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `serialNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `partNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `revisionNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `batchNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `operatedByIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `createdByStationIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `createdByUserIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `startedAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `startedBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `excludeRetries` | `logical (optional)` | :heavy_minus_sign: | Exclude retried phase attempts, keeping only the final attempt. | true |
| `valueMin` | `double (optional)` | :heavy_minus_sign: | N/A | 3.14 |
| `valueMax` | `double (optional)` | :heavy_minus_sign: | N/A | 3.14 |
| `valueBool` | `logical (optional)` | :heavy_minus_sign: | N/A | true |
| `valueStrings` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `measurementOutcomes` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `measurementTypes` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `sortBy` | `string` | :heavy_minus_sign: | Field to sort results by. | created_at |
| `sortOrder` | `string` | :heavy_minus_sign: | Sort order direction. | desc |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of measurements to return. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | Cursor for pagination. Use next_cursor from the previous response to fetch the next page. | 0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## get

Get a single measurement by ID, with its value, validators, and run context.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Measurements.get('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | ID of the measurement to retrieve. | 550e8400-e29b-41d4-a716-446655440000 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

