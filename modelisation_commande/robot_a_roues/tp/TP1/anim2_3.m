function [szOut]=anim

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% anim.m: Fonction qui fait l'animation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% on r�cup�re les data
load cart;
cart= ans';
save cart.data cart -ascii;
load xproj;
xproj= ans';
save xproj.data xproj -ascii;

% on dessine le premier
Xf=[cart(1,2),cart(1,3),cart(1,4)];
Xb=[cart(1,4),cart(1,5),cart(1,6)];
xpf= [xproj(1,2),xproj(1,3)];
xpb= [xproj(1,4),xproj(1,5)];
draw(Xf,Xb,xpf,xpb,1);
refresh;

% on fait l'animation
cl0=clock;
  for index = 1:1:size(cart,1)
    while  etime(clock,cl0) < cart(index,1),
     etime(clock,cl0);
    end;
    Xf=[cart(index,2),cart(index,3),cart(index,4)];
    Xb=[cart(index,5),cart(index,6),cart(index,7)];
    xpf= [xproj(index,2),xproj(index,3)];
    xpb= [xproj(index,4),xproj(index,5)];
    draw(Xf,Xb,xpf,xpb,index);
  end;
 disp('Taper sur une touche pour fermer la fenetre');
 pause;
 close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [szOut] = draw(Xf,Xb,xpf,xpb,index)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% draw.m: Function qui fait les trac�s
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global hc;

% D�finition de la g�om�trie et de la pose du v�hicule leader
L=2;
Pf= [Xf(1) Xf(2)]';
thetaf	= Xf(3);
XYf	= [ 0 L nan 0  0 nan   -0.5*L  0.5*L nan -0.5*L -0.5*L nan...
          -0.5*L  0.5*L nan 0.5*L L nan L 0.5*L nan -0.3*L 0.3*L nan...
          -0.3*L 0.3*L; 
          0 0 nan -0.7*L 0.7*L nan 0.5*L 0.5*L nan -0.5*L 0.5*L nan...
          -0.5*L -0.5*L nan -0.5*L 0 nan 0 0.5*L nan -0.7*L -0.7*L nan...
          0.7*L 0.7*L];
RMatf	= [cos(thetaf) -sin(thetaf); sin(thetaf) cos(thetaf)];

for i=1:26
  XYf(:,i) = RMatf * XYf(:,i) + Pf;
end;

% D�finition de la g�om�trie et de la pose du v�hicule suiveur
L=2;
Pb= [Xb(1) Xb(2)]';
thetab	= Xb(3);
XYb	= [ 0 L nan 0  0 nan   -0.5*L  0.5*L nan -0.5*L -0.5*L nan...
          -0.5*L  0.5*L nan 0.5*L L nan L 0.5*L nan -0.3*L 0.3*L nan...
          -0.3*L 0.3*L; 
          0 0 nan -0.7*L 0.7*L nan 0.5*L 0.5*L nan -0.5*L 0.5*L nan...
          -0.5*L -0.5*L nan -0.5*L 0 nan 0 0.5*L nan -0.7*L -0.7*L nan...
          0.7*L 0.7*L];
RMatb	= [cos(thetab) -sin(thetab); sin(thetab) cos(thetab)];

for i=1:26
  XYb(:,i) = RMatb * XYb(:,i) + Pb;
end;

% D�finition des rayons de mesure
D=0;
Rayf= [Pf(1)+ D*cos(thetaf) xpf(1) ; Pf(2)+ D*sin(thetaf) xpf(2)];
Rayb= [Pb(1)+ D*cos(thetab) xpb(1) ; Pb(2)+ D*sin(thetab) xpb(2)];


% Definition du chemin
angle= 0:pi/100:4*pi;
ch1= angle*5.5;
ch2= 5*(cos(ch1/5)+1);

% On dessine les objets
if index==1   
% Initialisation des propri�t�s de la figure
  figure(1);
  clf;
  set(gcf, 'Name', 'Animation Window');
  set(gcf,'Position',[ 10 50 950 600]);
  set(1,'BackingStore','on');
  hold on;
  set(gca, 'UserData', hc,'NextPlot', 'add','Visible', 'on','DataAspectRatio', [1 1 1], ...
	  'Color', 'k', 'SortMethod', 'childorder','Xlim',[-2 64],'Ylim',[-10 20]);

  hc(1)=plot(XYf(1,:),XYf(2,:),'g-','Linewidth',2);%modele voiture front
  hc(2)=plot(XYb(1,:),XYb(2,:),'y-','Linewidth',2);%modele voiture back
  hc(3)= plot(ch1,ch2,'w-','Linewidth',1);%modele voiture trajectoire 
  hc(4)= plot(Rayf(1,:),Rayf(2,:),'r','Linewidth',2);
  hc(5)= plot(Rayb(1,:),Rayb(2,:),'r','Linewidth',2);
  drawnow;
 
else
  set(hc(1),'XData',XYf(1,:),'YData',XYf(2,:));
  set(hc(2),'XData',XYb(1,:),'YData',XYb(2,:));
  set(hc(3),'XData',ch1,'YData',ch2);
  set(hc(4),'XData',Rayf(1,:),'YData',Rayf(2,:));
  set(hc(5),'XData',Rayb(1,:),'YData',Rayb(2,:));
  drawnow;

end
