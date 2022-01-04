% Regenerate the teams exited from the search space using the Best Team
%Strategy (BTS).
function [newT]=BTS(newT,T,bestT,Lb,Ub,NITs)
nT=size(newT,1);
nV=size(newT,2);
for i=1:nT
    for j=1:nV
        if newT(i,j)<Lb(j)||newT(i,j)>Ub(j)
            if rand<=0.5
                newT(i,j)=bestT(j)+randn/NITs*(bestT(j)-newT(i,j)); % Best Team Strategy.
                if newT(i,j)<Lb(j)||newT(i,j)>Ub(j)
                    newT(i,j)=T(i,j); % If the component is still outside the
                    %search space, return it using the flyback strategy.
                end
            else
                if newT(i,j)<Lb(j)
                    newT(i,j)=Lb(j);
                end
                if newT(i,j)>Ub(j)
                    newT(i,j)=Ub(j);
                end
            end
        end
    end
end