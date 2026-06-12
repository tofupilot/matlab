classdef Deployments < handle
    %DEPLOYMENTS Deployments resource operations.
    %
    %   Methods:
    %     list - List and filter deployments
    %     get - Get deployment
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = Deployments(client)
            %DEPLOYMENTS Create Deployments resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List and filter deployments
            %   List deployments with filtering by procedure, environment, build status, branch, author, and date range. Cursor-paginated.
            arguments
                obj
                opts.procedureIds  = []
                opts.environments  = []
                opts.buildStatuses  = []
                opts.pushed  = []
                opts.branchNames  = []
                opts.authorUsernames  = []
                opts.deployedAfter (1,1) string = ""
                opts.deployedBefore (1,1) string = ""
                opts.searchQuery (1,1) string = ""
                opts.limit (1,1) double = 50
                opts.cursor  = []
            end
            queryParams = struct();
            if ~isempty(opts.procedureIds)
                queryParams.procedure_ids = opts.procedureIds;
            end
            if ~isempty(opts.environments)
                queryParams.environments = opts.environments;
            end
            if ~isempty(opts.buildStatuses)
                queryParams.build_statuses = opts.buildStatuses;
            end
            if ~isempty(opts.pushed)
                queryParams.pushed = opts.pushed;
            end
            if ~isempty(opts.branchNames)
                queryParams.branch_names = opts.branchNames;
            end
            if ~isempty(opts.authorUsernames)
                queryParams.author_usernames = opts.authorUsernames;
            end
            if ~isempty(opts.deployedAfter)
                queryParams.deployed_after = opts.deployedAfter;
            end
            if ~isempty(opts.deployedBefore)
                queryParams.deployed_before = opts.deployedBefore;
            end
            if ~isempty(opts.searchQuery)
                queryParams.search_query = opts.searchQuery;
            end
            if ~isempty(opts.limit)
                queryParams.limit = opts.limit;
            end
            if ~isempty(opts.cursor)
                queryParams.cursor = opts.cursor;
            end
            response = obj.Client.get('/v2/deployments', queryParams);
        end

        function response = get(obj, id)
            %GET Get deployment
            %   Get a deployment by ID, with its artifact metadata, commit, creator, and per-station push state.
            arguments
                obj
                id (1,1) string
            end
            path = sprintf('/v2/deployments/%s', id);
            response = obj.Client.get(path);
        end
    end
end
