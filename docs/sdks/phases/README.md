# Phases

## Overview

### Available Operations

* [list](#list) - List and filter phases
* [get](#get) - Get phase

## list

List phases for a procedure with filtering by outcome, date range, unit, and run details. Cursor-paginated.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Phases.list('procedureId', '550e8400-e29b-41d4-a716-446655440000', 'names', {'value-1', 'value-2'}, 'outcomes', {'PASS', 'FAIL'});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `procedureId` | `string` | :heavy_check_mark: | Procedure to list phases for. Required: phases are scoped to a single procedure. | 550e8400-e29b-41d4-a716-446655440000 |
| `names` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `outcomes` | `cell array of string` | :heavy_minus_sign: | N/A | {'PASS', 'FAIL'} |
| `startedAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `startedBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `excludeRetries` | `logical (optional)` | :heavy_minus_sign: | N/A | true |
| `runOutcomes` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `ids` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `durationMin` | `string (optional)` | :heavy_minus_sign: | N/A | example-value |
| `durationMax` | `string (optional)` | :heavy_minus_sign: | N/A | example-value |
| `deploymentIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `procedureVersions` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `environments` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `operatedByIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `operatedByNames` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `createdByStationIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `createdByUserIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `serialNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `partNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `revisionNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `batchNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `samples` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `sortBy` | `string` | :heavy_minus_sign: | Field to sort results by. | created_at |
| `sortOrder` | `string` | :heavy_minus_sign: | Sort order direction. | desc |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of phases to return. | 20 |
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

Get a single phase by ID, with its measurements and run context.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Phases.get('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | ID of the phase to retrieve. | 550e8400-e29b-41d4-a716-446655440000 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

