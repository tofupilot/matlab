function run_tests()
%RUN_TESTS Run all MATLAB SDK integration tests against localhost:3000.

    envFile = fullfile(fileparts(fileparts(mfilename('fullpath'))), '..', '.env.local');
    env = load_env(envFile);

    apiKey = env('TOFUPILOT_API_KEY_USER');
    baseUrl = env('TOFUPILOT_URL') + "/api";

    sdk = tofupilot.TofuPilot(apiKey, 'BaseUrl', baseUrl, 'Timeout', 30);

    ts = string(datetime('now', 'Format', 'yyyyMMddHHmmssSSS'));

    passed = 0;
    failed = 0;
    errors = {};

    suites = {
        @() test_users(sdk)
        @() test_procedures(sdk, ts)
        @() test_procedures_errors(sdk)
        @() test_procedures_pagination(sdk, ts)
        @() test_parts(sdk, ts)
        @() test_revisions(sdk, ts)
        @() test_batches(sdk, ts)
        @() test_units(sdk, ts)
        @() test_units_errors(sdk)
        @() test_units_filters(sdk, ts)
        @() test_runs(sdk, ts)
        @() test_runs_errors(sdk)
        @() test_runs_filters(sdk, ts)
        @() test_stations(sdk, ts)
        @() test_attachments(sdk)
    };

    suiteNames = {
        'users'
        'procedures'
        'procedures_errors'
        'procedures_pagination'
        'parts'
        'revisions'
        'batches'
        'units'
        'units_errors'
        'units_filters'
        'runs'
        'runs_errors'
        'runs_filters'
        'stations'
        'attachments'
    };

    for i = 1:numel(suites)
        fprintf('\n=== %s ===\n', suiteNames{i});
        try
            results = suites{i}();
            for j = 1:numel(results)
                r = results{j};
                if r.passed
                    fprintf('  PASS: %s\n', r.name);
                    passed = passed + 1;
                else
                    fprintf('  FAIL: %s -- %s\n', r.name, r.message);
                    failed = failed + 1;
                    errors{end+1} = sprintf('%s/%s: %s', suiteNames{i}, r.name, r.message); %#ok<AGROW>
                end
            end
        catch ex
            fprintf('  ERROR: %s -- %s\n', suiteNames{i}, ex.message);
            failed = failed + 1;
            errors{end+1} = sprintf('%s: %s', suiteNames{i}, ex.message); %#ok<AGROW>
        end
    end

    fprintf('\n========================================\n');
    fprintf('Results: %d passed, %d failed\n', passed, failed);
    if ~isempty(errors)
        fprintf('\nFailures:\n');
        for i = 1:numel(errors)
            fprintf('  - %s\n', errors{i});
        end
    end
    fprintf('========================================\n');

    if failed > 0
        exit(1);
    end
end

function env = load_env(filepath)
    env = containers.Map();
    fid = fopen(filepath, 'r');
    if fid == -1
        error('Cannot open %s', filepath);
    end
    cleanup = onCleanup(@() fclose(fid));
    while ~feof(fid)
        line = strtrim(fgetl(fid));
        if isempty(line) || startsWith(line, '#')
            continue;
        end
        parts = split(line, '=', 2);
        if numel(parts) == 2
            env(strtrim(parts{1})) = strtrim(parts{2});
        end
    end
end

function r = pass(name)
    r = struct('name', name, 'passed', true, 'message', '');
end

function r = fail(name, msg)
    r = struct('name', name, 'passed', false, 'message', msg);
end

%% ---- Users ----
function results = test_users(sdk)
    results = {};

    try
        resp = sdk.User.list();
        assert(isstruct(resp), 'Expected struct response');
        results{end+1} = pass('list');
    catch ex
        results{end+1} = fail('list', ex.message);
    end

    try
        resp = sdk.User.list('current', true);
        assert(isstruct(resp), 'Expected struct response');
        results{end+1} = pass('list_current');
    catch ex
        results{end+1} = fail('list_current', ex.message);
    end
