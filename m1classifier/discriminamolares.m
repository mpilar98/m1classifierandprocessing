function discriminamolares(U,V,muestra,filenames) 
% uses Hausdorff distance as a discriminant of varieties
% Cladograms on centroids of varieties
% called from estimar_esquemasH or estimar_recortesH
% version 5-01-2023
global uno dos tres cuatro
m=size(U,1);
minpix=size(U,2);
load('Semiperidentales200.mat','X','Y','origen','molar')
respuesta1=origen';
items=size(X,1);
Etiquetas=etiquetas(origen);
numvar=size(Etiquetas,2);% number of diferen varieties
%%%%%%%% To the Centroids
load('Semicentroides200.mat','XC','YC','variedad')
respuesta2=variedad';
itemsC=size(XC,1);
%%%%%%%%%%%%%%%%%% Preparando ventana salida info
figure(dos)
clf(gcf)
axis([1 600 1 600])
axis off
            text(20,600,' Hausdorff ( Ejemplar afín )','Color','r')
            text(250,600,'Fisher LDC  ','Color','b')
            text(500,600,' Hausdorff ( Centroides )','Color','m')
            hold on
 %%%%%%%%doble bucle para Hausdorff
for j=1:m
    for k=1:items
        [~,Z(k,:,:)]=procrustes([U(j,:)',V(j,:)'],[X(k,:)',Y(k,:)'],'Scaling',true);% true !!!
        %%%%% noew coordinates of the varieties, in line with the first one:
        P(k,:)=Z(k,:,1);
        Q(k,:)=Z(k,:,2);       
        DH(j,k)=vectorized_MHD([U(j,:)',V(j,:)'],[P(k,:)',Q(k,:)']); %
%         DH(j,k)=vectorized_MHD([U(j,:),V(j,:)],[P(k,:),Q(k,:)]); %?
    end
    [dh,ih]=sort(DH,2);
    claseh{j}=respuesta1{ih(j,2)};%2
end
%%%%%%
%%% index Hausdorff distances to Varieties 
%%%%%%%% end double loop Hausdorff
%%%%%%%%%%%%%%%%%%%%%%%%% elthe double loop Fisher LDC %%%%%%%%%% added in setting
for j=1:m
    for k=1:items
        %%%%%%%%%%%%%%%% Leave One Out
        if strcmp(string(molar(k)),string(filenames(j)))
% % %             text(425,600,'Fisher LDC ( L O O )','Color','b')
% % %             hold on
            continue  % leave one out
        else
        [~,ZF(k,:,:)]=procrustes([U(j,:)',V(j,:)'],[X(k,:)',Y(k,:)'],'Scaling',true);
        %%%%% new coordinates of the varieties:
        F(k,:)=ZF(k,:,1);
        G(k,:)=ZF(k,:,2);
        end
    end
        Mdl=fitcdiscr([F,G],respuesta1,'discrimType','linear','Prior','uniform',...
            'ClassNames',Etiquetas);
        clasef(j)=predict(Mdl,[U(j,:),V(j,:)]); % Fisher discriminant. 
        hold on
end  % already done,OK m x 1 cell of chars
%%%%%%%%%%%%%%%%%%%% Totals and Summaries for variety %%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%% Totales por variedad
                for kv=1:numvar
                    TV(kv)=sum(count(claseh,Etiquetas(kv)));
                    TVF(kv)=sum(count(clasef,Etiquetas(kv)));
                end
                [~,Imax]=max(TV(1:numvar));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                text(2,1,'Muestra:','Color','b')
                text(60,1,muestra,'Interpreter','none')
                 text(400,1,num2str(m))
                text(420,1,'items')
                text(20,560,'Afinidad : ','Color','r')
                text(170,560,'% ','Color','r')
                text(250,560,'Afinidad : ','Color','b')%%%
                text(400,560,'% ','Color','b')%%%
                text(500,560,'Afinidad : ','Color','m')%%%
                text(600,560,'%','Color','m')
                for kk=1:numvar
                    text(20,550-25*kk,Etiquetas(kk),'Interpreter','none')
                    text(130,550-25*kk,num2str(TV(kk)))
                    text(170,550-25*kk,num2str(100*TV(kk)/m,3)) 
                    text(250,550-25*kk,Etiquetas(kk),'Interpreter','none') %%%
                    text(360,550-25*kk,num2str(TVF(kk)))%%%
                    text(400,550-25*kk,num2str(100*TVF(kk)/m,3)) %%%
                end
                hold on  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% End summaries %%%%%
