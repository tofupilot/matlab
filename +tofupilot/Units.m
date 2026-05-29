classdef Units < handle
    %UNITS Units resource operations.
    %
    %   Methods:
    %     create - Create unit
    %     list - List and filter units
    %     delete - Delete units
    %     get - Get unit
    %     update - Update unit
    %     addChild - Add sub-unit
    %     removeChild - Remove sub-unit
    %     createAttachment - Attach file to unit
    %     deleteAttachment - Delete unit attachments
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Units(client)
            %UNITS Create Units resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = create(obj, request)
            %CREATE Create unit
            %   Create a unit with a serial number and link it to a part revision.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/units', request);
        end

        function response = list(obj, opts)
            %LIST List and filter units
            %   List units with filtering by serial number, part number, and batch. Cursor-paginated.
            arguments
                obj
                opts.searchQuery (1,1) string = ""
                opts.ids  = []
                opts.serialNumbers  = []
                opts.partNumbers  = []
                opts.revisionNumbers  = []
                opts.batchNumbers  = []
                opts.procedureIds  = []
                opts.outcomes  = []
                opts.startedAfter (1,1) string = ""
                opts.startedBefore (1,1) string = ""
                opts.latestOnly (1,1) logical = false
                opts.runCountMin  = []
                opts.runCountMax  = []
                opts.createdAfter (1,1) string = ""
                opts.createdBefore (1,1) string = ""
                opts.createdByUserIds  = []
                opts.createdByStationIds  = []
                opts.excludeUnitsWithParent (1,1) logical = false
                opts.samples  = []
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.sortBy (1,1) string = "created_at"
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
            if ~isempty(opts.procedureIds)
                queryParams.procedure_ids = opts.procedureIds;
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
            if ~isempty(opts.latestOnly)
                queryParams.latest_only = opts.latestOnly;
            end
            if ~isempty(opts.runCountMin)
                queryParams.run_count_min = opts.runCountMin;
            end
            if ~isempty(opts.runCountMax)
                queryParams.run_count_max = opts.runCountMax;
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
            if ~isempty(opts.excludeUnitsWithParent)
                queryParams.exclude_units_with_parent = opts.excludeUnitsWithParent;
            end
            if ~isempty(opts.samples)
                queryParams.samples = opts.samples;
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
            response = obj.Client.get('/v2/units', queryParams);
        end

        function response = delete(obj, opts)
            %DELETE Delete units
            %   Delete units by serial number. Sub-units are unlinked, not deleted. Irreversible.
            arguments
                obj
                opts.serialNumbers  = []
            end
            queryParams = struct();
            if ~isempty(opts.serialNumbers)
                queryParams.serial_numbers = opts.serialNumbers;
            end
            response = obj.Client.deleteWithQuery('/v2/units', queryParams);
        end

        function response = get(obj, serial_number)
            %GET Get unit
            %   Get a unit by serial number, with its part, parent/child links, and run history.
            arguments
                obj
                serial_number (1,1) string
            end
            path = sprintf('/v2/units/%s', serial_number);
            response = obj.Client.get(path);
        end

        function response = update(obj, serial_number, request)
            %UPDATE Update unit
            %   Update a unit: serial number, part revision, batch, and file attachments.
            arguments
                obj
                serial_number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/units/%s', serial_number);
            response = obj.Client.patch(path, request);
        end

        function response = addChild(obj, serial_number, request)
            %ADDCHILD Add sub-unit
            %   Link a sub-unit to a parent unit to track assemblies.
            arguments
                obj
                serial_number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/units/%s/children', serial_number);
            response = obj.Client.put(path, request);
        end

        function response = removeChild(obj, serial_number, opts)
            %REMOVECHILD Remove sub-unit
            %   Unlink a sub-unit from its parent. Neither unit is deleted.
            arguments
                obj
                serial_number (1,1) string
                opts.childSerialNumber (1,1) string = ""
            end
            path = sprintf('/v2/units/%s/children', serial_number);
            queryParams = struct();
            if ~isempty(opts.childSerialNumber)
                queryParams.child_serial_number = opts.childSerialNumber;
            end
            response = obj.Client.deleteWithQuery(path, queryParams);
        end

        function response = createAttachment(obj, serial_number, request)
            %CREATEATTACHMENT Attach file to unit
            %   Attach a file to a unit. Returns an upload ID and pre-signed URL; PUT the file to the URL, then call Finalize upload to commit.
            arguments
                obj
                serial_number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/units/%s/attachments', serial_number);
            response = obj.Client.post(path, request);
        end

        function response = deleteAttachment(obj, serial_number, opts)
            %DELETEATTACHMENT Delete unit attachments
            %   Delete attachments from a unit by ID. Removes the files from storage and unlinks them.
            arguments
                obj
                serial_number (1,1) string
                opts.ids  = []
            end
            path = sprintf('/v2/units/%s/attachments', serial_number);
            queryParams = struct();
            if ~isempty(opts.ids)
                queryParams.ids = opts.ids;
            end
            response = obj.Client.deleteWithQuery(path, queryParams);
        end
    end
end
