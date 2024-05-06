% analysis_molar_semiH.m
% Main function: Start menu for biometrical mesures on m1 micrommanmals molars
% Discriminant algorithms: Modified Hausdorff Distance, Procrustes Distance ,
% and Fisher's Linear Discriminant Classifier 
% Release 3-01-2023
% Main steps:
% 1.- Image orientation 
% 2.- Scale and measure
% 3.- Estime and process individual items (m1 Drawings and m1 Occlusal surfaces)
% 4.- Estime and process files containing a sample of images (tif,tiff,TIF)
% 5.- The images of the sample must previously be scaled and stored in an accesible file
% 6.- This function complements the characterizing m1 molars function biometry_molar_semi() 
%     The estimation of the species is accomplised under a batch process on
%     files containing homogeneous images (Drawings or Occlusal surfaces) 
%     It uses the "leave one out" method to avoid biases in the characterization of the samples
% 7.- The 1 mm metric unit, as in the 768x576 microscopical TIFF images, is also a reference to scale
%     other images (Drawings ...)
% 8.- This is also the Main Function for the m1classify app
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function analysis_molar_semiH()
clear
close all
warning off all;
workroot=cd;
dirpath=cd;%%%
% Screens definition and variables inicialization
pantallasper
etapa=0;
div=200;% 200 sampling points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while etapa<8
    etapa=menu('M1 molars images Biometry : Analysis',...
        '1.- Orient images',...
        '2.- Metric adjustment / Measure ',...
        '3.- Clasify LDC/Hf Occlusal surface',...
        '4.- Clasify LDC/Hf Drawing',...
        '5.- Clasify Hf LOO drawing sample file',...
        '6.- Clasify Hf LOO occlusal sample file',...
        '7.- Manage reference data file Semiperidentales200',...
        '8.- Reboot',...
        '9.- Exit'); 
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