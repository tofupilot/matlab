classdef AuditLog < handle
    %AUDITLOG AuditLog resource operations.
    %
    %   Methods:
    %     list - List audit events
    %
    %   See also tofupilot.TofuPilot

    properties (SetAccess = {?tofupilot.TofuPilot})
    end

    properties (Access = private)
        Client  % tofupilot.BaseClient
    end

    methods
        function obj = AuditLog(client)
            %AUDITLOG Create AuditLog resource.
            arguments
                client
            end
            obj.Client = client;
        end

        function response = list(obj, opts)
            %LIST List audit events
            %   List the audit trail of the organization, newest first: every change made from the dashboard, the API and MCP, with its actor, target, replaced values and outcome. Cursor-paginated. Requires an Owner or Admin API key, on the Enterprise plan.
            arguments
                obj
                opts.occurredAfter (1,1) string = ""
                opts.occurredBefore (1,1) string = ""
                opts.actions  = []
                opts.actorIds  = []
                opts.vias  = []
                opts.outcomes  = []
                opts.targetType (1,1) string = ""
                opts.targetId (1,1) string = ""
                opts.requestId (1,1) string = ""
                opts.searchQuery (1,1) string = ""
                opts.limit (1,1) double = 50
                opts.cursor (1,1) string = ""
            end
            queryParams = struct();
            if ~isempty(opts.occurredAfter)
                queryParams.occurred_after = opts.occurredAfter;
            end
            if ~isempty(opts.occurredBefore)
                queryParams.occurred_before = opts.occurredBefore;
            end
            if ~isempty(opts.actions)
                queryParams.actions = opts.actions;
            end
            if ~isempty(opts.actorIds)
                queryParams.actor_ids = opts.actorIds;
            end
            if ~isempty(opts.vias)
                queryParams.vias = opts.vias;
            end
            if ~isempty(opts.outcomes)
                queryParams.outcomes = opts.outcomes;
            end
            if ~isempty(opts.targetType)
                queryParams.target_type = opts.targetType;
            end
            if ~isempty(opts.targetId)
                queryParams.target_id = opts.targetId;
            end
            if ~isempty(opts.requestId)
                queryParams.request_id = opts.requestId;
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
            response = obj.Client.get('/v2/audit-events', queryParams);
        end
    end
end
