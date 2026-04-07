classdef Procedures < handle
    %PROCEDURES Procedures resource operations.
    %
    %   Methods:
    %     list - List and filter procedures
    %     create - Create procedure
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

        function response = list(obj, opts)
            %LIST List and filter procedures
            %   Retrieve procedures with optional filtering and search. Returns procedure data including creator and linked repository.
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

        function response = create(obj, request)
            %CREATE Create procedure
            %   Create a new test procedure that can be used to organize and track test runs. The procedure serves as a template or framework for organizing test execution.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/procedures', request);
        end

        function response = get(obj, id)
            %GET Get procedure
            %   Retrieve a single procedure by ID, including recent test runs, linked stations, and version history.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/procedures/%s', id);
            response = obj.Client.get(path);
        end

        function response = delete(obj, id)
            %DELETE Delete procedure
            %   Permanently delete a procedure, removing all associated runs, phases, measurements, and attachments.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/procedures/%s', id);
            response = obj.Client.delete(path);
        end

        function response = update(obj, id, request)
            %UPDATE Update procedure
            %   Update a test procedure's name or configuration. The procedure is identified by its unique ID in the URL path. Only provided fields are modified.
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
