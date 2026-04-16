classdef TofuPilot < handle
    %TOFUPILOT TofuPilot API v2 client for MATLAB
    %
    %   sdk = tofupilot.TofuPilot('your-api-key')
    %   sdk = tofupilot.TofuPilot('your-api-key', 'BaseUrl', 'https://custom.url/api')
    %   sdk = tofupilot.TofuPilot('your-api-key', 'Timeout', 60)
    %   sdk = tofupilot.TofuPilot('your-api-key', 'MaxRetries', 5)
    %
    %   Resources:
    %     sdk.Procedures, sdk.Procedures.Versions
    %     sdk.Runs
    %     sdk.Attachments
    %     sdk.Units
    %     sdk.Parts, sdk.Parts.Revisions
    %     sdk.Batches
    %     sdk.Stations
    %     sdk.User
    %
    %   Hooks:
    %     sdk = tofupilot.TofuPilot('key', 'BeforeRequest', {@(ctx) disp(ctx.path)})
    %     sdk = tofupilot.TofuPilot('key', 'AfterSuccess', {@(ctx,resp) disp('ok')})
    %     sdk = tofupilot.TofuPilot('key', 'AfterError', {@(ctx,err) disp(err.message)})
    %
    %   Example:
    %     sdk = tofupilot.TofuPilot('your-api-key');
    %     runs = sdk.Runs.list('limit', 10);
    %
    %   See also tofupilot.BaseClient

    properties (SetAccess = private)
        Procedures  % tofupilot.Procedures
        Runs  % tofupilot.Runs
        Attachments  % tofupilot.Attachments
        Units  % tofupilot.Units
        Parts  % tofupilot.Parts
        Batches  % tofupilot.Batches
        Stations  % tofupilot.Stations
        User  % tofupilot.User
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = TofuPilot(apiKey, opts)
            %TOFUPILOT Create a new TofuPilot client.
            %   sdk = tofupilot.TofuPilot(apiKey)
            %   sdk = tofupilot.TofuPilot(apiKey, 'BaseUrl', url)
            %   sdk = tofupilot.TofuPilot(apiKey, 'Timeout', seconds)
            %   sdk = tofupilot.TofuPilot(apiKey, 'MaxRetries', n)
            %   sdk = tofupilot.TofuPilot(apiKey, 'BeforeRequest', {@myHook})
            %
            %   Input:
            %     apiKey        - API key string (required)
            %     BaseUrl       - Server base URL (default: https://www.tofupilot.app/api)
            %     Timeout       - Request timeout in seconds (default: 30)
            %     MaxRetries    - Max retries on 429/5xx errors (default: 3)
            %     BeforeRequest - Cell array of @(ctx) function handles
            %     AfterSuccess  - Cell array of @(ctx, response) function handles
            %     AfterError    - Cell array of @(ctx, err) function handles
            arguments
                apiKey (1,1) string
                opts.BaseUrl (1,1) string = "https://www.tofupilot.app/api"
                opts.Timeout (1,1) double = 30
                opts.MaxRetries (1,1) double = 3
                opts.BeforeRequest cell = {}
                opts.AfterSuccess cell = {}
                opts.AfterError cell = {}
            end
            hooks = struct( ...
                'beforeRequest', {opts.BeforeRequest}, ...
                'afterSuccess', {opts.AfterSuccess}, ...
                'afterError', {opts.AfterError});
            baseUrl = opts.BaseUrl;
            if endsWith(baseUrl, '/')
                baseUrl = extractBefore(baseUrl, strlength(baseUrl));
            end
            if ~endsWith(baseUrl, '/api')
                baseUrl = baseUrl + "/api";
            end
            obj.Client = tofupilot.BaseClient(apiKey, baseUrl, opts.Timeout, opts.MaxRetries, hooks);
            obj.Procedures = tofupilot.Procedures(obj.Client);
            obj.Runs = tofupilot.Runs(obj.Client);
            obj.Attachments = tofupilot.Attachments(obj.Client);
            obj.Units = tofupilot.Units(obj.Client);
            obj.Parts = tofupilot.Parts(obj.Client);
            obj.Batches = tofupilot.Batches(obj.Client);
            obj.Stations = tofupilot.Stations(obj.Client);
            obj.User = tofupilot.User(obj.Client);
            obj.Procedures.Versions = tofupilot.Versions(obj.Client);
            obj.Parts.Revisions = tofupilot.Revisions(obj.Client);
        end
    end
end
