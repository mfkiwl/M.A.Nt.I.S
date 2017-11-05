function [position direction] = movestraight(position, direction, length)
   
   dp = length*direction;  %% dp means distance position                    
   quiver(real(position),imag(position),real(dp),imag(dp),0,'b', 'LineWidth',2,'MaxHeadSize',1);
   %plot([position position1]);
   position = position + length*direction;
end