classdef Runs < handle
    %RUNS Runs resource operations.
    %
    %   Methods:
    %     create - Create run
    %     list - List and filter runs
    %     delete - Delete runs
    %     get - Get run
    %     update - Update run
    %     createAttachment - Attach file to run
    %     updateMetadata - Update run metadata
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

        function response = create(obj, request)
            %CREATE Create run
            %   Create a run linked to a procedure and unit. Existing procedures and units are reused automatically.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/runs', request);
        end

        function response = list(obj, opts)
            %LIST List and filter runs
            %   List runs with filtering by unit, procedure, date range, outcome, and station. Cursor-paginated.
            arguments
                obj
                opts.searchQuery (1,1) string = ""
                opts.ids  = []
                opts.outcomes  = []
                opts.procedureIds  = []
                opts.procedureVersions  = []
                opts.deploymentIds  = []
                opts.executionIds  = []
                opts.slotKeys  = []
                opts.environments  = []
                opts.serialNumbers  = []
                opts.samples  = []
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
                opts.operatedByNames  = []
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.sortBy (1,1) string = "started_at"
                opts.sortOrder (1,1) string = "desc"
                opts.metadata  = []
                opts.includeMetadata (1,1) logical = false
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
            if ~isempty(opts.deploymentIds)
                queryParams.deployment_ids = opts.deploymentIds;
            end
            if ~isempty(opts.executionIds)
                queryParams.execution_ids = opts.executionIds;
            end
            if ~isempty(opts.slotKeys)
                queryParams.slot_keys = opts.slotKeys;
            end
            if ~isempty(opts.environments)
                queryParams.environments = opts.environments;
            end
            if ~isempty(opts.serialNumbers)
                queryParams.serial_numbers = opts.serialNumbers;
            end
            if ~isempty(opts.samples)
                queryParams.samples = opts.samples;
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
            if ~isempty(opts.operatedByNames)
                queryParams.operated_by_names = opts.operatedByNames;
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
            if ~isempty(opts.metadata)
                queryParams.metadata = jsonencode(opts.metadata);
            end
            if ~isempty(opts.includeMetadata)
                queryParams.include_metadata = opts.includeMetadata;
            end
            response = obj.Client.get('/v2/runs', queryParams);
        end

        function response = delete(obj, opts)
            %DELETE Delete runs
            %   Delete runs by ID. Also removes their phases, measurements, and attachments. Irreversible.
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
            %   Get a run by ID, with its metadata, phases, measurements, and logs.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/runs/%s', id);
            response = obj.Client.get(path);
        end

        function response = update(obj, id, request)
            %UPDATE Update run
            %   Link uploaded files to a run. Upload files via Initialize and Finalize first, then call this to attach them.
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
            %   Attach a file to a run. Returns an upload ID and pre-signed URL; PUT the file to the URL, then call Finalize upload to commit.
            arguments
                obj
                id (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/runs/%s/attachments', id);
            response = obj.Client.post(path, request);
        end

        function response = updateMetadata(obj, id, request)
            %UPDATEMETADATA Update run metadata
            %   Upsert custom metadata on a run as a key/value object. Omitted keys are preserved; pass `null` to delete a key.
            arguments
                obj
                id (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/runs/%s/metadata', id);
            response = obj.Client.patch(path, request);
        end
    end
end
