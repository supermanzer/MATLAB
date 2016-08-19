function [ h ] = plotCoord(mylat,mylon,n)
%PLOTCOORD This function generates a contour map of Monterey Bay bathymetry
%and highlights the location indicated with the latitude and longitude
%passed in.  The lat and lon will be vectors of all lat and lon values in
%the group and the n will identify which index value should  be specially
%labeled.
%   INPUTS
%       lat - latitude vector in decimal degrees
%       lon - longitude vector in decimal degrees
%       n - index #
%   OUTPUTS
%        h - figure handle for the plot generated
obj=findobj('tag','deletefigure');
if ~isempty(obj)
    delete(obj)
end
scrz=get(0,'Screensize');
load MBBathy
maxLat=max(mylat);minLat=min(mylat);maxLon=max(mylon);minLon = min(mylon);
% Shrinking our plotting window to focus on the Monterey Peninsula
a=find(lat>(maxLat+0.1));eLat=min(a); % Only looking south of 36.8 deg N
a=find(lat<(minLat-0.1));bLat=max(a); % and only looking north of 36.5 deg
myLat=lat(bLat:eLat);clear a; clear b;
a=find(lon<(minLon-0.1));bLon=max(a); % East of 122.15W
a=find(lon>(maxLon+0.1));eLon=min(a); % and west of 121.75W
myLon=lon(bLon:eLon);
myZ=Z(bLat:eLat,bLon:eLon);
V=0:-80:-800; % defining our isobath start,steps, and stop
figure('Color','black','Position',[scrz(3)-104 scrz(4) 700 500], ...
    'tag','deletefigure')
%set(1,'Position',scrz)
[c,h]=contour(myLon,myLat,myZ,V);
title('Monterey Bay Bathymetry','Color','white')
set(gcf,'menubar','none')
set(gca,'XColor',[1,1,1],'YColor',[1,1,1])
%[c,h]=contour(myLon,myLat,myZ,V);
contourcmap('hsv') 
v=0:-80:-200;
clabel(c,h,v,'LineSpacing',128,'Rotation',0);
hold on
for k = 1:length(mylat)
    plot(mylon(k),mylat(k),'go','MarkerSize',6,'MarkerFaceColor',[0 1 0])
   text(mylon(k)-0.01,mylat(k)+.01,num2str(k),'FontWeight','bold','FontSize',8)
end
plot(mylon(n),mylat(n),'r*','MarkerSize',12,'LineWidth',2)
text(mylon(n)-0.01,mylat(n)+.02,'CTD Location','FontWeight','bold')

end

