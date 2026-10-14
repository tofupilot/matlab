classdef Users < handle
    %USERS Users resource operations.
    %
    %   Methods:
    %     list - List users
    %     getCurrent - Get current user
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

        function response = list(obj)
            %LIST List users
            %   List users in your organization. For the user behind the key, use GET /v2/users/current.
            response = obj.Client.get('/v2/users');
        end

        function response = getCurrent(obj)
            %GETCURRENT Get current user
            %   Get the user the request is authenticated as. The mirror of GET /v2/stations/current: a station key is refused.
            response = obj.Client.get('/v2/users/current');
        end
    end
end
