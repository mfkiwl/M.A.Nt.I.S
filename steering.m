function [] = steering(power, direction, port)

%%% STEERING FUNCTION; NO OUTPUT
%
%   Function for controlling the streering of the robot. Simple. Fast.
%   Reliable. No, it doesn't solve Einstein's field equations. 
%
%%%

% Reverse the power for a left turn
if strcmp (direction, 'LEFT')
    power = - power;
end

% Set the motor values and send the command to steer
SteeringWheels = NXTMotor(port, 'TachoLimit', 105, 'Power', power, 'ActionAtTachoLimit', 'Brake');
SteeringWheels.SendToNXT();

end