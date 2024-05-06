function Orientar_molar() 
% Release 8-01-2022
     global uno 
     diente='0';
     workroot=cd;
     dirpath=cd;
     % accessing image to reorient
 lado=0;
while lado<9
    cd(workroot)
    lado=miMENUvdm('Especifying orientation',...
        '1.- Choose image',...
        '2.- Discard',...
        '3.- Vertical mirroring',...
        '4.- Horizontal mirroring ',...
        '5.- Turn 90� Counterclockwise',...
        '6.- Invert tones',...
        '7.- Validate',...
        '8.- End');
    switch lado
        case 1 
            try
                [imagen,dirpath,diente]=leer_imagen(dirpath);
            catch
                continue
            end
        case 2
           figure(uno)
            clf(uno)
            axis([1 100 1 150])
            axis off
            text(40,100,'Image discarded: ');
            text(40,130,cellstr(diente),'Interpreter','none');
        case 3
        imagen=flip(imagen,1);
            figure(uno) 
            clf
            imshow(imagen)
            text(10,10,diente,'Interpreter','none');
            hold on
        case 4
            imagen=flip(imagen,2);
            figure(uno)
            clf
            imshow(imagen)
            text(10,10,diente,'Interpreter','none');
            hold on
        case 5
            imagen=imrotate(imagen,90,'bilinear','loose');
            figure(uno) 
            clf
            imshow(imagen)
            text(10,10,diente,'Interpreter','none');
            hold on
        case 6
            imagen=imcomplement(imagen);
             figure(uno) 
            clf
            imshow(imagen)
            text(10,10,diente,'Interpreter','none');
            hold on
        case 7
            imwrite(imagen,[dirpath,diente]);
            figure(uno)
            text(10,30,'Orientation completed','Color','b')
            hold off
        case 8
            cd(workroot)
            break; 
     end
end
end