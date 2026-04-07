classdef Versions < handle
    %VERSIONS Versions resource operations.
    %
    %   Methods:
    %     get - Get procedure version
    %     delete - Delete procedure version
    %     create - Create procedure version
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Versions(client)
            %VERSIONS Create Versions resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = get(obj, procedure_id, tag)
            %GET Get procedure version
            %   Retrieve a single procedure version by its tag, including version metadata and configuration details.
            arguments
                obj
                procedure_id (1,1) string
                tag (1,1) string
            end
            path = sprintf('/v2/procedures/%s/versions/%s', procedure_id, tag);
            response = obj.Client.get(path);
        end

        function response = delete(obj, procedure_id, tag)
            %DELETE Delete procedure version
            %   Permanently delete a procedure version by its tag. This removes the version record and all associated configuration data and cannot be undone.
            arguments
                obj
                procedure_id (1,1) string
                tag (1,1) string
            end
            path = sprintf('/v2/procedures/%s/versions/%s', procedure_id, tag);
            response = obj.Client.delete(path);
        end

        function response = create(obj, procedure_id, request)
            %CREATE Create procedure version
            %   Create a new version for an existing test procedure. Versions let you track procedure changes over time and maintain a history of test configurations.
            arguments
                obj
                procedure_id (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/procedures/%s/versions', procedure_id);
            response = obj.Client.post(path, request);
        end
    end
end
