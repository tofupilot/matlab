classdef Revisions < handle
    %REVISIONS Revisions resource operations.
    %
    %   Methods:
    %     get - Get part revision
    %     update - Update part revision
    %     delete - Delete part revision
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
            %   Get a part revision by part number and revision number, with its metadata, configuration, and linked units.
            arguments
                obj
                part_number (1,1) string
                revision_number (1,1) string
            end
            path = sprintf('/v2/parts/%s/revisions/%s', part_number, revision_number);
            response = obj.Client.get(path);
        end

        function response = update(obj, part_number, revision_number, request)
            %UPDATE Update part revision
            %   Update a revision's number or image.
            arguments
                obj
                part_number (1,1) string
                revision_number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/parts/%s/revisions/%s', part_number, revision_number);
            response = obj.Client.patch(path, request);
        end

        function response = delete(obj, part_number, revision_number)
            %DELETE Delete part revision
            %   Delete a part revision. Irreversible.
            arguments
                obj
                part_number (1,1) string
                revision_number (1,1) string
            end
            path = sprintf('/v2/parts/%s/revisions/%s', part_number, revision_number);
            response = obj.Client.delete(path);
        end

        function response = create(obj, part_number, request)
            %CREATE Create part revision
            %   Create a revision of a part. Revision numbers match case-insensitively ("REV-A" == "rev-a").
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
