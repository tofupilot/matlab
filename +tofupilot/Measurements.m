classdef Measurements < handle
    %MEASUREMENTS Measurements resource operations.
    %
    %   Methods:
    %     list - List and filter measurements
    %     get - Get measurement
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Measurements(client)
            %MEASUREMENTS Create Measurements resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List and filter measurements
            %   List measurements for a procedure with filtering by phase, measurement, value, outcome, date range, unit, and run details. Cursor-paginated.
            arguments
                obj
                opts.procedureId (1,1) string = ""
                opts.phaseName (1,1) string = ""
                opts.measurementName (1,1) string = ""
                opts.phaseNames  = []
                opts.outcomes  = []
                opts.ids  = []
                opts.durationMin (1,1) string = ""
                opts.durationMax (1,1) string = ""
                opts.deploymentIds  = []
                opts.procedureVersions  = []
                opts.environments  = []
                opts.serialNumbers  = []
                opts.partNumbers  = []
                opts.revisionNumbers  = []
                opts.batchNumbers  = []
                opts.operatedByIds  = []
                opts.operatedByNames  = []
                opts.createdByStationIds  = []
                opts.createdByUserIds  = []
                opts.startedAfter (1,1) string = ""
                opts.startedBefore (1,1) string = ""
                opts.excludeRetries (1,1) logical = true
                opts.valueMin  = []
                opts.valueMax  = []
                opts.valueBool  = []
                opts.valueStrings  = []
                opts.measurementOutcomes  = []
                opts.measurementTypes  = []
                opts.sortBy (1,1) string = "started_at"
                opts.sortOrder (1,1) string = "desc"
                opts.limit (1,1) double = 50
                opts.cursor  = []
            end
            queryParams = struct();
            if ~isempty(opts.procedureId)
                queryParams.procedure_id = opts.procedureId;
            end
            if ~isempty(opts.phaseName)
                queryParams.phase_name = opts.phaseName;
            end
            if ~isempty(opts.measurementName)
                queryParams.measurement_name = opts.measurementName;
            end
            if ~isempty(opts.phaseNames)
                queryParams.phase_names = opts.phaseNames;
            end
            if ~isempty(opts.outcomes)
                queryParams.outcomes = opts.outcomes;
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
            if ~isempty(opts.startedAfter)
                queryParams.started_after = opts.startedAfter;
            end
            if ~isempty(opts.startedBefore)
                queryParams.started_before = opts.startedBefore;
            end
            if ~isempty(opts.excludeRetries)
                queryParams.exclude_retries = opts.excludeRetries;
            end
            if ~isempty(opts.valueMin)
                queryParams.value_min = opts.valueMin;
            end
            if ~isempty(opts.valueMax)
                queryParams.value_max = opts.valueMax;
            end
            if ~isempty(opts.valueBool)
                queryParams.value_bool = opts.valueBool;
            end
            if ~isempty(opts.valueStrings)
                queryParams.value_strings = opts.valueStrings;
            end
            if ~isempty(opts.measurementOutcomes)
                queryParams.measurement_outcomes = opts.measurementOutcomes;
            end
            if ~isempty(opts.measurementTypes)
                queryParams.measurement_types = opts.measurementTypes;
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
            response = obj.Client.get('/v2/measurements', queryParams);
        end

        function response = get(obj, id)
            %GET Get measurement
            %   Get a single measurement by ID, with its value, validators, and run context.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/measurements/%s', id);
            response = obj.Client.get(path);
        end
    end
end
