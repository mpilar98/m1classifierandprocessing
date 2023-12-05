function [imagen,dirpath,diente]=leer_imagen(dirpath)
% version 3-12-2021
%%Donde se resuelve el modo de acceder a las imágenes de una carpeta
%%de manera sucesiva sin tener que recorrer el arbol de directorios
%% Se mantiene en la carpeta activa hasta terminar el proceso
     global uno dos tres cuatro
     dientergb=' ';
     diente='0';
     % abrir imagen a medir
     cd(dirpath)
            [diente,dirpath]=uigetfile({'*.bmp;*.tif;*.prn;*.jpg;*.tiff;*.TIF',...
            'Files with drawings (*.bmp,*.tif,*.prn,*.jpg)'},'Select image '); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if diente=='0' 
                figure(uno)
                clf;
                title('Loading image')
                axis([0 10 -5 0])
                text(1.0,-2.0,char(muestra),'Interpreter','none')
                text(2.5,-2.0,'NOT A VALID IMAGE ')
                text(5.0, -4.0,'Try again')
                hold off  
            else 
                dientergb=imread([dirpath,diente]);
                 dim1=size(dientergb);
                 dim2=size(dim1);
                if dim2(2)>=3
                    imagen=dientergb(:,:,2);% canal verde
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