end

%% ---- Procedures ----
function results = test_procedures(sdk, ts)
    results = {};

    procName = "MATLAB-Test-Proc-" + ts;

    % create
    try
        resp = sdk.Procedures.create(struct('name', char(procName)));
        assert(isfield(resp, 'id') && ~isempty(resp.id), 'Missing id');
        procId = string(resp.id);
        results{end+1} = pass('create');
    catch ex
        results{end+1} = fail('create', ex.message);
        return;
    end

    % list
    try
        resp = sdk.Procedures.list('searchQuery', procName, 'limit', 5);
        assert(isfield(resp, 'data'), 'Missing data field');
        results{end+1} = pass('list');
    catch ex
        results{end+1} = fail('list', ex.message);
    end

    % get
    try
        resp = sdk.Procedures.get(procId);
        assert(strcmp(string(resp.id), procId), 'ID mismatch');
        results{end+1} = pass('get');
    catch ex
        results{end+1} = fail('get', ex.message);
    end

    % update
    try
        sdk.Procedures.update(procId, struct('name', char(procName + "-Updated")));
        results{end+1} = pass('update');
    catch ex
        results{end+1} = fail('update', ex.message);
    end

    % versions - create
    try
        sdk.Procedures.Versions.create(procId, struct('tag', '1.0.0'));
        results{end+1} = pass('versions_create');
    catch ex
        results{end+1} = fail('versions_create', ex.message);
    end

    % versions - get
    try
        resp = sdk.Procedures.Versions.get(procId, '1.0.0');
        results{end+1} = pass('versions_get');
    catch ex
        results{end+1} = fail('versions_get', ex.message);
    end

    % versions - delete
    try
        sdk.Procedures.Versions.delete(procId, '1.0.0');
        results{end+1} = pass('versions_delete');
    catch ex
        results{end+1} = fail('versions_delete', ex.message);
    end

    % delete
    try
        sdk.Procedures.delete(procId);
        results{end+1} = pass('delete');
    catch ex
        results{end+1} = fail('delete', ex.message);
    end
end

%% ---- Parts ----
function results = test_parts(sdk, ts)
    results = {};

    partNumber = "MATLAB-PART-" + ts;
    partName = "Test Part " + ts;

    % create
    try
        resp = sdk.Parts.create(struct('number', char(partNumber), 'name', char(partName)));
        assert(isfield(resp, 'id') && ~isempty(resp.id), 'Missing id');
        results{end+1} = pass('create');
    catch ex
        results{end+1} = fail('create', ex.message);
        return;
    end

    % list
    try
        resp = sdk.Parts.list('searchQuery', partNumber, 'limit', 5);
        assert(isfield(resp, 'data'), 'Missing data field');
        results{end+1} = pass('list');
    catch ex
        results{end+1} = fail('list', ex.message);
    end

    % get
    try
        resp = sdk.Parts.get(partNumber);
        assert(strcmp(string(resp.number), partNumber), 'Number mismatch');
        results{end+1} = pass('get');
    catch ex
        results{end+1} = fail('get', ex.message);
    end

    % update
    try
        sdk.Parts.update(partNumber, struct('name', char(partName + " Updated")));
        results{end+1} = pass('update');
    catch ex
        results{end+1} = fail('update', ex.message);
    end

    % delete
    try
        sdk.Parts.delete(partNumber);
        results{end+1} = pass('delete');
    catch ex
        results{end+1} = fail('delete', ex.message);
    end
end

