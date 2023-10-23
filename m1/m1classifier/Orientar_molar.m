function Orientar_molar() 
% version 8-01-2022
%%Donde se resuelve el modo de acceder a las imágenes de una carpeta
%%de manera sucesiva sin tener que recorrer el arbol de directorios
%%% No normaliza los tamaños de las imágenes. Solo modifica orientación
%% Se mantiene en la carpeta activa hasta terminar el proceso
     global uno 
     diente='0';
     workroot=cd;
     dirpath=cd;
     % accediendo imagen a reorientar
 lado=0;
while lado<9
    cd(workroot)
    lado=miMENU('Especificando orientación',...
        '1.-Seleccionar imagen',...
        '2.- Descartar',...
        '3.-Reflejar verticalmente',...
        '4.- Reflejar horizontalmente',...
        '5.- Girar 90º',...
        '6.- Invertir tonos',...
        '7.- Validar',...
        '8.- Terminar');
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
            text(40,100,'Imagen no procesada: ');
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
            text(10,30,'Orientación completada','Color','b')
            hold off
        case 8
            cd(workroot)
            break; 
     end
end
end