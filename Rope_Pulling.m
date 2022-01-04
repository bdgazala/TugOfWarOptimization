% Determine the total displacement of teams by a series of rope pulling
%competitions.
function[stepsize]=Rope_Pulling(T,W,Lb,Ub,meus,meuk,deltat,alpha,beta,NITs)
nT=size(T,1);
nV=size(T,2);
stepsize=zeros(size(T));
for i=1:nT
    for j=1:nT
        if W(i)<W(j)
            PF=max(W(i)*meus,W(j)*meus); % Pulling force between teams i
            %and j.
            RF=PF-W(i)*meuk; % The resultant force affecting the team i due
            %to its interaction with the heavier team j.
            g=T(j,:)-T(i,:); % Gravitational acceleration.
            a=RF/(W(i)*meuk).*g; % Acceleration of team i towards team j.
            stepsize(i,:)=stepsize(i,:)+0.5*a*deltat^2+alpha^NITs*beta*(Lb-Ub).*randn(1,nV);
        end
    end
end