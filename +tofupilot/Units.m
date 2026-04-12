classdef Units < handle
    %UNITS Units resource operations.
    %
    %   Methods:
    %     list - List and filter units
    %     create - Create unit
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

        function response = list(obj, opts)
            %LIST List and filter units
            %   Retrieve a paginated list of units with filtering by serial number, part number, and batch. Uses cursor-based pagination for efficient large dataset traversal.
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
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.sortBy (1,1) string = "created_at"
                opts.sortOrder (1,1) string = "desc"
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
            response = obj.Client.get('/v2/units', queryParams);
        end

        function response = create(obj, request)
            %CREATE Create unit
            %   Create a new unit with a serial number and link it to a part revision. Units represent individual hardware items tracked for manufacturing traceability.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/units', request);
        end

        function response = delete(obj, opts)
            %DELETE Delete units
            %   Permanently delete units by serial number. This action will remove all nested elements and relationships associated with the units.
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
            %   Retrieve a single unit by its serial number. Returns comprehensive unit data including part information, parent/child relationships, and test run history.
            arguments
                obj
                serial_number (1,1) string
            end
            path = sprintf('/v2/units/%s', serial_number);
            response = obj.Client.get(path);
        end

        function response = update(obj, serial_number, request)
            %UPDATE Update unit
            %   Update unit properties including serial number, part revision, batch assignment, and file attachments with case-insensitive matching.
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
            %   Add a sub-unit to a parent unit to track component assemblies and multi-level hardware traceability.
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
            %   Remove a sub-unit relationship from a parent unit by serial number. Only unlinks the parent-child relationship; neither unit is deleted from the system.
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
            %   Create an attachment linked to a unit and get a temporary pre-signed URL. Upload the file to the URL with a PUT request to complete the attachment.
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
            %   Delete attachments from a unit by their IDs. Removes the files from storage and unlinks them from the unit.
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
