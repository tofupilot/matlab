classdef Parts < handle
    %PARTS Parts resource operations.
    %
    %   Methods:
    %     create - Create part
    %     list - List and filter parts
    %     get - Get part
    %     update - Update part
    %     delete - Delete part
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

        function response = create(obj, request)
            %CREATE Create part
            %   Create a part, optionally with an initial revision. Part numbers match case-insensitively ("PART-001" == "part-001").
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/parts', request);
        end

        function response = list(obj, opts)
            %LIST List and filter parts
            %   List parts. Filter and search by name, number, or revision number. Cursor-paginated.
            arguments
                obj
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.searchQuery (1,1) string = ""
                opts.procedureIds  = []
                opts.sortBy (1,1) string = "created_at"
                opts.sortOrder (1,1) string = "desc"
                opts.metadata  = []
                opts.includeMetadata (1,1) logical = false
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
            if ~isempty(opts.metadata)
                queryParams.metadata = jsonencode(opts.metadata);
            end
            if ~isempty(opts.includeMetadata)
                queryParams.include_metadata = opts.includeMetadata;
            end
            response = obj.Client.get('/v2/parts', queryParams);
        end

        function response = get(obj, number)
            %GET Get part
            %   Get a part by number, with its revisions, metadata, and linked units. Numbers match case-insensitively.
            arguments
                obj
                number (1,1) string
            end
            path = sprintf('/v2/parts/%s', number);
            response = obj.Client.get(path);
        end

        function response = update(obj, number, request)
            %UPDATE Update part
            %   Update a part's number or name. Numbers match case-insensitively.
            arguments
                obj
                number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/parts/%s', number);
            response = obj.Client.patch(path, request);
        end

        function response = delete(obj, number)
            %DELETE Delete part
            %   Delete a part and all its revisions. Irreversible.
            arguments
                obj
                number (1,1) string
            end
            path = sprintf('/v2/parts/%s', number);
            response = obj.Client.delete(path);
        end
    end
end
