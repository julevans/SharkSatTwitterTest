function [lat,lon,year,month,day] = extractTweetInfo(inputText)
%% INPUTS
% inputText: the entire input string of the tweet's text
%% OUTPUTS
% lat, lon, year, month, day
% outputs are all in string format


%% String input
%test
%inputText = 'Take a picture of 37.207 S, 80.408 W on 2018-03-15 @VTSharkSat #VTSharkSat';
%A = 'Take a picture of 137.207 N, 80.408 E on 2018-03-15 @VTSharkSat #VTSharkSat';

A = char(inputText);
B = regexp(A,'\d*','Match');
B = B';

%get latitude coordinate by extracting number from string and concatenating strings
lat1 = string(B(1,1));
lat2 = string(B(2,1));
lat = strcat(lat1,'.',lat2);

%get longitude coordinate by extracting number from string and concatenating strings
lon1 = string(B(3,1));
lon2 = string(B(4,1));
lon = strcat(lon1,'.',lon2);

%get datetime information
year = string(B(5,1));
month = string(B(6,1));
day = string(B(7,1));


%% Check if lat/lon are N or S and E or W

%search for any of these: 'N' 'S' 'E' 'W'
ifN = strfind(A,' N');
ifS = strfind(A,' S');
ifE = strfind(A,' E ');
ifW = strfind(A,' W ');

%If statement for 'N'
if isempty(ifN)==0 && isempty(ifS)==1
    latNS = string(A(ifN+1));
end

%If statement for 'S'
if isempty(ifS)==0 && isempty(ifN)==1
    latNS = string(A(ifS+1));
end

%If statement for 'E'
if isempty(ifE)==0 && isempty(ifW)==1
    lonEW = string(A(ifE+1));
end

%If statement for 'W'
if isempty(ifW)==0 && isempty(ifE)==1
    lonEW = string(A(ifW+1));
end

%% Switch statements for N/S and E/W (convert to +/- numbers)
switch latNS
    case 'N'
        %do nothing, latitude is positive
    case 'S'
        lat = str2double(lat);
        lat = -1*lat;
        lat = string(lat);
end

switch lonEW
    case 'E'
        %do nothing, longitude is positive
    case 'W'
        lon = str2double(lon);
        lon = -1*lon;
        lon = string(lon);
end

end