%% ---- Revisions ----
function results = test_revisions(sdk, ts)
    results = {};

    partNumber = "MATLAB-REVPART-" + ts;
    revNumber = "REV-A";

    % setup
    try
        sdk.Parts.create(struct('number', char(partNumber), 'name', char("RevTest Part " + ts)));
    catch ex
        results{end+1} = fail('setup_part', ex.message);
        return;
    end

    % create
    try
        resp = sdk.Parts.Revisions.create(partNumber, struct('number', char(revNumber)));
        assert(isfield(resp, 'id') && ~isempty(resp.id), 'Missing id');
        results{end+1} = pass('create');
    catch ex
        results{end+1} = fail('create', ex.message);
        sdk.Parts.delete(partNumber);
        return;
    end

    % get
    try
        resp = sdk.Parts.Revisions.get(partNumber, revNumber);
        results{end+1} = pass('get');
    catch ex
        results{end+1} = fail('get', ex.message);
    end

    % update
    try
        sdk.Parts.Revisions.update(partNumber, revNumber, struct('number', 'REV-B'));
        results{end+1} = pass('update');
        revNumber = "REV-B";
    catch ex
        results{end+1} = fail('update', ex.message);
    end

    % delete
    try
        sdk.Parts.Revisions.delete(partNumber, revNumber);
        results{end+1} = pass('delete');
    catch ex
        results{end+1} = fail('delete', ex.message);
    end

    % cleanup
    try sdk.Parts.delete(partNumber); catch; end
end

%% ---- Batches ----
function results = test_batches(sdk, ts)
    results = {};

    batchNumber = "MATLAB-BATCH-" + ts;

    % create
    try
        resp = sdk.Batches.create(struct('number', char(batchNumber)));
        assert(isfield(resp, 'id') && ~isempty(resp.id), 'Missing id');
        results{end+1} = pass('create');
    catch ex
        results{end+1} = fail('create', ex.message);
        return;
    end

    % list
    try
        resp = sdk.Batches.list('searchQuery', batchNumber, 'limit', 5);
        assert(isfield(resp, 'data'), 'Missing data field');
        results{end+1} = pass('list');
    catch ex
        results{end+1} = fail('list', ex.message);
    end

    % get
    try
        sdk.Batches.get(batchNumber);
        results{end+1} = pass('get');
    catch ex
        results{end+1} = fail('get', ex.message);
    end

    % update
    newBatchNumber = batchNumber + "-UPD";
    try
        sdk.Batches.update(batchNumber, struct('new_number', char(newBatchNumber)));
        results{end+1} = pass('update');
        batchNumber = newBatchNumber;
    catch ex
        results{end+1} = fail('update', ex.message);
    end

    % delete
    try
        sdk.Batches.delete(batchNumber);
        results{end+1} = pass('delete');
    catch ex
        results{end+1} = fail('delete', ex.message);
    end
end

