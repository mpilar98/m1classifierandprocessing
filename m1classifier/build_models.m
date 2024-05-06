function [Mdl,Mdl2]=build_models(muestra,filenames)
% build the models for the LDC discrimination and SVM
load('Semiperidentales200.mat','X','Y','origen','molar')
respuesta1=origen';
items=size(X,1);
Etiquetas=etiquetas(origen);
numvar=size(Etiquetas,2);
%%%%%%%%
load('Semicentroides200.mat','XC','YC','variedad')
respuesta2=variedad';
itemsC=size(XC,1);
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
            'ClassNames',Etiquetas);% LDC
   %%%%%%%%%
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
        Mdl2=fitcecoc([F,G],respuesta1,'Prior','uniform'); % SVM
end
        