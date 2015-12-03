function [gloc,gdist] = tgaps(t,tol)
%TGAPS Finds the locations of gaps in time vectors and the amount of time
%missing for each.  This function assumes your time vector is, for the most
%part, evenly spaced.
%   Inputs:
%   t - time vector
%   tol - the tolerance level appropriate (i.e. the max difference to be
%         ignored)
%   Outputs: 
%   gloc - an [nx2] matrix of the index numbers.  each row corresponds to a
%          gap and each set of numbers corresponds to the values in the 
%          time vector on either side of that gap.
%   gdist - and [nx2] matrix with the floating point value of the
%           distance in gdist(n,1) and the string description of the
%           distance in gdist(n,2).  Calculated as the temporal distance
%           between gloc(n,1) and gloc(n,2).
if isnumeric(t) == 0 
    try 
        t=datenum(t);
    catch
        fprintf(['The time vector passed in must be in a recognizable \n' ...
            'date format (datestring datenum or datetime).  Please \n' ...
            'correct the t vector type and try again. \n']);
        return
    end
end
a=diff(t); % Get the difference between each successive point in the time vector
m=mode(a); % Get the most common difference (the normal sampling rate)
b=find(a>(m+tol)); % find difference values greater than the normal sample time + a tolerance level
gloc=zeros(length(b),2); % initialize our matrix to hold index locations
gdist=cell(length(b),2); % initialize our temproal distance matrix
h=0;m=0;s=0;
for i=1:length(b)
    gloc(i,1) = b(i);
    gloc(i,2)=b(i)+1;
    gdist{i,1}=t(gloc(i,2))-t(gloc(i,1));
    d=idivide(gdist{i,1},int8(1)); % Getting the number of days between the
                                   % two time steps.
    r = mod(gdist{i,1},1); % Let's check on the remainder.
    if r > 0
        tLeft = r*24; % going to hours
        h=idivide(tLeft,int8(1)); % getting the number of hours in the remainder
        r=mod(tLeft,1);
        if r> 0 % keep checking that remainder for mintes/seconds
           tLeft=r*60;
           m=idivide(tLeft,int8(1)); % Getting the minutes
           r=mod(tLeft,1); % Let's see if there are any seconds here
            if r>0
                tLeft=r*60;
                s=idivide(tLeft,int8(1));
            end
        end
    end
    if d >0
        gdist{i,2} = sprintf('%i days %i hours %i minutes %i seconds',d,h,m,s);
    elseif h>0
        gdist{i,2} = sprintf('%i hours %i minutes %i seconds',h,m,s);
    elseif m>0 
        gdist{i,2} = sprintf('%i minutes %i seconds',m,s);
    end
end
end

