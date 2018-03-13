%% Twitter Analysis Code
% Julianna M. Evans
% 03.11.2018

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

%% Reorder the commands for shortest distance pointing

%get initial condition of satellite (assume pointing at 0,0 )
%NOTE: hardcoded!!!!
latInit = 0;
lonInit = 0;

%instantiate old values
oldlat = latInit;    
oldlon = lonInit;    

%initialize temporary Ulat and Ulon vectors (so we don't mess up the originals)
tempUlat = str2double(Ulat(:));
tempUlon = str2double(Ulon(:));

for j = 1:nrows

    %calculate distances for each entry of tempU-vecs
    dHav = []; %set as empty to prevent indexing issues
    for k = 1:length(tempUlat)
    %go through tempUlat/Ulon list and calculate distances
    [dHav(k)] = latlonDIST(oldlat,oldlon,tempUlat(k),tempUlon(k));
    end
    
%get the minimum distance and the index
[minval, idxval] = min(dHav);

%set this value as the next entry in 'newlist'
newlistLAT(j) = tempUlat(idxval);
newlistLON(j) = tempUlon(idxval);

%update oldlat and oldlon
oldlat = tempUlat(idxval);
oldlon = tempUlon(idxval);

%remove the entry from the temp vectors
tempUlat(idxval) = [];
tempUlon(idxval) = [];

end

%% Put together new list of tweets

newCellstruc = cell(length(newlistLAT),3);

for m = 1:length(newlistLAT)
    
    %write values to new cell table
    newCellstruc{m,1} = m;
    newCellstruc{m,2} = newlistLAT(m);
    newCellstruc{m,3} = newlistLON(m);
    
end

newTable = cell2table(newCellstruc, 'VariableNames', {'cmd_num', 'latitude', 'longitude'});

%% Write new table to excel sheet

writetable(newTable,'reorderedLatLon.xlsx');

