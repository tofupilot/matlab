classdef Attachments < handle
    %ATTACHMENTS Attachments resource operations.
    %
    %   Methods:
    %     initialize - Initialize upload
    %     finalize - Finalize upload
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Attachments(client)
            %ATTACHMENTS Create Attachments resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = initialize(obj, request)
            %INITIALIZE Initialize upload
            %   Get a temporary pre-signed URL to upload a file. Returns the upload ID and URL. Upload the file to the URL with a PUT request, then call Finalize upload.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/attachments', request);
        end

        function response = finalize(obj, id)
            %FINALIZE Finalize upload
            %   Finalize a file upload after uploading to the pre-signed URL. Validates the file and records its metadata.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/attachments/%s/finalize', id);
            response = obj.Client.post(path);
        end
    end
end