%% ---- Units ----
function results = test_units(sdk, ts)
    results = {};

    partNumber = "MATLAB-UPART-" + ts;
    revNumber = "REV-A";
    serialNumber = "MATLAB-SN-" + ts;

    % setup
    try
        sdk.Parts.create(struct('number', char(partNumber), 'name', char("UnitTest Part " + ts)));
        sdk.Parts.Revisions.create(partNumber, struct('number', char(revNumber)));
    catch ex
        results{end+1} = fail('setup', ex.message);
        return;
    end

    % create
    try
        resp = sdk.Units.create(struct( ...
            'serial_number', char(serialNumber), ...
            'part_number', char(partNumber), ...
            'revision_number', char(revNumber)));
        assert(isfield(resp, 'id') && ~isempty(resp.id), 'Missing id');
        results{end+1} = pass('create');
    catch ex
        results{end+1} = fail('create', ex.message);
        return;
    end

    % list
    try
        resp = sdk.Units.list('serialNumbers', {{char(serialNumber)}}, 'limit', 5);
        assert(isfield(resp, 'data'), 'Missing data field');
        results{end+1} = pass('list');
    catch ex
        results{end+1} = fail('list', ex.message);
    end

    % get
    try
        resp = sdk.Units.get(serialNumber);
        assert(strcmp(string(resp.serial_number), serialNumber), 'Serial mismatch');
        results{end+1} = pass('get');
    catch ex
        results{end+1} = fail('get', ex.message);
    end

    % update serial number
    newSerial = serialNumber + "-UPD";
    try
        sdk.Units.update(serialNumber, struct('new_serial_number', char(newSerial)));
        results{end+1} = pass('update');
        serialNumber = newSerial;
    catch ex
        results{end+1} = fail('update', ex.message);
    end

    % sub-units
    childSerial = "MATLAB-CHILD-" + ts;
    try
        sdk.Units.create(struct( ...
            'serial_number', char(childSerial), ...
            'part_number', char(partNumber), ...
            'revision_number', char(revNumber)));
        sdk.Units.addChild(serialNumber, struct('child_serial_number', char(childSerial)));
        results{end+1} = pass('add_child');
    catch ex
        results{end+1} = fail('add_child', ex.message);
    end

    try
        sdk.Units.removeChild(serialNumber, 'childSerialNumber', childSerial);
        results{end+1} = pass('remove_child');
    catch ex
        results{end+1} = fail('remove_child', ex.message);
    end

    % delete
    try
        sdk.Units.delete('serialNumbers', {{char(childSerial)}});
        sdk.Units.delete('serialNumbers', {{char(serialNumber)}});
        results{end+1} = pass('delete');
    catch ex
        results{end+1} = fail('delete', ex.message);
    end

    try sdk.Parts.delete(partNumber); catch; end
end

%% ---- Runs ----
function results = test_runs(sdk, ts)
    results = {};

    procName = "MATLAB-RunProc-" + ts;
    partNumber = "MATLAB-RPART-" + ts;
    revNumber = "REV-A";
    serialNumber = "MATLAB-RSN-" + ts;

    % setup
    try
        procResp = sdk.Procedures.create(struct('name', char(procName)));
        procId = string(procResp.id);
        sdk.Parts.create(struct('number', char(partNumber), 'name', char("RunTest Part " + ts)));
        sdk.Parts.Revisions.create(partNumber, struct('number', char(revNumber)));
    catch ex
        results{end+1} = fail('setup', ex.message);
        return;
    end

    % create run
    now_str = char(datetime('now', 'TimeZone', 'UTC', 'Format', 'yyyy-MM-dd''T''HH:mm:ss''Z'''));
    try
        resp = sdk.Runs.create(struct( ...
            'procedure_id', char(procId), ...
            'serial_number', char(serialNumber), ...
            'part_number', char(partNumber), ...
            'revision_number', char(revNumber), ...
            'outcome', 'PASS', ...
            'started_at', now_str, ...
            'ended_at', now_str));
        assert(isfield(resp, 'id') && ~isempty(resp.id), 'Missing id');
        runId = string(resp.id);
        results{end+1} = pass('create');
    catch ex
        results{end+1} = fail('create', ex.message);
        return;
    end

    % list
    try
        resp = sdk.Runs.list('serialNumbers', {{char(serialNumber)}}, 'limit', 5);
        assert(isfield(resp, 'data'), 'Missing data field');
        results{end+1} = pass('list');
    catch ex
        results{end+1} = fail('list', ex.message);
    end

    % get
    try
        resp = sdk.Runs.get(runId);
        assert(strcmp(string(resp.id), runId), 'ID mismatch');
        results{end+1} = pass('get');
    catch ex
        results{end+1} = fail('get', ex.message);
    end

    % create run with phases and measurements
    measurement = struct( ...
        'name', 'voltage', ...
        'outcome', 'PASS', ...
        'measured_value', 3.3, ...
        'lower_limit', 3.0, ...
        'upper_limit', 3.6, ...
        'unit', 'V');
    phase = struct( ...
        'name', 'Phase1', ...
        'outcome', 'PASS', ...
        'started_at', now_str, ...
        'ended_at', now_str, ...
        'measurements', {{measurement}});
    try
        resp = sdk.Runs.create(struct( ...
            'procedure_id', char(procId), ...
            'serial_number', char(serialNumber + "-meas"), ...
            'part_number', char(partNumber), ...
            'revision_number', char(revNumber), ...
            'outcome', 'FAIL', ...
            'started_at', now_str, ...
            'ended_at', now_str, ...
            'phases', {{phase}}));
        assert(isfield(resp, 'id'), 'Missing id');
        results{end+1} = pass('create_with_measurements');
        sdk.Runs.delete('ids', {{resp.id}});
    catch ex
        results{end+1} = fail('create_with_measurements', ex.message);
    end

    % delete
    try
        sdk.Runs.delete('ids', {{char(runId)}});
        results{end+1} = pass('delete');
    catch ex
        results{end+1} = fail('delete', ex.message);
    end

    % cleanup
    try sdk.Units.delete('serialNumbers', {{char(serialNumber)}}); catch; end
    try sdk.Units.delete('serialNumbers', {{char(serialNumber + "-meas")}}); catch; end
    try sdk.Parts.delete(partNumber); catch; end
