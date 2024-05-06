% diezmar.m 
% Data vector decimate
% Get M uniformly distributed points
function diezmo=diezmar(datos,M)
L=length(datos);
x=1:L;
div=M-1;
mayor=ceil((L-1)/(div));
menor=floor((L-1)/(div));
%
m=L-div*menor;
n=div-m;
%%%%%%%%%%%%%%
recorte=zeros(1,M);
%%%%%%%%%%%%%%%%%%
m2=floor(m/2);
m22=ceil(m/2);
n2=floor(n/2);
n22=ceil(n/2);
%%%%%%%%%%%%%%%%%
recorte(1)=x(1);
% 
for i=2:n22+2
    recorte(i)=recorte(i-1)+menor;
end
% % % %  
    for j=n22+2+1:div-n2+1
        recorte(j)=recorte(j-1)+mayor;
    end
% % % % 
    for k=div-n2+2:div+1
        recorte(k)=recorte(k-1)+menor;
    end
diezmo=datos(recorte);
return