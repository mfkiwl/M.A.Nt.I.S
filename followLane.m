function [directionState, turncounter, numberOfTurns] = followLane(LightSensorLPort,...
                                                     LightSensorRPort,...
                                                     ColorSensorPort,...
                                                     power,...
                                                     directionState,...
                                                     SteeringWheelsPort,...
                                                     DriveWheelsPort,...
                                                     turncounter,...
                                                     numberOfTurns)


%%% FOLLOW LANE FUNCTION; MIXED OUTPUT
%
%   followLane is called by the drive function to check if an action
%   needs to be taken to follow the lane. Just as the name of the function
%   suggests. Duh.
%
%   E.g. an outOfBounds detection coming from the left sensor must make
%   the robot turn right and then correct itself to straight when the
%   sensor stops sending the outOfBounds signal.
%
%%%


%%% SENSOR VALUES
%
%   Reading the sensor values for the moment when the function has been
%   called.
%
%%%

sensorRight = checkBounds(LightSensorRPort);
sensorLeft = checkBounds(LightSensorLPort);
color = checkColor(ColorSensorPort);


%%% DECISION MECHANISM
%
%   Following if clauses are the ones deciding which steering direction the
%   robot must be steered in order to follow the lane. Cases of turning
%   right and left have and additional logical statement checking if the
%   steering if already set to the same state. If yes no steering must be
%   carried out to avoid damage to the gears.
%
%%%


% Check for the case of a 90 degree turn
% if strcmp(color, 'BLACK') && strcmp(directionState,'CENTER')
%     turn90deg(DriveWheelsPort, SteeringWheelsPort, power, directionState,...
%                                                           ColorSensorPort); 
% end

%%% Execute individual right/left turns

% Wheels set staight right turn case
if sensorLeft == 1 && strcmp(directionState,'CENTER') == 1 && turncounter <= 1
    directionState = 'RIGHT';
    steering(power, directionState, SteeringWheelsPort);
    turncounter = turncounter + 1 ;
    numberOfTurns = numberOfTurns + 1;
    
% Wheels set right reset case
elseif sensorLeft == 0 && strcmp(directionState,'RIGHT') == 1
    
    directionState = 'LEFT';
    steering(power, directionState, SteeringWheelsPort);
    directionState = 'CENTER';
    
    %Increasing counters for data tracking
    turncounter = turncounter - 1 ;
    numberOfTurns = numberOfTurns + 1;
    
% Wheels set straight left turn case
elseif sensorRight == 1 && strcmp(directionState,'CENTER') == 1 && turncounter >= -1
    
    directionState = 'LEFT';
    steering(power, directionState, SteeringWheelsPort);
    
    %Increasing counters for data tracking
    turncounter = turncounter - 1 ;
    numberOfTurns = numberOfTurns + 1;

% Wheels set left reset case
elseif sensorRight == 0 && strcmp(directionState,'LEFT') == 1 
    
    directionState = 'RIGHT';
    steering(power, directionState, SteeringWheelsPort);
    directionState = 'CENTER';
    
    %Increasing counters for data tracking
    turncounter = turncounter + 1 ;
    numberOfTurns = numberOfTurns + 1;

end

end