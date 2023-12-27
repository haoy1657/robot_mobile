%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controlleur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output]=control(inp)

% Variables
  vf= inp(1); % vitesse du v�hicule leader 
  df= inp(2); % distance sign�e du vehicule leader au chemin
  db= inp(3); % distance sign�e du vehicule suiveur au chemin
  dfb=inp(4);
  thetae=inp(5);
  thetae_b=inp(6);
  Id_f=inp(7);
  Id_b=inp(8);

  
% calcul de la commande

  wf= 0; % vitesse angulaire du v�hicule leader (commande)
  k1=0.5;k2=1;k3=0.05;
  k4=0.5;k5=1;k6=0.05;
  k7=0.5;
  df_etoile=0.2;
  db_etoile=0.2;
  dfb_etoile=4.5;
  wf=-k1*vf*(df-df_etoile)-k2*abs(vf)*thetae-k3*abs(vf)*Id_f;
  vb= vf+k7*(dfb-dfb_etoile); % vitesse lin�aire du v�hicule suiveur 
  wb=-k4*vb*(db-db_etoile)-k5*abs(vb)*thetae_b-k6*abs(vb)*Id_b;
   
  u= [wf;vb;wb];

output= u;

  