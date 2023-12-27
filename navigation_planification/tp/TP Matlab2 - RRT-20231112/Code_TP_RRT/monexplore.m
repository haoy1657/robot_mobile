function rrt=monexplore(k)

close all;

%define environment and start node
lim=[-10. +10.;-10. +10.];
start=[0. 0.];
goal=[7. 7.];

%setup the first tree and first node to be the start
rrt(1).cords=start;
rrt(1).parent=0;

axis([lim(1,:),lim(2,:)]);
% Plot initial node
plot(start(1),start(2),'sg');


% Size of search space
range=abs(lim(:,2)-lim(:,1));
k=2000;
delta_q=1.2;
hold on;
nb=0;
    
%每次循环添加一个点
for i=1:k
    nb=nb+1;
    % Randomly generate point
    new_pnt=[lim(1,1)+ range(1)*rand, lim(2,1)+ range(2)*rand];

    %Polar sampling
    u1= lim(1,1)+ range(1)*rand;%x轴最小值 以x轴最小值为中心，范围为0-20 的高斯分布？
    %这样u1是-10到10的高斯分布
    u2= lim(2,1)+ range(2)*rand;%y轴最小值
    dd=-2*log(u1);%将u1转换成高斯分布的半径 u1 的波动范围太大 这里取log缩小波动
    %但是其高斯特性不是由log给的，而是在生成u1时就有了
    %r=sqrt(dd);
    teta= 2*pi*u2;%将u2转换成高斯分布的theta 因为2pi的周期特性，这里简单乘以2pi即可
    %new_pnt=[(dd^(1/2))*cos(teta), (dd^(1/2))*sin(teta)];
    %最后再把高斯分布的r theta 转换成笛卡尔坐标系的xy
    new_pnt=[delta_q*u1*cos(teta), delta_q*u1*sin(teta)];
    %plot new point
    plot(new_pnt(1),new_pnt(2),'ko');
    %find nearest neighbour
    %计算出来新点到之前的所有节点的欧几里得距离，然后取距离最小的点位父点
    dist=sqrt((rrt(1).cords(:,1)-new_pnt(1)).^2+(rrt(1).cords(:,2)-new_pnt(2)).^2); 
    %disp(dist);
    %[minimumValue, index] = min(dist);
    [unused_val,minNode_index]=min(dist); 
    %disp(minNode_index);
    %add point to graph
    %rrt(1).parent=[rrt(1).parent;1]; 
    %这里面保存了父点的索引
    %每次父点的索引是基于之前所有点的个数决定的每次循环总点的个数增加，相应父点索引的范围也增加一
    %每次新点生成都会生成相应的父点索引，最终只需要把所有父点按照顺讯连接即可并不会出现乱连接的情况
    rrt(1).parent=[rrt(1).parent;minNode_index]; 
    rrt(1).cords=[rrt(1).cords;new_pnt];
    dist_goal=sqrt((new_pnt(1)-goal(1)).^2+(new_pnt(2)-goal(2)).^2);
    dist_path=sqrt((new_pnt(1)-start(1)).^2+(new_pnt(2)-start(2)).^2);
    if dist_goal<=0.5
        break
    end
end


% % 原始列表
% list = [1, 2, 3, 4, 5];
% 
% % 要去掉的元素的索引
% index = 3; % 例如，要去掉索引为 3 的元素
% 
% % 创建新的列表，不包含要去掉的元素
% newList = list([1:index-1, index+1:end]);
%plot vertices
%disp(rrt(1).cords);
%disp(rrt(1).parent);
%把每个节点和他的父点连接
%初始点没有父点，所以从二开始

%直接把最后一个点和他的父点连接然后把父点和他的父点连接，如此循环就能够找到路径，最终parent的索引会到一，也就是初始点，循环结束
index_parent=rrt(1).parent(end);%代表着最后一个点的父点，最后把父点之间
%彼此连接后，要把这个初始父点和最后一个节点连接
index_noueds=size(rrt(1).parent);%初始化初始节点为最后一个点，然后其父点索引
%在上面定义
path=[rrt(1).parent(end)];
while index_parent ~=1
    index_noueds=index_parent;%把之前的父点看做新的节点
    index_parent=rrt(1).parent(index_noueds);%找出新的节点的父点
    path=[path,index_parent];
end
disp('path');
disp(path);
figure(1);
for i=2:size(rrt(1).parent,1)
    %rrt(1).parent(i)父点的索引
    plot([rrt(1).cords(rrt(1).parent(i),1),rrt(1).cords(i,1)],[rrt(1).cords(rrt(1).parent(i),2),rrt(1).cords(i,2)],'b');   
end
hold on;
% figure(2);
% disp(size(path,2));
for j=1:size(path,2)-1
    hold on;
    plot([rrt(1).cords(path(j),1),rrt(1).cords(path(j+1),1)],[rrt(1).cords(path(j),2),rrt(1).cords(path(j+1),2)],'r','LineWidth', 1); 
end

% %path
% path=[];
% L=rrt(1).cords;
% %disp('L(1)');
% %disp(L(1));
% list=rrt(1).cords;
% minNonZeroIndex=size(rrt(1).parent,1);
% fprintf('zuihouyi: %d\n', size(L(minNonZeroIndex)));
% while dist_path ~=0
%     %nb=size(rrt(1).parent);
%     %最后一个新点就是我们达到的终点
%     dist1=sqrt((list(:,1)-L(minNonZeroIndex,1)).^2+(list(:,2)-L(minNonZeroIndex,2)).^2);
%     %fprintf('dist1: %d\n', size(dist1));
%     nonZeroIndices = find(dist1 ~= 0);
%     minNonZeroValue = min(dist1(nonZeroIndices));
%     minNonZeroIndex = find(dist1 == minNonZeroValue);  
%     path=[path,rrt(1).cords(minNonZeroIndex)];
%     dist_path=sqrt((rrt(1).cords(minNonZeroIndex,1)-start(1)).^2+(rrt(1).cords(minNonZeroIndex,2)-start(2)).^2);
%     fprintf('dist_path: %d\n', dist_path);
%     %去掉选中的点
%     %注意，列表索引范围有变化，每次提取到的path索引不是相对于原始列表而是一个逐渐减少的索引
% 
% end
% disp('path');
% disp(path);
%第二题把所有生成的点和树的根连接


