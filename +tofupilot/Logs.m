classdef Logs < handle
    %LOGS Logs resource operations.
    %
    %   Methods:
    %     list - List and filter logs
    %     get - Get log
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Logs(client)
            %LOGS Create Logs resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List and filter logs
            %   List logs with filtering by run, procedure, level, date range, unit, and source. Cursor-paginated.
            arguments
                obj
                opts.procedureIds  = []
                opts.searchQuery (1,1) string = ""
                opts.levels  = []
                opts.timestampAfter (1,1) string = ""
                opts.timestampBefore (1,1) string = ""
                opts.sourceFiles  = []
                opts.runIds  = []
                opts.runOutcomes  = []
                opts.procedureVersions  = []
                opts.deploymentIds  = []
                opts.environments  = []
                opts.serialNumbers  = []
                opts.partNumbers  = []
                opts.revisionNumbers  = []
                opts.batchNumbers  = []
                opts.samples  = []
                opts.createdByStationIds  = []
                opts.createdByUserIds  = []
                opts.sortBy (1,1) string = "created_at"
                opts.sortOrder (1,1) string = "desc"
                opts.limit (1,1) double = 50
                opts.cursor  = []
            end
            queryParams = struct();
            if ~isempty(opts.procedureIds)
                queryParams.procedure_ids = opts.procedureIds;
            end
            if ~isempty(opts.searchQuery)
                queryParams.search_query = opts.searchQuery;
            end
            if ~isempty(opts.levels)
                queryParams.levels = opts.levels;
            end
            if ~isempty(opts.timestampAfter)
                queryParams.timestamp_after = opts.timestampAfter;
            end
            if ~isempty(opts.timestampBefore)
                queryParams.timestamp_before = opts.timestampBefore;
            end
            if ~isempty(opts.sourceFiles)
                queryParams.source_files = opts.sourceFiles;
            end
            if ~isempty(opts.runIds)
                queryParams.run_ids = opts.runIds;
            end
            if ~isempty(opts.runOutcomes)
                queryParams.run_outcomes = opts.runOutcomes;
            end
            if ~isempty(opts.procedureVersions)
                queryParams.procedure_versions = opts.procedureVersions;
            end
            if ~isempty(opts.deploymentIds)
                queryParams.deployment_ids = opts.deploymentIds;
            end
            if ~isempty(opts.environments)
                queryParams.environments = opts.environments;
            end
            if ~isempty(opts.serialNumbers)
                queryParams.serial_numbers = opts.serialNumbers;
            end
            if ~isempty(opts.partNumbers)
                queryParams.part_numbers = opts.partNumbers;
            end
            if ~isempty(opts.revisionNumbers)
                queryParams.revision_numbers = opts.revisionNumbers;
            end
            if ~isempty(opts.batchNumbers)
                queryParams.batch_numbers = opts.batchNumbers;
            end
            if ~isempty(opts.samples)
                queryParams.samples = opts.samples;
            end
            if ~isempty(opts.createdByStationIds)
                queryParams.created_by_station_ids = opts.createdByStationIds;
            end
            if ~isempty(opts.createdByUserIds)
                queryParams.created_by_user_ids = opts.createdByUserIds;
            end
            if ~isempty(opts.sortBy)
                queryParams.sort_by = opts.sortBy;
            end
            if ~isempty(opts.sortOrder)
                queryParams.sort_order = opts.sortOrder;
            end
            if ~isempty(opts.limit)
                queryParams.limit = opts.limit;
            end
            if ~isempty(opts.cursor)
                queryParams.cursor = opts.cursor;
            end
            response = obj.Client.get('/v2/logs', queryParams);
        end

        function response = get(obj, id)
            %GET Get log
            %   Get a single log entry by ID, with its run and unit context.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/logs/%s', id);
            response = obj.Client.get(path);
        end
    end
end
