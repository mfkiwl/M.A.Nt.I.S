function [obstacle] = checkObstacle(port)

%%% OBSTACLE CHECKER FUNCTION; OUTPUT BOOLEAN
%   
%   The following function checks if there is an obstacle in
%   front of the robot. Return value is 0, or in other words 
%   FALSE, when the ultrasonic sensor hasn't detected an object
%   and is 1, or TRUE, when there is an object blocking the way.
%
%%%

if GetObstacle(port) ~= 0
    obstacle = GetObstacle(port);
else
    obstacle = 0;
end

end