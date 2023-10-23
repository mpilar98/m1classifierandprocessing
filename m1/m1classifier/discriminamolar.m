% funcion discriminante para biometry_alfaro_semi
% opera sobre ejemplares sueltos, no carpetas
% versión 5-01-2023 para 200 puntos muestreo semiperimetral
function discriminamolar(u,v,ejemplar)
global dos cuatro
load('Semiperidentales200.mat','X','Y','origen','molar')
load('Semicentroides200.mat','XC','YC','variedad')%%% fichero de Centroides
respuesta1=origen';
items=size(X,1);
div=size(X,2);
Etiquetas=etiquetas(origen);
numvar=size(Etiquetas,2);% número de variedades distintas
%%%%%%%%%%%%%%%%%%bloque para LOO del ejemplar bajo estudio LDC
for k=1:items
        if strcmp(char(molar(k)),char(ejemplar))
           continue  % leave one out
        else
        [~,Z(k,:,:)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',true);% true
%         %%%%% nuevas coordenadas de las variedades:
           P(k,:)=Z(k,:,1);
           Q(k,:)=Z(k,:,2);
        end
end
%%% d(k) es la distancia a cada ejemplar de las variedades, que no utilizo 
%%%%%%%%%%%%%%%%%% sin LOO (para distancia de Hausdorff)
for k=1:items
    [~,Z1(:,:,k)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',true);% true
%      [d(k),Z(:,:,k)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',true);% true mejor que false
     % d es la distancia a cada ejemplar de las variedades
    %%%%% nuevas coordenadas de las variedades:
    U(:,k)=Z1(:,1,k);
    V(:,k)=Z1(:,2,k);
end
%%%%%%% introduzco distancia del ejemplar a los centroides de las variedades caracterizadas
itemsC=size(XC,1);% Total variedades caracterizadas
for kc=1:itemsC
[dc(kc),Z2(k,:,:)]=procrustes([u',v'],[XC(kc,:)',YC(kc,:)'],'Scaling',false);% ahora sin escalado
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mdl=fitcdiscr([P,Q],respuesta1,'discrimType','linear','Prior','uniform',...
    'ClassNames',Etiquetas);
clase=predict(Mdl,[u v]);% discriminante de Fisher
% [clase,posterior,coste]=predict(Mdl,[u v]) % discriminante de Fisher en pruebas
%%%%%%%%%%%%%%%%%%% hasta aquí, discriminante lineal de Fisher
% % % clear U V X Y k Z items D respuesta1
%%%%%%%%%%% Estimación por distancia de Haussdorf a los centroides ???
% % % load Semicentroides200.mat XC YC variedad
% % % itemsC=size(XC,1);
% % % respuesta2=variedad;%%% cuando use centroides
%%%%%%%%%%%%% No Utilizo esta posibilidad, de momento. 
% % % for k=1:itemsC % para ajuste de los centroides al ejemplar en estudio ?
% % %     [~,Z(:,:,k)]=procrustes([u',v'],[XC(k,:)',YC(k,:)'],'Scaling',false);% 
% % %     %%%%% nuevas coordenadas de las variedades:
% % %     U(:,k)=Z(:,1,k);
% % %     V(:,k)=Z(:,2,k);
% % % end
% Distancia de Hausdorff a los ejemplares de la base de datos
 for n=1:items
   D(n)=vectorized_MHD([u', v'],[U(:,n), V(:,n)]);%
 end
 %%%%%% Calculo la distancia de hausdorff a los centroides de las variedades
% % %  for n=1:itemsC
% % %    D(n)=vectorized_MHD([u', v'],[XC(n,:)',YC(n,:)']);%  
% % %  end
 %%%%%%%%%%%%%%%%%%
 [~,ih]=sort(D);%%% indexa distancias Hausdorff a Variedades / Centroides
%  molar(ih(1))
% % %  [~,ip]=sort(d);%%% indexa distancias procrustes a Variedades. No utilizado
 [~,ic]=sort(dc);%%% indexa distancias procrustes a Centroides
%%%%%%%%%%%%%%%%%%%%%% 
figure(dos)
text(1,100,ejemplar,'Color','k','Interpreter','none')
text(10,50,'Estimación','Color','g')
text(10,20,'Fisher :','Color','r')
text(20,20,clase,'Color','r','Interpreter','none')
text(10,30,'Haussdorff :','Color','b')
text(20,30,respuesta1{ih(1)},'Color','b','Interpreter','none') %Hausdorff a Variedades
text(10,40,'Procrustes :','Color','m')
text(20,40,variedad(ic(1)),'Color','m','Interpreter','none') % Procrustes a centroides
%%%%%%%%%%%%%%%%
% % % text(15,10,variedad{ih(1)},'Color','b')% Centroides
%%% text(40,200,'D (Hausdorff,Centroides)','Color','b')
text(40,200,'D (Hausdorff,Variedades)','Color','b')
for k1=1:numvar % numvar variedades y numvar centroides distintos
text(40,200-8*k1,origen(ih(k1)),'Color','b','Interpreter','none')
end
for k2=1:numvar
text(60,200-8*k2,num2str(D(ih(k2))'),'Color','b')
end
%%%%%%%%% procrustes a ejemplares de las variedades
% % % text(65,200,'d(Procrustes,Variedades)','Color','m')
% % % for k3=1:30
% % % text(65,200-5*k3,origen(ip(k3)),'Color','r')
% % % end
% % % for k4=1:30
% % % text(75,200-5*k4,num2str(D(ip(k4))'),'Color','r')
% % % end
%%%%%%%%%%%%% procrustes a los centroides de las variedades (10)
text(75,200,'100*d (Procrustes,Centroides)','Color','m')
for k3=1:itemsC
text(75,200-8*k3,variedad(ic(k3)),'Color','m','Interpreter','none')
end
for k4=1:itemsC
text(100,200-8*k4,num2str(100*dc(ic(k4))'),'Color','m')
end
% % % hold off
%%%%%%%% Ejemplares afines Hausdorff
% % % figure(cuatro)
% % % clf(gcf)
% % % axis([1 100 1 200])
% % % axis off
 text(40,90,'Ejemplares afines','Color','k')
 text(80,90,'D(Hausdorff)')
 for k1=1:numvar % numvar variedades y numvar centroides distintos
    text(40,85-7*k1,molar(ih(k1)),'Color','k','Interpreter','none')
 end
for k2=1:numvar
    text(80,85-7*k2,num2str(D(ih(k2))'),'Color','k')
end
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear U V X Y XC YC k itemsC u v respuesta2 
clear im D dh dp n clase respuesta1 molar
return