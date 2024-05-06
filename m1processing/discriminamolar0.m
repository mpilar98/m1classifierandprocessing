% discriminant function for analysis_molar_semiH
% operates on single individuals, not folders
% version 25-03-2022 for 200 points of semi-perimeter sampling
function discriminamolar(u,v,ejemplar)
global dos  
% global dos Clases
%%%%%%%%%%%%%
load('Semiperidentales200.mat','X','Y','origen','molar')
load('Semicentroides200.mat','XC','YC','variedad')%%% Centroids file
respuesta1=origen';
items=size(X,1);
div=size(X,2);
Etiquetas=etiquetas(origen);
%%%%%%%%%%%%%%%%%%block for LOO of the specimen under study LDC
for k=1:items
        if strcmp(char(molar(k)),char(ejemplar))
           continue  % leave one out
        else
        [~,Z(k,:,:)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',false);% true better than false?
%         %%%%% new variety coordinates:
           P(k,:)=Z(k,:,1);
           Q(k,:)=Z(k,:,2);
        end
end
%%%%%%%%%%%%%%%%%% without LOO (for Hausdorff distance)
for k=1:items
    [~,Z1(:,:,k)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',false);% 
    %%%%% new variety coordinates:
    U(:,k)=Z1(:,1,k);
    V(:,k)=Z1(:,2,k);
end
%%%%%%% enter distance from the specimen to the centroids of the characterised varieties
itemsC=size(XC,1);% Total varieties characterised
for kc=1:itemsC
[dc(kc),Z2(k,:,:)]=procrustes([u',v'],[XC(kc,:)',YC(kc,:)'],'Scaling',false);% now without scaling
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % Mdl=fitcdiscr([P,Q],respuesta1,'discrimType','linear','Prior','uniform',...
% % %     'ClassNames',{'allophate','cabrerae','m_agrestis','m_arvalis',...
% % %     'gregalis','oeconomus','t_duodecimcostatus','t_lusitanicus','t_pyrenaicus','chionomys'});
Mdl=fitcdiscr([P,Q],respuesta1,'discrimType','linear','Prior','uniform',...
    'ClassNames',Etiquetas);
clase=predict(Mdl,[u v]);% Fisher discriminant
%%%% Calculation of the hausdorff distance to the specimens of the varieties
 for n=1:items
   D(n)=vectorized_MHD([u', v'],[U(:,n), V(:,n)]);%
 end
 %%%%%%%%%%%%%%%%%%
 [~,ih]=sort(D);%%% index Hausdorff distance to Varieties / Centroids
 [~,ic]=sort(dc);%%% index procrustes distance to Centroids
%%%%%%%%%%%%%%%%%%%%%% 
figure(dos)
text(1,100,ejemplar,'Color','k')
text(1,60,'Estimación','Color','k')
text(10,20,'Fisher :','Color','r')
text(30,20,clase,'Color','r')
text(10,30,'Haussdorff :','Color','b')
text(30,30,respuesta1{ih(1)},'Color','b') %Varieties,without LOO
text(10,40,'Procrustes :','Color','m')
text(30,40,variedad{ic(1)},'Color','m') %Centroids
%%%%%%%%%%%%%%%%
text(40,200,'D (Hausdorff,Variedades)','Color','b')
for k1=1:itemsC % itemsC varieties and itemsC centroids diferents
text(40,200-10*k1,origen(ih(k1)),'Color','b')
end
for k2=1:itemsC
text(60,200-10*k2,num2str(D(ih(k2))'),'Color','b')
end
%%%%%%%%%%%%% procrustes to the centroids fo the varieties (10)
text(75,200,'100*d (Procrustes,Centroides)','Color','m')
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