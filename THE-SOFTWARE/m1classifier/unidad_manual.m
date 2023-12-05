function [mmbase,dirpath] = unidad_manual(dirpath)
%Función para el ajuste de la unidad métrica
% versión 7/01/2022
%   Establece la correspondencia entre coordenadas de las ventanas de Matlab
%   y la imagen de la unidad de medida ( 1 mm ) obtenida bajo la ampliación
%   de trabajo. Usualmente 20x 
foto=' ';
global uno dos cuatro
       % ajuste de la unidad de medida
       figure(cuatro)
       text(20,500,'Select the photo of the unit of measurement (1mm)','Color','b');
            try
            % abrir imagen correspondiente a la unidad de medida
            [foto,dirpath]=uigetfile({'*.TIF;*.bmp;*.tif;*.tiff;*.prn;*.jpg'},'Select the photo of the unit of measurement (1mm)');
            regla=imread([dirpath,foto]);
            if size(regla,3)>=3
                regla=regla(:,:,2); %%% canal verde
            else
            end           
            catch
             if foto==' '   
                figure(uno)
                reset(gcf);
                title('Loading image')
                axis([0 10 -5 0])
                text(2.5,-2.0,'NOT A VALID IMAGE ')
                text(5.0, -4.0,'Try again')
                hold off
             end
             end
             figure(dos)
             clf(gcf)
             imshow(regla);
             hold on
            axis image
            text(50,100,' Unit segment adjustment ','Color','r')
            for q=1:2
            [xu(q),yu(q)]=ginput(1);
            plot(xu(q),yu(q),'r +')
            hold on
            text(xu(q)+5,yu(q)+2,int2str(q),'Color','g')
            end
              P0=[xu(1,1) -yu(1,1)];%punto 1 del segmento unidad 
              Q0=[xu(1,2) -yu(1,2)];% punto 2 del segmento unidad
              mmbase=norm(Q0-P0);
              hold off
end


