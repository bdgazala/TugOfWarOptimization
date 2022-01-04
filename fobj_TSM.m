function [X,fit,pfit]=fobj_TSM(X,Lb,Ub,C)
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
distance=C(X(1),X(length(X)));
for i=1:length(X)-1
    distance=distance+C(X(i),X(i+1));
end
fit=distance;
penalty=0;
% Calculate the penalized cost function (pfit) by adding measure of penalty
%function (penalty).
pfit=fit+penalty;