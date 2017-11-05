function [position direction] = moveincircle(position, direction, radius, arclength,LR)
    
    theta = arclength./radius;
    plottheta = linspace(0,theta,10);
    
    if LR == -1 % turn left      
        radialdirection = exp((angle(direction)+pi/2)*1j);
        center = radialdirection.*radius+position;
        radialangle = pi+angle(radialdirection)+plottheta;
        arcplot = exp(radialangle*1j)*radius + center;
        direction = exp((radialangle(end)+pi/2)*1j);
    else % turn right
        radialdirection = exp((angle(direction)-pi/2)*1j);
        center = radialdirection.*radius+position;
        radialangle = pi+angle(radialdirection)-plottheta;
        arcplot = exp(radialangle*1j)*radius + center;
        direction = exp((radialangle(end)-pi/2)*1j);
    end
        plot(arcplot,'b','LineWidth',2);  
        position = arcplot(end);

end