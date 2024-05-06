% Called from biometry_molar_semi(), analisys_molar_semi()
% Release 5-01-2023 
function discriminamolar(u,v,ejemplar)
global dos cuatro
load('Semiperidentales200.mat','X','Y','origen','molar')
load('Semicentroides200.mat','XC','YC','variedad')
respuesta1=origen';
items=size(X,1);
div=size(X,2);
Etiquetas=etiquetas(origen);
numvar=size(Etiquetas,2);
%%%%%%%%%%%%%%%%%% item LOO 
for k=1:items
        if strcmp(char(molar(k)),char(ejemplar))
           continue  % leave one out
        else
        [~,Z(k,:,:)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',true);
         %%%%% 
           P(k,:)=Z(k,:,1);
           Q(k,:)=Z(k,:,2);
        end
end 
%%%%%%%%%%%%%%%%%% without LOO ( Hausdorff distance )
for k=1:items
    [~,Z1(:,:,k)]=procrustes([u',v'],[X(k,:)',Y(k,:)'],'Scaling',true);% true
    U(:,k)=Z1(:,1,k);
    V(:,k)=Z1(:,2,k);
end
%%%%%%% 
itemsC=size(XC,1);
for kc=1:itemsC
[dc(kc),Z2(k,:,:)]=procrustes([u',v'],[XC(kc,:)',YC(kc,:)'],'Scaling',false);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mdl=fitcdiscr([P,Q],respuesta1,'discrimType','linear','Prior','uniform',...
    'ClassNames',Etiquetas);
clase=predict(Mdl,[u v]); %  Fisher LDC
% Hausdorff distance to database items 
 for n=1:items
   D(n)=vectorized_MHD([u', v'],[U(:,n), V(:,n)]);%
 end
 [~,ih]=sort(D);%%% indexing  Hausdorff distances 
 [~,ic]=sort(dc);%%% indexing  Procrustes  distances to  Centroides
%%%%%%%%%%%%%%%%%%%%%% 
figure(dos)
text(1,100,ejemplar,'Color','k','Interpreter','none')
text(10,50,'Estimates','Color','g')
text(10,20,'Fisher :','Color','r')
text(20,20,clase,'Color','r','Interpreter','none')
text(10,30,'Haussdorff :','Color','b')
text(20,30,respuesta1{ih(1)},'Color','b','Interpreter','none') %Hausdorff 
text(10,40,'Procrustes :','Color','m')
text(20,40,variedad(ic(1)),'Color','m','Interpreter','none') % Procrustes
%%%%%%%%%%%%%%%%
text(40,200,'D (Hausdorff,Species)','Color','b')
for k1=1:numvar 
text(40,200-8*k1,origen(ih(k1)),'Color','b','Interpreter','none')
end
for k2=1:numvar
text(60,200-8*k2,num2str(D(ih(k2))'),'Color','b')
end
%%%%%%%%%%%%% 
text(75,200,'100*d (Procrustes,Centroids)','Color','m')
for k3=1:itemsC
text(75,200-8*k3,variedad(ic(k3)),'Color','m','Interpreter','none')
end
for k4=1:itemsC
text(100,200-8*k4,num2str(100*dc(ic(k4))'),'Color','m')
end
% % % hold off
%%%%%%%% Related species Hausdorfff
% % % figure(cuatro)
% % % clf(gcf)
% % % axis([1 100 1 200])
% % % axis off
 text(40,90,'Affine items ','Color','k')
 text(80,90,'D(Hausdorff)')
 for k1=1:numvar % numvar varieties and numvar distinct centroids
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