end

%% ---- Procedures Errors ----
function results = test_procedures_errors(sdk)
    results = {};

    % get nonexistent
    try
        sdk.Procedures.get('00000000-0000-0000-0000-000000000000');
        results{end+1} = fail('get_nonexistent', 'Expected error');
    catch ex
        if contains(ex.message, '404') || contains(ex.message, 'Not Found')
            results{end+1} = pass('get_nonexistent_404');
        else
            results{end+1} = fail('get_nonexistent_404', ex.message);
        end
    end

    % delete nonexistent
    try
        sdk.Procedures.delete('00000000-0000-0000-0000-000000000000');
        results{end+1} = fail('delete_nonexistent', 'Expected error');
    catch ex
        if contains(ex.message, '404') || contains(ex.message, 'Not Found')
            results{end+1} = pass('delete_nonexistent_404');
        else
            results{end+1} = fail('delete_nonexistent_404', ex.message);
        end
    end
end

%% ---- Procedures Pagination ----
function results = test_procedures_pagination(sdk, ts)
    results = {};

    prefix = "MATLAB-Pag-" + ts;
    ids = {};
    for i = 1:3
        resp = sdk.Procedures.create(struct('name', char(prefix + "-" + string(i))));
        ids{end+1} = resp.id; %#ok<AGROW>
    end

    % page 1
    try
        page1 = sdk.Procedures.list('searchQuery', prefix, 'limit', 1);
        assert(numel(page1.data) == 1, 'Expected 1 result');
        assert(page1.meta.has_more == true, 'Expected has_more');
        results{end+1} = pass('page1');
    catch ex
        results{end+1} = fail('page1', ex.message);
        for i = 1:numel(ids); try sdk.Procedures.delete(ids{i}); catch; end; end
        return;
    end

    % page 2
    try
        page2 = sdk.Procedures.list('searchQuery', prefix, 'limit', 1, 'cursor', page1.meta.next_cursor);
        assert(numel(page2.data) == 1, 'Expected 1 result');
        assert(~strcmp(page2.data.id, page1.data.id), 'Expected different ID');
        results{end+1} = pass('page2');
    catch ex
        results{end+1} = fail('page2', ex.message);
    end

    % cleanup
    for i = 1:numel(ids)
        try sdk.Procedures.delete(ids{i}); catch; end
    end
end

