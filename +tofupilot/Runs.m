classdef Runs < handle
    %RUNS Runs resource operations.
    %
    %   Methods:
    %     list - List and filter runs
    %     create - Create run
    %     delete - Delete runs
    %     get - Get run
    %     update - Update run
    %     createAttachment - Attach file to run
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Runs(client)
            %RUNS Create Runs resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List and filter runs
            %   Retrieve a paginated list of test runs with filtering by unit, procedure, date range, outcome, and station.
            arguments
                obj
                opts.searchQuery (1,1) string = ""
                opts.ids  = []
                opts.outcomes  = []
                opts.procedureIds  = []
                opts.procedureVersions  = []
                opts.serialNumbers  = []
                opts.partNumbers  = []
                opts.revisionNumbers  = []
                opts.batchNumbers  = []
                opts.durationMin (1,1) string = ""
                opts.durationMax (1,1) string = ""
                opts.startedAfter (1,1) string = ""
                opts.startedBefore (1,1) string = ""
                opts.endedAfter (1,1) string = ""
                opts.endedBefore (1,1) string = ""
                opts.createdAfter (1,1) string = ""
                opts.createdBefore (1,1) string = ""
                opts.createdByUserIds  = []
                opts.createdByStationIds  = []
                opts.operatedByIds  = []
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.sortBy (1,1) string = "started_at"
                opts.sortOrder (1,1) string = "desc"
            end
            queryParams = struct();
            if ~isempty(opts.searchQuery)
                queryParams.search_query = opts.searchQuery;
            end
            if ~isempty(opts.ids)
                queryParams.ids = opts.ids;
            end
            if ~isempty(opts.outcomes)
                queryParams.outcomes = opts.outcomes;
            end
            if ~isempty(opts.procedureIds)
                queryParams.procedure_ids = opts.procedureIds;
            end
            if ~isempty(opts.procedureVersions)
                queryParams.procedure_versions = opts.procedureVersions;
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
            if ~isempty(opts.durationMin)
                queryParams.duration_min = opts.durationMin;
            end
            if ~isempty(opts.durationMax)
                queryParams.duration_max = opts.durationMax;
            end
            if ~isempty(opts.startedAfter)
                queryParams.started_after = opts.startedAfter;
            end
            if ~isempty(opts.startedBefore)
                queryParams.started_before = opts.startedBefore;
            end
            if ~isempty(opts.endedAfter)
                queryParams.ended_after = opts.endedAfter;
            end
            if ~isempty(opts.endedBefore)
                queryParams.ended_before = opts.endedBefore;
            end
            if ~isempty(opts.createdAfter)
                queryParams.created_after = opts.createdAfter;
            end
            if ~isempty(opts.createdBefore)
                queryParams.created_before = opts.createdBefore;
            end
            if ~isempty(opts.createdByUserIds)
                queryParams.created_by_user_ids = opts.createdByUserIds;
            end
            if ~isempty(opts.createdByStationIds)
                queryParams.created_by_station_ids = opts.createdByStationIds;
            end
            if ~isempty(opts.operatedByIds)
                queryParams.operated_by_ids = opts.operatedByIds;
            end
            if ~isempty(opts.limit)
                queryParams.limit = opts.limit;
            end
            if ~isempty(opts.cursor)
                queryParams.cursor = opts.cursor;
            end
            if ~isempty(opts.sortBy)
                queryParams.sort_by = opts.sortBy;
            end
            if ~isempty(opts.sortOrder)
                queryParams.sort_order = opts.sortOrder;
            end
            response = obj.Client.get('/v2/runs', queryParams);
        end

        function response = create(obj, request)
            %CREATE Create run
            %   Create a new test run, linking it to a procedure and unit. Existing entities are reused automatically.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/runs', request);
        end

        function response = delete(obj, opts)
            %DELETE Delete runs
            %   Permanently delete test runs by their IDs. Removes all associated phases, measurements, and attachments.
            arguments
                obj
                opts.ids  = []
            end
            queryParams = struct();
            if ~isempty(opts.ids)
                queryParams.ids = opts.ids;
            end
            response = obj.Client.deleteWithQuery('/v2/runs', queryParams);
        end

        function response = get(obj, id)
            %GET Get run
            %   Retrieve a single test run by its ID. Returns comprehensive run data including metadata, phases, measurements, and logs.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/runs/%s', id);
            response = obj.Client.get(path);
        end

        function response = update(obj, id, request)
            %UPDATE Update run
            %   Update a test run, including linking file attachments. Files must be uploaded via Initialize upload and Finalize upload before linking.
            arguments
                obj
                id (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/runs/%s', id);
            response = obj.Client.patch(path, request);
        end

        function response = createAttachment(obj, id, request)
            %CREATEATTACHMENT Attach file to run
            %   Create an attachment linked to a run and get a temporary pre-signed URL. Upload the file to the URL with a PUT request to complete the attachment.
            arguments
                obj
                id (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/runs/%s/attachments', id);
            response = obj.Client.post(path, request);
        end
    end
end
