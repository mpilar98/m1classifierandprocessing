% analysis_molar_semiH.m
% Funci�n principal y  men� general de  medidas biom�tricas sobre recortes y esquemas de molares de micromam�feros
% Discrimina con algoritmos  Distancia de Hausdorff Modificada ,
% Distancia Procrustes y Linear Discriminant Classifier de Fisher
% Version 3-01-2023
% 1.- Orienta im�genes 
% 2.- Mide y escala 
% 3.- Procesa y estima sobre recortes de ejemplares sueltos 
% 4.- Procesa y estima sobre esquemas de ejemplares sueltos
% 5.- Procesa y estima ejemplares agrupados en carpetas
% 6.- Procesa  carpetas con esquemas o recortes de im�genes tif,tiff,TIF
% 7.- Previamente deben colocarse las im�genes correspondientes a la muestra bajo estudio
%     agrupadas en una misma carpeta y debidamente escaladas
% 8.- Esta funci�n es complementaria de biometry_molar() 
%     Efect�a la estimaci�n de variedades mediante proceso batch sobre carpetas conteniendo
%     im�genes homog�neas ( recortes o esquemas ) 
%     Efect�a "leave one out" para evitar sesgos en la caracterizaci�n
% 9.- La resoluci�n de la unidad m�trica 1 mmm en tama�o 768x576
%      como en los recortes e imagenes al microscopio de los molares 
%     se usa como referencia para escalar los otros tipos de im�genes
% 10.- Funcion principal para app m1classifier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function analysis_molar_semiH()
clear
close all
warning off all;
workroot=cd;
dirpath=cd;%%%
% colocacion de las pantallas de trabajo e inicializaci�n de variables y par�metros
pantallasper
etapa=0;
div=200;% 200 puntos muestrales en semiper�metro molar anterior
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while etapa<8
    etapa=menu('Biometr�a con im�genes de molares: An�lisis',...
        '1.- Orientar las im�genes',...
        '2.- Ajuste m�trico / Medir ',...
        '3.- Clasificar LDC/Hf Recorte',...
        '4.- Clasificar LDC/Hf Esquema',...
        '5.- Clasificar Hf LOO carpeta Esquemas',...
        '6.- Clasificar Hf LOO carpeta Recortes',...
        '7.- Gestionar fichero referentes Semiperidentales200',...
        '8.- Reiniciar',...
        '9.- Salir'); 
    switch etapa
        case 1
            try
               Orientar_molar;
            catch
                continue
            end
            cd(workroot)
        case 2
            try
                [dirpath,div]=microMolar(dirpath);
            catch
                cd(workroot)
                continue
            end
            cd(workroot)
        case 3
            try
                dirpath=Recorte(dirpath,div);
            catch
                cd(workroot)               
                continue
            end
        case 4
            try
              dirpath=Esquema(dirpath,div);
            catch
                cd(workroot)
                continue
            end
        case 5
            try
              estimar_esquemasH(div) 
            catch
                cd(workroot)                
                continue
            end
        case 6
            try
            estimar_recortesH(div)
            catch
                cd(workroot)               
                continue
            end
        case 7
            try
                variedades_semi200(div)
            catch
                cd(workroot)
                continue
            end
        case 8
            clear
            close all
            workroot=cd;
            dirpath=cd;
            pantallasper
            etapa=0;
            div=200;
        case 9
            etapa=99;
    end
end
close all
return