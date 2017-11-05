function [color] = checkColor(port)

%%% COLOR CHECKER FUNCTION; OUTPUT STRING
%   
%   The following function checks the color value of the color sensor
%   Return values are the same as the GetNXT2Color but the function
%   was created to increase the readability of the source code.
%   
%   Examplary return values:
%   
%   'BLACK', 'WHITE', 'BLUE'...
%   
%%%

color = GetNXT2Color(port);

end