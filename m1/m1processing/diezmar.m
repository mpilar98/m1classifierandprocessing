% diezmar.m decimado de un vector de datos
% se obtienen M muestras uniformemente repartidas
function diezmo=diezmar(datos,M)
L=length(datos);% longitud del vector de datos
x=1:L;% vector de posiciones a decimar
%M : numero de muestras a extraer
div=M-1; %intervalos  a calcular (div=200)
mayor=ceil((L-1)/(div));
menor=floor((L-1)/(div));
% calculo de m y n
m=L-div*menor;
n=div-m;
%%%%%%%%%%%%%%
%inicializacion vector recorte
recorte=zeros(1,M);
%%%%%%%%%%%%%%%%%%
m2=floor(m/2);% calculo limite indices bucles
m22=ceil(m/2);
n2=floor(n/2);
n22=ceil(n/2);
%%%%%%%%%%%%%%%%%
% El algoritmo : hay que diferenciar entre m<>n ?
% ¿Hay que alternar intervalos mayores y menores?
% Compromiso: Coloco los intervalos menores al principio y al final
% En la parte central, los intervalos mayores
recorte(1)=x(1);
% Valores iniciales
for i=2:n22+2
    recorte(i)=recorte(i-1)+menor;
end
% % % %     % Valores medios
    for j=n22+2+1:div-n2+1
        recorte(j)=recorte(j-1)+mayor;
    end
% % % %     %Valores finales
    for k=div-n2+2:div+1
        recorte(k)=recorte(k-1)+menor;%-1
    end
diezmo=datos(recorte);
return