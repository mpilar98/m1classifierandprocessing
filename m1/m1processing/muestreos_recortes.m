function muestreos_recortes(div) 
global uno dos tres cuatro
% llamado desde biometry_molar_semi
% version 18/01/2023 .
workroot=cd;
variedad='?';
var=0;
load Semiperidentales200
Etiquetas=etiquetas(origen);
clear molar origen X Y
nc=size(Etiquetas,2);
Clases0=string(Etiquetas);
Clases0(nc+1)="Otra";
Clases0(nc+2)="VOLVER";
Clases=cellstr(Clases0);
figure(dos)
clf(gcf)
axis([1 100 1 200])
axis off
hold off
%%%%%%%%%%%%%%%%%%%%
var=miMENU('Selecciona la variedad  :',Clases);
while var<nc+2
    switch var
        case {var}
            variedad=Clases(var);
            break
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if var==nc+2
    return
else
    if var==nc+1
        prompt='Nombre: ';
        name='Nueva variedad';
        numlines=1;
        defaultanswer={'indefinida'};
        options='on';
%         figure(uno)
        variedad=inputdlg(prompt,name,numlines,defaultanswer,options);
%         hold off
        else
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
Muestra=uigetdir('Selecciona la carpeta con los recortes a muestrear');
            if char(Muestra)==' '
                return
            else
            muestra=strcat(Muestra,'/');
            dirOutput=dir(fullfile(Muestra));
            fileNames={dirOutput.name}';
            m=size(fileNames,1);% todas las imagenes de la carpeta
            k=1;
             for j=1:m
            	muela=char(fileNames(j));             
                if muela(1)=='.'
                    continue
                else
                    molar(k)=fileNames(j);
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
 X=zeros(m,div);
 Y=zeros(m,div);
 for j=1:m 
     dientergb=imread([muestra molar{j}]);
                 dim1=size(dientergb);
                 dim2=size(dim1);
                if dim2(2)>=3
                    dientergb=dientergb(:,:,2);% canal verde
                else
                end
                %%%%%%%%%%%%%%%
                figure(cuatro)
                clf(gcf) 
                imshow(dientergb)
                hold off
              %%%%%%%%%%%%%%%%%%%%
              figure(tres)
                clf(gcf) 
                axis([1 100 1 200])
                axis off
                   text(5,40,'Imagen en proceso:')
                    text(30,40,char(molar(j)),'Interpreter','none')
                    text(5,20,'Muestra: ')
                    text(20,20,muestra,'Interpreter','none')
              hold off
              %%%%%%%%%%%%%%%%%%%%
              cd(workroot)
                Imagen = delineartif(imcomplement(dientergb),0.1);
                [r,c]=size(Imagen);
                figure(uno)
                clf(gcf)
                imshow(Imagen);
                axis([1 c 1 r])
                hold off 
                Imagenbis=imfill(Imagen,'holes');
                F=find(Imagenbis);
                [row, col]=ind2sub([r c],F(1));%end,para el extremo derecho de la imagen
                contour = bwtraceboundary(Imagenbis, [row, col],'W' ,8,Inf,'clockwise');
                puntos(j)=size(contour,1);
% % % definido el contorno perimetral y calculado el número total de puntos perimetrales
% % % Cálculo de los semiperímetros
[~,xd]=ind2sub([r c],F(end));
 y1=row;
 x1=col;
