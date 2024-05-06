function discriminamolares_SVM(U,V,muestra,filenames) 
% Hausdorff LDC  SVM 
% Release 5-01-2023
global uno dos tres cuatro
m=size(U,1);
minpix=size(U,2);
load('Semiperidentales200.mat','X','Y','origen','molar')
respuesta1=origen';
items=size(X,1);
Etiquetas=etiquetas(origen);
numvar=size(Etiquetas,2);
%%%%%%%%
load('Semicentroides200.mat','XC','YC','variedad')
respuesta2=variedad';
itemsC=size(XC,1);
%%%%%%%%%%%%%%%%%% 
figure(dos)
clf(gcf)
axis([1 600 1 600])
axis off
            text(100,600,' Hausdorff ( Affine item )','Color','r')
            text(240,600,'Fisher LDC  ','Color','b')
            text(370,600,' S V Machine ','Color','k')
            text(500,600,' Hausdorff ( Centroids )','Color','m')
            hold on
 %%%%%%%% Hausdorff
for j=1:m
    for k=1:items
        [~,Z(k,:,:)]=procrustes([U(j,:)',V(j,:)'],[X(k,:)',Y(k,:)'],'Scaling',true);
        P(k,:)=Z(k,:,1);
        Q(k,:)=Z(k,:,2);       
        DH(j,k)=vectorized_MHD([U(j,:)',V(j,:)'],[P(k,:)',Q(k,:)']); 
    end
    [dh,ih]=sort(DH,2);
    claseh{j}=respuesta1{ih(j,2)};%2
end
%%%%%%%%%%%%%%%%%%%%%%%%%  Fisher LDC 
for j=1:m
    for k=1:items
        %%%%%%%%%%%%%%%% Leave One Out
        if strcmp(string(molar(k)),string(filenames(j)))
            continue  % leave one out
        else
        [~,ZF(k,:,:)]=procrustes([U(j,:)',V(j,:)'],[X(k,:)',Y(k,:)'],'Scaling',true);
        F(k,:)=ZF(k,:,1);
        G(k,:)=ZF(k,:,2);
        end
    end
        Mdl=fitcdiscr([F,G],respuesta1,'discrimType','linear','Prior','uniform',...
            'ClassNames',Etiquetas);
        clasef(j)=predict(Mdl,[U(j,:),V(j,:)]); % Fisher discriminant. 
end  
%%%% SVM
for j=1:m
    for k=1:items
        %%%%%%%%%%%%%%%% Leave One Out
        if strcmp(string(molar(k)),string(filenames(j)))
            continue  % leave one out
        else
        [~,ZF(k,:,:)]=procrustes([U(j,:)',V(j,:)'],[X(k,:)',Y(k,:)'],'Scaling',true);
        F(k,:)=ZF(k,:,1); 
        G(k,:)=ZF(k,:,2);
        end
    end
        Mdl2=fitcecoc([F,G],respuesta1,'Prior','uniform');
        clasesvm(j)=predict(Mdl2,[U(j,:),V(j,:)]); % discriminante de Fisher. 
end
 %%%%%%%%%%%%%%%%%%%%%%%% 
                for kv=1:numvar
                    TV(kv)=sum(count(claseh,Etiquetas(kv)));
                    TVF(kv)=sum(count(clasef,Etiquetas(kv)));
                    TVSVM(kv)=sum(count(clasesvm,Etiquetas(kv)));
                end
                [~,Imax]=max(TV(1:numvar));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                text(2,1,'sample:','Color','b')
                text(60,1,muestra,'Interpreter','none')
                 text(400,1,num2str(m))
                text(420,1,'items')
                text(130,560,'Affinity : ','Color','r')
                text(170,560,'% ','Color','r')
                text(240,560,'Affinity : ','Color','b')
                text(280,560,'% ','Color','b')
                text(370,560,'Affinity : ','Color','k')
                text(410,560,'% ','Color','k')
                text(500,560,'Affinity : ','Color','m')
                text(600,560,'%','Color','m')
                for kk=1:numvar
                    text(20,550-25*kk,Etiquetas(kk),'Interpreter','none')
                    text(130,550-25*kk,num2str(TV(kk)))
                    text(170,550-25*kk,num2str(100*TV(kk)/m,3)) 
                    text(240,550-25*kk,num2str(TVF(kk)))
                    text(280,550-25*kk,num2str(100*TVF(kk)/m,3)) 
                    text(370,550-25*kk,num2str(TVSVM(kk)))
                    text(410,550-25*kk,num2str(100*TVSVM(kk)/m,3)) 
                end
                hold on  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear TV TVF