clear TV TVF
clear clase P Q Z ZF F G Imax
%%%%%% duble loop for Hausdorff to the Centroids
for j=1:m
    for k=1:itemsC
        %%%%%%%%%%%%%%%% Leave One Out not needed      
        [~,Z(k,:,:)]=procrustes([U(j,:)',V(j,:)'],[XC(k,:)',YC(k,:)'],'Scaling',false);% 
        %%%%% new coordiantes of the varieties, adjusted to the first one:
        P(k,:)=Z(k,:,1);
        Q(k,:)=Z(k,:,2);       
        DHC(j,k)=vectorized_MHD([U(j,:)',V(j,:)'],[P(k,:)',Q(k,:)']); %
    end
    %%%%%%%%%%
    %%%%%%%%%
[~,ihc]=sort(DHC,2);
 clasec{j}=respuesta2{ihc(j,1)};%2
end
%%%%%%%%% end double loop. Vareity estimation
 %%%%%%%%%%%%%%%%%%%%%%%% Totals for variety
                for kc=1:numvar
                    TC(kc)=sum(count(clasec,Etiquetas(kc)));
                end
                [~,Imax]=max(TC(1:numvar));
%%%%%%%%%%%%%% Totals and %
                for kk=1:numvar
                    text(500,550-25*kk,Etiquetas(kk),'Interpreter','none')
                    text(580,550-25*kk,num2str(TC(kk)))
                    text(600,550-25*kk,num2str(100*TC(kk)/m,3))    
                end
                %
                hold off  
%%%%% End estimation of Hausdorff distance to Centroids   
%%% procrustes calculation
workroot=cd;
workpath=workroot;
addpath(workpath);
%%%%%% procrustes distance to the centroids of the varieties
            DC=zeros(m);%
            M=[V',-U'];
for k=1:m 
 [~,Z1(:,:,k)]=procrustes([M(:,1) M(:,m+1)],[M(:,k) M(:,m+k)],'Scaling',false);%distance to the first individual
 [DC(k),~]=procrustes([XC(Imax,:)' -YC(Imax,:)'],[M(:,k) M(:,m+k)],'Scaling',false);%distance to a similar a centroid
end
% centroid calculation
for kk=1:minpix
centro(kk,1)=mean(Z1(kk,1,:));
centro(kk,2)=mean(Z1(kk,2,:));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure(cuatro)
            clf(gcf)
            axis([1 50 1 150])
            axis off 
         text(1,150,'Muestra: ','Color','r');
         text(10,150,muestra,'Interpreter','none');
         text(1,140,'Ejemplares estudiados','Color','r');
          text(20,140,'Ejemplares similares','Color','b');
          text(40,140,'Distancia Hausdorff');
         for q=1:m %n
             text(1,135-6*q,char(filenames(q)),'Interpreter','none')
              text(20,135-6*q,char(molar(ih(q,2))),'Interpreter','none')
              text(40,135-6*q,num2str(dh(q,2)))
         end
         %%%%%%%%%%%%%%%%%%%%%%%%
         figure(uno)
         clf
         axis image 
        plot(V(1,:)',-U(1,:)','gx');% + % plot of the first instance (model)
        % the negative sing of U place the dots without inverting
        title('Ajuste procrustes')
        hold on
for k=1:m %n
X1(:,k)=Z1(:,1,k);
X2(:,k)=Z1(:,2,k);
end
plot(X1,X2,'-')%%%paint in different colours
hold on
plot(centro(:,1),centro(:,2),'ko');
hold off %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%cladogram
% DD = pdist([XC YC],'squaredeuclidean');
DD = pdist2([XC YC],[XC YC],'squaredeuclidean');
tree = linkage(DD,'average');
% tree = linkage(DD,'centroid');%
leafOrder = optimalleaforder(tree,DD);
figure(tres)
clf(gcf)
H=dendrogram(tree,'reorder',leafOrder,'Labels',Etiquetas,'ColorThreshold','default');
title('Relaciones filomorfométricas (Centroides / Average / pdist2 square euclidean)')
set(H,'LineWidth',2,'TickLabelInterpreter','none')
hold off
end