%%%%%%%%%%%%%%%%%%%contorno sin diezmar%%%%%%%%%%%
contoury=contour(:,2);
contourx=contour(:,1);
pix(j)=size(contourx,1);%img
U(j,1:pix(j))=contourx(1:end);
V(j,1:pix(j))=contoury(1:end);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,indd]=find(V(j,:)==xd);% indice del extremo derecho
ind=floor(mean(indd));
%%%%%%%%%%  Calculo del centroide del perimetro dental 
y2= floor(mean(contourx)); % localización centroide imagen
x2= floor(mean(contoury));
%%% buscando partes de la imagen 
x4= floor((x2+x1)/2);% x 1/4
x3=floor((2*x2+x1)/3);% x 1/3
%%%%%%%%%% Calculando ofset
ofset=floor((x3-x4)/(5/2));%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Buscar  máximos locales en semiperimetro superior
%%%%%%%% definicion semiperimetros
%%%%%% contornos para calcular el corte central
stoparriba=find(contoury>=x2);% indice del extremo derecho% centralcontour=contour(contourx<=y2,contoury<=x2)
contornoxa=contourx(1:stoparriba(1),:);
contornoya=contoury(1:stoparriba(1),:);
arriba=[contornoya,contornoxa];
%%%%%%stopabajo: encontrando primer minimo local despues de centroide
stopabajo=find(contoury(ind:puntos(j))<=x2);
stopmin=islocalmax(U(j,ind+stopabajo(1):puntos(j)),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locsmin=find(stopmin);
% plot(V(j,ind+stopabajo(1)+locsmin(1)),U(j,ind+stopabajo(1)+locsmin(1)),'m^')%%%minimo siguiente a x2 centroide
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% calculo para el contorno abajo 
contornoxb=contourx(ind:ind+stopabajo(1)+locsmin(1),:);
contornoyb=contoury(ind:ind+stopabajo(1)+locsmin(1),:);
abajo=[contornoyb,contornoxb];
%%%%%%%%%%%%%%%%%%calculo punto de corte
[~,P4,Q4]=mindist(arriba,abajo);%
% % % [~,P5,Q5]=mindist(abajo,arriba);% es lo mismo que P4,Q4
% % % plot(V(1:P4),U(1:P4),'ro')% ok para 1:P4, semiperimetro superior
% % % plot(V(P5+ind),U(P5+ind),'r+')%ok
% % % plot(V(Q4+ind),U(Q4+ind),'r+')%ok
line([V(j,P4) V(j,Q4+ind)],[U(j,P4) U(j,Q4+ind)],'Color','y') %%% ok
%%%%%%%%%%% definicion contorno semiperímetros
% plot(V(j,Q4+ind:puntos(j)),U(j,Q4+ind:puntos(j)),'ro') % semiperimetro inferior
contour_up=[V(j,1:P4)',U(j,1:P4)'];
contour_down=[V(j,Q4+ind:puntos(j))',U(j,Q4+ind:puntos(j))'];
%%%%%%%%%% diezmado del semiperímetro
semicontourupy=diezmar(contour_up(:,2),div/2);%:,2
semicontourupx=diezmar(contour_up(:,1),div/2);
semicontourdowny=diezmar(contour_down(:,2),div/2);
semicontourdownx=diezmar(contour_down(:,1),div/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pixup=size(semicontourupx,1);%img
pixdown=size(semicontourdownx,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xup=semicontourupx;
Yup=semicontourupy;
Xdown=semicontourdownx;
Ydown=semicontourdowny;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% puntos totales
nuevospuntos(j)=2*size(semicontourupx,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X(j,1:div)=[Xup',Xdown'];
Y(j,1:div)=[Yup',Ydown'];
%%%%%%%%%%%%%%%%%%%%%%%%%% 
% % % % Bloque operativo
figure(uno)
clf(gcf)
imshow(Imagen)
axis([1 c 1 r])
axis off
hold on
    if(~isempty(contour))
          plot(X(j,:),Y(j,:),'r+');
       else
         plot(col, row,'rx','LineWidth',2);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                figure(dos) 
                text(30,200,'puntos ')
                text(30,200-6*j,num2str(puntos(j)))
                text(70,200,'nuevos puntos ')
                text(70,200-6*j,num2str(nuevospuntos(j)))
                text(10,200,'Imagen :')
                text(10,200-6*j,num2str(j))
                text(16,200-6*j,'(')
                text(17,200-6*j,num2str(m))
                text(22,200-6*j,')')
                hold on
 end
%%%%%%%%%%%%%%%%%%
clear U V
cd(workroot)
minpix=div;
U=Y;
V=X;
save(Muestra,'variedad','muestra','U','V','molar','div');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%% cálculo procrustes
workroot=cd;
workpath=workroot;
addpath(workpath);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         figure(uno)
         clf
         axis image 
        plot(V(1,:)',-U(1,:)','gx');% + % plot de la primera instancia (modelo)
        % el signo negativo de U coloca los puntos sin invertir
        title('NO Escalado')
        hold on
for k=1:m 
X1(:,k)=Z1(:,1,k);
X2(:,k)=Z1(:,2,k);
end
plot(X1,X2,'-')%%%pinta en diferentes colores
hold on
plot(centro(:,1),centro(:,2),'ko');
hold off 
end
         