classdef Imports < handle
    %IMPORTS Imports resource operations.
    %
    %   Methods:
    %     createFromFiles - Import runs from files
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Imports(client)
            %IMPORTS Create Imports resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = createFromFiles(obj, request)
            %CREATEFROMFILES Import runs from files
            %   Import one or more previously uploaded files (OpenHTF, WATS WSJF/WSXF, ATML, NI TestStand, STDF, or ATDF) in a single call. Each file is parsed independently and its result returned per-item, so one bad file does not fail the others. A file that contains several units (a multi-part STDF/ATDF datalog or a multi-report WSXF/TestStand document) creates one run per unit; all run ids are returned in the item’s `ids`.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/import', request);
        end
    end
end
