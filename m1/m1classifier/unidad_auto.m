function [mmbase,dirpath] = unidad_auto(dirpath)
%Función para el ajuste automático de la unidad métrica
% versión 7/01/2022
%   Establece la correspondencia entre coordenadas de las ventanas de Matlab
%   y la imagen de la unidad de medida ( 1 mm ) obtenida bajo la ampliación
%   de trabajo. Usualmente 20x 
foto=' ';
global uno dos cuatro
       % ajuste de la unidad de medida
       figure(cuatro)
       text(20,500,'Selecciona la foto de la unidad de medida (1mm)','Color','b');
            try
            % cargar imagen correspondiente a la unidad de medida
            [foto,dirpath]=uigetfile({'*.bmp;*.tif;*.tiff;*.prn;*.jpg;*.TIF'},'Seleciona la foto de la unidad de medida (1mm)');
            regla=imread([dirpath,foto]);
            if size(regla,3)>=3
                regla=regla(:,:,2); %%% canal verde
            else
            end
            regla=EstilizarTodo(regla,0.1); 
            [r,c]=size(regla);
            F=find(regla);
                [row1, col1]=ind2sub([r c],F(1));
              F2=find(regla,1,'last');
                [row2, col2]=ind2sub([r c],F2);
                P0=[col1 row1];%punto 1 del segmento unidad 
                Q0=[col2 row2];% punto 2 del segmento unidad
                mmbase=norm(Q0-P0);
            catch
             if foto==' '   
                figure(uno)
                reset(gcf);
                title('Cargando imagen')
                axis([0 10 -5 0])
                text(2.5,-2.0,'NO ES UNA IMAGEN VALIDA ')
                text(5.0, -4.0,'Vuelve a intentarlo')
                hold off
             end
            end
             
            figure(dos)
            clf(gcf)
             imshow(regla);
             hold on
            axis image
            text(1,100,' Ajuste del segmento unidad: ','Color','r')
            text(5,150,num2str(mmbase),'Color','r')
            hold off
end

