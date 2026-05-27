# Imports

## Overview

### Available Operations

* [structured](#structured) - Import runs from structured files
* [tabular](#tabular) - Import a run from a tabular file

## structured

Import one or more previously uploaded structured files (OpenHTF, WATS WSJF/WSXF, ATML, NI TestStand, STDF, or ATDF) in a single call. Each file is parsed independently and its result returned per-item, so one bad file does not fail the others. A file that contains several units (a multi-part STDF/ATDF datalog or a multi-report WSXF/TestStand document) creates one run per unit; all run ids are returned in the item’s `ids`.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.items = {};

response = sdk.Imports.structured(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `items` | `cell array of string` | :heavy_check_mark: | Files to import (1–100). Pass a single-item list to import one file. Each item is parsed independently; one failure does not abort the others. | {} |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

## tabular

Import a previously uploaded tabular file (CSV or Excel) by mapping its columns to TofuPilot fields. Provide exactly one of `mapping` (an inline column mapping) or `template_id` (a mapping template saved in the dashboard). The `procedure_id` is required and overrides any procedure referenced in the file.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.upload_id = 'example-value';
req.procedure_id = '550e8400-e29b-41d4-a716-446655440000';
req.mapping = struct();
req.template_id = 'example-value';

response = sdk.Imports.tabular(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `upload_id` | `string` | :heavy_check_mark: | ID of a previously uploaded tabular file. | example-value |
| `procedure_id` | `string` | :heavy_check_mark: | Procedure to attach the imported run to. Always overrides any procedure referenced in the file. Create the procedure in the app first, then find the auto-generated ID on the procedure page. | 550e8400-e29b-41d4-a716-446655440000 |
| `mapping` | `string` | :heavy_minus_sign: | Inline column mapping describing how source columns feed TofuPilot fields. Provide this OR template_id, not both. | struct() |
| `template_id` | `string (optional)` | :heavy_minus_sign: | ID of a saved mapping template to apply. Provide this OR mapping, not both. | example-value |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

