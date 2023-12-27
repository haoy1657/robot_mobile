%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controlleur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output]=control(inp)

% Variables
  p1=inp(1); p2=inp(2); theta=inp(3); p=[p1;p2];        % etat du vehicule
  pr1=inp(4); pr2=inp(5); thetar=inp(6); pr=[pr1;pr2]; % etat de la reference
  vr= inp(7); wr= inp(8); % vitesses de la r�f�rence
  pt= rot(-thetar)*(p-pr); % erreur en position exprim�es dans le rep�re de r�f�rence
  %method = 1; % commenter cette ligne pour l'asservissement en position
  method = 2; % commenter cette ligne pour l'asservissement en position/orientation methode lineaire
  %method=3;  % commenter cette ligne pour l'asservissement en position/orientation methode non lineaire








 %第一题必须固定一个点和p0隔开，如果不隔开不稳定，结果是隔开的点和参考点之间的追踪
 %第二题可隔开也可不隔开，隔开就是固定的那个点和参考点之间的追踪，不隔开就是p0追踪参考点

 if method == 1  %%%%%%  Stabilisation de la position
      l1=0.2;
      l2=0.2;
      p=[p1+l1;p2+l2];
      xr_dot=vr*cos(thetar);
      yr_dot=vr*sin(thetar);
      k1=0.5;
      k2=0.5;
      e1=[1;0];
      l=[l1;l2];
      x_barre_tilde=p(1)-pr1;    %这里不应该选择p1和p2而是我们选择的点
      y_barre_tilde=p(2)-pr2;
      p_barre_tilde=[x_barre_tilde;y_barre_tilde];
      R_theta=[cos(theta) sin(theta); -sin(theta) cos(theta)];
      S=[0 -1;1 0];
      M=[e1 S*l];
      commande=[xr_dot;yr_dot] -[k1 0;0 k2]*p_barre_tilde;
      u=inv(M)*R_theta*commande;
      v= [u(1);u(2);pt]; 

 elseif method==2  %%%%%%  Stabilisation de la position + orientation
      %stabiliser par rapport a p0
      l1=0.2;
      l2=0.2;
      p=[p1+l1;p2+l2];
      R_thetar=[cos(thetar) sin(thetar);-sin(thetar) cos(thetar)];
      %g_tilde=[pt;theta-thetar];
      g_tilde=[R_thetar*[p(1)-pr1;p(2)-pr2];theta-thetar];
      
      k1=0.5;k2=1;k3=1.4*k2^0.5;%d apres le facteur amortissement 
      %sous systeme 1
      u1_tilde=-wr*g_tilde(2)-k1*g_tilde(1);
      u1=u1_tilde+vr;
      %sous systeme 2
      u2_tilde=-k2*vr*g_tilde(2)-k3*abs(vr)*g_tilde(3);
      u2=u2_tilde+wr;
      
      v= [u1;u2;pt]; 
 % else 
 %     v= [0;0;pt]; 
 %     R_thetar=[cos(thetar) sin(thetar);-sin(thetar) cos(thetar)];
 %     g_tilde=[R_thetar*[p1-pr1;p2-pr2];theta-thetar];
 %     k1=0.5;k2=1;k3=1.4*k2^0.5;
 %     u1=vr-k1*abs(vr)*(g_tilde(1)*cos(g_tilde(3))+g_tilde(2)*sin(g_tilde(3)));
 %     u2=wr-k2*vr*(cos(g_tilde(3)/2))^3*()

 end;

output= v;

function [out]= rot(theta) % Rotation matrix in the plane
  out= [cos(theta) -sin(theta); sin(theta) cos(theta)]; 

