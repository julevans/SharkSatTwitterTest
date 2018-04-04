%% tweet object class
% Julianna Evans
% 03.12.17

%% Define a class where tweet components can be stored
classdef tweetObj
    % balloon object data set class
    properties
        
        %Imported variables
        id;               % ['string']
        createdAt;        % ['string']
        text;             % ['string']        
        
        %Date/time variables (from twitter) 
        TwDatetime;         % ['string']
        TwYear;             % [num]
        TwMonth;            % [num]
        TwDay;              % [num]
        TwHour;             % [num]
        TwMin;              % [num]
        TwSec;              % [num]
        
        %Extracted text info
        Ulat;
        Ulon;
        Uyear;
        Umonth;
        Uday;
        
        %Orbit Value
        OrbitVal;
      
    end
end