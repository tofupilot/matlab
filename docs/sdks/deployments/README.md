# Deployments

## Overview

### Available Operations

* [list](#list) - List and filter deployments
* [get](#get) - Get deployment

## list

List deployments with filtering by procedure, environment, build status, branch, author, and date range. Cursor-paginated.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Deployments.list('procedureIds', {'value-1', 'value-2'}, 'environments', {}, 'buildStatuses', {});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `procedureIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `environments` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `buildStatuses` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `pushed` | `logical (optional)` | :heavy_minus_sign: | N/A | true |
| `branchNames` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `authorUsernames` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `deployedAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `deployedBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | N/A | search-term |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of deployments to return. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | Cursor for pagination. Use next_cursor from the previous response to fetch the next page. | 0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## get

Get a deployment by ID, with its artifact metadata, commit, creator, and per-station push state.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Deployments.get('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | The deployment ID to retrieve. | 550e8400-e29b-41d4-a716-446655440000 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

