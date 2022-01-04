% Updating the league by comparing the updated teams with current teams of
%league.
function [T,Fit,PFit]=Replacement(T,Fit,PFit,newT,newFit,newPFit)
nT=size(T,1);
helpT=[T;newT];helpFit=[Fit newFit];helpPFit=[PFit newPFit];
[~,order]=sort(helpPFit);
T=helpT(order(1:nT),:);
Fit=helpFit(order(1:nT));
PFit=helpPFit(order(1:nT));