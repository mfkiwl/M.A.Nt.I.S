defunction [] = turn90deg(DriveWheelsPort, SteeringWheelsPort, power, directionState, ColorSensorPort)

DrivingWheels = NXTMotor('A', 'TachoLimit', 360, 'Power', -7);  %350
DrivingWheels.SendToNXT();
pause(7); %9

steering(power, directionState, SteeringWheelsPort);

DrivingWheels = NXTMotor('A', 'TachoLimit', 800, 'Power', 7); %780
DrivingWheels.SendToNXT();
pause(15); %19

color = checkColor(ColorSensorPort);

if strcmp(color, 'BLACK') == 1
    DrivingWheels = NXTMotor(DriveWheelsPort, 'TachoLimit', 780, 'Power', -5);
    DrivingWheels.SendToNXT();
    pause(19);
    directionState = 'LEFT';
    steering(power, directionState, SteeringWheelsPort);
    pause(2);
    steering(power, directionState, SteeringWheelsPort);
    pause(2)
    DrivingWheels = NXTMotor(DriveWheelsPort, 'TachoLimit', 780, 'Power', 5);
    DrivingWheels.SendToNXT();
    pause(19);
    directionState = 'RIGHT';
    steering(power, directionState, SteeringWheelsPort);
else
    directionState = 'LEFT';
    steering(power, directionState, SteeringWheelsPort);
end

end