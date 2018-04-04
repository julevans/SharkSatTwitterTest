clc;
clear all;

%Inputs
year  = 2018;  month = 10;  day   = 01;
hour  = 16;    min   = 00; sec   = 00;
long  = -79.9762; %Blacksburg

%Julian Day
UT = hour + min/60 + sec/3600;
J0 = 367*year - floor(7/4*(year + floor((month+9)/12))) ...
    + floor(275*month/9) + day + 1721013.5;
JD = J0 + UT/24;              % Julian Day
fprintf('Julian day = %6.4f [days] \n',JD);

%Greenwich Sidereal Time
JC = (J0 - 2451545.0)/36525;
GST0 = 100.4606184 + 36000.77004*JC + 0.000387933*JC^2 - 2.583e-8*JC^3; %[deg]
GST0 = mod(GST0, 360);  % GST0 range [0..360]
fprintf('Greenwich sidereal time at 0 hr UT %6.4f [deg]\n',GST0);

GST = GST0 + 360.98564724*UT/24;
GST = mod(GST, 360);  % GST0 range [0..360]
fprintf('Greenwich sidereal time at UT[hours] %6.4f [deg]\n',GST);

%Local Sidereal Time
LST = GST + long;
LST = mod(LST, 360);  % LST range [0..360]
fprintf('Local sidereal time,LST %6.4f [deg]\n',LST);