# Units

## Overview

### Available Operations

* [list](#list) - List and filter units
* [create](#create) - Create unit
* [delete](#delete) - Delete units
* [get](#get) - Get unit
* [update](#update) - Update unit
* [addChild](#addchild) - Add sub-unit
* [removeChild](#removechild) - Remove sub-unit

## list

Retrieve a paginated list of units with filtering by serial number, part number, and batch. Uses cursor-based pagination for efficient large dataset traversal.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Units.list('searchQuery', 'search-term', 'ids', {'value-1', 'value-2'}, 'serialNumbers', {'value-1', 'value-2'});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | N/A | search-term |
| `ids` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `serialNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `partNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `revisionNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `batchNumbers` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `procedureIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `outcomes` | `cell array of string` | :heavy_minus_sign: | N/A | {'PASS', 'FAIL'} |
| `startedAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `startedBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `latestOnly` | `logical (optional)` | :heavy_minus_sign: | N/A | false |
| `runCountMin` | `double (optional)` | :heavy_minus_sign: | N/A | 10 |
| `runCountMax` | `double (optional)` | :heavy_minus_sign: | N/A | 10 |
| `createdAfter` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `createdBefore` | `string (optional)` | :heavy_minus_sign: | N/A | 2026-01-15T10:30:00Z |
| `createdByUserIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `createdByStationIds` | `cell array of string` | :heavy_minus_sign: | N/A | {'value-1', 'value-2'} |
| `excludeUnitsWithParent` | `logical (optional)` | :heavy_minus_sign: | N/A | false |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of units to return. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | N/A | 0 |
| `sortBy` | `string` | :heavy_minus_sign: | Field to sort results by. last_run_at sorts by most recent test run date. last_run_procedure sorts by procedure name of the last run. | created_at |
| `sortOrder` | `string` | :heavy_minus_sign: | Sort order direction. | desc |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## create

Create a new unit with a serial number and link it to a part revision. Units represent individual hardware items tracked for manufacturing traceability.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.serial_number = 'SN-001234';
req.part_number = 'PCB-V1.2';
req.revision_number = 'REV-A';

response = sdk.Units.create(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `serial_number` | `string` | :heavy_check_mark: | Unique serial number identifier for the unit. Must be unique within the organization. | SN-001234 |
| `part_number` | `string` | :heavy_check_mark: | Component part number that defines what type of unit this is. If the part does not exist, it will be created. | PCB-V1.2 |
| `revision_number` | `string` | :heavy_check_mark: | Hardware revision identifier for the specific version of the part. If the revision does not exist, it will be created. | REV-A |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## delete

Permanently delete units by serial number. This action will remove all nested elements and relationships associated with the units.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Units.delete('serialNumbers', {'value-1', 'value-2'});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `serialNumbers` | `cell array of string` | :heavy_check_mark: | Array of unit serial numbers to delete. | {'value-1', 'value-2'} |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## get

Retrieve a single unit by its serial number. Returns comprehensive unit data including part information, parent/child relationships, and test run history.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Units.get('SN-001234');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `serial_number` | `string` | :heavy_check_mark: | Serial number of the unit to retrieve. | SN-001234 |


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

Update unit properties including serial number, part revision, batch assignment, and file attachments with case-insensitive matching.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.new_serial_number = 'example-value';
req.part_number = 'PCB-V1.2';
req.revision_number = 'REV-A';
req.batch_number = 'BATCH-2024-Q1';
req.attachments = {'value-1', 'value-2'};

response = sdk.Units.update('SN-001234', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `serial_number` | `string` | :heavy_check_mark: | Serial number of the unit to update. | SN-001234 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `new_serial_number` | `string (optional)` | :heavy_minus_sign: | New serial number for the unit. | example-value |
| `part_number` | `string (optional)` | :heavy_minus_sign: | New part number for the unit. | PCB-V1.2 |
| `revision_number` | `string (optional)` | :heavy_minus_sign: | New revision number for the unit. | REV-A |
| `batch_number` | `string (optional)` | :heavy_minus_sign: | New batch number for the unit. Set to null to remove batch. | BATCH-2024-Q1 |
| `attachments` | `cell array of string` | :heavy_minus_sign: | Array of upload IDs to attach to the unit. | {'value-1', 'value-2'} |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## addChild

Add a sub-unit to a parent unit to track component assemblies and multi-level hardware traceability.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.child_serial_number = 'SUB-001';

response = sdk.Units.addChild('SN-001234', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `serial_number` | `string` | :heavy_check_mark: | Serial number of the parent unit | SN-001234 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `child_serial_number` | `string` | :heavy_check_mark: | Serial number of the sub-unit to add | SUB-001 |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## removeChild

Remove a sub-unit relationship from a parent unit by serial number. Only unlinks the parent-child relationship; neither unit is deleted from the system.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Units.removeChild('SN-001234', 'childSerialNumber', 'SUB-001');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `serial_number` | `string` | :heavy_check_mark: | Serial number of the parent unit | SN-001234 |
| `childSerialNumber` | `string` | :heavy_check_mark: | Serial number of the sub-unit to remove | SUB-001 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

