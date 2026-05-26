classdef Procedures < handle
    %PROCEDURES Procedures resource operations.
    %
    %   Methods:
    %     create - Create procedure
    %     list - List and filter procedures
    %     get - Get procedure
    %     delete - Delete procedure
    %     update - Update procedure
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot, ?tofupilot.Versions})
        Versions  % tofupilot.Versions
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Procedures(client)
            %PROCEDURES Create Procedures resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = create(obj, request)
            %CREATE Create procedure
            %   Create a procedure to group and track related runs.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/procedures', request);
        end

        function response = list(obj, opts)
            %LIST List and filter procedures
            %   List procedures with filtering and search. Includes creator and linked repository. Cursor-paginated.
            arguments
                obj
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.searchQuery (1,1) string = ""
                opts.createdAfter (1,1) string = ""
                opts.createdBefore (1,1) string = ""
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
            if ~isempty(opts.createdAfter)
                queryParams.created_after = opts.createdAfter;
            end
            if ~isempty(opts.createdBefore)
                queryParams.created_before = opts.createdBefore;
            end
            response = obj.Client.get('/v2/procedures', queryParams);
        end

        function response = get(obj, id)
            %GET Get procedure
            %   Get a procedure by ID, with recent runs, linked stations, and version history.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/procedures/%s', id);
            response = obj.Client.get(path);
        end

        function response = delete(obj, id)
            %DELETE Delete procedure
            %   Delete a procedure and all its runs, phases, measurements, and attachments. Irreversible.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/procedures/%s', id);
            response = obj.Client.delete(path);
        end

        function response = update(obj, id, request)
            %UPDATE Update procedure
            %   Update a procedure's name or configuration. Only provided fields are changed.
            arguments
                obj
                id (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/procedures/%s', id);
            response = obj.Client.patch(path, request);
        end
    end
end
