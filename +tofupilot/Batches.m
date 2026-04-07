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
            %   Retrieve a single batch by its number, including all associated units, serial numbers, and part revisions.
            arguments
                obj
                number (1,1) string
            end
            path = sprintf('/v2/batches/%s', number);
            response = obj.Client.get(path);
        end

        function response = delete(obj, number)
            %DELETE Delete batch
            %   Permanently delete a batch by number. Units associated with the batch will be disassociated but not deleted. No nested elements are removed.
            arguments
                obj
                number (1,1) string
            end
            path = sprintf('/v2/batches/%s', number);
            response = obj.Client.delete(path);
        end

        function response = update(obj, number, request)
            %UPDATE Update batch
            %   Update a batch number. The current batch number is specified in the URL path with case-insensitive matching.
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
            %   Retrieve batches with associated units, serial numbers, and part revisions using cursor-based pagination.
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
            %   Create a new batch without any units attached. Batch numbers are matched case-insensitively (e.g., "BATCH-001" and "batch-001" are considered the same).
            arguments
                obj
                request struct = struct()
            end
            response = obj.Client.post('/v2/batches', request);
        end
    end
end
