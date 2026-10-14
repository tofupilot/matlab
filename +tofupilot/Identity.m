classdef Identity < handle
    %IDENTITY Identity resource operations.
    %
    %   Methods:
    %     whoami - Who am I
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Identity(client)
            %IDENTITY Create Identity resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = whoami(obj)
            %WHOAMI Who am I
            %   The identity the request is authenticated as: the station or the user behind the API key, and its organization. Works with both kinds of key; `type` says which one. Use it before a call that only one kind may make, instead of catching that call's refusal.
            response = obj.Client.get('/v2/whoami');
        end
    end
end
