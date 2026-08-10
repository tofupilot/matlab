classdef AttachmentHelpers
    %ATTACHMENTHELPERS Convenience methods for attaching files and downloading.
    %
    %   Methods (Static):
    %     attachToRun  - Attach a file to a run.
    %     attachToUnit - Attach a file to a unit.
    %     download     - Download an attachment to a local file.
    %
    %   Example:
    %     sdk = tofupilot.TofuPilot('your-api-key');
    %     tofupilot.AttachmentHelpers.attachToRun(sdk, runId, 'report.pdf');
    %     tofupilot.AttachmentHelpers.attachToUnit(sdk, 'SN-0001', 'cal.pdf');
    %
    %   See also tofupilot.Runs, tofupilot.Units, tofupilot.TofuPilot

    methods (Static)
        function attachmentId = attachToRun(sdkOrRuns, runId, filePath)
            %ATTACHTORUN Attach a file to a run. Returns the attachment ID.
            %   id = tofupilot.AttachmentHelpers.attachToRun(sdk, runId, filePath)
            %
            %   Pass the root sdk (tofupilot.TofuPilot). The PUT stores the
            %   bytes but records no metadata; the finalize call afterwards
            %   stamps size and content type, and needs sdk.Attachments.
            %   Passing sdk.Runs (the pre-2.9 signature) still uploads but
            %   cannot finalize, so the attachment shows size 0.
            arguments
                sdkOrRuns
                runId (1,1) string
                filePath (1,1) string
            end

            if ~isfile(filePath)
                error('tofupilot:FileNotFound', 'File not found: %s', filePath);
            end

            [~, name, ext] = fileparts(filePath);
            fileName = name + ext;

            [runs, attachments] = tofupilot.AttachmentHelpers.resolveApis(sdkOrRuns, 'Runs');
            result = runs.createAttachment(char(runId), struct('name', char(fileName)));
            tofupilot.AttachmentHelpers.putFile(filePath, string(result.upload_url), ext);
            % Best-effort: the attachment is already stored and linked, so
            % a metadata failure must not fail the upload — the caller
            % would retry and duplicate it.
            if ~isempty(attachments)
                try
                    attachments.finalize(char(string(result.id)));
                catch ex
                    warning('tofupilot:FinalizeFailed', ...
                        'Attachment %s uploaded but not finalized (size will read 0): %s', ...
                        char(string(result.id)), ex.message);
                end
            end
            attachmentId = string(result.id);
        end

        function attachmentId = attachToUnit(sdkOrUnits, serialNumber, filePath)
            %ATTACHTOUNIT Attach a file to a unit. Returns the attachment ID.
            %   id = tofupilot.AttachmentHelpers.attachToUnit(sdk, serialNumber, filePath)
            %
            %   Pass the root sdk (tofupilot.TofuPilot); see attachToRun for
            %   why the finalize step needs it.
            arguments
                sdkOrUnits
                serialNumber (1,1) string
                filePath (1,1) string
            end

            if ~isfile(filePath)
                error('tofupilot:FileNotFound', 'File not found: %s', filePath);
            end

            [~, name, ext] = fileparts(filePath);
            fileName = name + ext;

            [units, attachments] = tofupilot.AttachmentHelpers.resolveApis(sdkOrUnits, 'Units');
            result = units.createAttachment(char(serialNumber), struct('name', char(fileName)));
            tofupilot.AttachmentHelpers.putFile(filePath, string(result.upload_url), ext);
            % Best-effort: the attachment is already stored and linked, so
            % a metadata failure must not fail the upload — the caller
            % would retry and duplicate it.
            if ~isempty(attachments)
                try
                    attachments.finalize(char(string(result.id)));
                catch ex
                    warning('tofupilot:FinalizeFailed', ...
                        'Attachment %s uploaded but not finalized (size will read 0): %s', ...
                        char(string(result.id)), ex.message);
                end
            end
            attachmentId = string(result.id);
        end

        function [resource, attachments] = resolveApis(sdkOrResource, resourceName)
            %RESOLVEAPIS Accept the root sdk or a bare resource object.
            %   With the root sdk both the resource and the attachments API
            %   are available, so uploads can finalize. A bare resource
            %   (pre-2.9 call style) cannot reach the attachments API — warn
            %   so the size-0 result is traceable.
            if isa(sdkOrResource, 'tofupilot.TofuPilot')
                resource = sdkOrResource.(resourceName);
                attachments = sdkOrResource.Attachments;
            else
                resource = sdkOrResource;
                attachments = [];
                warning('tofupilot:NoFinalize', ...
                    ['Pass the root sdk object so the upload can be ' ...
                     'finalized; without it the attachment is stored but ' ...
                     'its size and content type are not recorded.']);
            end
        end

        function outputPath = download(downloadUrl, destinationPath)
            %DOWNLOAD Download an attachment to a local file.
            arguments
                downloadUrl (1,1) string
                destinationPath (1,1) string
            end

            if strlength(downloadUrl) == 0
                error('tofupilot:InvalidUrl', 'Download URL cannot be empty.');
            end

            outputPath = websave(char(destinationPath), char(downloadUrl));
            outputPath = string(outputPath);
        end
    end

    methods (Static, Access = private)
        function putFile(filePath, uploadUrl, ext)
            %PUTFILE Upload file bytes to a pre-signed URL via HTTP PUT.
            contentType = tofupilot.AttachmentHelpers.getContentType(ext);

            javaUrl = java.net.URL(char(uploadUrl));
            conn = javaUrl.openConnection();
            conn.setRequestMethod('PUT');
            conn.setDoOutput(true);
            conn.setRequestProperty('Content-Type', contentType);
            fid = fopen(char(filePath), 'r');
            fileBytes = fread(fid, '*uint8');
            fclose(fid);
            conn.setRequestProperty('Content-Length', string(numel(fileBytes)));
            outStream = conn.getOutputStream();
            outStream.write(fileBytes);
            outStream.close();
            responseCode = conn.getResponseCode();
            conn.disconnect();
            if responseCode < 200 || responseCode >= 300
                error('tofupilot:UploadFailed', 'Upload failed with status %d', responseCode);
            end
        end

        function ct = getContentType(ext)
            ext = lower(char(ext));
            switch ext
                case '.pdf',  ct = 'application/pdf';
                case '.png',  ct = 'image/png';
                case {'.jpg', '.jpeg'}, ct = 'image/jpeg';
                case '.gif',  ct = 'image/gif';
                case '.csv',  ct = 'text/csv';
                case '.json', ct = 'application/json';
                case '.xml',  ct = 'application/xml';
                case '.zip',  ct = 'application/zip';
                case {'.txt', '.log'}, ct = 'text/plain';
                case {'.html', '.htm'}, ct = 'text/html';
                otherwise, ct = 'application/octet-stream';
            end
        end
    end
end
