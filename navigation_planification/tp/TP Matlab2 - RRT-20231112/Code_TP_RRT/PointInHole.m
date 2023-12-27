%% Function PointInQuad
%
% *Description:* Is point of intersection inside the obstacle uses sameSide
% usually used for checking a point in a mesh (triangle) but here we do the
% same for a 4 point plannar object   

function test_segment=PointInHole(Pint,obs)
%% this is slightly faster
test_segment=0;
if dot([Pint-obs(2,:,:)],[obs(1,:,:)-obs(2,:,:)])>0, 
    if dot([Pint-obs(3,:,:)],[obs(4,:,:)-obs(3,:,:)])>0 
                test_segment=1;
    end
end

