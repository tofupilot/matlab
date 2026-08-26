classdef Phases < handle
    %PHASES Phases resource operations.
    %
    %   Methods:
    %     list - List and filter phases
    %     get - Get phase
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Phases(client)
            %PHASES Create Phases resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List and filter phases
            %   List phases for a procedure with filtering by outcome, date range, unit, and run details. Cursor-paginated.
            arguments
                obj
                opts.procedureId (1,1) string = ""
                opts.names  = []
                opts.outcomes  = []
                opts.startedAfter (1,1) string = ""
                opts.startedBefore (1,1) string = ""
                opts.excludeRetries (1,1) logical = true
                opts.runOutcomes  = []
                opts.ids  = []
                opts.durationMin (1,1) string = ""
                opts.durationMax (1,1) string = ""
                opts.deploymentIds  = []
                opts.procedureVersions  = []
                opts.environments  = []
                opts.operatedByIds  = []
                opts.operatedByNames  = []
                opts.createdByStationIds  = []
                opts.createdByUserIds  = []
                opts.serialNumbers  = []
                opts.partNumbers  = []
                opts.revisionNumbers  = []
                opts.batchNumbers  = []
                opts.samples  = []
                opts.sortBy (1,1) string = "started_at"
                opts.sortOrder (1,1) string = "desc"
                opts.limit (1,1) double = 50
                opts.cursor  = []
            end
            queryParams = struct();
            if ~isempty(opts.procedureId)
                queryParams.procedure_id = opts.procedureId;
            end
            if ~isempty(opts.names)
                queryParams.names = opts.names;
            end
            if ~isempty(opts.outcomes)
                queryParams.outcomes = opts.outcomes;
            end
            if ~isempty(opts.startedAfter)
                queryParams.started_after = opts.startedAfter;
            end
            if ~isempty(opts.startedBefore)
                queryParams.started_before = opts.startedBefore;
            end
            if ~isempty(opts.excludeRetries)
                queryParams.exclude_retries = opts.excludeRetries;
            end
            if ~isempty(opts.runOutcomes)
                queryParams.run_outcomes = opts.runOutcomes;
            end
            if ~isempty(opts.ids)
                queryParams.ids = opts.ids;
            end
            if ~isempty(opts.durationMin)
                queryParams.duration_min = opts.durationMin;
            end
            if ~isempty(opts.durationMax)
                queryParams.duration_max = opts.durationMax;
            end
            if ~isempty(opts.deploymentIds)
                queryParams.deployment_ids = opts.deploymentIds;
            end
            if ~isempty(opts.procedureVersions)
                queryParams.procedure_versions = opts.procedureVersions;
            end
            if ~isempty(opts.environments)
                queryParams.environments = opts.environments;
            end
            if ~isempty(opts.operatedByIds)
                queryParams.operated_by_ids = opts.operatedByIds;
            end
            if ~isempty(opts.operatedByNames)
                queryParams.operated_by_names = opts.operatedByNames;
            end
            if ~isempty(opts.createdByStationIds)
                queryParams.created_by_station_ids = opts.createdByStationIds;
            end
            if ~isempty(opts.createdByUserIds)
                queryParams.created_by_user_ids = opts.createdByUserIds;
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
            response = obj.Client.get('/v2/phases', queryParams);
        end

        function response = get(obj, id)
            %GET Get phase
            %   Get a single phase by ID, with its measurements and run context.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/phases/%s', id);
            response = obj.Client.get(path);
        end
    end
end
