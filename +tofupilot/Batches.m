classdef Batches < handle
    %BATCHES Batches resource operations.
    %
    %   Methods:
    %     get - Get batch
    %     delete - Delete batch
    %     update - Update batch
    %     list - List and filter batches
    %     create - Create batch
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Batches(client)
            %BATCHES Create Batches resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = get(obj, number)
            %GET Get batch
            %   Get a batch by number, with its units, serial numbers, and part revisions.
            arguments
                obj
                number (1,1) string
            end
            path = sprintf('/v2/batches/%s', number);
            response = obj.Client.get(path);
        end

        function response = delete(obj, number)
            %DELETE Delete batch
            %   Delete a batch by number. Linked units are unlinked, not deleted.
            arguments
                obj
                number (1,1) string
            end
            path = sprintf('/v2/batches/%s', number);
            response = obj.Client.delete(path);
        end

        function response = update(obj, number, request)
            %UPDATE Update batch
            %   Rename a batch. The current number matches case-insensitively.
            arguments
                obj
                number (1,1) string
                request struct = struct()
            end
            path = sprintf('/v2/batches/%s', number);
            response = obj.Client.patch(path, request);
        end

        function response = list(obj, opts)
            %LIST List and filter batches
            %   List batches with their units, serial numbers, and part revisions. Cursor-paginated.
            arguments
                obj
                opts.ids  = []
                opts.numbers  = []
                opts.createdAfter (1,1) string = ""
                opts.createdBefore (1,1) string = ""
                opts.limit (1,1) double = 50
                opts.cursor  = []
                opts.searchQuery (1,1) string = ""
                opts.partNumbers  = []
                opts.revisionNumbers  = []
                opts.sortBy (1,1) string = "created_at"
                opts.sortOrder (1,1) string = "desc"
            end
            queryParams = struct();
            if ~isempty(opts.ids)
                queryParams.ids = opts.ids;
            end
            if ~isempty(opts.numbers)
                queryParams.numbers = opts.numbers;
            end
            if ~isempty(opts.createdAfter)
                queryParams.created_after = opts.createdAfter;
            end
            if ~isempty(opts.createdBefore)
                queryParams.created_before = opts.createdBefore;
            end
            if ~isempty(opts.limit)
                queryParams.limit = opts.limit;
            end
            if ~isempty(opts.cursor)
                queryParams.cursor = opts.cursor;
            end
            if ~isempty(opts.searchQuery)
                queryParams.search_query = opts.searchQuery;
            end
            if ~isempty(opts.partNumbers)
                queryParams.part_numbers = opts.partNumbers;
            end
            if ~isempty(opts.revisionNumbers)
                queryParams.revision_numbers = opts.revisionNumbers;
            end
            if ~isempty(opts.sortBy)
                queryParams.sort_by = opts.sortBy;
            end
            if ~isempty(opts.sortOrder)
                queryParams.sort_order = opts.sortOrder;
            end
            response = obj.Client.get('/v2/batches', queryParams);
        end

        function response = create(obj, request)
            %CREATE Create batch
            %   Create an empty batch. Batch numbers match case-insensitively ("BATCH-001" == "batch-001").
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/batches', request);
        end
    end
end
