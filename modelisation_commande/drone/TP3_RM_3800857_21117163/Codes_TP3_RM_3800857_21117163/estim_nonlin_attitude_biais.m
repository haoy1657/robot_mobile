function [output]= estim_nonlin_attitude_biais(u)

% Fonction qui definit la dynamique de l'observateur non-lineaire (Filtre nonlineaire explicit, ou autre) 
% pour estimler le quaternion du repere corps vers le repere inertiel (note "qhat").
% La fonction doit renvoyer dqhat/dt

qhat= u(1:4); %Quaternion estime au temps k
biais_gyro=u(5:7);

acc= u(8:10); %Mesures accelerometres au temps k
gyro= u(11:13); %Mesures gyrometres au temps k
magneto= u(14:16); %Mesures magnetometres au temps k
R1=u(17:19);
R2=u(20:22);
R3=u(23:25);
R=[R1 R2 R3];

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

k1=100;
k2=100;
% estimation d'attitude R au temps k
Rhat=eye(3)+2*qshat*S_qvhat+2*S_qvhat*S_qvhat;

% R_tilde
R_tilde=R*Rhat';
% P_Rtilde
P_R_tilde=0.5*(R_tilde-R_tilde');
% estimation de vitesse angulaire au temps k
omegahat=gyro-biais_gyro+k1*Rhat'*vex(P_R_tilde);


% estimation du q_dot
qshat_dot=-0.5*(qvhat'*omegahat-qshat*(1-norm(qhat)^2));
qvhat_dot=0.5*(qshat*omegahat+cross(qvhat,omegahat)+qvhat*(1-norm(qhat)^2));
biais_dot=-k2*Rhat'*vex(P_R_tilde); 






output= [qshat_dot;qvhat_dot;biais_dot];

