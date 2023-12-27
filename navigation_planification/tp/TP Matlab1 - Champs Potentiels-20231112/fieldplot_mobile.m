function fieldplot(s,r,minZ,scale)

%surfc(Z);
hold on;

if (exist('s'))
   for i = 1:size(s,2)
      plot3(s(i).x(1,1)*scale,s(i).x(1,2)*scale,minZ,'b.','MarkerSize',20);
      axis([0 120 40 100]);
   end
end
if (exist('r'))
   for i = 1:size(r,2)
      plot3(r(i).x(1,1)*scale,r(i).x(1,2)*scale,minZ,'r.','MarkerSize',20);
      axis([0 120 40 100]);
   end
end
