classdef Stations < handle
    %STATIONS Stations resource operations.
    %
    %   Methods:
    %     list - List and filter stations
    %     create - Create station
    %     getCurrent - Get current station
    %     get - Get station
    %     remove - Remove station
    %     update - Update station
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

        function response = list(obj, opts)
            %LIST List and filter stations
            %   Retrieve a paginated list of test stations in your organization. Search by station name and filter by status for station fleet management.
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

        function response = create(obj, request)
            %CREATE Create station
            %   Create a new test station in TofuPilot to register production equipment and link it to test procedures.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/stations', request);
        end

        function response = getCurrent(obj)
            %GETCURRENT Get current station
            %   Retrieve detailed information about the currently authenticated station including linked procedures and connection status.
            response = obj.Client.get('/v2/stations/current');
        end

        function response = get(obj, id)
            %GET Get station
            %   Retrieve detailed station information including linked procedures, connection status, and recent activity.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/stations/%s', id);
            response = obj.Client.get(path);
        end

        function response = remove(obj, id)
            %REMOVE Remove station
            %   Remove a test station. Deletes permanently if unused, or archives with preserved historical data if runs exist.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/stations/%s', id);
            response = obj.Client.delete(path);
        end

        function response = update(obj, id, request)
            %UPDATE Update station
            %   Update station name and/or image. The station ID is specified in the URL path. To remove an image, pass an empty string for image_id.
            arguments
                obj
                id (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/stations/%s', id);
            response = obj.Client.patch(path, request);
        end
    end
end
