%% Function collisionCheck
% 
% *Description:* Returns whether a collision occurs between an edge and a set
% of obstacles. Also gives the point of intersection. (P1=node,P2=parent node)

function [collision,PInt]=collisionCheck(P1,P2,obs)
collision=0;
global collcount;
collcount=collcount+1;
%default is that it is safe, then if a collision is found it is set to 1
%and we return

if size(obs,1)==0
    PInt=inf;
    return;
end
% Calculate intercept point of a line and line
% ---------------------------------------------


for i=1:size(obs,3)
  
    pt1.x = P1(1);
    pt1.y = P1(2);
    pt2.x = P2(1);
    pt2.y = P2(2);
    pt3.x = obs(1,1,i);
    pt3.y = obs(1,2,i);
    pt4.x = obs(2,1,i);
    pt4.y = obs(2,2,i);
    
      denom=((pt4.y - pt3.y)*(pt2.x - pt1.x))-((pt4.x - pt3.x)*(pt2.y - pt1.y));
      nume_a=((pt4.x - pt3.x)*(pt1.y - pt3.y))-((pt4.y - pt3.y)*(pt1.x - pt3.x));
      nume_b=((pt2.x - pt1.x)*(pt1.y - pt3.y))-((pt2.y - pt1.y)*(pt1.x - pt3.x));
 
        if(denom==0)
            if(nume_a == 0 & nume_b == 0)
                collision=1;
                PInt=inf;
                return;
            end
            collision=0;
        end
 
        ua = nume_a / denom;
        ub = nume_b / denom;
 
        if(ua >= 0.0 & ua <= 1.0 & ub >= 0.0 & ub <= 1.0)
            % Get the intersection point.
            PInt(1) = pt1.x + ua*(pt2.x - pt1.x);
            PInt(2) = pt1.y + ua*(pt2.y - pt1.y);
            collision=1;
            return;
        end
        collision=0;
        PInt=Inf;

end
