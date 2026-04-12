# TofuPilot SDK

## Overview

TofuPilot API v2 client for MATLAB

### Available Resources

* [Procedures](procedures/README.md) — [Versions](versions/README.md)
* [Runs](runs/README.md)
* [Attachments](attachments/README.md)
* [Units](units/README.md)
* [Parts](parts/README.md) — [Revisions](revisions/README.md)
* [Batches](batches/README.md)
* [Stations](stations/README.md)
* [User](user/README.md)

## Usage

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

% Create a test run
req.procedure_id = '550e8400-e29b-41d4-a716-446655440000';
req.serial_number = 'SN-0042';
req.part_number = 'PCB-100';
req.outcome = 'PASS';
req.started_at = '2026-04-12T10:00:00Z';
req.ended_at = '2026-04-12T10:05:00Z';

run = sdk.Runs.create(req);
```

## Configuration

```matlab
% Default (production)
sdk = tofupilot.TofuPilot('your-api-key');

% Custom base URL (e.g. self-hosted)
sdk = tofupilot.TofuPilot('your-api-key', 'BaseUrl', 'https://your-server.com/api');

% Custom timeout (seconds)
sdk = tofupilot.TofuPilot('your-api-key', 'Timeout', 60);
```

## Requirements

- MATLAB R2019b or later
- No additional toolboxes required
