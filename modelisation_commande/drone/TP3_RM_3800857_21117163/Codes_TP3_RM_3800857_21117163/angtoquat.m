function [output]= angtoquat(u)
% fonction qui passe des trois angles de roulis/tangage/lacet au quaternion
% associé

% Définition des matrices de rotation élémentaires et de R

R1= [1 0 0; 0 cos(u(1)) -sin(u(1)); 0 sin(u(1)) cos(u(1))];
R2= [cos(u(2)) 0 sin(u(2)); 0 1 0; -sin(u(2)) 0 cos(u(2))];
R3= [cos(u(3)) -sin(u(3)) 0; sin(u(3)) cos(u(3)) 0; 0 0 1];
R= R3*R2*R1;

% Calcul du quaternion 

tr= trace(R);
if tr > 0 
  s = 2*sqrt(tr+1);
  qs = s/4;
  qx = (R(3,2) - R(2,3))/s;
  qy = (R(1,3) - R(3,1))/s; 
  qz = (R(2,1) - R(1,2))/s; 
elseif ((R(1,1) > R(2,2))&(R(1,1) > R(3,3))) 
  s = 2*sqrt(1+ R(1,1) - R(2,2) - R(3,3));
  qs = (R(3,2) - R(2,3))/s;
  qx = s/4;
  qy = (R(1,2) + R(2,1))/s; 
  qz = (R(1,3) + R(3,1))/s; 
elseif (R(2,2) > R(3,3)) 
  s = 2*sqrt(1 + R(2,2) - R(1,1) - R(3,3))
  qs = (R(1,3) - R(3,1))/s;
  qx = (R(1,2) + R(2,1))/s; 
  qy = s/4;
  qz = (R(2,3) + R(3,2))/s; 
else 
  s = 2*sqrt(1 + R(3,3) - R(1,1) - R(2,2))
  qs = (R(2,1) - R(1,2))/s;
  qx = (R(1,3) + R(3,1))/s;
  qy = (R(2,3) + R(3,2))/s;
  qz = s/4;
end;
qv= [qx;qy;qz];
output= [qs;qv];

