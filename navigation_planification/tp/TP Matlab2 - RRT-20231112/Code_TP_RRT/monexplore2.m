function rrt=monexplore2(k,deltaq)

close all;

%define environment and start node
lim=[-10. +10.;-10. +10.];
start=[0. 0.];

%setup the first tree and first node to be the start
rrt(1).cords=start;
rrt(1).parent=0;

figure(1);
axis([lim(1,:),lim(2,:)]);
% Plot initial node
plot(start(1),start(2),'sg');


% Size of search space
range=abs(lim(:,2)-lim(:,1));

hold on;
for i=1:k
    % Randomly generate point
    %new_pnt=[lim(1,1)+ range(1)*rand, lim(2,1)+ range(2)*rand];

    %Polar sampling
    u1= rand;
    u2= rand;
    dd= -2*log(u1);
    %r=sqrt(dd);
    teta= 2*pi*u2;
   
    new_pnt=[(dd^(1/2))*cos(teta), (dd^(1/2))*sin(teta)];
    %new_pnt=[u1*cos(teta), u1*sin(teta)];
    
    
    
    %plot new point
    %plot(new_pnt(1),new_pnt(2),'ko');

    %find nearest neighbour
    dist=sqrt((rrt(1).cords(:,1)-new_pnt(1)).^2+(rrt(1).cords(:,2)-new_pnt(2)).^2);
    [unused_val,minNode_index]=min(dist);
    
    prochevoisin = rrt(1).cords(minNode_index,:);
    vect=  new_pnt - prochevoisin;
    
    pointtoadd = vect/norm(vect)*min(deltaq,norm(vect))+prochevoisin;
    
    %add point to graph
    %rrt(1).parent=[rrt(1).parent;1]; 
    
    rrt(1).parent=[rrt(1).parent;minNode_index]; 
    rrt(1).cords=[rrt(1).cords;pointtoadd];

    %rrt(1).cords=[rrt(1).cords;new_pnt];
  
plot(pointtoadd(1),pointtoadd(2),'.k');

    plot([prochevoisin(1),pointtoadd(1)],[prochevoisin(2),pointtoadd(2)],'r');
    
    axis([lim(1,:),lim(2,:)]);
    pause(.1);
end

%plot vertices
% for i=2:size(rrt(1).parent,1)
%     plot([rrt(1).cords(rrt(1).parent(i),1),rrt(1).cords(i,1)],[rrt(1).cords(rrt(1).parent(i),2),rrt(1).cords(i,2)],'r');
% end