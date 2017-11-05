function [outOfBounds] = checkBounds (port)

%%% BOUND CHECKER FUNCTION; OUTPUT BOOLEAN
%   
%   The following function checks if the robot has gone out of
%   the bounds. Return value is 0, or in other words FALSE, when
%   the robot is between the bounds, and is 1, or TRUE, when 
%   the robot has gone off the bounds and an action is to be taken.
%
%%%

% A predefined threshold value for white reflectivity value
white = 550;

if GetLight(port) <  white
    outOfBounds = 1;
else
    outOfBounds = 0;
end

end