classdef User < handle
    %USER User resource operations.
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
        function obj = User(client)
            %USER Create User resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List users
            %   Retrieve a list of users in your organization. Use the current parameter to get only the authenticated user profile and permissions.
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
