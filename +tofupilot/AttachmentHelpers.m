classdef AttachmentHelpers
    %ATTACHMENTHELPERS Convenience methods for file upload and download.
    %
    %   Methods (Static):
    %     upload   - Upload a local file and return its attachment ID.
    %     download - Download an attachment to a local file.
    %
    %   Example:
    %     sdk = tofupilot.TofuPilot('your-api-key');
    %     id = tofupilot.AttachmentHelpers.upload(sdk.Attachments, 'report.pdf');
    %     tofupilot.AttachmentHelpers.download(downloadUrl, 'local_copy.pdf');
    %
    %   See also tofupilot.Attachments, tofupilot.TofuPilot

    methods (Static)
        function attachmentId = upload(attachments, filePath)
            %UPLOAD Upload a file and return its attachment ID.
            %   id = tofupilot.AttachmentHelpers.upload(sdk.Attachments, filePath)
            %
            %   Handles the full workflow: initialize -> PUT to storage -> finalize.
            %
            %   Input:
            %     attachments - tofupilot.Attachments resource from the SDK
            %     filePath    - Path to the local file to upload
            %
            %   Output:
            %     attachmentId - UUID string to use with Runs.update or Units.update
            arguments
                attachments
                filePath (1,1) string
            end

            if ~isfile(filePath)
                error('tofupilot:FileNotFound', 'File not found: %s', filePath);
            end

            [~, name, ext] = fileparts(filePath);
            fileName = name + ext;

            % Step 1: Initialize upload
            initResp = attachments.initialize(struct('name', char(fileName)));

            % Step 2: PUT file bytes to the pre-signed URL
            uploadUrl = string(initResp.upload_url);
            contentType = tofupilot.AttachmentHelpers.getContentType(ext);

            javaUrl = java.net.URL(char(uploadUrl));
            conn = javaUrl.openConnection();
            conn.setRequestMethod('PUT');
            conn.setDoOutput(true);
            conn.setRequestProperty('Content-Type', contentType);
            fid2 = fopen(char(filePath), 'r');
            fileBytes = fread(fid2, '*uint8');
            fclose(fid2);
            conn.setRequestProperty('Content-Length', string(numel(fileBytes)));
            outStream = conn.getOutputStream();
            outStream.write(fileBytes);
            outStream.close();
            responseCode = conn.getResponseCode();
            conn.disconnect();
            if responseCode < 200 || responseCode >= 300
                error('tofupilot:UploadFailed', 'Upload failed with status %d', responseCode);
            end

            % Step 3: Finalize
            attachments.finalize(string(initResp.id));

            attachmentId = string(initResp.id);
        end

        function outputPath = download(downloadUrl, destinationPath)
            %DOWNLOAD Download an attachment to a local file.
            %   path = tofupilot.AttachmentHelpers.download(url, destPath)
            %
            %   Input:
            %     downloadUrl     - The download URL from an attachment object
            %     destinationPath - Local file path to save to
            %
            %   Output:
            %     outputPath - The path to the downloaded file
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
        function ct = getContentType(ext)
            %GETCONTENTTYPE Map file extension to MIME content type.
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
                case '.txt',  ct = 'text/plain';
                case {'.html', '.htm'}, ct = 'text/html';
                otherwise, ct = 'application/octet-stream';
            end
        end
    end
end
