# Units

## Overview

### Available Operations

* [create](#create) - Create unit
* [list](#list) - List and filter units
* [delete](#delete) - Delete units
* [get](#get) - Get unit
* [update](#update) - Update unit
* [addChild](#addchild) - Add sub-unit
* [removeChild](#removechild) - Remove sub-unit
* [createAttachment](#createattachment) - Attach file to unit
* [deleteAttachment](#deleteattachment) - Delete unit attachments

## create

Create a unit with a serial number and link it to a part revision.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.serial_number = 'SN-001234';
req.part_number = 'PCB-V1.2';
req.revision_number = 'REV-A';
req.sample = struct();
req.metadata = struct();

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
| `sample` | `string` | :heavy_minus_sign: | Sample classification. 'golden' marks a known-good reference unit; 'failing' marks a known-faulty reference unit; 'ignored' marks a bench-check unit excluded from analytics and alerts. All are excluded from production analytics aggregates (FPY, Cpk, throughput) by default. Omit or null for regular production units. | struct() |
| `metadata` | `string` | :heavy_minus_sign: | Custom metadata to attach to the unit (max 50 keys per unit). Plain object of key/value pairs; values can be string, number, or boolean. Type is detected from the value. | struct() |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## list

List units with filtering by serial number, part number, and batch. Cursor-paginated.
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
| `samples` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of units to return. | 20 |
| `cursor` | `double (optional)` | :heavy_minus_sign: | N/A | 0 |
| `sortBy` | `string` | :heavy_minus_sign: | Field to sort results by. last_run_at sorts by most recent test run date. last_run_procedure sorts by procedure name of the last run. | created_at |
| `sortOrder` | `string` | :heavy_minus_sign: | Sort order direction. | desc |
| `metadata` | `string` | :heavy_minus_sign: | Filter units by custom metadata. Supports up to 5 keys per request. Per-key operators: string `{in: [...]}`/`{contains: "..."}`, number `{gte, lte, gt, lt, eq}`, bool `{eq: true\|false}`. | struct() |
| `includeMetadata` | `logical (optional)` | :heavy_minus_sign: | When true, includes the unit metadata array in the response. Defaults to false to keep payloads small. | false |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 408 | 408 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## delete

Delete units by serial number. Sub-units are unlinked, not deleted. Irreversible.
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
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## get

Get a unit by serial number, with its part, parent/child links, and run history.
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
| Error 408 | 408 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## update

Update a unit: serial number, part revision, batch, and file attachments.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.new_serial_number = 'example-value';
req.part_number = 'PCB-V1.2';
req.revision_number = 'REV-A';
req.batch_number = 'BATCH-2024-Q1';
req.attachments = {'value-1', 'value-2'};
req.sample = struct();
req.metadata = struct();

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
| `sample` | `string` | :heavy_minus_sign: | Sample classification. 'golden' marks a known-good reference unit; 'failing' marks a known-faulty reference unit; 'ignored' marks a bench-check unit excluded from analytics and alerts. All are excluded from production analytics by default. Set to null to clear and treat as a production unit. | struct() |
| `metadata` | `string` | :heavy_minus_sign: | Custom metadata to upsert on the unit. Plain object of key/value pairs. PATCH semantics: keys not present here are preserved. Pass `null` as a value to delete a key. | struct() |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## addChild

Link a sub-unit to a parent unit to track assemblies.
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
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## removeChild

Unlink a sub-unit from its parent. Neither unit is deleted.
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
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## createAttachment

Attach a file to a unit. Returns an upload ID and pre-signed URL; PUT the file to the URL, then call Finalize upload to commit.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.name = 'Example Name';

response = sdk.Units.createAttachment('SN-001234', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `serial_number` | `string` | :heavy_check_mark: | Serial number of the unit to attach the file to. Matched case-insensitively. | SN-001234 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `name` | `string` | :heavy_check_mark: | File name including extension (e.g. "calibration.pdf"). Used to determine content type and display name. | Example Name |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## deleteAttachment

Delete attachments from a unit by ID. Removes the files from storage and unlinks them.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Units.deleteAttachment('SN-001234', 'ids', {'value-1', 'value-2'});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `serial_number` | `string` | :heavy_check_mark: | Serial number of the unit. Matched case-insensitively. | SN-001234 |
| `ids` | `cell array of string` | :heavy_check_mark: | Attachment IDs to delete | {'value-1', 'value-2'} |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

