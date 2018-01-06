function [latitude,longitude]= location()
connector on matlab2017;
m = mobiledev;
m.PositionSensorEnabled = 1;
m.Logging = 1;
m.Logging = 0;
[lat, lon, t, spd] = poslog(m);
nBins = 10;
binSpacing = (max(spd) - min(spd))/nBins;
binRanges = min(spd):binSpacing:max(spd)-binSpacing;


% Add an inf to binRanges to enclose the values above the last bin.
binRanges(end+1) = inf;

% histc determines which bin each speed value falls into.connector
[~, spdBins] = histc(spd, binRanges);
lat = lat';
lon = lon';
spdBins = spdBins';

% Create a geographical shape vector, which stores the line segments as
% features.
%s = geoshape();

for k = 1:nBins

    % Keep only the lat/lon values which match the current bin. Leave the
    % rest as NaN, which are interpreted as breaks in the line segments.
    latValid = nan(1, length(lat));
    latValid(spdBins==k) = lat(spdBins==k);

    lonValid = nan(1, length(lon));
    lonValid(spdBins==k) = lon(spdBins==k);

    % To make the path continuous despite being segmented into different
    % colors, the lat/lon values that occur after transitioning from the
    % current speed bin to another speed bin will need to be kept.
    transitions = [diff(spdBins) 0];
    insertionInd = find(spdBins==k & transitions~=0) + 1;

    % Preallocate space for and insert the extra lat/lon values.
    latSeg = zeros(1, length(latValid) + length(insertionInd));
    latSeg(insertionInd + (0:length(insertionInd)-1)) = lat(insertionInd);
    latSeg(~latSeg) = latValid;

    lonSeg = zeros(1, length(lonValid) + length(insertionInd));
    lonSeg(insertionInd + (0:length(insertionInd)-1)) = lon(insertionInd);
    lonSeg(~lonSeg) = lonValid;

    % Add the lat/lon segments to the geographic shape vector.
    s(k) = geoshape(latSeg, lonSeg);

end
wm = webmap('World Street Map');
mwLat = lat;
latitude= lat;
mwLon = lon;
longitude = lon;
name = 'MathWorks';
iconDir = fullfile(matlabroot,'toolbox','matlab','icons');
iconFilename = fullfile(iconDir, 'matlabicon.gif');
wmmarker(mwLat, mwLon, 'FeatureName', name, 'Icon', iconFilename);
