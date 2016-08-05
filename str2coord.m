function [ coord ] = str2coord( coordstring )
%str2coord Converts a string of latitude or longitude to the decimal degree
%value
%   INPUTS
%       coordstring - a string in either decimal degrees or degrees with
%       minutes and secords including the direction character (e.g N, W)
%   OUTPUS
%       coord - the decimal degree with direction indicated by the sign

% ONE THING TO BE AWARE OF - Matlab doesn't (to my knowledge) have a string
% mechanism to recognize a degree symbol.  I don't know that one can even
% be passed in a string so this may be a moot point but this function does
% not have a method for dealing with a degree symbol should one arise.
% Currently it handles strings of degree decimals, degrees and minutes, and
% degrees, minutes, and seconds.  It does strip apostrophes that may be
% present to indicate minutes.
%--------------------------------------------------------------------------
% C. Ryan Manzer - Moss Landing Marine Labs, 8/5/2016
%--------------------------------------------------------------------------
% First we determine what the sign of the resultant number should be
if ~isempty(strfind(coordstring,'S')) || ~isempty(strfind(coordstring,'W'))
    mysign = -1;
else
    mysign = 1;
end

% Now that we have the sign, let's remove the character at the end along
% with any trailing whitespace
coordstring = strtrim(coordstring(1:length(coordstring)-1));
% Now we find how many spaces remain in our string
sp=strfind(coordstring,' ');

switch length(sp)
    case 0 % if we have no more spaces then we shoud be good
        coord = str2double(coordstring);
    case 1 % looks like we have minutes in this string
        degs= strtrim(coordstring(1:sp(1)));
        mins= strtrim(coordstring(sp(1):length(coordstring)));
        mins=strrep(mins,'''','');
        coord = str2double(degs) + (str2double(mins)/60);
    case 2 % looks like separate minutes and seconds in this string
        degs = strtrim(coordstring(1:sp(1)));
        mins=strtrim(coordstring(sp(1):sp(2)));
        secs=strtrim(coordstring(sp(2):length(coordstring)));
        mins=strrep(mins,'''',''); secs=strrep(secs,'''','');
        mins=str2double(mins)+str2double(secs)/60;
        coord=str2double(degs)+mins/60;
end
coord = coord*mysign;
end

