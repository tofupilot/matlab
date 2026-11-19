# AuditLog

## Overview

### Available Operations

* [list](#list) - List audit events

## list

List the audit trail of the organization, newest first: every change made from the dashboard, the API and MCP, with its actor, target, replaced values and outcome. Cursor-paginated. Requires an Owner or Admin API key, on the Enterprise plan.
### Example Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

response = sdk.AuditLog.list('occurredAfter', '2026-01-15T10:30:00Z', 'occurredBefore', '2026-01-15T10:30:00Z', 'actions', {'value-1', 'value-2'});
```

### Parameters

| Parameter | Type | Required | Description | Example |
| --------- | ---- | -------- | ----------- | ------- |
| `occurredAfter` | `string (optional)` | :heavy_minus_sign: | Only events that occurred at or after this time (ISO 8601). | 2026-01-15T10:30:00Z |
| `occurredBefore` | `string (optional)` | :heavy_minus_sign: | Only events that occurred at or before this time (ISO 8601). | 2026-01-15T10:30:00Z |
| `actions` | `cell array of string` | :heavy_minus_sign: | Filter by action, written resource.verb. | {'value-1', 'value-2'} |
| `actorIds` | `cell array of string` | :heavy_minus_sign: | Filter by the user or station that acted. | {'value-1', 'value-2'} |
| `vias` | `cell array of string` | :heavy_minus_sign: | N/A | {} |
| `outcomes` | `cell array of string` | :heavy_minus_sign: | N/A | {'PASS', 'FAIL'} |
| `targetType` | `string (optional)` | :heavy_minus_sign: | Filter by the type of record acted on. | example-value |
| `targetId` | `string (optional)` | :heavy_minus_sign: | Filter by the ID of the record acted on. | example-value |
| `requestId` | `string (optional)` | :heavy_minus_sign: | Filter by request ID, to find the events one API request produced. | example-value |
| `searchQuery` | `string (optional)` | :heavy_minus_sign: | Match the actor name or email, the record name, or the action. | search-term |
| `limit` | `double (optional)` | :heavy_minus_sign: | Maximum number of events to return. | 20 |
| `cursor` | `any` | :heavy_minus_sign: | Opaque cursor of the next page: pass next_cursor from the previous response unchanged. A keyset cursor rather than an offset: paging is stable while new events arrive. An event is timestamped when its request starts and appears when it commits, so a poller re-reads the last 10 minutes and de-duplicates by id. | 0 |


### Errors

| Error Type | Status Code | Content Type |
| ---------- | ----------- | ------------ |
| Error 400 | 400 | application/json |
| Error 401 | 401 | application/json |
| Error 403 | 403 | application/json |
| Error 408 | 408 | application/json |
| Error 4XX | 4XX | application/json |
| Error 500 | 500 | application/json |
| Error 5XX | 5XX | application/json |

