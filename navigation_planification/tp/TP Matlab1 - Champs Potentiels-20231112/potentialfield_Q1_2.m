%%% Variables :
%%% q: position courante "robot" 
%%% s: struct positions des attracteurs 
%%% r: struct positions des repulsifs
%%%
%%%  champs des structures des points attracteurs (s) et repulsifs (r) : 
%%%  attract :  x (position), w (poids), and k (forme, 1:conique, 2:parabolique)
%%%  repuls :  x (position), w (poids), and k (forme, 1:exponentiel, 2:hyperbolique)


function [ output_args ] = potentialfield_etu(gen_field)

close all;

s=[];
r=[];

% configuration des attracteurs/repulsifs
%gen_field = 11;
switch gen_field
    case 1 % cas 1 : champ attractif de type conique
        q = [9 9];
        s(1).x = [1 5]; s(1).w = 0.22; s(1).k = 1;
    case 2 % cas 2 : champ attractif de type parabolique
        q = [9 9];
        s(1).x = [1 5]; s(1).w = 0.03; s(1).k = 2;
    case 3  % cas 3 : champ r�pulsif de type exponentiel
        q = [9 9];
        r(1).x = [3 5]; r(1).w = 0.6; r(1).k = 1; 
        r(2).x = [6 8]; r(2).w = 0.6; r(2).k = 1;
        r(3).x = [2 8]; r(3).w = 0.6; r(3).k = 1; 
    case 4  % cas 4 : champ r�pulsif de type hyperbolique
        q = [9 9];
        rho_0 = 1.5;
        r(1).x = [3 5]; r(1).w = 0.6; r(1).k = 2; 
        r(2).x = [6 8]; r(2).w = 0.6; r(2).k = 2;
        r(3).x = [2 8]; r(3).w = 0.6; r(3).k = 2; 
%    case X  % cas X : combinaison(s) de champs attractifs et repulsifs
%       q = [9 9];
%       rho_0 = 1.5;
%       ------------------ A COMPLETER ------------------------
%
%       conseil : combiner dans un premier temps
%       les points precedents sans changer les parametres
    case 5
        %cas1+ cas3
        q = [9 9];
        s(1).x = [1 5]; s(1).w = 0.22; s(1).k = 1;
        r(1).x = [3 5]; r(1).w = 0.6; r(1).k = 1; 
        r(2).x = [6 8]; r(2).w = 0.6; r(2).k = 1;
        r(3).x = [2 8]; r(3).w = 0.6; r(3).k = 1;

    case 6 
        %cas 2+ cas4
        q = [9 9];
        s(1).x = [1 5]; s(1).w = 0.03; s(1).k = 2;
        rho_0 = 1.5;
        r(1).x = [3 5]; r(1).w = 0.6; r(1).k = 2; 
        r(2).x = [6 8]; r(2).w = 0.6; r(2).k = 2;
        r(3).x = [2 8]; r(3).w = 0.6; r(3).k = 2;
    case 7
        % minimum local
        q = [9 9];
        s(1).x = [5 5]; s(1).w = 0.22; s(1).k = 1;
     

        r(1).x = [4 6]; r(1).w = 1.25; r(1).k = 1; 
        r(2).x = [6 4]; r(2).w = 1.25; r(2).k = 1;




        
    



end


% calcul des champs de potentiel 
U = [];
minU = 0;
maxU = 3.3; % necessaire pour l affichage avec des champs repulsifs de type parabolique (infini)
scale = 10;
for i=1:100
    for j=1:100
        pos = [j/scale i/scale]; % position de l espace ou on calcule le champ 'u'
        u = 0;
        
        % s il y a un point attracteur, 
        % sommation de son potentiel a 'u'
        if (exist('s'))
            % scan over all sink nodes
            for p = 1:size(s,2)
                if (s(p).k == 1) %type canonique
                     u = u + s(p).w * ( norm(s(p).x - pos) );% u = u + %-------------------------- A COMPLETER
                    % question 1
                elseif (s(p).k == 2)%type parabolique
                     u= u +0.5*s(p).w*( norm(s(p).x - pos) )^2;
                    % u = u + %-------------------------- A COMPLETER
                end
            end
        end
        
        % s il y a un (des) point(s) repulsif(s), 
        % sommation de son potentiel a 'u'
        if (exist('r'))
            for p = 1:size(r,2)
                if (r(p).k == 1) %type exponentielle
                   u= u+r(p).w*exp(-( norm(r(p).x - pos) )/r(p).w);
                   % u = u + %-------------------------- A COMPLETER
                elseif (r(p).k == 2)%type hyberbolique
                    dist = norm((pos-r(p).x));
                    if dist==0
                        u = maxU; % on n additionne pas si dist==0 ... 
                    else
                        u = u + (dist<rho_0)*0.5*r(p).w *(1/dist-1/rho_0)^2; %-------------------------- A COMPLETER
                    end
                   % u = u + %-------------------------- A COMPLETER
                end
            end
        end
        
        if (u>maxU) 
            u=maxU;
        end;
        
        U(i,j) = u;
        
        if u < minU
           minU = u; 
        end
    end
