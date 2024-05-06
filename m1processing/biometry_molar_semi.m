%
% Main function for biometric processes on Occlusal surfaces and Drawings of m1 micromammals molars
% 18/04/2024 release
% Works on  tif,tiff,TIF pictures previously calibrated and assembled in a file related with the species under analisys 
function biometry_molar_semi()
clear
close all
warning off all;
workroot=cd;
dirpath=cd;
pantallasper
etapa=0;
div=200;% sampling points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while etapa<9
    etapa=menu('Biometry on pictures: Previous processes',...
        '1.- Orient images',...
        '2.- Calibrate / Measure',...
        '3.- Process Occlusal surface',...
        '4.- Process Drawing',...
        '5.- Drawings file characterization ',...
        '6.- Occlusal surfaces file characterization',...
        '7.- Manage reference data files (Semiperidentales200.mat,Semicentroides200.mat)',...
        '8.- Show .mat file / Build .tps file',...
        '9.- Reboot ',...
        '10.- Exit'); 
    switch etapa
        case 1
            try
               Orientar_molar;
            catch
                continue
            end
            cd(workroot)
        case 2
            try
                [dirpath,div]=microMolar(dirpath);
            catch
                cd(workroot)
                continue
            end
            cd(workroot)
        case 3
            try
                dirpath=Recorte(dirpath,div);
            catch
                cd(workroot)               
                continue
            end
        case 4
            try
              dirpath=Esquema(dirpath,div); 
            catch
                cd(workroot)
                continue
            end
        case 5
            try
               muestreos_esquemas(div)
            catch
                cd(workroot)                
                continue
            end
        case 6
            try
                muestreos_recortes(div)
            catch
                cd(workroot)               
                continue
            end
        case 7
            try
                variedades_semi200(div)
            catch
                cd(workroot)
                continue
            end
        case 8
% % %             clear
% % %             close all
% % %             dirpath=cd;
% % %             pantallasper
% % %             etapa=0;
% % %             div=200;
% % % workroot=cd;
% % % workpath=workroot;
% % % addpath(workpath);
[fichero,pathname]=uigetfile('*.mat','Choose .mat file:');
load([pathname fichero]);
try
m=size(U,1);
minpix=size(U,2);
catch
    try
    m=size(X,1);
    minpix=size(X,2);
    U=X;
    V=Y;
    muestra=fichero;
    especie=origen;%%%
    catch
     m=size(XC,1);
    minpix=size(XC,2);
    U=XC;
    V=YC;
    muestra='Centroids'; 
    especie=variedad;
    end    
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
             figure(cuatro) 
             clf(gcf)
               axis([1 100 1 200])
               axis off
               text(1,60,'Sample: ')
               text(1,50,char(muestra),'Interpreter','none')
               text(1,40,num2str(m));
               text(4,40,'items')
               text(1,20,'Species:')
               try
                text(10,20,especie,'Interpreter','none')
               catch
                 text(10,20,char(variedad),'Interpreter','none')
               end
               try
                   for q=1:m
                    text(45,200-6*q,int2str(q))
                    text(50,200-6*q,molar(q),'Interpreter','none');
                   end
               catch
                   for q=1:m
                    text(45,200-6*q,int2str(q))
                    text(50,200-6*q,especie(q),'Interpreter','none');
                   end
               end
               hold off
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              
            D=zeros(m);
            M=[V',-U'];
            for k=1:m 
 [D(k),Z1(:,:,k)]=procrustes([M(:,1) M(:,m+1)],[M(:,k) M(:,m+k)],'Scaling',false);
end
% Centroids calculation
for kk=1:minpix
centro(kk,1)=mean(Z1(kk,1,:));
centro(kk,2)=mean(Z1(kk,2,:));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
             figure(tres)
            clf(gcf)
             axis([1 100 1 200])
         text(3,150,'Sample: ');
         text(12,150,muestra,'Interpreter','none');
         text(3,140,num2str(m));
         text(6,140,' items');
         text(3,130,'Adjustment  estimation');
         text(3,120,'(respect to the first database item)');
        text(50,200,'item '); 
        text(55,200,'100*d'); 
         for q=2:m 
            text(50,200-6*q,int2str(q));
            text(55,200-6*q,num2str(100*D(q,1),2));
         end
         axis off 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%       
         figure(uno)
         clf(gcf)
         axis image 
        plot(V(1,:)',-U(1,:)','k.');%  % plot first item (template)
        title('NOT scaled')
        hold on
for k=1:m 
X1(:,k)=Z1(:,1,k);
X2(:,k)=Z1(:,2,k);
end
plot(X1,X2,'-')
hold on
          plot(centro(:,1),centro(:,2),'ko');
hold off 
%%%%%%%% building tps file
try
    crear_tps(m,minpix,molar,fichero,U,V);
catch
    crear_tps(m,minpix,variedad,fichero,U,V);
end
%%%%%%%%
        case 9
            clear
            close all
            workroot=cd;
            dirpath=cd;
            pantallasper
            etapa=0;
            div=200;
%%%%%%%%%%
        case 10
            etapa=99;
    end
end
 close all
return