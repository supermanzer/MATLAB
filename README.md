# MATLAB
This is a repository for MATLAB code that I have developed for my own (mostly scientific and academic) studies.  I welcome all sincerely interested comments and suggestions.

I am an MS student who uses MATLAB to analyze oceanographic data.  I hope to produce code and analyses that some marine ecosystem stakeholders may find of interest or useful.  Eventually I would like to transition to Python but much of my education in data analysis has been in MATLAB so it's the fastest tool for development at present.

-----------------------------------------------------------------------------------------------------------------
 FUNCTIONS/SCRIPTS/FILES
-----------------------------------------------------------------------------------------------------------------

NDBC_Scripts: A series of interacting functions designed to allow users to query NDBC standard meteorological data.

tgaps.m:  A function used to find gaps in time vector of time series data (e.g. when instruments are being serviced 		  and no data is logged).

nanFuncs:  A series of functions used to finding NaN values and interpolating over them if they fall within user 		   specified parameters.

calcDF.m:  This function is used to calculate effective degrees of freedom in one or two time series vectors.  It calculates the autocorrelation function and uses the first zero crossing or first e-folding (depending on user input) to determine decorrelation time.  In the case two vectors are passed in, it returns the lower of the two degrees of freedom for the most conservative estimate.

str2coord: A simple function used to convert various string representations of latitude and longitude coordinates into numerical decimal degrees with the direction indicated by the sign.

bigfig: A simple function that determines the screen size of the computer on which it is run, generates a MATLAB figure object that occupies the entire screen, and returns the figure handle. 
