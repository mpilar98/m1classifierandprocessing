# m1classifierandprocessing
In this repositorie you can find both apps: m1processing and m1classifier, their project (.prj), their installers (.mlappinstall), and all the code in the corresponding folders.
Installation:
To instal both programs you need to open de installerrs (.mlappinstall) in MatLab. MatLab can be downloaded from the official website.  
For the proper functioning of the applications, you will need to have the following products installed in MATLAB: MATLAB, Computer Vision System Toolbox, DSP System Toolbox, Image Processing Toolbox, Signal Processing Toolbox, and Statistics and Machine Learning Toolbox.

1. m1processing let to process and prepare the "Recortes" and "Esquemas" to their posterior study, and to create or expand the data base. The options of m1processing are:

    1.1 Orient images (function Orientar_molar): let to modify the orientation of the images.
   
    1.2 Calibrate / Measure (funtion microMolar): let to measure and calibrate the images, using a reference scale (1mm)

    1.3 Process Esquema (function Esquema) and Process Recorte (function Recorte): let to process the images of "Esquemas" and "Recortes" respectively, identifying the semipremeter and defining the 200 points of the semiperimeter.

    1.4 Characterized Esquemas (function muestreos_esquemas) and Characterized Recortes (function muestreos_recortes): let to process the images of "Esquemas" and "Recortes" respectively of a folder, and create the archive .mat of the samples, identifying the semipremeter and defining the 200 points of the semiperimeter.

    1.5 Manage reference file (Semiperidentales200.mat, Semicentroides200.mat) (function variedades_semi200): build the file .mat of the varities and let to modify it. This option gide the user in how to add new photos, from species already defined or from new species, to the data base

    1.6 View file .mat / Crear fichero .tps: creates a .tps file for other types of analysis, with the information from the .mat file of the varieties.

2. m1classifier let to classify the "Recortes" and "Esquemas" in study, comparing them with the data base. The options of m1classifier are:
   
    2.1 Orient images (function Orientar_molar): let to modify the orientation of the images.

    2.2 Calibrate / Measure (funtion microMolar): let to measure and calibrate the images, using a reference scale (1mm)

    2.3 Classify LDC/Hf Recorte (function Recorte) and Classify LDC/Hf Esquema (function Esquema): classifies the "Recortes" and "Esquemas" according Procustres, Fisher LDA and Hausdorff. Additionaly, it calculate the Van der Meulen indices. 

    2.4 Classify Hf LOO folder Esquemas (function estimar_esquemasH) Classify Hf LOO folder Recortes (funtion estimar_recortesH): classifies the "Esquemas" and "Recortes" of a folder according Procustres, Fisher LDA and Hausdorff. Additionaly, it calculate the Van der Meulen indices.

    2.5 Manage reference file (Semiperidentales200.mat, Semicentroides200.mat) (function variedades_semi200): build the file .mat of the varities and let to modify it.
