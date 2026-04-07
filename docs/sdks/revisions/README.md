# Revisions

## Overview

### Available Operations

* [get](#get) - Get part revision
* [delete](#delete) - Delete part revision
* [update](#update) - Update part revision
* [create](#create) - Create part revision

## get

Retrieve a single part revision by its part number and revision number, including revision metadata, configuration details, and linked units.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Parts.Revisions.get('PCB-V1.2', 'REV-A');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `part_number` | `string` | :heavy_check_mark: | Part number that the revision belongs to. | PCB-V1.2 |
| `revision_number` | `string` | :heavy_check_mark: | Revision number to retrieve. | REV-A |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## delete

Permanently delete a part revision by its part number and revision number. This action removes the revision and all associated data and cannot be undone.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Parts.Revisions.delete('PCB-V1.2', 'REV-A');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `part_number` | `string` | :heavy_check_mark: | Part number that the revision belongs to. | PCB-V1.2 |
| `revision_number` | `string` | :heavy_check_mark: | Revision number to delete. | REV-A |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## update

Update a part revision's number or image. Identifies the revision by part number and revision number in the URL.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.number = 'PCB-V2.0';
req.image_id = 'example-value';

response = sdk.Parts.Revisions.update('PCB-V1.2', 'REV-A', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `part_number` | `string` | :heavy_check_mark: | Part number that the revision belongs to. | PCB-V1.2 |
| `revision_number` | `string` | :heavy_check_mark: | Current revision number to update. | REV-A |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `number` | `string (optional)` | :heavy_minus_sign: | New revision number to set. | PCB-V2.0 |
| `image_id` | `string (optional)` | :heavy_minus_sign: | Upload ID for the revision image, or empty string to remove image | example-value |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## create

Create a new part revision for an existing part. Revision numbers are matched case-insensitively (e.g., "REV-A" and "rev-a" are considered the same).
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.number = 'PCB-V2.0';

response = sdk.Parts.Revisions.create('PCB-V1.2', req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `part_number` | `string` | :heavy_check_mark: | Part number to create a revision for. | PCB-V1.2 |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `number` | `string` | :heavy_check_mark: | Revision number (e.g., version number or code). | PCB-V2.0 |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 409 | 409 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

