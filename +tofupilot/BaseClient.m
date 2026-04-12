classdef BaseClient < handle
    %BASECLIENT Low-level HTTP client for TofuPilot API communication.
    %
    %   This class handles authentication, request serialization, retry
    %   logic, and request lifecycle hooks for all TofuPilot API endpoints.
    %   It is not intended for direct use — access it through tofupilot.TofuPilot.
    %
    %   See also tofupilot.TofuPilot

    properties (Access = private)
        ApiKey     string
        BaseUrl    string
        Options    weboptions
        MaxRetries double
        Hooks      struct
    end

    methods
        function obj = BaseClient(apiKey, baseUrl, timeout, maxRetries, hooks)
            %BASECLIENT Create a new HTTP client.
            %   client = BaseClient(apiKey, baseUrl, timeout, maxRetries, hooks)
            arguments
                apiKey (1,1) string
                baseUrl (1,1) string
                timeout (1,1) double
                maxRetries (1,1) double = 3
                hooks struct = struct('beforeRequest', {{}}, 'afterSuccess', {{}}, 'afterError', {{}})
            end
            obj.ApiKey = apiKey;
            obj.BaseUrl = baseUrl;
            obj.MaxRetries = maxRetries;
            obj.Hooks = hooks;
            obj.Options = weboptions( ...
                'HeaderFields', { ...
                    'Authorization', ['Bearer ' char(apiKey)]; ...
                    'User-Agent', 'tofupilot-matlab/2.0.2' ...
                }, ...
                'ContentType', 'json', ...
                'Timeout', timeout, ...
                'MediaType', 'application/json');
        end

        function response = get(obj, path, queryParams)
            %GET Send GET request.
            %   response = client.get(path)
            %   response = client.get(path, queryParams)
            arguments
                obj
                path (1,1) string
                queryParams struct = struct()
            end
            url = obj.BaseUrl + path;
            qs = obj.buildQueryString(queryParams);
            if strlength(qs) > 0
                url = url + "?" + qs;
            end
            response = obj.doRequest(@() webread(char(url), obj.Options), 'GET', path);
        end

        function response = post(obj, path, body)
            %POST Send POST request.
            %   response = client.post(path)
            %   response = client.post(path, body)
            arguments
                obj
                path (1,1) string
                body struct = struct()
            end
            url = obj.BaseUrl + path;
            response = obj.doRequest(@() webwrite(char(url), body, obj.Options), 'POST', path);
        end

        function response = patch(obj, path, body)
            %PATCH Send PATCH request.
            %   response = client.patch(path, body)
            arguments
                obj
                path (1,1) string
                body struct = struct()
            end
            url = obj.BaseUrl + path;
            opts = obj.Options;
            opts.RequestMethod = 'patch';
            response = obj.doRequest(@() webwrite(char(url), body, opts), 'PATCH', path);
        end

        function response = put(obj, path, body)
            %PUT Send PUT request.
            %   response = client.put(path, body)
            arguments
                obj
                path (1,1) string
                body struct = struct()
            end
            url = obj.BaseUrl + path;
            opts = obj.Options;
            opts.RequestMethod = 'put';
            response = obj.doRequest(@() webwrite(char(url), body, opts), 'PUT', path);
        end

        function response = delete(obj, path, body)
            %DELETE Send DELETE request.
            %   response = client.delete(path)
            %   response = client.delete(path, body)
            arguments
                obj
                path (1,1) string
                body struct = struct()
            end
            url = obj.BaseUrl + path;
            opts = obj.Options;
            opts.RequestMethod = 'delete';
            if isempty(fieldnames(body))
                response = obj.doRequest(@() webwrite(char(url), '', opts), 'DELETE', path);
            else
                response = obj.doRequest(@() webwrite(char(url), body, opts), 'DELETE', path);
            end
        end

        function response = deleteWithQuery(obj, path, queryParams)
            %DELETEWITHQUERY Send DELETE request with query parameters.
            %   response = client.deleteWithQuery(path, queryParams)
            arguments
                obj
                path (1,1) string
                queryParams struct = struct()
            end
            url = obj.BaseUrl + path;
            qs = obj.buildQueryString(queryParams);
            if strlength(qs) > 0
                url = url + "?" + qs;
            end
            opts = obj.Options;
            opts.RequestMethod = 'delete';
            response = obj.doRequest(@() webwrite(char(url), '', opts), 'DELETE', path);
        end
    end

    methods (Access = private)
        function response = doRequest(obj, requestFn, method, path)
            %DOREQUEST Execute request with retry logic and hooks.
            %   Retries on 429 (Too Many Requests) and 5xx errors with
            %   exponential backoff (1s, 2s, 4s, ...).

            % Before-request hooks
            ctx = struct('method', method, 'path', path, 'base_url', char(obj.BaseUrl));
            for k = 1:numel(obj.Hooks.beforeRequest)
                obj.Hooks.beforeRequest{k}(ctx);
            end

            lastErr = [];
            for attempt = 0:obj.MaxRetries
                try
                    response = requestFn();

                    % After-success hooks
                    for k = 1:numel(obj.Hooks.afterSuccess)
                        obj.Hooks.afterSuccess{k}(ctx, response);
                    end
                    return;
                catch err
                    lastErr = err;

                    % After-error hooks
                    for k = 1:numel(obj.Hooks.afterError)
                        obj.Hooks.afterError{k}(ctx, err);
                    end

                    % Only retry on 429 or 5xx
                    if ~obj.isRetryable(err) || attempt == obj.MaxRetries
                        rethrow(err);
                    end

                    % Exponential backoff: 1s, 2s, 4s, ...
                    pause(2^attempt);
                end
            end
            rethrow(lastErr);
        end

        function tf = isRetryable(~, err)
            %ISRETRYABLE Check if the error is retryable (429 or 5xx).
            tf = false;
            msg = err.message;
            if contains(msg, '429')
                tf = true;
            elseif contains(msg, {'500', '502', '503', '504'})
                tf = true;
            end
        end

        function qs = buildQueryString(obj, s)
            %BUILDQUERYSTRING Convert struct to URL query string.
            %   Skips empty values and URL-encodes string values.
            qs = "";
            fields = fieldnames(s);
            parts = {};
            for i = 1:numel(fields)
                val = s.(fields{i});
                if ~isempty(val)
                    if (isstring(val) || ischar(val)) && strlength(val) == 0
                        continue;
                    end
                    key = string(fields{i});
                    if isstring(val) || ischar(val)
                        parts{end+1} = key + "=" + obj.urlencode(char(val)); %#ok<AGROW>
                    elseif isnumeric(val) && isscalar(val)
                        parts{end+1} = key + "=" + string(num2str(val)); %#ok<AGROW>
                    elseif islogical(val) && isscalar(val)
                        if val
                            parts{end+1} = key + "=true"; %#ok<AGROW>
                        else
                            parts{end+1} = key + "=false"; %#ok<AGROW>
                        end
                    elseif iscell(val)
                        for j = 1:numel(val)
                            parts{end+1} = key + "=" + obj.urlencode(char(string(val{j}))); %#ok<AGROW>
                        end
                    end
                end
            end
            if ~isempty(parts)
                qs = strjoin(string(parts), "&");
            end
        end

        function encoded = urlencode(~, str)
            %URLENCODE Percent-encode a string for use in URL query values.
            encoded = char(java.net.URLEncoder.encode(str, 'UTF-8'));
            % URLEncoder encodes spaces as '+'; convert to %20 for RFC 3986
            encoded = strrep(encoded, '+', '%20');
        end
    end
end
