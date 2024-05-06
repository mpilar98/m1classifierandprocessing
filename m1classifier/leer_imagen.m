function [imagen,dirpath,diente]=leer_imagen(dirpath)
% version 3-12-2021
%%Where the way to access the images in a folder is solved.
%%in succession without having to traverse the directory tree.
%% The folder is active until the process is finished
     global uno dos tres cuatro
     dientergb=' ';
     diente='0';
     % open image to measure
     cd(dirpath)
            [diente,dirpath]=uigetfile({'*.bmp;*.tif;*.prn;*.jpg;*.tiff;*.TIF',...
            'Ficheros con dibujos (*.bmp,*.tif,*.prn,*.jpg)'},'Selecciona la imagen '); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if diente=='0' 
                figure(uno)
                clf;
                title('Cargando imagen')
                axis([0 10 -5 0])
                text(1.0,-2.0,char(muestra),'Interpreter','none')
                text(2.5,-2.0,'NO ES UNA IMAGEN VALIDA ')
                text(5.0, -4.0,'Vuelve a intentarlo')
                hold off  
            else 
                dientergb=imread([dirpath,diente]);
                 dim1=size(dientergb);
                 dim2=size(dim1);
                if dim2(2)>=3
                    imagen=dientergb(:,:,2);% green channel
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