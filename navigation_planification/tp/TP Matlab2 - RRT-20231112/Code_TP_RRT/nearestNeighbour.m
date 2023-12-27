%% Function nearestNeighbour
%
% *Description:* This function finds the nearest node or edge.

function [d2nodes]=nearestNeighbour(new_pnt)
        
global rrt nncount;
nncount=nncount+1;

%go through each tree and find vector of dist to edge and nodes
for t=1:size(rrt,2)
    if rrt(t).valid
        % Distance to all nodes 
        d2nodes(t).vals=sqrt((rrt(t).cords(:,1)-new_pnt(1)).^2+...
                             (rrt(t).cords(:,2)-new_pnt(2)).^2);
    end
end