end

% affichage de champs
fieldplot(s,r,U,minU,scale);
path=q;

% ------------------------ partie a decommenter a partir de la question 2

% boucle iterative : mise a jour de la position du robot au cours du temps
for t = 1:1000

   % initialise le vecteur d accumulation des vecteurs deplacement/force 
   %du robot induits par les champs (dq equivaut a dq/dt)
   dq = [0 0];  pas_iteration = 0.5;

   % sommation des forces attractives
   if (exist('s'))
      for i = 1:size(s,2)
         if (s(i).k == 1) %canonique
            dq = dq - pas_iteration*(s(i).w)*(q - s(i).x)/norm(q - s(i).x);
            %-------------------------- A COMPLETER
         elseif (s(i).k == 2)%parabolique 
            dq = dq  - pas_iteration*(s(i).w)*(q - s(i).x);  %-------------------------- A COMPLETER
         end
      end
   end

   % sommation des forces repulsives
   if (exist('r'))
      for i = 1:size(r,2)
         if (r(i).k == 1) %exponentielle
            rho = (norm(r(i).x - q)) ; gradient_rho = (q - r(i).x)/(norm(q - r(i).x));
            dq = dq + pas_iteration*(exp(- rho / r(i).w))*gradient_rho ;
            % dq = dq +  %-------------------------- A COMPLETER
         elseif (r(i).k == 2)%hyberbolique
            rho = (norm(r(i).x - q)) ; gradient_rho = (q - r(i).x)/norm(q - r(i).x);
            dq = dq + (rho<rho_0)*pas_iteration*(r(i).w)*( 1/(rho) - 1/rho_0 )*(1/(rho^2))*gradient_rho ;
            % dq = dq +  %-------------------------- A COMPLETER
         end
      end
   end

   % integration de la position du robot
   q = q + dq;

   % gestion des limites de l espace
   q=(size(U)-1)/scale.*(round(q*scale)>(size(U)-1))+(ones(size(q))/scale+eps).*(round(q*scale)<1)+q.*(round(q*scale)<=(size(U)-1)&round(scale*q)>=1); 

   % enregistrement du chemin
   path = [path; q];

   % affichage du robot
   robotplot(q,U,minU,scale);
   title(sprintf('Iteration: %d',t));
   refresh;
   drawnow;

   % critere d arret distance/q_goal
   % %------------------------------------- A COMPLETER
   disp(s(1).x);
   disp(dq);
   if(norm(q-s(1).x) < pas_iteration) 
       break
   end
   
   % if any(dq < 10^(-2)) && any(norm(q - s(1).x) > pas_iteration)
   %     disp('en train de trouver un chemin')
   %     % Assuming qinit and qgoal are given configurations
   %      qinit =q; %...;  % Define qinit
   %      qgoal =s(1).x; %...;  % Define qgoal
   % 
   %      % Initialize the tree T with qinit as the root
   %      T = tree(qinit);
   % 
   %      % Initialize OPEN as a priority queue with qinit
   %      OPEN = priorityQueue();
        % OPEN.insert(qinit);
% 
%         % Mark qinit as visited
%         visited(qinit) = true;
% 
%         % Initially, mark all configurations in C as unvisited
%         visitedC = false(size(C, 1), 1);
% 
%         SUCCESS = false;
% 
%         while ~OPEN.isEmpty() || ~SUCCESS
%             % Get the first node from OPEN
%             q = OPEN.getFirst();
% 
%             % For every node q' adjacent to q in C
%             adjacentNodes = getAdjacentNodes(q, C);
%             for i = 1:length(adjacentNodes)
%                 q_prime = adjacentNodes(i);
% 
%                 % Check conditions for adding q' to the tree
%                 if U(q_prime) < M && ~visited(q_prime)
%                     % Add q' to T with a pointer toward q
%                     T.addNode(q_prime, q);
% 
%                     % Insert q' into OPEN
%                     OPEN.insert(q_prime);
% 
%                     % Mark q' as visited
%                     visited(q_prime) = true;
% 
%                     % Check if q' is the goal configuration
%                     if isequal(q_prime, qgoal)
%                         SUCCESS = true;
%                         break;
%                     end
%                 end
%             end
% 
%             % If SUCCESS, construct the path by tracing pointers in T
%             if SUCCESS
%                 % Trace the path from qgoal back to qinit
%                 path = tracePath(T, qgoal, qinit);
%                 % Return the constructed path
%                 disp('Path found:');
%                 disp(path);
%                 return;
%             end
%         end
% 
%         % Return failure if the loop completes without finding a path
%         disp('Path not found.');
%    end
% %%%%



end
