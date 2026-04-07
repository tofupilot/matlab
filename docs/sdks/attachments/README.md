# Attachments

## Overview

### Available Operations

* [initialize](#initialize) - Initialize upload
* [delete](#delete) - Delete attachments
* [finalize](#finalize) - Finalize upload

## initialize

Get a temporary pre-signed URL to upload a file. Returns the upload ID and URL. Upload the file to the URL with a PUT request, then call Finalize upload.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

req.name = 'Example Name';

response = sdk.Attachments.initialize(req);
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `request` | `struct` | :heavy_check_mark: | Request body struct | — |

#### Request Body Fields

| Field | Type | Required | Description | Example |
| ----- | ---- | -------- | ----------- | ------- |
| `name` | `string` | :heavy_check_mark: | File name including extension (e.g. "report.pdf") | Example Name |

### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 403 | 403 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 502 | 502 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## delete

Permanently delete attachments by their IDs and unlink them from any associated runs or units. Removes files from storage and clears all references.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Attachments.delete('ids', {'value-1', 'value-2'});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `ids` | `cell array of string` | :heavy_check_mark: | Upload IDs to delete | {'value-1', 'value-2'} |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

## finalize

Finalize a file upload after uploading to the pre-signed URL. Validates the file and records its metadata.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.Attachments.finalize('550e8400-e29b-41d4-a716-446655440000');
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `id` | `string` | :heavy_check_mark: | ID of the upload to finalize | 550e8400-e29b-41d4-a716-446655440000 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 401 | 401 | application/json |
| Error 404 | 404 | application/json |
| Error 500 | 500 | application/json |
| Error 4XX | 4XX | application/json |
| Error 5XX | 5XX | application/json |

