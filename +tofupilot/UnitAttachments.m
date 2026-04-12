classdef UnitAttachments < handle
    %UNITATTACHMENTS Sub-resource for unit attachments.
    %
    %   Methods:
    %     upload   - Upload a file and attach it to a unit. Returns the attachment ID.
    %     download - Download an attachment to a local file.
    %     delete   - Delete attachments from a unit by their IDs.
    %
    %   Example:
    %     sdk = tofupilot.TofuPilot('your-api-key');
    %     id = sdk.Units.Attachments.upload('SN-0001', 'calibration.pdf');
    %     sdk.Units.Attachments.download(downloadUrl, 'local-copy.pdf');
    %     sdk.Units.Attachments.delete('SN-0001', {id});

    properties (Access = private)
        Units  % tofupilot.Units
    end

    methods
        function obj = UnitAttachments(units)
            obj.Units = units;
        end

        function attachmentId = upload(obj, serialNumber, filePath)
            %CREATE Attach a file to a unit. Returns the attachment ID.
            arguments
                obj
                serialNumber (1,1) string
                filePath (1,1) string
            end

            if ~isfile(filePath)
                error('tofupilot:FileNotFound', 'File not found: %s', filePath);
            end

            [~, name, ext] = fileparts(filePath);
            fileName = name + ext;

            result = obj.Units.createAttachment(char(serialNumber), struct('name', char(fileName)));
            tofupilot.UnitAttachments.putFile(filePath, string(result.upload_url), ext);
            attachmentId = string(result.id);
        end

        function outputPath = download(~, downloadUrl, destinationPath)
            %DOWNLOAD Download an attachment to a local file.
            arguments
                ~
                downloadUrl (1,1) string
                destinationPath (1,1) string
            end

            if strlength(downloadUrl) == 0
                error('tofupilot:InvalidUrl', 'Download URL cannot be empty.');
            end

            outputPath = websave(char(destinationPath), char(downloadUrl));
            outputPath = string(outputPath);
        end

        function response = delete(obj, serialNumber, ids)
            %DELETE Delete attachments from a unit by their IDs.
            arguments
                obj
                serialNumber (1,1) string
                ids cell
            end

            response = obj.Units.deleteAttachment(char(serialNumber), 'ids', ids);
        end
    end

    methods (Static, Access = private)
        function putFile(filePath, uploadUrl, ext)
            contentType = tofupilot.UnitAttachments.getContentType(ext);
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
