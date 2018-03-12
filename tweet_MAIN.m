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