%% ---- Units Errors ----
function results = test_units_errors(sdk)
    results = {};

    % get nonexistent
    try
        sdk.Units.get('NONEXISTENT-SERIAL-99999');
        results{end+1} = fail('get_nonexistent', 'Expected error');
    catch ex
        if contains(ex.message, '404') || contains(ex.message, 'Not Found')
            results{end+1} = pass('get_nonexistent_404');
        else
            results{end+1} = fail('get_nonexistent_404', ex.message);
        end
    end

    % delete nonexistent
    try
        sdk.Units.delete('serialNumbers', {{'NONEXISTENT-SERIAL-99999'}});
        results{end+1} = fail('delete_nonexistent', 'Expected error');
    catch ex
        if contains(ex.message, '404') || contains(ex.message, 'Not Found')
            results{end+1} = pass('delete_nonexistent_404');
        else
            results{end+1} = fail('delete_nonexistent_404', ex.message);
        end
    end

    % create with empty serial
    try
        sdk.Units.create(struct('serial_number', '', 'part_number', 'X', 'revision_number', 'A'));
        results{end+1} = fail('create_empty_serial', 'Expected error');
    catch ex
        if contains(ex.message, '400') || contains(ex.message, 'Bad Request')
            results{end+1} = pass('create_empty_serial_400');
        else
            results{end+1} = fail('create_empty_serial_400', ex.message);
        end
    end
end

%% ---- Units Filters ----
function results = test_units_filters(sdk, ts)
    results = {};

    partNumber = "MATLAB-UFILT-" + ts;
    revNumber = "REV-A";

    try
        sdk.Parts.create(struct('number', char(partNumber), 'name', char("FilterTest " + ts)));
        sdk.Parts.Revisions.create(partNumber, struct('number', char(revNumber)));
        for i = 1:3
            sdk.Units.create(struct( ...
                'serial_number', char("MATLAB-FILT-" + ts + "-" + string(i)), ...
                'part_number', char(partNumber), ...
                'revision_number', char(revNumber)));
        end
    catch ex
        results{end+1} = fail('setup', ex.message);
        return;
    end

    % filter by part number
    try
        resp = sdk.Units.list('partNumbers', {{char(partNumber)}}, 'limit', 10);
        assert(numel(resp.data) >= 3, 'Expected at least 3 units');
        results{end+1} = pass('filter_by_part_number');
    catch ex
        results{end+1} = fail('filter_by_part_number', ex.message);
    end

    % filter by serial number
    try
        sn = "MATLAB-FILT-" + ts + "-1";
        resp = sdk.Units.list('serialNumbers', {{char(sn)}}, 'limit', 5);
        assert(numel(resp.data) == 1, 'Expected exactly 1 unit');
        results{end+1} = pass('filter_by_serial');
    catch ex
        results{end+1} = fail('filter_by_serial', ex.message);
    end

    % sort order
    try
        resp = sdk.Units.list('partNumbers', {{char(partNumber)}}, 'sortBy', 'created_at', 'sortOrder', 'asc', 'limit', 10);
        assert(numel(resp.data) >= 3, 'Expected at least 3 units');
        results{end+1} = pass('sort_order');
    catch ex
        results{end+1} = fail('sort_order', ex.message);
    end

    % cleanup
    for i = 1:3
        try sdk.Units.delete('serialNumbers', {{char("MATLAB-FILT-" + ts + "-" + string(i))}}); catch; end
    end
    try sdk.Parts.delete(partNumber); catch; end
end

%% ---- Runs Errors ----
function results = test_runs_errors(sdk)
    results = {};

    % get nonexistent
    try
        sdk.Runs.get('00000000-0000-0000-0000-000000000000');
        results{end+1} = fail('get_nonexistent', 'Expected error');
    catch ex
        if contains(ex.message, '404') || contains(ex.message, 'Not Found')
            results{end+1} = pass('get_nonexistent_404');
        else
            results{end+1} = fail('get_nonexistent_404', ex.message);
        end
    end

    % create with invalid procedure_id
    try
        now_str = char(datetime('now', 'TimeZone', 'UTC', 'Format', 'yyyy-MM-dd''T''HH:mm:ss''Z'''));
        sdk.Runs.create(struct( ...
            'procedure_id', '00000000-0000-0000-0000-000000000000', ...
            'serial_number', 'ERR-SN', ...
            'part_number', 'ERR-PN', ...
            'outcome', 'PASS', ...
            'started_at', now_str, ...
            'ended_at', now_str));
        results{end+1} = fail('create_invalid_proc', 'Expected error');
    catch ex
        if contains(ex.message, '404') || contains(ex.message, 'Not Found')
            results{end+1} = pass('create_invalid_proc_404');
        else
            results{end+1} = fail('create_invalid_proc_404', ex.message);
        end
    end

    % create missing required fields
    try
        sdk.Runs.create(struct('outcome', 'PASS'));
        results{end+1} = fail('create_missing_fields', 'Expected error');
    catch ex
        if contains(ex.message, '400') || contains(ex.message, 'Bad Request')
            results{end+1} = pass('create_missing_fields_400');
        else
            results{end+1} = fail('create_missing_fields_400', ex.message);
        end
    end
