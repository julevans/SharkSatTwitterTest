%% Twitter Analysis Code
% Author: Julianna M. Evans
% Date: 03.11.2018
% Last Rev: 04.03.2018


%clear statements
clc; clear;

%% NOTE: Required scripts
% tweetObj.m -- the class definition of the twitter object. Used to store tweet info
% extractTweetInfo.m -- function file to analyze the actual text of the tweet

%% NOTE: input CSV created from the Python "tweet_dumper.py" code must be in
% the matlab workspace. You have to enter the filename manually in this
% script.


%% ---------------- START ANALYSIS CODE ---------------------------------%%

%% Import the CSV file

%import to table
filename = 'VTSharkSat_tweets.csv';
TimportCSV = readtable(filename);

%convert to cell from table
Cellstruc = table2cell(TimportCSV);

% get dimensions of the table
[nrows, ncols] = size(Cellstruc);  %NOTE: does NOT include headers in size

%% Assign each tweet to the "tweetObj.m" classdef

%assign "tweet" as a tweetObj class
tweet = tweetObj;

%Assign the twitter-defined properties and store to tweet object
for i = 1:nrows
    
    %assign object properties
    tweet(i).id = Cellstruc(i,1);
    tweet(i).createdAt = Cellstruc(i,2);
    tweet(i).text = Cellstruc(i,3);

    %get and store datetime
    tweet(i).TwDatetime = char(string(tweet(i).createdAt));
    temp = tweet(i).TwDatetime;
    
    %separate datetime information
    tweet(i).TwYear = temp(1:4);
    tweet(i).TwMonth = temp(6:7);
    tweet(i).TwDay = temp(9:10);
    tweet(i).TwHour = temp(12:13);
    tweet(i).TwMin = temp(15:16);
    tweet(i).TwSec = temp(18:19);
end

%% Extract information from tweets and store user-defined properties
% calls the function 'extractTweetInfo' script
for i = 1:nrows
    
    inputText(i) = string(tweet(i).text);
    
    [Ulat(i),Ulon(i),Uyear(i),Umonth(i),Uday(i)] = extractTweetInfo(inputText(i));
    
    %store user-entered lat/lon and date info into tweet object
    tweet(i).Ulat = Ulat(i);
    tweet(i).Ulon = Ulon(i);
    tweet(i).Uyear = Uyear(i);
    tweet(i).Umonth = Umonth(i);
    tweet(i).Uday = Uday(i);
    
end

%% Import coordinates and set orbit numbers
% Calculated using "Orbital_Library" scripts.
% the loaded object is the Lat and Long coordinate vectors
load('coords_sharksat.mat')

coordData = ones(length(Lat),3);
coordData(:,2) = Lat;
coordData(:,3) = Long;
% Assign the coordinates to an orbit number and store in a coordinate matrix
orbitNum = 1;
oldVal = 0;
for i = 1:length(Lat)

    if (0<i && i<=93)
        coordData(i,1)= 1; %Orbit 1
    end
    if (94<=i && i<=186)
        coordData(i,1)= 2; %Orbit 2
    end
    if (187<=i && i<=279)
        coordData(i,1)= 3; %Orbit 3
    end
    if (280<=i && i<=371)
        coordData(i,1)= 4; %Orbit 4
    end
    if (372<=i && i<=464)
        coordData(i,1)= 5; %Orbit 5
    end
    if (465<=i && i<=557)
        coordData(i,1)= 6; %Orbit 6
    end 
    if (558<=i && i<=650)
        coordData(i,1)= 7; %Orbit 7
    end
    if (651<=i && i<=743)
        coordData(i,1)= 8; %Orbit 8
    end
    if (744<=i && i<=835)
        coordData(i,1)= 9; %Orbit 9
    end
    if (836<=i && i<=928)
        coordData(i,1)= 10; %Orbit 10
    end
    if (929<=i && i<=1020)
        coordData(i,1)= 11; %Orbit 11
    end
    if (1021<=i && i<=1113)
        coordData(i,1)= 12; %Orbit 12
    end
    if (1114<=i && i<=1206)
        coordData(i,1)= 13; %Orbit 13
    end
    if (1207<=i && i<=1299)
        coordData(i,1)= 14; %Orbit 14
    end
    if (1300<=i && i<=1391)
        coordData(i,1)= 15; %Orbit 15
    end
    if (1392<=i && i<=1441)
        coordData(i,1)= 16; %Orbit 16
    end
end

%% Determine closest orbit for each point

for i = 1:length(tweet)
    
    %latlon point of interest
    myLat = str2double(tweet(i).Ulat);
    myLon = str2double(tweet(i).Ulon);
    
    %call function to determine which orbit is best
    [orbitNumVal] = getOrbit(coordData, myLat, myLon);
    
    %store orbit value into tweet object
    tweet(i).OrbitVal = orbitNumVal;
    
end


%% Put together new table of tweets

newCellstruc = cell(length(tweet),3);

for m = 1:length(tweet)
    
    %write values to new cell table
    newCellstruc{m,1} = m;
    newCellstruc{m,2} = tweet(m).OrbitVal;
    newCellstruc{m,3} = tweet(m).Ulat;
    newCellstruc{m,4} = tweet(m).Ulon;
    
end

newTable = cell2table(newCellstruc, 'VariableNames', {'cmd_num', 'orbit','latitude', 'longitude'});

%% Write new table to excel sheet

writetable(newTable,'reorderedLatLon.xlsx');

