function [output]= estim_nonlin(u)

% Fonction qui definit la dynamique de l'observateur non-lineaire (Filtre nonlineaire explicit, ou autre) 
% pour estimler le quaternion du repere corps vers le repere inertiel (note "qhat").
% La fonction doit renvoyer dqhat/dt

qhat= u(1:4); %Quaternion estime au temps k
acc= u(5:7); %Mesures accelerometres au temps k
gyro= u(8:10); %Mesures gyrometres au temps k
magneto= u(11:13); %Mesures magnetometres au temps k

g=9.81;
% vecteur exprimer par rapport au repere inertiel
v1_I=[0 0 -g]';
m_I =4.7e-5*[cos(65/360*2*pi);0;sin(65/360*2*pi)];
v2_I=m_I;

% vecteur exprimer par rapport au repere du corps du drone
v1_B=acc;
v2_B=magneto;

qshat=qhat(1);
qvhat=qhat(2:4);
S_qvhat=S(qvhat);

k1=0.002;
k2=0.002;
% estimation d'attitude R au temps k
Rhat=eye(3)+2*qshat*S_qvhat+2*S_qvhat*S_qvhat;
% estimation de vitesse angulaire au temps k
omegahat=gyro+cross(k1*v1_B,Rhat'*v1_I)+cross(k2*v2_B,Rhat'*v2_I);


% estimation du q_dot
qshat_dot=-0.5*(qvhat'*omegahat-qshat*(1-norm(qhat)^2));
qvhat_dot=0.5*(qshat*omegahat+cross(qvhat,omegahat)+qvhat*(1-norm(qhat)^2));






output= [qshat_dot;qvhat_dot];
