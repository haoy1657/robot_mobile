function [output]= estim_lin(u)

% Fonction qui d�finit la dynamique de l'observateur lin�aire pour estimer
% le vecteur des angles de Roulis/Tangage/Lacet (not� "thetahat"). La fonction doit renvoyer dthetahat/dt

thetahat= u(1:3); % Angles estim�s
acc= u(4:6); % Mesures acc�l�rom�tres
gyro= u(7:9); % Mesures gyrom�tres
magneto= u(10:12); % Mesures magn�tom�tres

% approximation mi
m_I =4.7e-5*[cos(65/360*2*pi);0;sin(65/360*2*pi)];
g=9.81;
% mmbarre
magneto_barre=magneto-dot(magneto,acc/g)*acc/g;
% approximation theta
theta1=-acc(2)/g;
theta2=acc(1)/g;
% definition omega
theta_dot1=gyro(1);
theta_dot2=gyro(2);
theta_dot3=gyro(3);

omega1=theta_dot1;
omega2=theta_dot2;
omega3=theta_dot3;

% definition observateur
k1=0.05;
k2=0.05;
k=0.05;
e2=[0 1 0]';
thetahat_dot1=omega1-k1*(thetahat(1)-theta1);
thetahat_dot2=omega2-k2*(thetahat(2)-theta2);
thetahat_dot3=omega3-k*(thetahat(3)-dot(magneto_barre/m_I(1),e2));




output= [thetahat_dot1 thetahat_dot2 thetahat_dot3 ];

