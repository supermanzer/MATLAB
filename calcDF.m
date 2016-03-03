function [ df ] = calcDF(x,type,y )
%calcDF This function calculates effective degrees of freedom for one or
%two timeseries data vectors.  If two time sries are provided it determines
%the most conservative (longest decorrelation time) value to return.
%   INPUTS
%       x - data vector to be analyzed for decorrelation time
%       type - optional type of degrees of freedom to be calculated.  If
%       absent the first zero crossing will be used. Only "zc" for first
%       zero crossing or "ef" for first e-folding are valid values.
%       y - Optional second data vector.  If provided the effective degrees
%       of freedom will be whichever data vector has the smaller degrees of
%       freedom.
%
% Created by C. Ryan Manzer, Moss Landing Marine Labs - 1/21/2016
%--------------------------------------------------------------------------
if nargin >= 2
% ensuring compliance with of df type naming standards
    if strcmp(type,'zc')==0 && strcmp(type,'ef')==0
        disp('Only "zc" or "ef" are valid types for degrees of freedom')
        return
    end
end
if nargin < 2 % if only one time series was provided and no df type
    y=[];
    [c,l]=xcov(x,'coeff'); % we get our autocovariance spectrum
    c=c(l>=0);l=l(l>=0); % because this is a time series we are only
                         % interested in correlations moving forward
                         % (non-negative).
    df=length(x)/(l(find(c<=0,1,'first')));
elseif nargin < 3 % if the user passed in a df type along with a single vector
    [c,l]=xcov(x,'coeff');
    c=c(l>=0);l=l(l>=0);
    if strcmp(type,'zc')==1 % if the type passed in is zero crossing, we use that
        df=l(find(c<=0,1,'first'));
        df=floor(length(x)/df);
    else  % otherwise we check for the first e-folding
        df = l(find(c<=(1/exp(1)),1,'first'));
        df=floor(length(x))/df;
    end
else % if a type and two time series vectors were provided
    [cx,lx]=xcov(x,'coeff'); cx=cx(lx>=0);lx=lx(lx>=0);
    [cy,ly]=xcov(y,'coeff'); cy=cy(ly>=0);ly=ly(ly>=0);
    % calculating degrees of freedom using first zero crossing
    if strcmp(type,'zc')==1
        xdf=floor(length(x)/(lx(find(cx<=0,1,'first'))));
        ydf=floor(length(y)/(ly(find(cy<=0,1,'first'))));
    else % using first e-folding
        xdf=floor(length(x)/(lx(find(cx<=(1/exp(1)),1,'first'))));
        ydf=floor(length(y)/(ly(find(cy<=(1/exp(1)),1,'first'))));
    end
% selecting the most conservative degrees of freedom to return
    if xdf < ydf
        df=xdf;
    else
        df=ydf;
    end
end
end

