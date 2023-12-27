%% Function initSearch
%
% *Description:* This function plots and outputs some info

function initSearch(Iterations,lim,start,goal,treesMax,dodraw)

global obs;

% Initialise display
% ------------------
if dodraw

    % Output to command window
    fprintf('\n******************************************\n');
    fprintf('***   Rapidly-Exploring Random Trees   ***\n');
    fprintf('******************************************\n\n');
    fprintf('Max. number of steps: %d \n',Iterations);
    fprintf('Max. number of trees: %d \n\n',treesMax);
    
    % Output to figure
    figure(1);
    title('Rapidly-Exploring Random Trees (Step 1)');
    %xlabel('X'); ylabel('Y'); zlabel('Z');
    set(gca,'xtick',[],'ytick',[]);
    %axis off;
    axis([lim(1,1) lim(1,2) lim(2,1) lim(2,2)],'square');
    hold on;

    % Plot initial node
    plot(start(1),start(2),'sm');

    % Plot goal node
    plot(goal(1),goal(2),'sb');
    
    % Plot obstacles
    if size(obs,1)>0
        for i=1:size(obs,3),
            line([obs(1,1,i);obs(2,1,i)],[obs(1,2,i);obs(2,2,i)],'LineWidth',4,'Color',[.8 .8 .8]);
        end
    end
end
