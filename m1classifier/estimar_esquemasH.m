function estimar_esquemasH(div)
% Release 24/10/2022 
% subfunction of analysis_molar_semi()
 global uno dos tres cuatro
 workroot=cd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
Muestra=uigetdir('Select file with Drawings to classify');
            if char(Muestra)==' '
                return
            else
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            muestra=strcat(Muestra,'/');
            dirOutput=dir(fullfile(Muestra));
            fileNames={dirOutput.name}';
            m=size(fileNames,1);
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
                    dientergb=dientergb(:,:,2);% green channel
                else
                end
              %%%%%%%%%%%%%%%%%
                figure(cuatro) 
                clf(gcf) 
                axis([1 100 1 200])
                axis off
                   text(5,40,'Image processing:')
                    text(30,40,filenames(j),'Interpreter','none')
                    text(5,20,'Muestra: ')
                    text(15,20,muestra,'Interpreter','none')
              hold off
              %%%%%%%%%%%%%%%%%%%%%%%%%%
              figure(tres)
                clf(gcf) 
                imshow(dientergb)
                hold off
              %%%%%%%%%%%%%%%%%%%%
              cd(workroot)
                I0=imsharpen(imgaussfilt(dientergb,2),'Radius',2,'Amount',3);
                imagen=EstilizarEsquemas(I0);
                [r,c]=size(imagen);          
            %%%%%%%%%%%%%%%%%%%%%%%%%%%
             try
                BW7=areasplus(imagen);
                BW7bis=imfill(BW7,'holes'); 
                BW8 = bwmorph(BW7bis,'bridge');
                BW9=255*median_filt(bwperim(BW8,8),1,1);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%
                Imagenbis=imfill(BW8,'holes');
                F=find(Imagenbis);
                [row, col]=ind2sub([r c],F(1));
                contour = bwtraceboundary(Imagenbis, [row, col],'W' ,8,Inf,'clockwise');
                puntos(j)=size(contour,1);
                [~,xd]=ind2sub([r c],F(end));
                x1=col;
%%%%%%%%%%% 
contoury=contour(:,2);
contourx=contour(:,1);
pix(j)=size(contourx,1);
U(j,1:pix(j))=contourx(1:end);
V(j,1:pix(j))=contoury(1:end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,indd]=find(V(j,:)==xd);
ind=floor(mean(indd));
%%%%%%%%%% 
x2= floor(mean(contoury)); 
%%%  
x4= floor((x2+x1)/2);% x 1/4
x3=floor((2*x2+x1)/3);% x 1/3
ofset=floor((x3-x4)/2);%  1/3 - 1/4 /2
%%%%%%%%
TF1max = islocalmin(U(j,1:ind),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs2=find(TF1max);
nmax1=sum(TF1max);
%%%%%%%% 
TF2min=islocalmax(U(j,ind:puntos(j)),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs4=find(TF2min);
%%%% 
S3=[V(j,locs2(nmax1-3):locs2(nmax1-2))', U(j,locs2(nmax1-3):locs2(nmax1-2))'];
%%%% 
S2=[V(j,ind+locs4(2):ind+locs4(3))',U(j,ind+locs4(2):ind+locs4(3))'];
%%%%%%%%%%%%%%%% 
[~,P4,Q4]=mindist(S3,S2);
contour_up=[V(j,1:P4+locs2(nmax1-3))',U(j,1:P4+locs2(nmax1-3))'];%'
contour_down=[V(j,Q4+ind+locs4(2):puntos(j))',U(j,Q4+ind+locs4(2):puntos(j))'];
%%%%%%%%%%
semicontourupy=diezmar(contour_up(:,2),div/2);
semicontourupx=diezmar(contour_up(:,1),div/2);
semicontourdowny=diezmar(contour_down(:,2),div/2);
semicontourdownx=diezmar(contour_down(:,1),div/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
U=Y;
V=X;
clear X Y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % discriminamolares_SVM(U,V,muestra,filenames,Mdl,Mdl2) % sin LOO
discriminamolares_SVM(U,V,muestra,filenames)% con LOO
%%%%%%%%%%%%%%%%%%%%%
end