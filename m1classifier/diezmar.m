% diezmar.m decimation of a data vector
%  M evenly distributed samples are obtained
function diezmo=diezmar(datos,M)
L=length(datos);% length of the data vector
x=1:L;% vector of positions to be decimated
%M : number of samples to be extracted
div=M-1; %intervals to be calculated (div=200)
mayor=ceil((L-1)/(div));
menor=floor((L-1)/(div));
% calculation of m and n
m=L-div*menor;
n=div-m;
%%%%%%%%%%%%%%
%trimming vector initialisation
recorte=zeros(1,M);
%%%%%%%%%%%%%%%%%%
m2=floor(m/2);% calculation of limit index loops
m22=ceil(m/2);
n2=floor(n/2);
n22=ceil(n/2);
%%%%%%%%%%%%%%%%%
% The algorithm : must differentiate between m<>n ?
% Should major and minor intervales be alternated?
% I place minor intervals at the beginning and at the end.
% In the central part, the major intervals
recorte(1)=x(1);
% Initial values
for i=2:n22+2
    recorte(i)=recorte(i-1)+menor;
end
% % % %     % mean values
    for j=n22+2+1:div-n2+1
        recorte(j)=recorte(j-1)+mayor;
    end
% % % %     %final values
    for k=div-n2+2:div+1
        recorte(k)=recorte(k-1)+menor;%-1
    end
diezmo=datos(recorte);
return