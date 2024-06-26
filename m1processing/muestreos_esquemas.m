function muestreos_esquemas(div)
global uno dos tres cuatro
% called from biometry_molar_semi()
% Release 18/01/2023
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
var=miMENU('Select Species name  :',Clases);
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
        prompt='Name: ';
        name='New species';
        numlines=1;
        defaultanswer={'indefinite'};
        options='on';
        variedad=inputdlg(prompt,name,numlines,defaultanswer,options);
        else
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
Muestra=uigetdir('Select file containing the Drawings to sample ');
            if char(Muestra)==' '
                return
            else
            muestra=strcat(Muestra,'/');
            dirOutput=dir(fullfile(muestra));
            fileNames={dirOutput.name}';
            m=size(fileNames,1);
            k=1;
            for j=1:m
            	muela= char(fileNames(j));
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
 m=k-1;
 X=zeros(m,div);
 Y=zeros(m,div);
 for j=1:m 
     dientergb=imread([muestra molar{j}]);
      dim1=size(dientergb);
                 dim2=size(dim1);
                if dim2(2)>=3
                    dientergb=dientergb(:,:,2);
                else
                end
              %%%%%%%%%%%%%%%%%
              figure(cuatro)
                clf(gcf) 
                imshow(dientergb)
                hold off
              %%%%%%%%%%%%%%%%%%%%
              figure(tres)
                clf(gcf) 
                axis([1 100 1 200])
                axis off
                   text(5,40,'Image processing:')
                    text(30,40,char(molar(j)),'Interpreter','none')
                    text(5,20,'Sample: ')
                    text(20,20,muestra,'Interpreter','none')
              hold off
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              cd(workroot)
                I0=imsharpen(imgaussfilt(dientergb,2),'Radius',2,'Amount',3);
                imagen=EstilizarEsquemas(I0);
                [r,c]=size(imagen);  
            %%%%%%%%%%%%%%%%%%%%%%%%%%%
             try
                BW7=areas(imagen);
                BW7bis=imfill(BW7,'holes'); 
                BW8 = bwmorph(BW7bis,'bridge');
                %%%%%%%% 
                [~,NUM] = bwlabel(BW8,8);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                BW9=255*median_filt(bwperim(BW8,8),1,1);
%%% 
                Imagenbis=imfill(BW8,'holes');
                F=find(Imagenbis);
                [row, col]=ind2sub([r c],F(1));
                contour = bwtraceboundary(Imagenbis, [row, col],'W' ,8,Inf,'clockwise');
                puntos(j)=size(contour,1);
% % % 
[~,xd]=ind2sub([r c],F(end));
 y1=row;
 x1=col;
%%%%%%%%%%%%%%%%%%%
contoury=contour(:,2);
contourx=contour(:,1);
pix(j)=size(contourx,1);
U(j,1:pix(j))=contourx(1:end);
V(j,1:pix(j))=contoury(1:end);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,indd]=find(V(j,:)==xd);
ind=floor(mean(indd));
%%%%%%%%%%  
y2= floor(mean(contourx));
x2= floor(mean(contoury));
%%% 
x4= floor((x2+x1)/2);% x 1/4
x3=floor((2*x2+x1)/3);% x 1/3
%%%%%%%%%% 
ofset=floor((x3-x4)/(5/2));%
%%%%%% 
stoparriba=find(contoury>=x2);
contornoxa=contourx(1:stoparriba(1),:);
contornoya=contoury(1:stoparriba(1),:);
arriba=[contornoya,contornoxa];
%%%%%%
stopabajo=find(contoury(ind:puntos(j))<=x2);
stopmin=islocalmax(U(j,ind+stopabajo(1):puntos(j)),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locsmin=find(stopmin);
%%%%% 
contornoxb=contourx(ind:ind+stopabajo(1)+locsmin(1),:);
contornoyb=contoury(ind:ind+stopabajo(1)+locsmin(1),:);
abajo=[contornoyb,contornoxb];
%%%%%%%%%%%%%%%%%%
[~,P4,Q4]=mindist(arriba,abajo);%
line([V(j,P4) V(j,Q4+ind)],[U(j,P4) U(j,Q4+ind)],'Color','y')
%%%%%%%%%%% 
contour_up=[V(j,1:P4)',U(j,1:P4)'];
contour_down=[V(j,Q4+ind:puntos(j))',U(j,Q4+ind:puntos(j))'];
%%%%%%%%%%
semicontourupy=diezmar(contour_up(:,2),div/2);
semicontourupx=diezmar(contour_up(:,1),div/2);
semicontourdowny=diezmar(contour_down(:,2),div/2);
semicontourdownx=diezmar(contour_down(:,1),div/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pixup=size(semicontourupx,1);
pixdown=size(semicontourdownx,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xup=semicontourupx;
Yup=semicontourupy;
Xdown=semicontourdownx;
Ydown=semicontourdowny;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nuevospuntos(j)=2*size(semicontourupx,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X(j,1:div)=[Xup',Xdown'];
Y(j,1:div)=[Yup',Ydown'];
%%%%%%%%%%%%%%%%%
                figure(uno)
                 clf(gcf)
                 imshow(BW9)
                 axis([1 c 1 r])
                 hold on
                if(~isempty(contour))
                      plot(X(j,:),Y(j,:),'r+');
                      hold off
                   else
                     plot(col, row,'rx','LineWidth',2);
                end
                if NUM>2
                    figure(uno)
                    clf(gcf)
                    axis([0 10 -5 0])
                    text(2.5,-2.0,'Image not recognized')
                    text(6.0,-2.0,char(molar(j)),'Interpreter','none')
                    text(5.0,-4.0,'Redraw or discard')
                    hold off
                end
                figure(dos) 
                text(30,200,'points ')
                text(30,200-6*j,num2str(puntos(j)))
                text(70,200,'new points ')
                text(70,200-6*j,num2str(nuevospuntos(j)))
                text(10,200,'Image :')
                text(10,200-6*j,num2str(j))
                text(16,200-6*j,'(')
                text(17,200-6*j,num2str(m))
                text(22,200-6*j,')')
                hold on
             catch
                cd(workroot)
             end
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear U V
cd(workroot)
minpix=div;
U=Y;
V=X;
save(Muestra,'variedad','muestra','U','V','molar','div');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%% procrustes calculation
workroot=cd;
workpath=workroot;
addpath(workpath);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           figure(cuatro) 
            clf(gcf)
               axis([1 100 1 200])
               axis off
               text(1,60,'Sample: ')
               text(10,60,char(muestra),'Interpreter','none')
               text(5,40,num2str(m));
               text(10,40,'items')
               text(1,20,'Species:')
               text(10,20,variedad,'Interpreter','none')
               for q=1:m
                   text(45,200-6*q,int2str(q))
                text(50,200-6*q,molar(q),'Interpreter','none');
               end
               hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            D=zeros(m);
            M=[V',-U'];
            for k=1:m 
 [D(k),Z1(:,:,k)]=procrustes([M(:,1) M(:,m+1)],[M(:,k) M(:,m+k)],'Scaling',false);
end
% 
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
         text(3,120,'(respect to the first item)');
        text(50,200,'item '); 
        text(55,200,'100*d'); 
         for q=2:m 
            text(50,200-6*q,int2str(q));
            text(55,200-6*q,num2str(100*D(q,1),2));
         end
         axis off 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%
      figure(uno)
        clf
        axis image 
        plot(V(1,:)',-U(1,:)','gx');
        %
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
end