end

%% ---- Runs Filters ----
function results = test_runs_filters(sdk, ts)
    results = {};

    procName = "MATLAB-RunFilt-" + ts;
    partNumber = "MATLAB-RFILT-" + ts;
    revNumber = "REV-A";

    try
        procResp = sdk.Procedures.create(struct('name', char(procName)));
        procId = string(procResp.id);
        sdk.Parts.create(struct('number', char(partNumber), 'name', char("RunFiltPart " + ts)));
        sdk.Parts.Revisions.create(partNumber, struct('number', char(revNumber)));
    catch ex
        results{end+1} = fail('setup', ex.message);
        return;
    end

    now_str = char(datetime('now', 'TimeZone', 'UTC', 'Format', 'yyyy-MM-dd''T''HH:mm:ss''Z'''));
    runIds = {};
    serials = {};
    outcomes = {'PASS', 'FAIL', 'PASS'};
    for i = 1:3
        sn = "MATLAB-RFILT-" + ts + "-" + string(i);
        serials{end+1} = sn; %#ok<AGROW>
        resp = sdk.Runs.create(struct( ...
            'procedure_id', char(procId), ...
            'serial_number', char(sn), ...
            'part_number', char(partNumber), ...
            'revision_number', char(revNumber), ...
            'outcome', outcomes{i}, ...
            'started_at', now_str, ...
            'ended_at', now_str));
        runIds{end+1} = resp.id; %#ok<AGROW>
    end

    % filter by outcome
    try
        resp = sdk.Runs.list('partNumbers', {{char(partNumber)}}, 'outcomes', {{'PASS'}}, 'limit', 10);
        assert(numel(resp.data) >= 2, 'Expected at least 2 PASS runs');
        results{end+1} = pass('filter_by_outcome');
    catch ex
        results{end+1} = fail('filter_by_outcome', ex.message);
    end

    % filter by procedure
    try
        resp = sdk.Runs.list('procedureIds', {{char(procId)}}, 'limit', 10);
        assert(numel(resp.data) >= 3, 'Expected at least 3 runs');
        results{end+1} = pass('filter_by_procedure');
    catch ex
        results{end+1} = fail('filter_by_procedure', ex.message);
    end

    % filter by serial number
    try
        resp = sdk.Runs.list('serialNumbers', {{char(serials{1})}}, 'limit', 5);
        assert(numel(resp.data) >= 1, 'Expected at least 1 run');
        results{end+1} = pass('filter_by_serial');
    catch ex
        results{end+1} = fail('filter_by_serial', ex.message);
    end

    % sort order
    try
        resp = sdk.Runs.list('partNumbers', {{char(partNumber)}}, 'sortBy', 'started_at', 'sortOrder', 'asc', 'limit', 10);
        assert(numel(resp.data) >= 3, 'Expected at least 3 runs');
        results{end+1} = pass('sort_order');
    catch ex
        results{end+1} = fail('sort_order', ex.message);
    end

    % empty result
    try
        resp = sdk.Runs.list('serialNumbers', {{'NONEXISTENT-SN-99999'}}, 'limit', 5);
        assert(numel(resp.data) == 0, 'Expected 0 runs');
        results{end+1} = pass('empty_result');
    catch ex
        results{end+1} = fail('empty_result', ex.message);
    end

    % cleanup
    for i = 1:numel(runIds)
        try sdk.Runs.delete('ids', {{runIds{i}}}); catch; end
    end
    for i = 1:numel(serials)
        try sdk.Units.delete('serialNumbers', {{char(serials{i})}}); catch; end
    end
    try sdk.Parts.delete(partNumber); catch; end
