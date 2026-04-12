# TofuPilot MATLAB Client

MATLAB client for the [TofuPilot](https://tofupilot.com) REST API. Struct-based, with retries and request lifecycle hooks.

## Installation

### Option 1: Add-On Explorer (recommended)

Search for **TofuPilot** in the MATLAB Add-On Explorer and click **Install**.

### Option 2: GitHub

```bash
git clone https://github.com/tofupilot/matlab.git
```

Then add to your MATLAB path:

```matlab
addpath('/path/to/matlab');
savepath;  % persist across sessions
```

## Quick Start

```matlab
sdk = tofupilot.TofuPilot('your-api-key');

% Create a test run
req.procedure_id = '550e8400-e29b-41d4-a716-446655440000';
req.serial_number = 'SN-001234';
req.part_number = 'PCB-V1.2';
req.outcome = 'PASS';
req.started_at = '2026-04-12T10:00:00Z';
req.ended_at = '2026-04-12T10:05:00Z';

run = sdk.Runs.create(req);
fprintf('Created run: %s\n', run.id);
```

## Available Resources

| Resource | Methods | Docs |
| --- | --- | --- |
| **Procedures** | list, create, get, delete, update | [docs/sdks/procedures](https://github.com/tofupilot/matlab/blob/main/docs/sdks/procedures/README.md) |
| **Runs** | list, create, delete, get, update | [docs/sdks/runs](https://github.com/tofupilot/matlab/blob/main/docs/sdks/runs/README.md) |
| **Runs.Attachments** | upload, download | - |
| **Units** | list, create, delete, get, update, addChild, removeChild | [docs/sdks/units](https://github.com/tofupilot/matlab/blob/main/docs/sdks/units/README.md) |
| **Units.Attachments** | upload, download, delete | - |
| **Parts** | list, create, get, delete, update | [docs/sdks/parts](https://github.com/tofupilot/matlab/blob/main/docs/sdks/parts/README.md) |
| **Batches** | get, delete, update, list, create | [docs/sdks/batches](https://github.com/tofupilot/matlab/blob/main/docs/sdks/batches/README.md) |
| **Stations** | list, create, getCurrent, get, remove, update | [docs/sdks/stations](https://github.com/tofupilot/matlab/blob/main/docs/sdks/stations/README.md) |
| **User** | list | [docs/sdks/user](https://github.com/tofupilot/matlab/blob/main/docs/sdks/user/README.md) |
| **Versions** | get, delete, create | [docs/sdks/versions](https://github.com/tofupilot/matlab/blob/main/docs/sdks/versions/README.md) |
| **Revisions** | get, delete, update, create | [docs/sdks/revisions](https://github.com/tofupilot/matlab/blob/main/docs/sdks/revisions/README.md) |

## File Attachments

```matlab
% Upload a file to a run
id = sdk.Runs.Attachments.upload(run.id, 'report.pdf');

% Upload a file to a unit
id = sdk.Units.Attachments.upload('SN-0001', 'calibration.pdf');

% Download an attachment
sdk.Runs.Attachments.download(downloadUrl, 'local-report.pdf');

% Delete a unit attachment
sdk.Units.Attachments.delete('SN-0001', {id});
```

## Phases & Measurements

```matlab
now = char(datetime('now', 'TimeZone', 'UTC', 'Format', 'yyyy-MM-dd''T''HH:mm:ss''Z'''));

measurement = struct( ...
    'name', 'output_voltage', ...
    'outcome', 'PASS', ...
    'measured_value', 3.3, ...
    'unit', 'V');

phase = struct( ...
    'name', 'voltage_check', ...
    'outcome', 'PASS', ...
    'started_at', now, ...
    'ended_at', now, ...
    'measurements', {{measurement}});

req.procedure_id = 'your-procedure-id';
req.serial_number = 'SN-001';
req.part_number = 'PCB-V1';
req.outcome = 'PASS';
req.started_at = now;
req.ended_at = now;
req.phases = {{phase}};

run = sdk.Runs.create(req);
```

## Retries

The client automatically retries on 429 (rate limit) and 5xx errors with exponential backoff (1s, 2s, 4s, ...). Default: 3 retries.

```matlab
% Custom retry count
sdk = tofupilot.TofuPilot('your-api-key', 'MaxRetries', 5);

% Disable retries
sdk = tofupilot.TofuPilot('your-api-key', 'MaxRetries', 0);
```

## Hooks

Inspect requests and responses with lifecycle hooks:

```matlab
sdk = tofupilot.TofuPilot('your-api-key', ...
    'BeforeRequest', {@(ctx) fprintf('-> %s %s\n', ctx.method, ctx.path)}, ...
    'AfterSuccess', {@(ctx, resp) fprintf('OK\n')}, ...
    'AfterError', {@(ctx, err) fprintf('Error: %s\n', err.message)});
```

## Self-Hosted

Point the client at your own TofuPilot instance:

```matlab
sdk = tofupilot.TofuPilot('your-api-key', 'BaseUrl', 'https://your-instance.example.com/api');
```

## Configuration

```matlab
sdk = tofupilot.TofuPilot('your-api-key', ...
    'BaseUrl', 'https://your-server.com/api', ...
    'Timeout', 60, ...
    'MaxRetries', 5);
```

## Requirements

- MATLAB R2019b or later
- No additional toolboxes required

## License

This SDK is distributed under the MIT License. See [LICENSE](LICENSE) for details.
