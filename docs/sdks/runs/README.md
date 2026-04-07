# Runs

## Overview

### Available Operations

* [list](#list) - List and filter runs
* [create](#create) - Create run
* [delete](#delete) - Delete runs
* [get](#get) - Get run
* [update](#update) - Update run

## list

Retrieve a paginated list of test runs with filtering by unit, procedure, date range, outcome, and station.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Runs.list('searchQuery', 'search-term', 'ids', {'value-1', 'value-2'}, 'outcomes', {'PASS', 'FAIL'});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | N/A | search-term |
| `ids` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `outcomes` | `cell array of string` | :heavy_minus_sign: | N/A | {'PASS', 'FAIL'} |
| `procedureIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `procedureVersions` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `serialNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `partNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `revisionNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `batchNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `durationMin` | `string (optional)` | :heavy_minus_sign: | N/A | example-value |
| `durationMax` | `string (optional)` | :heavy_minus_sign: | N/A | example-value |
| `startedAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `startedBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `endedAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `endedBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `createdAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `createdBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `createdByUserIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `createdByStationIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `operatedByIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of runs to return per page. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | N/A | 0 |
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

Create a new test run, linking it to a procedure and unit. Existing entities are reused automatically.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.outcome = 'PASS';
req.procedure_id = '550e8400-e29b-41d4-a716-446655440000';
req.procedure_version = 'v1.2.3';
req.operated_by = 'john.doe@example.com';
req.started_at = '2026-01-15T10:30:00Z';
req.ended_at = '2026-01-15T10:35:30Z';
req.serial_number = 'SN-001234';
req.part_number = 'PCB-V1.2';
req.revision_number = 'REV-A';
req.batch_number = 'BATCH-2024-Q1';
req.sub_units = {'value-1', 'value-2'};
req.docstring = 'Test run description';
req.phases = {};
req.logs = {};

response = sdk.Runs.create(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `outcome` | `string` | :heavy_check_mark: | Overall test result. Use PASS when test succeeds, FAIL when test fails but script execution completed successfully, ERROR when script execution fails, TIMEOUT when test exceeds time limit, ABORTED for manual script interruption. | PASS |
| `procedure_id` | `string` | :heavy_check_mark: | Procedure ID. Create the procedure in the app first, then find the auto-generated ID on the procedure page. | 550e8400-e29b-41d4-a716-446655440000 |
| `procedure_version` | `string (optional)` | :heavy_minus_sign: | N/A | v1.2.3 |
| `operated_by` | `string (optional)` | :heavy_minus_sign: | Email address of the operator who executed the test run. The operator must exist as a user in the system. The run will be linked to this user to track who performed the test. | john.doe@example.com |
| `started_at` | `string` | :heavy_check_mark: | ISO 8601 timestamp when the test run began execution. This timestamp will be used to track when the test execution started and for historical analysis of test runs. A separate created_at timestamp is stored internally server side to track upload date. | 2026-01-15T10:30:00Z |
| `ended_at` | `string` | :heavy_check_mark: | ISO 8601 timestamp when the test run finished execution. | 2026-01-15T10:35:30Z |
| `serial_number` | `string` | :heavy_check_mark: | Unique serial number of the unit under test. Matched case-insensitively. If no unit with this serial number exists, one will be created. | SN-001234 |
| `part_number` | `string (optional)` | :heavy_minus_sign: | Component part number for the unit. Matched case-insensitively. This field is required if the part number cannot be extracted from the serial number (as set in the settings). This field takes precedence over extraction from serial number. A component with the provided or extracted part number will be created if one does not exist. | PCB-V1.2 |
| `revision_number` | `string (optional)` | :heavy_minus_sign: | Hardware revision identifier for the unit. Matched case-insensitively. If none exist, a revision with this number will be created. If no revision is specified, the unit will be linked to the default revision of the part number. | REV-A |
| `batch_number` | `string (optional)` | :heavy_minus_sign: | Production batch identifier for grouping units manufactured together. Matched case-insensitively. If none exist, a batch with this batch number will be created. If no batch number is specified, the unit will not be linked to any batch. | BATCH-2024-Q1 |
| `sub_units` | `cell array of string` | :heavy_minus_sign: | Array of sub-unit serial numbers that are part of this main unit. Matched case-insensitively. Each sub-unit must already exist and will be linked as a sub-component of the main unit under test. If no sub-units are specified, the unit will be created without sub-unit relationships. | {'value-1', 'value-2'} |
| `docstring` | `string (optional)` | :heavy_minus_sign: | Additional notes or documentation about this test run. | Test run description |
| `phases` | `cell array of string` | :heavy_minus_sign: | Array of test phases with measurements and results. Each phase represents a distinct stage of the test execution with timing information, outcome status, and optional measurements. If no phases are specified, the run will be created without phase-level organization of test data. | {} |
| `logs` | `cell array of string` | :heavy_minus_sign: | Array of log messages generated during the test execution. Each log entry captures events, errors, and diagnostic information with severity levels and source code references. If no logs are specified, the run will be created without log entries. | {} |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 403 | 403 | application/json |
| Error 404 | 404 | application/json |
| Error 422 | 422 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## delete

Permanently delete test runs by their IDs. Removes all associated phases, measurements, and attachments.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Runs.delete('ids', {'value-1', 'value-2'});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `ids` | `cell array of string` | :heavy_check_mark: | Run IDs to delete. | {'value-1', 'value-2'} |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## get

Retrieve a single test run by its ID. Returns comprehensive run data including metadata, phases, measurements, and logs.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Runs.get('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | ID of the run to retrieve. | 550e8400-e29b-41d4-a716-446655440000 |


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

Update a test run, including linking file attachments. Files must be uploaded via Initialize upload and Finalize upload before linking.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.attachments = {'value-1', 'value-2'};

response = sdk.Runs.update('550e8400-e29b-41d4-a716-446655440000', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | Unique identifier of the run to update. | 550e8400-e29b-41d4-a716-446655440000 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `attachments` | `cell array of string` | :heavy_minus_sign: | Array of upload IDs to attach to the run. | {'value-1', 'value-2'} |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

