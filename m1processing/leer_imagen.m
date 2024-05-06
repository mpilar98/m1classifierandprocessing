function [imagen,dirpath,diente]=leer_imagen(dirpath)
% Release 3-12-2021
     global uno dos tres cuatro
     dientergb=' ';
     diente='0';
     cd(dirpath)
            [diente,dirpath]=uigetfile({'*.bmp;*.tif;*.prn;*.jpg;*.tiff;*.TIF',...
            'File of pictures (*.bmp,*.tif,*.prn,*.jpg)'},'Select image '); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if diente=='0' 
                figure(uno)
                clf;
                title('Loading image')
                axis([0 10 -5 0])
                text(1.0,-2.0,char(muestra),'Interpreter','none')
                text(2.5,-2.0,'INVALID IMAGE ')
                text(5.0, -4.0,'Try again')
                hold off  
            else 
                dientergb=imread([dirpath,diente]);
                 dim1=size(dientergb);
                 dim2=size(dim1);
                if dim2(2)>=3
                    imagen=dientergb(:,:,2);
                else
                    imagen=dientergb;
                end
                 figure(uno)
                  clf(gcf)
                  imshow(imagen)
                  text(250,20,diente,'Color','b','Interpreter','none')
                 hold off
                cd(dirpath)
            end
end