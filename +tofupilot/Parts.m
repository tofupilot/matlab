classdef Parts < handle
    %PARTS Parts resource operations.
    %
    %   Methods:
    %     list - List and filter parts
    %     create - Create part
    %     get - Get part
    %     delete - Delete part
    %     update - Update part
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot, ?tofupilot.Revisions})
        Revisions  % tofupilot.Revisions
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Parts(client)
            %PARTS Create Parts resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List and filter parts
            %   Retrieve a paginated list of parts and components in your organization. Filter and search by part name, number, or revision number for inventory management.
            arguments
                obj
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.searchQuery (1,1) string = ""
                opts.procedureIds  = []
                opts.sortBy (1,1) string = "created_at"
                opts.sortOrder (1,1) string = "desc"
            end
            queryParams = struct();
            if ~isempty(opts.limit)
                queryParams.limit = opts.limit;
            end
            if ~isempty(opts.cursor)
                queryParams.cursor = opts.cursor;
            end
            if ~isempty(opts.searchQuery)
                queryParams.search_query = opts.searchQuery;
            end
            if ~isempty(opts.procedureIds)
                queryParams.procedure_ids = opts.procedureIds;
            end
            if ~isempty(opts.sortBy)
                queryParams.sort_by = opts.sortBy;
            end
            if ~isempty(opts.sortOrder)
                queryParams.sort_order = opts.sortOrder;
            end
            response = obj.Client.get('/v2/parts', queryParams);
        end

        function response = create(obj, request)
            %CREATE Create part
            %   Create a new part. Optionally create with a revision. Part numbers are matched case-insensitively (e.g., "PART-001" and "part-001" are considered the same).
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/parts', request);
        end

        function response = get(obj, number)
            %GET Get part
            %   Retrieve a single part by its number, including all revisions, metadata, and linked units. Part numbers are matched case-insensitively.
            arguments
                obj
                number (1,1) string
            end
            path = sprintf('/v2/parts/%s', number);
            response = obj.Client.get(path);
        end

        function response = delete(obj, number)
            %DELETE Delete part
            %   Permanently delete a part and all its revisions. This removes all associated data and cannot be undone.
            arguments
                obj
                number (1,1) string
            end
            path = sprintf('/v2/parts/%s', number);
            response = obj.Client.delete(path);
        end

        function response = update(obj, number, request)
            %UPDATE Update part
            %   Update a part's number or name. Identifies the part by its current number in the URL with case-insensitive matching.
            arguments
                obj
                number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/parts/%s', number);
            response = obj.Client.patch(path, request);
        end
    end
end
