function [times, turns] = main ()

%%% MANTIS - SELF DRIVING CAR
%  Authors: Can Oezmaden, Jarek Ecke, Jason Jin
%  Date: 20.12.2016 - 23.12.2016
%  RWTH AACHEN Winter Term 2016-2017
%%%

%%%
%  Please type in your bluetooth ini file if you would like to establish
%  a BT connection.
%%%

BTini = 'bluetooth09.ini';

%%% INPUT: SENSOR PORTS DEFINITIONS
%
%   Predefining the sensor ports and modes for each sensor used in the 
%   robot.
%
%   WARNING: The values of your sensor ports might be different, it
%   is crucial to determine and define right sensor ports in the very
%   beginning for the correct execution of the program.
%
%%%

LightSensorRPort = SENSOR_1;
ColorSensorPort  = SENSOR_2;
ObstcSensorPort = SENSOR_3;
LightSensorLPort = SENSOR_4;

LightMode = 'ACTIVE';
ColorMode = 'FULL';
ObstcMode = 'SHORT';

%%% OUTPUT: MOTOR PORTS DEFINITIONS
%
%   Predefining the motor ports for each motor used in the robot.
%   WARNING: The values of your motor ports might be different, it
%   is crucial to determine and define right motor ports in the very
%   beginning for the correct execution of the program.
%
%%%

DriveWheelsPort    = 'A';
SteeringWheelsPort = 'B';

%%% CONNECTION TO THE ROBOT
%
%   Initializing the NXT Brick through the init_nxt function.
%   For details about the function please read the header comment
%   in the function init_nxt itself.
%
%%%

h = initNXT(BTini);

%%% INITIALIZING SENSORS

OpenLight(LightSensorRPort, LightMode);
OpenLight(LightSensorLPort, LightMode);
OpenNXT2Color(ColorSensorPort, ColorMode);
OpenObstacle(ObstcSensorPort, ObstcMode);

%%% TEST FIELD

NXT_PlayTone(523,200, h);
NXT_PlayTone(659,200, h);
NXT_PlayTone(784,200, h);
pause(2)


%%% VARIABLE DECLARATIONS
%
%   Variables declared here are used in the loops and functions
%   to follow.
%
%             run  - Status of the robot checked in the main while loop. 
%                    Set to 0 when the robot has completed the course.
% 
%     turncounter  - Variable used to control the maximum amount of turns
%                    allowed by the hardware of the robot. The counter is
%                    set to 1 when the robot turns right, set to 0 when
%                    it drives straight, and is set to -1 if it turns left.
%                    Thus a full control of the turn status is achieved and
%                    checked to not damage the hardware of the robot.
%                    E.g. if the robot is turning right a new command to 
%                    turn right will only overdrive and induce a wear on 
%                    the gears.
% 
%    numberOfTurns - A counter variable that records the total number of
%                    turns. Used as an index for both arrays saving values
%                    of turns and times of turns.
%
%   directionState - The state
%
%%%

run = 1;
turncounter = 0;
numberOfTurns = 1;
directionState = 'CENTER';


%%% INITIALIZATION OF RECORD VECTORS

turns = [];
times = [];

%%% MAIN CODE
DrivingWheels = NXTMotor(DriveWheelsPort);

tic  %timer start for the recording of times of turning
while (run == 1)
    
     pause(0.1)
    
    %%% Check for a traffic light or end of track
    
    % End of track case
    if strcmp(checkColor(ColorSensorPort), 'BLUE') == 1
        run = 0;
        DrivingWheels.Stop('brake')
        break;
    end
    
    pause(0.1)
    
    % Check for an obstacle in front or a red light, stop if needed
    while checkObstacle(ObstcSensorPort) >= 1 || strcmp(checkColor(ColorSensorPort), 'RED') == 1
        waiting = 1;
        if waiting == 1
            DrivingWheels.Stop('brake')
            pause(0.3)
            waiting = 0;
        else
            pause (0.3)
        end
    end
    
    pause(0.1)
    
    [DrivingWheels, directionState, turncounter, numberOfTurns] = drive(DriveWheelsPort,...
                                                          SteeringWheelsPort,...
                                                          LightSensorLPort,...
                                                          LightSensorRPort,...
                                                          ColorSensorPort,...
                                                          turncounter,...
                                                          directionState,...
                                                          numberOfTurns);
    
    %Saving the values for a new turn
    times(numberOfTurns) = toc;
    turns(numberOfTurns) = turncounter;
    
    pause(0.3)
    
end


%%% SENSOR TERMINATIONS

CloseSensor(LightSensorRPort);
CloseSensor(LightSensorLPort);
CloseSensor(ColorSensorPort);
CloseSensor(ObstcSensorPort);

end