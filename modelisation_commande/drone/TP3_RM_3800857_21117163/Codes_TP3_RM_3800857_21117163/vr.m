%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonction qui définit le vent en fonction du temps                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [z]= vr(tps,choix_traj)

if choix_traj==1 % Vol quasi stationnaire
    if tps<4
        v_ref= zeros(3,1);
        omega3_ref= 0;
    elseif tps<8
          v_ref= [0.5;0;0];
          omega3_ref= 0;
    elseif tps<12
          v_ref= [-0.5;0;0];
          omega3_ref= 0;
    elseif tps<16
          v_ref= [0;0.5;0];
          omega3_ref= 0;
    elseif tps<20
          v_ref= [0;-0.5;0];
          omega3_ref= 0;
    elseif tps<22
          v_ref= [0;0;0];
          omega3_ref= 0.5;
    elseif tps<24
          v_ref= zeros(3,1);
          omega3_ref= -0.5; 
    else
        v_ref= zeros(3,1);
        omega3_ref= 0;
    end;
else % Vol non stationnaire
    if tps<3
        v_ref= zeros(3,1);
        omega3_ref= 0;
    elseif tps<5
          v_ref= [2;0;0];
          omega3_ref= 0;
    elseif tps<7
          v_ref= [-2;0;0];
          omega3_ref= 0;
    elseif tps<9
          v_ref= [0;2;0];
          omega3_ref= 0;
    elseif tps<11
          v_ref= [0;-2;0];
          omega3_ref= 0;
    elseif tps<14
          v_ref= [0;0;0];
          omega3_ref= 1;
    elseif tps<23
          v_ref= 0.8*pi*[-sin(2*pi*(tps-14)/4-pi/2);cos(2*pi*(tps-14)/4-pi/2);0.5*sin(2*pi*(tps-14)/4)];
          omega3_ref= 0.7*sin((2*pi*tps-14)/4);
          omega3_ref= 0;
    else
        v_ref= zeros(3,1);
        omega3_ref= 0;
    end; 
end;

z=[v_ref;omega3_ref];

