function [mmbase,dirpath] = unidad_auto(dirpath)
%Function for the metric unit automatic adjustment
% version 7/01/2022
%   Sets the correspondence between coordinates of Matlab windows
%   and the image of the unit of measurement ( 1 mm ) obtained under magnification
%   of work. Usually 20x 
foto=' ';
global uno dos cuatro
       % djustment of the unit of measurement
       figure(cuatro)
       text(20,500,'Select image  of metric unit (1mm)','Color','b');
            try
            %  open image of the unit of measurement
            [foto,dirpath]=uigetfile({'*.bmp;*.tif;*.tiff;*.prn;*.jpg;*.TIF'},'Select image  of metric unit (1mm)');
            regla=imread([dirpath,foto]);
            if size(regla,3)>=3
                regla=regla(:,:,2); %%% green channel
            else
            end
            regla=EstilizarTodo(regla,0.1); 
            [r,c]=size(regla);
            F=find(regla);
                [row1, col1]=ind2sub([r c],F(1));
              F2=find(regla,1,'last');
                [row2, col2]=ind2sub([r c],F2);
                P0=[col1 row1];%point 1 of the unit segment 
                Q0=[col2 row2];% point 2 of the unit segment
                mmbase=norm(Q0-P0);
            catch
             if foto==' '   
                figure(uno)
                reset(gcf);
                title('Loading image')
                axis([0 10 -5 0])
                text(2.5,-2.0,'NOT A VALID IMAGE')
                text(5.0, -4.0,'Try again')
                hold off
             end
            end
             
            figure(dos)
            clf(gcf)
             imshow(regla);
             hold on
            axis image
            text(1,100,' Fitting metric unit: ','Color','r')
            text(5,150,num2str(mmbase),'Color','r')
            hold off
end

