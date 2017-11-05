function [h]= initNXT(BTini)

%%% NXT INITIALIZER; OUTPUT HANDLE
%
% Open USB conncetion if present otherwise tries to establish a BT 
% connection specified in bluetooth.ini and set the default handle.
%
%%%

DebugMode('off');

COM_CloseNXT('all');

 try
     COM_CloseNXT('all');
 catch
     error ('Error opening BT.'); 
 end
 
h = COM_OpenNXT(BTini);
COM_SetDefaultNXT(h);

end