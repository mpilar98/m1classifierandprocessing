% analysis_molar_semiH.m
% Función principal y  menú general de  medidas biométricas sobre recortes y esquemas de molares de micromamíferos
% Discrimina con algoritmos  Distancia de Hausdorff Modificada ,
% Distancia Procrustes y Linear Discriminant Classifier de Fisher
% Version 3-01-2023
% 1.- Orienta imágenes 
% 2.- Mide y escala 
% 3.- Procesa y estima sobre recortes de ejemplares sueltos 
% 4.- Procesa y estima sobre esquemas de ejemplares sueltos
% 5.- Procesa y estima ejemplares agrupados en carpetas
% 6.- Procesa  carpetas con esquemas o recortes de imágenes tif,tiff,TIF
% 7.- Previamente deben colocarse las imágenes correspondientes a la muestra bajo estudio
%     agrupadas en una misma carpeta y debidamente escaladas
% 8.- Esta función es complementaria de biometry_molar() 
%     Efectúa la estimación de variedades mediante proceso batch sobre carpetas conteniendo
%     imágenes homogéneas ( recortes o esquemas ) 
%     Efectúa "leave one out" para evitar sesgos en la caracterización
% 9.- La resolución de la unidad métrica 1 mmm en tamaño 768x576
%      como en los recortes e imagenes al microscopio de los molares 
%     se usa como referencia para escalar los otros tipos de imágenes
% 10.- Funcion principal para app m1classifier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function analysis_molar_semiH()
clear
close all
warning off all;
workroot=cd;
dirpath=cd;%%%
% colocacion de las pantallas de trabajo e inicialización de variables y parámetros
pantallasper
etapa=0;
div=200;% 200 puntos muestrales en semiperímetro molar anterior
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while etapa<8
    etapa=menu('Biometría con imágenes de molares: Análisis',...
        '1.- Orientar las imágenes',...
        '2.- Ajuste métrico / Medir ',...
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