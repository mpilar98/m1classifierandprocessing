
% Función  menú general de  procesos biométricos sobre recortes y esquemas de allophaiomys o similares
% 18/01/2023. Modificado para no depender calculo maximos y minimos
% Mejora versión anterior. Menos artificios. Mas robustez
% 1.- Orientar imágenes OK
% 2.- Medir y calibrar OK
% 3.- Procesar y muestrear recortes OK
% 4.- Procesar y muestrear esquemas OK 
% 5.- Muestreo de carpetas con esquemas y recortes genéricos en imágenes tif,tiff,TIF
% 6.- Deben ser colocadas juntas en una misma carpeta las imágenes previamente
% calibradas , correspondientes a la misma especie o variedad que se estudia
% Esta versión se hace para  200 puntos en el semiperímetro. Ver div
% Desde el punto del ápice hasta el segmento que define indice "a" de VanderMeulen 
% caracterización carpetas esquemas 
% caracterización carpetas recortes 
function biometry_molar_semi()
%colocacion de las pantallas de datos
clear
close all
warning off all;
workroot=cd;
dirpath=cd;%%%
pantallasper
etapa=0;
div=200;% 100 puntos en semiperímetro superior, 100 en inferior
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while etapa<9
    etapa=menu('Biometrics with images: Preliminary processes',...
        '1.- Orient images',...
        '2.- Calibrate / Measure',...
        '3.- Processs Recorte',...
        '4.- Process Esquema ',...
        '5.- Characterize folder Esquemas ',...
        '6.- Characterize folder Recortes',...
        '7.- Manage reference file (Semiperidentales200.mat, Semicentroides200.mat)',...
        '8.- View file .mat / Crear fichero .tps',...
        '9.- Restart ',...
        '10.- Exit')
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
            % actúa sobre imágenes de recortes 
            % previamente deben haberse orientado. 
            % La resolución de la unidad métrica 1 mmm en tamaño 768x576
            % se usa como referencia para escalar otro tipo de imágenes
            try
                dirpath=Recorte(dirpath,div);
%                 etapa=0;
            catch
                cd(workroot)               
                continue
            end
        case 4
            % Esquemas actúa sobre imágenes individuales de esquemas
            % o dibujos como los de Isa
            % previamente orientadas y escaladas con respecto a los
            % recortes
            try
              dirpath=Esquema(dirpath,div);
%               etapa=0; 
            catch
                cd(workroot)
                continue
            end
        case 5
            % muestreos_esquemas actúa sobre la carpeta completa  
            % muestrea tanto esquemas como dibujos. El proceso es identico
            try
               muestreos_esquemas(div)
%                etapa=0;
            catch
                cd(workroot)                
                continue
            end
        case 6
            % actúa en proceso batch sobre las imágenes de recortes en una carpeta
            % previamente deben haberse orientado. Su tamaño se usa como
            % referencia para escalar otro tipo de imágenes
            try
            muestreos_recortes(div)
%             etapa=0;
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
% % %         case 8
            clear
            close all
% % %             workroot=cd;
            dirpath=cd;%%%
            pantallasper
            etapa=0;
            div=200;
workroot=cd;
workpath=workroot;
addpath(workpath);
%%% uiload  %%% sustituído por:
[fichero,pathname]=uigetfile('*.mat','Select file .mat :');
load([pathname fichero]);
%%%%
try
m=size(U,1);
minpix=size(U,2);
catch
    try
    m=size(X,1);
    minpix=size(X,2);
    U=X;
    V=Y;
    muestra='Variedades';
    catch
     m=size(XC,1);
    minpix=size(XC,2);
    U=XC;
    V=YC;
    muestra='Centroides'; 
    end    
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
             figure(cuatro) 
             clf(gcf)
               axis([1 100 1 200])
               axis off
               text(1,60,'Sample: ')
               text(10,60,char(muestra),'Interpreter','none')
               text(5,40,num2str(m));
               text(10,40,'items')
               text(1,20,'Variety:')
               text(10,20,variedad,'Interpreter','none')
               for q=1:m
                   text(45,200-6*q,int2str(q))
                text(50,200-6*q,molar(q),'Interpreter','none');
               end
               hold off
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              
            D=zeros(m);%n
            M=[V',-U'];
            for k=1:m %n
 [D(k),Z1(:,:,k)]=procrustes([M(:,1) M(:,m+1)],[M(:,k) M(:,m+k)],'Scaling',false);%ajuste a primer ejemplar
end
% Cálculo de los centroides escalados
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
         text(5,140,num2str(m));
         text(10,140,' items');
         text(3,130,'Adjustment estimate');
         text(3,120,'(with respect to the first sample)');
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
        plot(V(1,:)',-U(1,:)','k.');% + % plot de la primera instancia (modelo)
        % el signo negativo de U coloca los puntos sin invertir
        title('NO Scaled')
        hold on
for k=1:m %n
X1(:,k)=Z1(:,1,k);
X2(:,k)=Z1(:,2,k);
end
plot(X1,X2,'-')%%%pinta en diferentes colores
hold on
          plot(centro(:,1),centro(:,2),'ko');
%            hold on %%%
%          for kk=1:minpix
%             text(centro(kk,1,:)-5,centro(kk,2,:)-5,num2str(kk));%%% 
%          end
hold off %%%
%%%%%%%% A petición de Alfaro
 crear_tps(m,minpix,molar,fichero,U,V);
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
%             cd(workroot)
            etapa=99;
    end
end
 close all
return