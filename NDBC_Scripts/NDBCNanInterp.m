%% NDBC Data NaN Interpolation
%  Really this shouldn't need to be a script but I'm just making sure I get
%  everything documented.  In this script I am looping through the fields
%  in the data structure and applying the NaN Interpolation script.

load data;
buoy=data.NDBC.B46042;

fnames = fieldnames(buoy);

for i = 1:length(fnames)
   if strcmp(fnames{i},'time') 
       continue
   else
       datavec=buoy.(fnames{i}).data;
       w = 12; % we assume a twelve hour window over which we can interpolate
       noNaN=naninterpW(datavec,w,'linear');
       buoy.(fnames{i}).data=noNaN;
   end
end
data.NDBC.B46042=buoy;
save('/home/supermanzer/Dropbox/MLML Student Data/Thesis Stuff/Data/data.mat','data');

