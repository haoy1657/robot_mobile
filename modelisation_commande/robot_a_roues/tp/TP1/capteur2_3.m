%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controlleur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output]=capteur(inp)

% Variables
  xf=inp(1); yf=inp(2); thetaf=inp(3); Xf=[xf;yf;thetaf]; % etat du vehicule leader (index� par f pour "front")
  xb=inp(4); yb=inp(5); thetab=inp(6); Xb=[xb;yb;thetab]; % etat du vehicule suiveur (index� par b pour "back")
  
% Calcul du point Xf_proj de projection sur la courbe pour le v�hicule leader - Algorithme "Brut force"  
  D=0;
  diam=5;
  opt= 1e+6;
  ray_max=5;
  for k= -100:100
      xc= xf+D*cos(thetaf)+k*ray_max/100;
      value= (xf+D*cos(thetaf)-xc)^2+ (yf+D*sin(thetaf)-diam*(cos(xc/5)+1))^2;
      %disp(value);
      if value < opt
          xcstar=xc;
          opt=value;
      end;
  end;
  Xf_proj= [xcstar;diam*(cos(xcstar/5)+1)];
  
  if Xf(2)+D*sin(Xf(3)) > diam*(cos((Xf(1)+D*cos(Xf(3)))/5)+1)
    df= sqrt(opt);
  else
    df= -sqrt(opt);
  end;

 % Calcul du point Xb_proj de projection sur la courbe pour le v�hicule suiveur - Algorithme "Brut force"  
  D=0;
  diam=5;
  opt= 1e+6;
  ray_max=5;
  for k= -100:100
      xc= xb+D*cos(thetab)+k*ray_max/100;
      value= (xb+D*cos(thetab)-xc)^2+ (yb+D*sin(thetab)-diam*(cos(xc/5)+1))^2;
      if value < opt
          xcstar=xc;
          opt=value;
      end;
  end;
  Xb_proj= [xcstar;diam*(cos(xcstar/5)+1)];
  
  if Xb(2)+D*sin(Xb(3)) > diam*(cos((Xb(1)+D*cos(Xb(3)))/5)+1)
    db= sqrt(opt);
  else
    db= -sqrt(opt);
  end; 
  
  % Calcul de la distance entre les deux v�hicules
  dfb=norm([Xf(1)-Xb(1);Xf(2)-Xb(2)]);
  
output= [df;db;dfb;Xf_proj;Xb_proj];