clear clase P Q Z ZF F G Imax
%%%%%%  Hausdorff distance to Centroids
for j=1:m
    for k=1:itemsC   
        [~,Z(k,:,:)]=procrustes([U(j,:)',V(j,:)'],[XC(k,:)',YC(k,:)'],'Scaling',false);
        P(k,:)=Z(k,:,1);
        Q(k,:)=Z(k,:,2);       
        DHC(j,k)=vectorized_MHD([U(j,:)',V(j,:)'],[P(k,:)',Q(k,:)']); 
    end
    %%%%%%%%%%
[~,ihc]=sort(DHC,2);
 clasec{j}=respuesta2{ihc(j,1)};
end
 %%%%%%%%%%%%%%%%%%%%%%%% 
                for kc=1:numvar
                    TC(kc)=sum(count(clasec,Etiquetas(kc)));
                end
                [~,Imax]=max(TC(1:numvar));
%%%%%%%%%%%%%% 
                for kk=1:numvar
                    text(500,550-25*kk,Etiquetas(kk),'Interpreter','none')
                    text(580,550-25*kk,num2str(TC(kk)))
                    text(600,550-25*kk,num2str(100*TC(kk)/m,3))    
                end
                %
                hold off  
%%%%%  
%%%  procrustes distance to centroids calculation
workroot=cd;
workpath=workroot;
addpath(workpath);
%%%%%% 
            DC=zeros(m);
            M=[V',-U'];
for k=1:m 
 [~,Z1(:,:,k)]=procrustes([M(:,1) M(:,m+1)],[M(:,k) M(:,m+k)],'Scaling',false);
 [DC(k),~]=procrustes([XC(Imax,:)' -YC(Imax,:)'],[M(:,k) M(:,m+k)],'Scaling',false);
end
% 
for kk=1:minpix
centro(kk,1)=mean(Z1(kk,1,:));
centro(kk,2)=mean(Z1(kk,2,:));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure(cuatro)
            clf(gcf)
            axis([1 50 1 150])
            axis off 
         text(1,150,'sample: ','Color','r');
         text(10,150,muestra,'Interpreter','none');
         text(1,140,'Items analized','Color','r');
          text(20,140,'Affine items','Color','b');
          text(40,140,'Hausdorff distance');
         for q=1:m %n
             text(1,135-6*q,char(filenames(q)),'Interpreter','none')
              text(20,135-6*q,char(molar(ih(q,2))),'Interpreter','none')
              text(40,135-6*q,num2str(dh(q,2)))
         end
         %%%%%%%%%%%%%%%%%%%%%%%%
         figure(uno)
         clf
         axis image 
        plot(V(1,:)',-U(1,:)','gx');% plotting template
        title('Procrustes superposition')
        hold on
for k=1:m %n
X1(:,k)=Z1(:,1,k);
X2(:,k)=Z1(:,2,k);
end
plot(X1,X2,'-')
hold on
plot(centro(:,1),centro(:,2),'ko');
hold off 
%%%%%%%%%%%%%%%%%%%%%%%%%%% cladogram
DD = pdist2([XC YC],[XC YC],'squaredeuclidean');
tree = linkage(DD,'average');
% tree = linkage(DD,'centroid');% less accurate
leafOrder = optimalleaforder(tree,DD);
figure(tres)
clf(gcf)
H=dendrogram(tree,'reorder',leafOrder,'Labels',Etiquetas,'ColorThreshold','default');
title(' Philomorphometric relations (Centroids / Average / pdist2 square euclidean)')
set(H,'LineWidth',2,'TickLabelInterpreter','none')
hold off
end

