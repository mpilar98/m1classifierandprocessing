% Recorte.m procesamiento de recortes de imágenes de molares
% version 23/03/2022 para 200 puntos muestreo semiperimetral
% llamado desde analysis_molar_semiH
function dirpath=Recorte(dirpath,div)
global uno dos tres cuatro
     workroot=cd;
     factor=240;
            try
             cd(dirpath)
            [fichero,dirpath]=uigetfile({'*.bmp;*.tif;*.tiff;*.prn;*.TIF'},'Select Recorte (already calibrated)'); 
                 imagen=imread([dirpath,fichero]);% lectura de imagen multiformato
                 dim1=size(imagen);
                 dim2=size(dim1);
                if dim2(2)>=3
                    imagen=imagen(:,:,2);% canal verde
                else
                end
                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 figure(tres)
                  clf(gcf)
                  imshow(imagen)
                 hold on
            catch
                figure(uno)
                clf(gcf)
                title('Loading image')
                axis([0 10 -5 0])
                text(2.5,-2.0,'NOT A VALID IMAGE ')
                text(5.0, -4.0,'Try again')
                hold off
                return
            end
            %%%%%%%%%%%%%% 
                cd(workroot)
               Imagen = delineartif(imcomplement(imagen),0.1);
                [r,c]=size(Imagen);
                figure(cuatro)
                clf(gcf)
                imshow(Imagen);
                axis([1 c 1 r])
                hold on
                %%%%%%%%%%%%%%
                Imagenbis=imfill(Imagen,'holes');
                F=find(Imagenbis);
                [row, col]=ind2sub([r c],F(1));
                contour = bwtraceboundary(Imagenbis, [row, col],'W' ,8,Inf,'clockwise');
                puntos=size(contour,1);
%%%%%%%%%%%% definido el contorno perimetral y calculado el numero total de
%%%%%%%%%%%% puntos perimetrales.
%%%%%%% Cálculo de los semiperímetrosanteriores contour_up, contour_down
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
ofset=floor((x3-x4)/2);%  1/3 - 1/4 /2
%%%%%%%%%%%%%% 
%%%%%%%% Buscar  máximos locales en semiperimetro superior
TF1max = islocalmin(U(1:ind),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs2=find(TF1max);
plot(V,U,V(TF1max),U(TF1max),'b*')
nmax1=sum(TF1max);% numero de maximos en perimetro superior
%%%%%%%% Buscar y pintar mínimos locales en semiperimetro inferior
TF2min=islocalmax(U(ind:puntos),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs4=find(TF2min);
nmin2=sum(TF2min);
%%%% Segmento S3 entre T4 y T3 
S3=[V(locs2(nmax1-3):locs2(nmax1-2))', U(locs2(nmax1-3):locs2(nmax1-2))'];
plot(V(locs2(nmax1-3):locs2(nmax1-2)),U(locs2(nmax1-3):locs2(nmax1-2)),'y.')
%%%% Segmento S2 entre b2 y b3
S2=[V(ind+locs4(2):ind+locs4(3))',U(ind+locs4(2):ind+locs4(3))'];
plot(V(ind+locs4(2):ind+locs4(3)),U(ind+locs4(2):ind+locs4(3)),'y.')
%%%%%%%%%%%%%%%% calcular a con mi algoritmo
[~,P4,Q4]=mindist(S3,S2);%
line([V(P4+locs2(nmax1-3)) V(Q4+ind+locs4(2))],[U(P4+locs2(nmax1-3)) U(Q4+ind+locs4(2))],'Color','y')
%%%%%%%% Segmento a
a=norm([x1,y1]-[V(P4+locs2(nmax1-3)),U(P4+locs2(nmax1-3))])/factor;
line([V(P4+locs2(nmax1-3)) x1],[U(P4+locs2(nmax1-3)) y1],'LineStyle','--','Color','r')
text(0.7*(V(P4+locs2(nmax1-3))),U(P4+locs2(nmax1-3))-10,'a','Color','r')
%%%%%%%% definicion semiperimetros
%%% Contornos entre el ápice y puntos segmento "a"
contour_up=[V(1:P4+locs2(nmax1-3))',U(1:P4+locs2(nmax1-3))'];
contour_down=[V(Q4+ind+locs4(2):end)',U(Q4+ind+locs4(2):end)'];
%%%%%%%%%% calculo puntos con algoritmo de diezmado
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
%%%%%%%%%%%
%%%%%%%%%%% Estimación variedad
discriminamolar(U,V,fichero);
%%%%%%%%%%%%% Estimación indices de Van der Meulen
Indices=vdmindicesB(Imagen,Imagenbis,contour,r,c,puntos,fichero); 
%         display(Indices)
%         disp('      L         W          e         d         b         c         a         La        Li')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
