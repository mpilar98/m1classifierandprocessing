% discriminant function for biometry_alfaro_semi
% operates on single individuals, not folders. Introduce Support Vector Machine
% version 5-01-2023 for 200 points of semi-perimeter sampling
function discriminamolar_SVM(u,v,ejemplar)
global dos cuatro
load('Semiperidentales200.mat','X','Y','origen','molar')
load('Semicentroides200.mat','XC','YC','variedad')%%% fichero de Centroides
respuesta1=origen';
items=size(X,1);
div=size(X,2);
Etiquetas=etiquetas(origen);
numvar=size(Etiquetas,2);% number of different varieties
%%%%%%%%%%%%%%%%%%block for LOO of the specimen under study LDC
for k=1:items
        if strcmp(char(molar(k)),char(ejemplar))
           continue  % leave one out
        else
        [~,Z(k,:,:)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',true);% true
%         %%%%% new variety coordinates:
           P(k,:)=Z(k,:,1);
           Q(k,:)=Z(k,:,2);
        end
end 
%%%%%%%%%%%%%%%%%% without LOO (for Hausdorff distance)
for k=1:items
    [~,Z1(:,:,k)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',true);% true
    %%%%% new variety coordinates:
    U(:,k)=Z1(:,1,k);
    V(:,k)=Z1(:,2,k);
end
%%%%%%% enter distance from the specimen to the centroids of the characterised varieties
itemsC=size(XC,1);% Total varieties characterised
for kc=1:itemsC
[dc(kc),Z2(k,:,:)]=procrustes([u',v'],[XC(kc,:)',YC(kc,:)'],'Scaling',false);% ahora sin escalado
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mdl1=fitcdiscr([P,Q],respuesta1,'discrimType','linear','Prior','uniform',...
    'ClassNames',Etiquetas);
clase=predict(Mdl1,[u v]);% Fisher discriminant
%%%%%%% block SVM
Mdl2=fitcecoc([P,Q],respuesta1,'Prior','uniform');
claseSVM=predict(Mdl2,[u v]);%
% Hausdorff distance to the individuals of the data base
 for n=1:items
   D(n)=vectorized_MHD([u', v'],[U(:,n), V(:,n)]);%
 end
 %%%%%% Calculation of the Hausdorff distance to the centroids of the varieties
% % %  for n=1:itemsC
% % %    D(n)=vectorized_MHD([u', v'],[XC(n,:)',YC(n,:)']);%  
% % %  end
 %%%%%%%%%%%%%%%%%%
 [~,ih]=sort(D);%%% index Hausdorff distance to Varieties / Centroids
 [~,ic]=sort(dc);%%% index procrustes distance to Centroids
%%%%%%%%%%%%%%%%%%%%%% 
figure(dos)
text(1,100,ejemplar,'Color','k','Interpreter','none')
text(1,60,'Estimation','Color','g')
text(1,20,'SVM :','Color','k')
text(15,20,claseSVM,'Color','k','Interpreter','none')
text(1,30,'Fisher :','Color','r')
text(15,30,clase,'Color','r','Interpreter','none')
text(1,40,'Haussdorff :','Color','b')
text(15,40,respuesta1{ih(1)},'Color','b','Interpreter','none') %Hausdorff to Variedades
text(1,50,'Procrustes :','Color','m')
text(15,50,variedad(ic(1)),'Color','m','Interpreter','none') % Procrustes to centroides
%%%%%%%%%%%%%%%%
text(40,200,'D (Hausdorff,Items)','Color','b')
for k1=1:numvar % numvar varieties and numvar different centroids
text(30,200-8*k1,origen(ih(k1)),'Color','b','Interpreter','none')
end
for k2=1:numvar
text(60,200-8*k2,num2str(D(ih(k2))'),'Color','b')
end
%%%%%%%%%%%%% procrustes to the centroids of the varieties  (10)
text(75,200,'100*d (Procrustes,Centroids)','Color','m')
for k3=1:itemsC
text(75,200-8*k3,variedad(ic(k3)),'Color','m','Interpreter','none')
end
for k4=1:itemsC
text(100,200-8*k4,num2str(100*dc(ic(k4))'),'Color','m')
end
%%%%%%%% Similar examples Hausdorff
 text(40,90,'Affine Items','Color','b')
 text(90,90,'D(Hausdorff)','Color','b')
 for k1=1:numvar % numvar varieties and numvar different centroids
    text(40,85-7*k1,molar(ih(k1)),'Color','b','Interpreter','none')
 end
for k2=1:numvar
    text(95,85-7*k2,num2str(D(ih(k2))'),'Color','b')
end
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear U V X Y XC YC k itemsC u v respuesta2 
clear im D dh dp n clase respuesta1 molar
return