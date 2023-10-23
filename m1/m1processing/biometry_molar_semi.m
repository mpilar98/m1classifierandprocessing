
% Función  menú general de  procesos biométricos sobre recortes y esquemas de allophaiomys o similares
% 18/01/2023. Mpdificado para no depender del calculo de maximos y minimos perimetrales
% Mejora versión anterior. Menos artificios. Mas robustez
% 1.- Orienta imágenes 
% 2.- Mide y calibra
% 3.- Procesa y muestrear recortes 
% 4.- Procesa y muestrear esquemas 
% 5.- Muestreo automático de carpetas con esquemas y recortes genéricos en imágenes tif,tiff,TIF
% 6.- Deben ser colocadas juntas en una misma carpeta las imágenes previamente
% calibradas , correspondientes a la misma especie o variedad que se estudia
% Esta versión se hace para  200 puntos en el semiperímetro. Ver div
% Desde el punto del ápice hasta el segmento que define indice "a" de VanderMeulen 
% caracteriza carpetas esquemas 
% caracteriza carpetas recortes 
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
    etapa=menu('Biometría con imágenes: Procesos previos',...
        '1.- Orientar las imágenes',...
        '2.- Calibrar / Medir',...
        '3.- Procesar Recorte',...
        '4.- Procesar Esquema ',...
        '5.- Caracterizar carpeta Esquemas ',...
        '6.- Caracterizar carpeta Recortes',...
        '7.- Gestionar fichero referentes (Semiperidentales200.mat,Semicentroides200.mat)',...
        '8.- Ver fichero .mat / Crear fichero .tps',...
        '9,. Reinicializar ',...
        '10.- Salir'); 
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
            catch
                cd(workroot)               
                continue
            end
        case 4
            % Esquemas actúa sobre imágenes individuales de esquemas o dibujos 
            % previamente orientadas y escaladas con respecto a los recortes
            try
              dirpath=Esquema(dirpath,div);
            catch
                cd(workroot)
                continue
            end
        case 5
            % muestreos_esquemas actúa sobre la carpeta completa  
            % muestrea tanto esquemas como dibujos. El proceso es idéntico
            try
               muestreos_esquemas(div)
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
            clear
            close all
            dirpath=cd;%%%
            pantallasper
            etapa=0;
            div=200;
workroot=cd;
workpath=workroot;
addpath(workpath);
%%% uiload  %%% sustituído por:
[fichero,pathname]=uigetfile('*.mat','Selecciona el fichero .mat :');
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
               text(1,60,'Muestra: ')
               text(10,60,char(muestra),'Interpreter','none')
               text(5,40,num2str(m));
               text(10,40,'items')
               text(1,20,'Variedad:')
               text(10,20,variedad,'Interpreter','none')
               for q=1:m
                   text(45,200-6*q,int2str(q))
                text(50,200-6*q,molar(q),'Interpreter','none');
               end
               hold off
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              
            D=zeros(m);
            M=[V',-U'];
            for k=1:m 
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
         text(3,150,'Muestra: ');
         text(12,150,muestra,'Interpreter','none');
         text(5,140,num2str(m));
         text(10,140,' items');
         text(3,130,'Estimación del ajuste');
         text(3,120,'(respecto al primer ejemplar)');
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
        title('NO Escalado')
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
            etapa=99;
    end
end
 close all
return