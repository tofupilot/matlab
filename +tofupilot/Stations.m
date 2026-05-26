classdef Stations < handle
    %STATIONS Stations resource operations.
    %
    %   Methods:
    %     create - Create station
    %     list - List and filter stations
    %     getCurrent - Get current station
    %     get - Get station
    %     update - Update station
    %     remove - Remove station
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Stations(client)
            %STATIONS Create Stations resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = create(obj, request)
            %CREATE Create station
            %   Create a station to register production equipment and link it to procedures.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/stations', request);
        end

        function response = list(obj, opts)
            %LIST List and filter stations
            %   List stations. Search by name and filter by status. Cursor-paginated.
            arguments
                obj
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.searchQuery (1,1) string = ""
                opts.procedureIds  = []
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
            response = obj.Client.get('/v2/stations', queryParams);
        end

        function response = getCurrent(obj)
            %GETCURRENT Get current station
            %   Get the station the request is authenticated as, with its linked procedures and connection status.
            response = obj.Client.get('/v2/stations/current');
        end

        function response = get(obj, id)
            %GET Get station
            %   Get a station by ID, with its linked procedures, connection status, and recent activity.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/stations/%s', id);
            response = obj.Client.get(path);
        end

        function response = update(obj, id, request)
            %UPDATE Update station
            %   Update a station name and/or image. Pass an empty string for image_id to remove the image.
            arguments
                obj
                id (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/stations/%s', id);
            response = obj.Client.patch(path, request);
        end

        function response = remove(obj, id)
            %REMOVE Remove station
            %   Remove a station. Deleted if unused; archived (history preserved) if runs reference it.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/stations/%s', id);
            response = obj.Client.delete(path);
        end
    end
end
