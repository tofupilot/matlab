function package_toolbox()
%PACKAGE_TOOLBOX Build the TofuPilot SDK .mltbx toolbox file.
%   Run from the matlab/ directory:
%     package_toolbox
%
%   Output: release/TofuPilot.mltbx

    rootDir = fileparts(mfilename('fullpath'));
    toolboxFolder = fullfile(rootDir, '+tofupilot');
    releaseDir = fullfile(rootDir, 'release');

    if ~isfolder(releaseDir)
        mkdir(releaseDir);
    end

    uuid = 'b7e3f1a2-4c6d-4e8f-9a1b-2c3d4e5f6a7b';
    opts = matlab.addons.toolbox.ToolboxOptions(toolboxFolder, uuid);

    opts.ToolboxName = 'TofuPilot';
    opts.ToolboxVersion = '2.0.1';
    opts.Summary = 'TofuPilot API v2 client for MATLAB';
    opts.Description = 'MATLAB SDK for the TofuPilot REST API. Manage test runs, units, procedures, parts, batches, stations, and attachments.';
    opts.AuthorName = 'TofuPilot';
    opts.AuthorEmail = 'support@tofupilot.com';
    opts.AuthorCompany = 'TofuPilot';
    opts.OutputFile = fullfile(releaseDir, 'TofuPilot.mltbx');
    opts.MinimumMatlabRelease = 'R2019b';
    opts.ToolboxMatlabPath = rootDir;

    matlab.addons.toolbox.packageToolbox(opts);
    fprintf('Packaged: %s\n', opts.OutputFile);
end
