function [] = plotPath(times, turns)

timeperiod = [];

speed = 1;
radius = 10;
direction = 1+1e-10*1j;
position = 0*1j;

%figure
hold on

timeperiod = times;
timeperiod(2:end) = diff(times);

 for index = 1:length(times)     
    if turns(index) == 0
        [position, direction] = movestraight(position, direction, timeperiod(index).*speed);
    else
        [position, direction] = moveincircle(position, direction, radius, timeperiod(index).*speed,turns(index));
    end
 end