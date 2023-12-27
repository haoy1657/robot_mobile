%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonction qui definit v1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [z]= vr(tps,choix_traj)

if choix_traj==1 % vitesse de roulement positive
  v1= 3+3*sin(pi*tps/10);
elseif choix_traj==2 % vitesse de roulement arbitraire
  v1= 7*sin(pi*tps/10);
end;
 
z=v1;
