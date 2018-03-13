%% check to see if I did the re-listing correctly

clc; clear;

%original vectors
Ulat = ["-49.526"    "25.687"    "-14.777"    "-50.35"    "15.209"    "37.207"];
Ulon = ["9.253"    "7.467"    "-135.75"    "-135.657"    "-90.259"    "-80.408"];

Ulat = str2double(Ulat);
Ulon = str2double(Ulon);

%final vectors
newUlat = [25.6870   37.2070   15.2090  -14.7770  -50.3500  -49.5260];
newUlon = [ 7.4670  -80.4080  -90.2590 -135.7500 -135.6570    9.2530];

[d1]=latlonDIST(0,0,newUlat(1),newUlon(1));
[d2]=latlonDIST(newUlat(1),newUlon(1),newUlat(2),newUlon(2));
[d3]=latlonDIST(newUlat(2),newUlon(2),newUlat(3),newUlon(3));
[d4]=latlonDIST(newUlat(3),newUlon(3),newUlat(4),newUlon(4));
[d5]=latlonDIST(newUlat(4),newUlon(4),newUlat(5),newUlon(5));
[d6]=latlonDIST(newUlat(5),newUlon(5),newUlat(6),newUlon(6));

dvec = [d1 d2 d3 d4 d5 d6]