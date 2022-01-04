function [X,fit,pfit]=fobj_Rastrigin(X,Lb,Ub)
% Correcting the design vector if it is not within the defined range.
for i=1:size(X,2)
    if X(i)>Ub(i)
        X(i)=Ub(i);
    end
    if X(i)<Lb(i)
        X(i)=Lb(i);
    end
end

% Calculate the cost function (fit).
fit=rastr(X);
% Defining the penalty parameter (represented here with nou). Notice that
%penalty parameter is considered as a very big number and equal for all four
%inequality constraints.
nou=10^9;
penalty=0;
% Calculate the penalized cost function (pfit) by adding measure of penalty
%function (penalty).
pfit=fit+penalty;