%% Function newPoint
%
% *Description:* This function randomly samples the search space. and produces a new node

function new_pnt=newPoint(lim)

% Size of search space
range=abs(lim(:,2)-lim(:,1));

% Randomly generate point
new_pnt=[lim(1,1)+round(10*range(1)*rand)/10,...
         lim(2,1)+round(10*range(2)*rand)/10];
     

