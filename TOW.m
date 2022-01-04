clc
clear
%% Initialization
% Define the properties of COP (tension/compression spring design problem).
nV=3; % Number of design variables.
Lb=[0.05 0.25 2]; % Lower bounds of design variables.
Ub=[2 1.3 15]; % Upper bounds of design variables.
% Define the parameters of TWO algorithm.
nT=10; % Number of Teams.
meus=1;meuk=1; % Static and Kinematic coefficients of friction.
deltat=1; % Time step in the movement equation with a constantacceleration.
alpha=0.99; % Controlling parameter of the algorithm's randomness.
beta=0.1; % Scaling factor of team's movement.
maxNFEs=20000; % Maximum Number of Objective Function Evaluations.
%Generate random initial solutions.
for i=1:nT
    T(i,:)=Lb+(Ub-Lb).*rand(1,nV); % Teams matrix or the league or matrix
    %of the initial candidate solutions or the initial population.
end
% Evaluate initial population (League) calling the fobj function
%constructed in the second chapter and form its corresponding vectors of
%objective function (Fit) and penalized objective function (PFit). It should
%be noted that the design vectors all are inside the search space.
for i=1:nT
    [X,fit,pfit]=fobj(T(i,:),Lb,Ub);
    T(i,:)=X;
    Fit(i)=fit;
    PFit(i)=pfit;
end
% Monitor the best candidate solution or team (bestT) and its corresponding
%objective function (minFit) and penalized objective function (minPFit).
[minPFit,m]=min(PFit);
minFit=Fit(m);
bestT=T(m,:);
%% Algorithm Body
NFEs=0; % Current Number of Objective Function Evaluations used by the
%algorithm until yet.
NITs=0; % Number of algorithm iterations
while NFEs<maxNFEs
    NITs=NITs+1; % Update the number of algorithm iterations.
    % Define the weights of the teams of the league.
    W=Weight(PFit);
    % Determine the total displacement of teams by a series of rope pulling
    %competitions.
    [stepsize]=Rope_Pulling(T,W,Lb,Ub,meus,meuk,deltat,alpha,beta,NITs);
    % Update the teams in the league.
    newT=T+stepsize;
    % Regenerate the teams exited from the search space using the Best Team
    %Strategy (BTS).
    [newT]=BTS(newT,T,bestT,Lb,Ub,NITs);
    % Evaluate the updated teams calling the fobj function. It should be noted
    % that the existed dimensions are corrected before within the BTS
    %function. However, to do not change the form of fobj function it is checked
    %again here which is not needed.
    for i=1:nT
        [X,fit,pfit]=fobj(newT(i,:),Lb,Ub);
        newT(i,:)=X;
        newFit(i)=fit;
        newPFit(i)=pfit;
    end
    NFEs=NFEs+nT;
    % Update the league by the replacement strategy.
    [T,Fit,PFit]=Replacement(T,Fit,PFit,newT,newFit,newPFit);
    % Monitor the best candidate solution (bestT) and its corresponding
    %objective function (minFit) and penalized objective function (minPFit).
    minPFit=PFit(1);minFit=Fit(1);bestT=T(1,:);
    % Display desired information of the iteration.
    disp(['NITs= ' num2str(NITs) '; minFit = ' num2str(minFit) '; minPFit= ' num2str(minPFit)]);
    % Save the required results for post processing and visualization of
    %the algorithm performance.
    output1(NITs,:)=[minFit,minPFit,NFEs];
    output2(NITs,:)=[min(PFit),max(PFit),mean(PFit)];
    output3(NITs,:)=[bestT,NFEs];
end
%% Monitoring the results
figure;
plot((1:1:NITs),output2(:,1),'g',(1:1:NITs),output2(:,2),'r--',(1:1:NITs),output2(:,3),'b-.')
legend('min','max','mean');
xlabel('NITs');
ylabel('PFit');
