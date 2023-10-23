
function [dmax,Q]=maxdist(P1,S2)
% esta función calcula la distancia máxima entre un punto y un segmento de curva
% y el punto de la curva en cuestión 
% version 12-01-2022
factor=240;
k2=size(S2,1);
dist=zeros(k2);
dref=2/factor;
    for q=1:k2
        dist(q)=norm([P1(1) P1(2)]-[S2(q,1) S2(q,2)])/factor;
        if dist(q) > dref 
            dmax=dist(q);
            Q=q;
            dref=dmax;
        else
        end           
    end
end

