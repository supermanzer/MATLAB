function [xavg] = getavg(x,n)
%GETAVG this function simply take a vector (x) and the number of points you
%wish to average (n) and creates a new vector (xavg) of those points.  The
%only tricky part is accounting for excess points on the end.
k=0;
for i = n+1:n:length(x) % if n doesn't divide evenly into the length of x, i won't be the end
    k=k+1;
    xavg(k)=mean(x(i-n:i));
end
if i < length(x)
   k=k+1;
   xavg(k) = mean(x(i:length(x)));
end
end

