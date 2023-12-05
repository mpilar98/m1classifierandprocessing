
function [dmin,P,Q]=mindist(P1,P2)
% esta función calcula la distancia mínima entre segmentos en mm
% y los puntos más próximos entre ambos 
% sobre imágenes previamente orientadas, calibradas y procesadas  
% version 10-01-2022
factor=240;
k1=size(P1,1);
k2=size(P2,1);
dist=zeros(k1,k2);
dref=3;
for p=1:k1
    for q=1:k2
        dist(p,q)=norm([P1(p,1) P1(p,2)]-[P2(q,1) P2(q,2)])/factor;
        if dist(p,q) < dref 
            dmin=dist(p,q);
            P=p;
            Q=q;
            dref=dmin;
        else
            continue
        end
            
    end
end
end

