% Define the weights of the teams of the league.
function [W]=Weight(PFit)
nT=size(PFit,2);
for i=1:nT
    W(i)=(PFit(i)-min(PFit))/(max(PFit)-min(PFit))+1;
end