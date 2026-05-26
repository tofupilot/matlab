classdef Users < handle
    %USERS Users resource operations.
    %
    %   Methods:
    %     list - List users
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Users(client)
            %USERS Create Users resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List users
            %   List users in your organization. Set `current=true` to return only the authenticated user.
            arguments
                obj
                opts.current  = []
            end
            queryParams = struct();
            if ~isempty(opts.current)
                queryParams.current = opts.current;
            end
            response = obj.Client.get('/v2/users', queryParams);
        end
    end
end
