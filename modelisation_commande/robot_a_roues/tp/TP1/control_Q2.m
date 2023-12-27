%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controlleur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output]=control(inp)

% Variables
  vf= inp(1); % vitesse du v�hicule leader 
  df= inp(2); % distance sign�e du vehicule leader au chemin
  db= inp(3); % distance sign�e du vehicule suiveur au chemin
  thetae=inp(5);
  Id=inp(6);

  
% calcul de la commande

  wf= 0; % vitesse angulaire du v�hicule leader (commande)
  k1=0.5;k2=1;k3=0.1;
  df_etoile=0.2;
  u2=-k1*vf*(df-df_etoile)-k2*abs(vf)*thetae-k3*abs(vf)*Id;
  wf=u2;
  vb= 0; % vitesse lin�aire du v�hicule suiveur (cette commande =0 pour Parties I et II)
  wb= 0; % vitesse angulaire du v�hicule suiveur (cette commande =0 pour Parties I et II)
  u= [wf;vb;wb];

output= u;

  