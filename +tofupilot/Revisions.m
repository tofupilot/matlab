classdef Revisions < handle
    %REVISIONS Revisions resource operations.
    %
    %   Methods:
    %     get - Get part revision
    %     delete - Delete part revision
    %     update - Update part revision
    %     create - Create part revision
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Revisions(client)
            %REVISIONS Create Revisions resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = get(obj, part_number, revision_number)
            %GET Get part revision
            %   Retrieve a single part revision by its part number and revision number, including revision metadata, configuration details, and linked units.
            arguments
                obj
                part_number (1,1) string
                revision_number (1,1) string
            end
            path = sprintf('/v2/parts/%s/revisions/%s', part_number, revision_number);
            response = obj.Client.get(path);
        end

        function response = delete(obj, part_number, revision_number)
            %DELETE Delete part revision
            %   Permanently delete a part revision by its part number and revision number. This action removes the revision and all associated data and cannot be undone.
            arguments
                obj
                part_number (1,1) string
                revision_number (1,1) string
            end
            path = sprintf('/v2/parts/%s/revisions/%s', part_number, revision_number);
            response = obj.Client.delete(path);
        end

        function response = update(obj, part_number, revision_number, request)
            %UPDATE Update part revision
            %   Update a part revision's number or image. Identifies the revision by part number and revision number in the URL.
            arguments
                obj
                part_number (1,1) string
                revision_number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/parts/%s/revisions/%s', part_number, revision_number);
            response = obj.Client.patch(path, request);
        end

        function response = create(obj, part_number, request)
            %CREATE Create part revision
            %   Create a new part revision for an existing part. Revision numbers are matched case-insensitively (e.g., "REV-A" and "rev-a" are considered the same).
            arguments
                obj
                part_number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/parts/%s/revisions', part_number);
            response = obj.Client.post(path, request);
        end
    end
end
