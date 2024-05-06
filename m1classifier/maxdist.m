
function [dmax,Q]=maxdist(P1,S2)
% this function calculates the maximum distance between a point and a curve segment
% and the point on the curve in question 
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

