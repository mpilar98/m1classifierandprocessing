function [mmbase,dirpath] = unidad_manual(dirpath)
%Function for the metric unit adjustment
% versión 7/01/2022
%   Sets the correspondence between coordinates of Matlab windows
%   and the image of the unit of measurement ( 1 mm ) obtained under magnification
%   of work. Usually 20x 
foto=' ';
global uno dos cuatro
       % adjustment of the unit of measurement
       figure(cuatro)
       text(20,500,'Select image of metric unit (1mm)','Color','b');
            try
            % open image of the unit of measurement
            [foto,dirpath]=uigetfile({'*.TIF;*.bmp;*.tif;*.tiff;*.prn;*.jpg'},'Select image of metric unit (1mm))');
            regla=imread([dirpath,foto]);
            if size(regla,3)>=3
                regla=regla(:,:,2); %%% green channel
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
            text(50,100,'Fitting the metric unit','Color','r')
            for q=1:2
            [xu(q),yu(q)]=ginput(1);
            plot(xu(q),yu(q),'r +')
            hold on
            text(xu(q)+5,yu(q)+2,int2str(q),'Color','g')
            end
              P0=[xu(1,1) -yu(1,1)];%point 1 of the unit segment
              Q0=[xu(1,2) -yu(1,2)];% point 2 of the unit segment
              mmbase=norm(Q0-P0);
              hold off
end


