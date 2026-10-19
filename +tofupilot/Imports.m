classdef Imports < handle
    %IMPORTS Imports resource operations.
    %
    %   Methods:
    %     structured - Import runs from structured files
    %     tabular - Import a run from a tabular file
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

        function response = structured(obj, request)
            %STRUCTURED Import runs from structured files
            %   Import one or more previously uploaded structured files (OpenHTF, WATS WSJF/WSXF, ATML, NI TestStand, STDF, or ATDF) in a single call. Each file is parsed independently and its result returned per-item, so one bad file does not fail the others. A file that contains several units (a multi-part STDF/ATDF datalog or a multi-report WSXF/TestStand document) creates one run per unit, and all run ids are returned in the item’s `ids`. A file whose exact content was already imported in your organization is not imported twice: its result returns the existing runs with `already_imported: true`, so retrying a batch is safe. A file whose earlier import created only some of its runs is not completed: the `warnings` of that first import say how to create the rest. Set `allow_duplicate` to import the file again as new runs, next to the existing ones.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/imports/structured', request);
        end

        function response = tabular(obj, request)
            %TABULAR Import a run from a tabular file
            %   Import a previously uploaded tabular file (CSV or Excel) by mapping its columns to TofuPilot fields. Provide exactly one of `mapping` (an inline column mapping) or `template_id` (a mapping template saved in the dashboard). The `procedure_id` is required and overrides any procedure referenced in the file.
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/imports/tabular', request);
        end
    end
end
