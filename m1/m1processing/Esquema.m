%Esquema.m procesamiento de esquemas
% Version 18-01-2023 para div puntos semiperímetro
% % llamado desde analysis_molar_semiH
function dirpath=Esquema(dirpath,div)
global uno dos tres 
     workroot=cd;
     factor=240;
            try
             cd(dirpath)
            [fichero,dirpath]=uigetfile({'*.bmp;*.tif;*.tiff;*.prn;*.TIF'},'Select Esquema (already calibrated)'); 
                 imagen=imread([dirpath,fichero]);% lectura de imagen multiformato
                  dim1=size(imagen);
                 dim2=size(dim1);
                if dim2(2)>=3
                    imagen=imagen(:,:,2);% canal verde
                else
                end
                 %%%%%%%%%%%%%%%%%%%%%%%%%%%
                 figure(tres) 
                  clf(gcf)
                  imshow(imagen)
                 hold on
            catch
                figure(tres)
                clf(gcf)
                title('Loading image')
                axis([0 10 -5 0])
                text(2.5,-2.0,'NOT A VALID IMAGE ')
                text(5.0, -4.0,'Try again')
                hold off
                return
            end
                cd(workroot)
                I0=imsharpen(imgaussfilt(imagen,2),'Radius',2,'Amount',3);
                Imagen0=EstilizarEsquemas(I0);
                 [r,c]=size(Imagen0);        
            %%%%%%%%%%%%%%%%%%%%%%%%%%%Proceso esquema
             try
                imagen=areas(Imagen0);
                BW7bis=imfill(imagen,'holes'); 
                BW8 = bwmorph(BW7bis,'bridge');
                %%%%%%%% cálculo de regiones obtenidas
                [~,NUM] = bwlabel(BW8,8);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Imagen=255*median_filt(bwperim(BW8,8),1,1);
                figure(uno) 
                clf(gcf)
                imshow(Imagen);
                axis([1 c 1 r])
                hold on
 % Comienza muestreo perimetral
                Imagenbis=imfill(BW8,'holes');
                F=find(Imagenbis);
                [row, col]=ind2sub([r c],F(1));
                contour = bwtraceboundary(Imagenbis, [row, col],'W' ,8,Inf,'clockwise');
                puntos=size(contour,1);
% % % definido el contorno perimetral y calculado el número total de puntos perimetrales
% % % Cálculo de los semiperímetros
[~, xd]=ind2sub([r c],F(end));
 y1=row;
 x1=col;
 %%%%%%%%%%%%%%%%%%%contorno sin diezmar%%%%%%%%%%%
contoury=contour(:,2);
contourx=contour(:,1);
pix=size(contourx,1);
U(1:pix)=contourx(1:end);
V(1:pix)=contoury(1:end);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,indd]=find(V==xd);% indice del extremo derecho
ind=floor(mean(indd));
%%%%%%%%%%  Calculo del centroide del perimetro dental 
y2= floor(mean(contourx)); % localización centroide imagen
x2= floor(mean(contoury));
%%%%%%%%%% Calculando ofset
%%% buscando partes de la imagen 
x4= floor((x2+x1)/2);% x 1/4
x3=floor((2*x2+x1)/3);% x 1/3
%%%% nuevo calculo para ofset
ofset=floor((x3-x4)/(5/2));%
%%%%%% contornos para calcular el corte central
stoparriba=find(contoury>=x2);% indice del extremo derecho% centralcontour=contour(contourx<=y2,contoury<=x2)
contornoxa=contourx(1:stoparriba(1),:);
contornoya=contoury(1:stoparriba(1),:);
arriba=[contornoya,contornoxa];
%%%%%%stopabajo: encontrando primer minimo local despues de centroide
stopabajo=find(contoury(ind:puntos)<=x2);
stopmin=islocalmax(U(ind+stopabajo(1):puntos),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locsmin=find(stopmin);
% plot(V(ind+stopabajo(1)+locsmin(1)),U(ind+stopabajo(1)+locsmin(1)),'m^')%%%minimo siguiente a x2 centroide
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% calculo para el contorno abajo 
contornoxb=contourx(ind:ind+stopabajo(1)+locsmin(1),:);
contornoyb=contoury(ind:ind+stopabajo(1)+locsmin(1),:);
abajo=[contornoyb,contornoxb];
%%%%%%%%%%%%%%%%%%calculo punto de corte
[~,P4,Q4]=mindist(arriba,abajo);%
% % % [~,P5,Q5]=mindist(abajo,arriba);% es lo mismo que P4,Q4
plot(V(1:P4),U(1:P4),'ro')% ok para 1:P4, semiperimetro superior
% % % plot(V(P5+ind),U(P5+ind),'r+')%ok
% % % plot(V(Q4+ind),U(Q4+ind),'r+')%ok
line([V(P4) V(Q4+ind)],[U(P4) U(Q4+ind)],'Color','y') %%% ok
%%%%%%%%%%% definicion contorno semiperímetros
plot(V(Q4+ind:puntos),U(Q4+ind:puntos),'ro') % semiperimetro inferior
contour_up=[V(1:P4)',U(1:P4)'];
contour_down=[V(Q4+ind:puntos)',U(Q4+ind:puntos)'];
%%%%%%%%%% calculo con algoritmo de diezmado
semicontourupy=diezmar(contour_up(:,2),div/2);
semicontourupx=diezmar(contour_up(:,1),div/2);
semicontourdowny=diezmar(contour_down(:,2),div/2);
semicontourdownx=diezmar(contour_down(:,1),div/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pixup=size(semicontourupx,1);
pixdown=size(semicontourdownx,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xup(1:pixup)=semicontourupx(1:pixup);
Yup(1:pixup)=semicontourupy(1:pixup);
Xdown(1:pixdown)=semicontourdownx(1:pixdown);
Ydown(1:pixdown)=semicontourdowny(1:pixdown);
% puntos totales
nuevospuntos=2*size(semicontourupx,1);
%%%%%%%%%%%%%%%%%%
figure(dos)
 clf(gcf)
 axis([1 100 1 200])
 axis off
text(1,195,'points ')
text(1,180,num2str(puntos))
text(10,195,'new points ')
text(10,180,num2str(nuevospuntos))
hold on
% % % % 
clear U V
V=[Xup,Xdown];
U=[Yup,Ydown];
                figure(uno)
                clf(gcf)
                imshow(Imagen)
                hold on
                if(~isempty(contour))
      %%%%%%%%%%%%%%%%% Estimación variedad
                    discriminamolar(U,V,fichero);
      %%%%%%%%%%%%%%%%%%
                else
                    plot(col, row,'r+','LineWidth',2);
                end
                hold off
      %%%%%%%%%%%%%%%%
                 if NUM>2
                     figure(uno)
                     clf(gcf)
                     axis([0 10 -5 0])
                    text(2.5,-2.0,'Image not recognized :')
                    text(6,-2.0,fichero,'Interpreter','none')
                    text(5.0, -4.0,'Redraw or discard')
                    hold off
                 end
              catch
                cd(workroot)
             end
 %%%%%%%%%%%%% Estimación indices de Van der Meulen 
        Indices=vdmindicesB(Imagen,Imagenbis,contour,r,c,puntos,fichero);
% % %         display(Indices)
% % %         disp('      L         W          e         d         b         c         a         La        Li')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
