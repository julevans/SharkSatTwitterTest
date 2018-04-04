%% function [orbitVal] = getOrbit(coordData, myLat, myLon)
% Author: Julianna M. Evans
% Data: 04.02.2018
% Last Rev: 04.02.2018


function [orbitVal] = getOrbit(coordData, myLat, myLon)

%calculate distance from the requested point to all lat/lon points
for i = 1:length(coordData)
    
    %values
    latDataPt = coordData(i,2);
    lonDataPt = coordData(i,3);
    
    
    %store the information (use Haversine)
    [dHav(i)]=latlonDIST(myLat,myLon,latDataPt,lonDataPt);
    
    
end

%get the minimum distance 
    %determine the maximum value and corresponding index
    %[minVal maxIdx] = abs(min(dHav));
    [minVal minIdx] = min(dHav);
%set the output
orbitVal = coordData(minIdx,1);



end