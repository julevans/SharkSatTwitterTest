function [dHav, dPyt]=latlonDIST(lat1,lon1,lat2,lon2)
%modified from MATLAB script by M. Sohrabinia
%Inputs:
%   latlon1: latlon of origin point [lat lon]
%   latlon2: latlon of destination point [lat lon]
%Outputs:
%   d1km: distance calculated by Haversine formula
%   d2km: distance calculated based on Pythagoran theorem
%--------------------------------------------------------------------------

%initial inputs
radius=6371; %[km]

%convert strings to doubles
lat1 = str2double(lat1);
lon1 = str2double(lon1);
lat2 = str2double(lat2);
lon2 = str2double(lon2);

%lat points (convert to radians)
lat1=lat1*pi/180;
lat2=lat2*pi/180;

%lon points (convert to radians)
lon1=lon1*pi/180;
lon2=lon2*pi/180;

%calculate changes in lat/lon (simple subtraction)
deltaLat=lat2-lat1;
deltaLon=lon2-lon1;

%Haversine distance 
a=sin((deltaLat)/2)^2 + cos(lat1)*cos(lat2) * sin(deltaLon/2)^2;
c=2*atan2(sqrt(a),sqrt(1-a));
dHav=radius*c;   

%Pythagorean distance
x=deltaLon*cos((lat1+lat2)/2);
y=deltaLat;
dPyt=radius*sqrt(x*x + y*y); 

end