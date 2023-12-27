function robotplot(q,Z,minZ,scale)

plot3(q(1,1)*scale,q(1,2)*scale, minZ, 'k.','MarkerSize',20);
plot3(q(1,1)*scale,q(1,2)*scale, Z(round(q(1,2)*scale), round(q(1,1)*scale))+.07,'k.','MarkerSize',100);


