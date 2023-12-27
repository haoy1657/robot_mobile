function explore
clc
clear
close all
q_start = [0, 0]; 
q_goal = [20,20 ];
q_noeuds=[q_start];
q_parents=[q_start];
figure(1);
k=1000;
delta_q=0.5;
for i =1:k
    for j=1:size(q_noeuds)
        q_new=[delta_q*rand delta_q*rand];
        
    end
    
    


    
end





end
