function estimar_esquemasH(div)
% version 24/10/2022  Trabaja sobre semiperímetros
% llamado desde analysis_molar_semiH
 global uno dos tres cuatro
 workroot=cd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
Muestra=uigetdir('Select the folder with the Esquemas to classify');
            if char(Muestra)==' '
                return
            else
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            muestra=strcat(Muestra,'/');
            dirOutput=dir(fullfile(Muestra));
            fileNames={dirOutput.name}';
            m=size(fileNames,1);% todas las imagenes de la carpeta
         k=1;
                for j=1:m
                    muela=char(fileNames(j));
                    if or(muela(1)=='.',muela(1)=='..')
                        continue
                    else
                        filenames(k)=fileNames(j);
                        k=k+1;
                    end
                end
            end
catch
  cd(workroot)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Seleccion de imágenes a muestrear
 m=k-1;
 %%%%%%%%%%%%%%%%%%%%%%%
             figure(dos) 
               clf(gcf)
               axis([1 100 1 200])
               axis off
               text(1,60,'Sample: ')
               text(15,60,char(muestra),'Interpreter','none')
               text(5,40,num2str(m));
               text(15,40,'items')
               hold off
%%%%%%%%%%%%%%%%%
 for j=1:m 
     dientergb=imread([muestra filenames{j}]);
                  dim1=size(dientergb);
                 dim2=size(dim1);
                if dim2(2)>=3
                    dientergb=dientergb(:,:,2);% canal verde
                else
                end
              %%%%%%%%%%%%%%%%%
                figure(cuatro) 
                clf(gcf) 
                axis([1 100 1 200])
                axis off
                   text(5,40,'Image in process:')
                    text(30,40,filenames(j),'Interpreter','none')
                    text(5,20,'Sample: ')
                    text(15,20,muestra,'Interpreter','none')
              hold off
              %%%%%%%%%%%%%%%%%%%%%%%%%%
              figure(tres)
                clf(gcf) 
                imshow(dientergb)
                hold off
              %%%%%%%%%%%%%%%%%%%%
              cd(workroot)
                I0=imsharpen(imgaussfilt(dientergb,2),'Radius',2,'Amount',3);%2,2,3%%% para esquemas
                imagen=EstilizarEsquemas(I0);
                [r,c]=size(imagen);          
            %%%%%%%%%%%%%%%%%%%%%%%%%%%Proceso esquema
             try
                BW7=areasplus(imagen);
                BW7bis=imfill(BW7,'holes'); 
                BW8 = bwmorph(BW7bis,'bridge');
                BW9=255*median_filt(bwperim(BW8,8),1,1);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%
                Imagenbis=imfill(BW8,'holes');
                F=find(Imagenbis);
                [row, col]=ind2sub([r c],F(1));%end,para el extremo derecho de la imagen
                contour = bwtraceboundary(Imagenbis, [row, col],'W' ,8,Inf,'clockwise');
                puntos(j)=size(contour,1);
% % % definido el contorno perimetral y calculado el número total de puntos perimetrales
% % % Cálculo de los semiperímetros
[~,xd]=ind2sub([r c],F(end));
%  y1=row;
 x1=col;
%%%%%%%%%% sustitucion downsample por mi algoritmo de diezmado
%%%%%%%%%%% contorno sin diezmar
contoury=contour(:,2);
contourx=contour(:,1);
pix(j)=size(contourx,1);
U(j,1:pix(j))=contourx(1:end);
V(j,1:pix(j))=contoury(1:end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,indd]=find(V(j,:)==xd);% indice del extremo derecho
ind=floor(mean(indd));
%%%%%%%%%%  Calculo del centroide del perimetro dental 
% y2= floor(mean(contourx)); % localización centroide imagen
x2= floor(mean(contoury)); % localización centroide imagen
%%%%%%%%%% Calculando ofset
%%% buscando partes de la imagen 
x4= floor((x2+x1)/2);% x 1/4
x3=floor((2*x2+x1)/3);% x 1/3
ofset=floor((x3-x4)/2);%  1/3 - 1/4 /2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Buscar  máximos locales en semiperimetro superior
TF1max = islocalmin(U(j,1:ind),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs2=find(TF1max);
% plot(V,U,V(TF1max),U(TF1max),'b*')
nmax1=sum(TF1max);% numero de maximos en perimetro superior
%%%%%%%% Buscando mínimos locales en semiperimetro inferior
TF2min=islocalmax(U(j,ind:puntos(j)),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs4=find(TF2min);
% nmin2=sum(TF2min);
%%%% Segmento S3 entre T4 y T3 
S3=[V(j,locs2(nmax1-3):locs2(nmax1-2))', U(j,locs2(nmax1-3):locs2(nmax1-2))'];
% plot(V(locs2(nmax1-3):locs2(nmax1-2)),U(locs2(nmax1-3):locs2(nmax1-2)),'y.')
%%%% Segmento S2 entre b2 y b3
S2=[V(j,ind+locs4(2):ind+locs4(3))',U(j,ind+locs4(2):ind+locs4(3))'];
% plot(V(ind+locs4(2):ind+locs4(3)),U(ind+locs4(2):ind+locs4(3)),'y.')
%%%%%%%%%%%%%%%% calculando a con mi algoritmo
[~,P4,Q4]=mindist(S3,S2);%
% line([V(P4+locs2(nmax1-3)) V(Q4+ind+locs4(2))],[U(P4+locs2(nmax1-3)) U(Q4+ind+locs4(2))],'Color','y')
%%%%%%%% Segmento a
% a=norm([x1,y1]-[V(P4+locs2(nmax1-3)),U(P4+locs2(nmax1-3))])/factor;%bien
% line([V(P4+locs2(nmax1-3)) x1],[U(P4+locs2(nmax1-3)) y1],'LineStyle','--','Color','r')
% text(0.7*(V(P4+locs2(nmax1-3))),U(P4+locs2(nmax1-3))-10,'a','Color','r')
%%%%%%%% definicion semiperimetros
%%% Contornos entre el ápice y puntos segmento "a"
contour_up=[V(j,1:P4+locs2(nmax1-3))',U(j,1:P4+locs2(nmax1-3))'];%'
contour_down=[V(j,Q4+ind+locs4(2):puntos(j))',U(j,Q4+ind+locs4(2):puntos(j))'];%Resuelto
%%%%%%%%%% Diezmado de puntos perimetrales
semicontourupy=diezmar(contour_up(:,2),div/2);
semicontourupx=diezmar(contour_up(:,1),div/2);
semicontourdowny=diezmar(contour_down(:,2),div/2);
semicontourdownx=diezmar(contour_down(:,1),div/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pixup=size(semicontourupx,1);
% pixdown=size(semicontourdownx,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xup=semicontourupx;
Yup=semicontourupy;
Xdown=semicontourdownx;
Ydown=semicontourdowny;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X(j,1:div)=[Xup',Xdown'];
Y(j,1:div)=[Yup',Ydown'];
%%%%%%%%%%%%%%%%%%%%%%%%%% 
figure(uno)
 clf(gcf)
imshow(BW9)
hold on
if(~isempty(contour))
      plot(X(j,:),Y(j,:),'r+');
   else
     plot(col, row,'rx','LineWidth',2);
end
hold off
        catch
         cd(workroot)
         continue
             end
 end
 %%%%%%%%%%%%%%%%%%
clear U V
cd(workroot)
% Coordenadas de los semiperímetros de la muestra en estudio
U=Y;
V=X;
clear X Y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
discriminamolares(U,V,muestra,filenames)
%%%%%%%%%%%%%%%%%%%%%
end