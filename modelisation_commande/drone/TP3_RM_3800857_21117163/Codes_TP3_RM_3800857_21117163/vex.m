function [x] = vex(S_x)

isAntiSymmetric = isequal(S_x, -S_x');
if isAntiSymmetric
    x=[S_x(3,2) S_x(1,3) S_x(2,1)]';
else
    disp('error')

end
end