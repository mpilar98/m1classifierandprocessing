% microMolar.m 
% Release 8/01/2022
function [dirpath,div]=microMolar(dirpath)
global  uno dos tres cuatro 
factor20=240;
base1mm=240;
%%%%%%%%%%%% 
x(1:2)=0;y(1:2)=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
workroot=cd;
choice=0;
div=200;
%%% 
while choice<7 
    choice=miMENUvdm('Segment Measurement and Sampling Density definition',...
        '1.- Calibrate metric unit',...
        '2.- Autocalibrate metric unit',...
        '3.- Measure image',...
        '4.- Calibrate image',...
        '5.- Calibrate sample file',...
        '6.- Back to main program');
    switch choice
        case 1
            try
             [base1mm,dirpath]=unidad_manual(dirpath);
             figure(dos)
             text(10,10,'pixels/mm = ','Color','r')
             text(200,10,num2str(base1mm),'Color','r')
            catch
                continue
            end
        case 2
            try
                 [base1mm,dirpath]=unidad_auto(dirpath);
                 figure(dos)
                 text(10,10,'pixels/mm = ','Color','r')
                 text(200,10,num2str(base1mm),'Color','r')
            catch
                continue
            end
        case 3
            figure(uno)
            text(10,200,'Select image to measure')
            cd(dirpath) 
            try
                x(1:2)=0.0;
                y(1:2)=0.0;
                [foto,dirpath]=uigetfile({'*.bmp;*.tif;*.tiff;*.prn;*.jpg;*.TIF'},'Choosing image ... ');
                I=imread([dirpath,foto]);
                dimI=size(size(I));
                if dimI(2)>=3
                    I=I(:,:,1:3);
                else
                end
                figure(uno)
                clf(gcf)
                imshow(I)
                hold on
                text(10,10,'Image processing: ','Color','r')
                text(150,10,foto,'Color','r','Interpreter','none')
                axis off
                hold on
                %%%%%%%%%%%%%%%%%% repeat until keypress
                cond=1.0;
                while cond>0
                    for j1=1:2
                       [x(j1),y(j1)]=ginput(1);
                       plot(x(j1),y(j1),'r+')
                       text(x(j1)+5,y(j1)+2,int2str(j1))
                       hold on
                    end
                        line([x(1) x(2)],[y(1) y(2)],'Color','r')
                    if base1mm==240
                       length=norm([x(1),y(1)]-[x(2),y(2)])/factor20;
                    else
                       length=norm([x(1),y(1)]-[x(2),y(2)])/base1mm;  
                    end
                    text(20,30+10*cond,num2str(length,3),'Color','r');
                    text(50,30+10*cond,'mm','Color','r');
                    text(400,10,'Presh space bar to finish','Color','b')
                    text(400,30,'Click left button for new measurement','Color','g')
                    hold off
                    tecla = waitforbuttonpress;
                    if tecla
                        break
                    else
                        cond=cond+1.0;
                        clear tecla x y
                        hold on
                        continue
                    end
                end
                hold off
                %%%%%%%%%%%%%%%%%% end repeat until condition
                cd(workroot)
            catch
                continue
            end
        case 4
            cd(dirpath)
            try
           [foto,dirpath]=uigetfile({'*.bmp;*.tif;*.tiff;*.prn;*.jpg;*.TIF'},'Select an image to calibrate');
            I=imresize(imread([dirpath,foto]),factor20/base1mm);
             dimI=size(size(I));
                if dimI(2)>=3
                    I=I(:,:,1:3);
                else
                end
            figure(cuatro)
            clf(gcf)
            imshow(I)
            hold on
            text(10,10,'Image processing: ','Color','b')
            text(250,10,foto,'Color','r','Interpreter','none')
            text(30,30,num2str(size(I)),'Color','r')
            axis on
            hold on
            info=imfinfo([dirpath,foto]);
            fmt=info.Filename(end-2:end);
            if fmt=='iff'
                 imwrite(I,[dirpath,strcat(foto(1:end-5),'_cal','.tif')],'tiff');
            else
                if fmt=='tif'
                    imwrite(I,[dirpath,strcat(foto(1:end-4),'_cal','.tif')],'tif');
                else
                    if fmt=='bmp'
                        imwrite(I,[dirpath,strcat(foto(1:end-4),'_cal','.bmp')],'bmp');
                    else
                      imwrite(I,[dirpath,strcat(foto(1:end-4),'_cal','.tif')],'tif');  
                    end
                end
            end
            figure(dos)
            clf(gcf)
            axis on
            imshow(I) 
            hold on
            text(50,400,'Size:','Color','r')
             text(150,400,num2str(size(I)),'Color','r') 
             cd(workroot)
            catch
                cd(workroot)
                continue
            end
        case 5
            cd(dirpath)
          try
            Muestra=uigetdir('Select file with images to calibrate');
            if char(Muestra)==' '
                return
            else
            muestra=strcat(Muestra,'/');
            dirOutput=dir(fullfile(Muestra));
            fileNames={dirOutput.name}';
            m=size(fileNames,1);
            %%%%%%%%%%%%%%%%%%%
            if char(fileNames(1))=='.' 
                fileNames=fileNames(3:end);
                m=m-2;
            else
            end
            %%%%%%%%%%%%%%%%%%%
                info=imfinfo([muestra,fileNames{end}]);
                fmt=info.Filename(end-2:end);
            end
          catch
            cd(workroot)
            continue
          end
           %%%%%%%%%%%%%%%%%%%%%%%%%%%
           try
           for j=1:m 
                dientergb=imread([muestra,fileNames{j}]);
                nombre=char(fileNames(j));
                figure(cuatro)
                clf(gcf) 
                axis([1 100 1 200])
                axis off
                   text(1,40,'Image processing:')
                    text(25,40,nombre,'Interpreter','none')%n
                    text(1,20,'Sample: ')
                    text(11,20,muestra,'Interpreter','none')
              hold on
              %%%%%%%%%%%%%%%%%
              figure(tres)
                clf(gcf) 
                imshow(dientergb)
                hold off
            %%%%%%%%%%%%%%% 
            I=imresize(dientergb,factor20/base1mm);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            dimI=size(size(I));
            if dimI(2)>=3
                I= I(:,:,1:3); 
            else
            end
            %%%%%%%%%%
            if fmt=='iff'
                 imwrite(I,[muestra,strcat(nombre(1:end-5),'_cal','.tiff')],'tiff');
            else
                if fmt=='tif'
                    imwrite(I,[muestra,strcat(nombre(1:end-4),'_cal','.tif')],'tif');
                else
                    if fmt=='bmp'
                        imwrite(I,[muestra,strcat(nombre(1:end-4),'_cal','.bmp')],'bmp');
                    else
                        imwrite(I,[muestra,strcat(nombre(1:end-4),'_cal','.tif')],'tif');
                    end
                end
            end
                    figure(dos)
                    clf(gcf)
                    axis on
                    imshow(I) 
                    hold on
                    text(10,500,'Size:','Color','r')
                     text(100,500,num2str(size(I)),'Color','r') 
           end
           cd(workroot)
           catch
               cd(workroot)
               continue
           end
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        case 6
            clf(uno)
            boca=imread('Arvicola sapidus.jpg');
            imshow(boca)
            axis off
            hold off
            choice=7;
     end
end
end
 

             