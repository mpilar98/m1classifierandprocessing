% funcion discriminante para analysis_molar_semiH
% opera sobre ejemplares sueltos, no carpetas
% versión 25-03-2022 para 200 puntos muestreo semiperimetral
function discriminamolar(u,v,ejemplar)
global dos  
% global dos Clases
%%%%%%%%%%%%%
load('Semiperidentales200.mat','X','Y','origen','molar')
load('Semicentroides200.mat','XC','YC','variedad')%%% fichero de Centroides
respuesta1=origen';
items=size(X,1);
div=size(X,2);
Etiquetas=etiquetas(origen);
%%%%%%%%%%%%%%%%%%bloque para LOO del ejemplar bajo estudio LDC
for k=1:items
        if strcmp(char(molar(k)),char(ejemplar))
           continue  % leave one out
        else
        [~,Z(k,:,:)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',false);% true mejor que false?
%         %%%%% nuevas coordenadas de las variedades:
           P(k,:)=Z(k,:,1);
           Q(k,:)=Z(k,:,2);
        end
end
%%%%%%%%%%%%%%%%%% sin LOO (para distancia de Hausdorff)
for k=1:items
    [~,Z1(:,:,k)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',false);% 
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
% % % Mdl=fitcdiscr([P,Q],respuesta1,'discrimType','linear','Prior','uniform',...
% % %     'ClassNames',{'allophate','Iberomys cabrerae','Microtus agrestis','Microtus arvalis',...
% % %     'Lasiopodomys gregalis','Alexandromys oeconomus','Terricola duodecimcostatus','Terricola lusitanicus','Terricola pyrenaicus','Chionomys nivalis'});
Mdl=fitcdiscr([P,Q],respuesta1,'discrimType','linear','Prior','uniform',...
    'ClassNames',Etiquetas);
clase=predict(Mdl,[u v]);% discriminante de Fisher
%%%% Calculo de la distancia de hausdorff a los ejemplares de las variedades
 for n=1:items
   D(n)=vectorized_MHD([u', v'],[U(:,n), V(:,n)]);%  la madre del cordero
 end
 %%%%%%%%%%%%%%%%%%
 [~,ih]=sort(D);%%% indexa distancias Hausdorff a Variedades / Centroides
 [~,ic]=sort(dc);%%% indexa distancias procrustes a Centroides
%%%%%%%%%%%%%%%%%%%%%% 
figure(dos)
text(1,100,ejemplar,'Color','k')
text(1,60,'Estimation','Color','k')
text(10,20,'Fisher :','Color','r')
text(30,20,clase,'Color','r')
text(10,30,'Haussdorff :','Color','b')
text(30,30,respuesta1{ih(1)},'Color','b') %Variedades,sin LOO
text(10,40,'Procrustes :','Color','m')
text(30,40,variedad{ic(1)},'Color','m') %Centroides
%%%%%%%%%%%%%%%%
text(40,200,'D (Hausdorff,Varieties)','Color','b')
for k1=1:itemsC % itemsC variedades e itemsC centroides distintos
text(40,200-10*k1,origen(ih(k1)),'Color','b')
end
for k2=1:itemsC
text(60,200-10*k2,num2str(D(ih(k2))'),'Color','b')
end
%%%%%%%%%%%%% procrustes a los centroides de las variedades (10)
text(75,200,'100*d (Procrustes,Centroids)','Color','m')
for k3=1:itemsC
text(75,200-10*k3,variedad(ic(k3)),'Color','m')
end
for k4=1:itemsC
text(100,200-10*k4,num2str(100*dc(ic(k4))'),'Color','m')
end
hold off
clear U V X Y XC YC k itemsC u v respuesta2 
clear im D dh dp n clase respuesta1 molar
return