end

%% ---- Attachments ----
function results = test_attachments(sdk)
    results = {};

    % initialize
    try
        resp = sdk.Attachments.initialize(struct('name', 'test-upload.txt'));
        assert(isfield(resp, 'id') && ~isempty(resp.id), 'Missing id');
        assert(isfield(resp, 'upload_url') && ~isempty(resp.upload_url), 'Missing upload_url');
        results{end+1} = pass('initialize');
    catch ex
        results{end+1} = fail('initialize', ex.message);
    end

    % upload helper
    tmpFile = fullfile(tempdir, 'tofupilot_test_upload.txt');
    fid = fopen(tmpFile, 'w');
    fprintf(fid, 'MATLAB SDK test content');
    fclose(fid);
    try
        attachId = tofupilot.AttachmentHelpers.upload(sdk.Attachments, tmpFile);
        assert(strlength(attachId) == 36, 'Expected UUID');
        results{end+1} = pass('upload_helper');
    catch ex
        results{end+1} = fail('upload_helper', ex.message);
    end
    delete(tmpFile);

    % upload nonexistent file
    try
        tofupilot.AttachmentHelpers.upload(sdk.Attachments, '/nonexistent/file.txt');
        results{end+1} = fail('upload_nonexistent', 'Expected error');
    catch ex
        if contains(ex.message, 'File not found') || contains(ex.identifier, 'FileNotFound')
            results{end+1} = pass('upload_nonexistent_error');
        else
            results{end+1} = fail('upload_nonexistent_error', ex.message);
        end
    end

    % download empty URL
    try
        tofupilot.AttachmentHelpers.download('', '/tmp/test.txt');
        results{end+1} = fail('download_empty_url', 'Expected error');
    catch ex
        if contains(ex.message, 'empty') || contains(ex.identifier, 'InvalidUrl')
            results{end+1} = pass('download_empty_url_error');
        else
            results{end+1} = fail('download_empty_url_error', ex.message);
        end
    end
end

%% ---- Stations ----
function results = test_stations(sdk, ts)
    results = {};

    stationName = "MATLAB-Station-" + ts;

    % create
    try
        resp = sdk.Stations.create(struct('name', char(stationName)));
        assert(isfield(resp, 'id') && ~isempty(resp.id), 'Missing id');
        stationId = string(resp.id);
        results{end+1} = pass('create');
    catch ex
        results{end+1} = fail('create', ex.message);
        return;
    end

    % list
    try
        resp = sdk.Stations.list('searchQuery', stationName, 'limit', 5);
        assert(isfield(resp, 'data'), 'Missing data field');
        results{end+1} = pass('list');
    catch ex
        results{end+1} = fail('list', ex.message);
    end

    % get
    try
        resp = sdk.Stations.get(stationId);
        assert(strcmp(string(resp.id), stationId), 'ID mismatch');
        results{end+1} = pass('get');
    catch ex
        results{end+1} = fail('get', ex.message);
    end

    % update
    try
        sdk.Stations.update(stationId, struct('name', char(stationName + " Updated")));
        results{end+1} = pass('update');
    catch ex
        results{end+1} = fail('update', ex.message);
    end

    % remove
    try
        sdk.Stations.remove(stationId);
        results{end+1} = pass('remove');
    catch ex
        results{end+1} = fail('remove', ex.message);
    end
end
