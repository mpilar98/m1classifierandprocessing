# m1classifierandprocessing
In this repositorie you can find both apps: m1processing and m1classifier, their project (.prj), their installers (.malappinstall), and all the code in the corresponding folders.
1. m1processing let to process and prepare the "Recortes" and "Esquemas" to their posterior study, and to create or expand the data base. The options of m1processing are:

    1.1 Orient images (function Orientar_molar): let to modify the orientation of the images.
   
    1.2 Calibrate / Measure (funtion microMolar): let to measure and calibrate the images, using a reference scale (1mm)

    1.3 Process Esquema (function Esquema) and Process Recorte (function Recorte): let to process the images of "Esquemas" and "Recortes" respectively, identifying the semipremeter and defining the 200 point of the semiperimeter.

    1.4 Characterized Esquemas (function muestreos_esquemas) and Characterized Recortes (function muestreos_recortes): let to process the images of "Esquemas" and "Recortes" respectively of a folder, and create the archive .mat of the samples, identifying the semipremeter and defining the 200 point of the semiperimeter.

    1.5 Manage reference file (Semiperidentales200.mat, Semicentroides200.mat) (function variedades_semi200): build the file .mat of the varities and let to modify it.

    1.6 View file .mat / Crear fichero .tps: creates a .tps file for other types of analysis, with the information from the .mat file of the varieties.

2. m1classifier let to classify the "Recortes" and "Esquemas" in study, comparing with the data base. The options of m1classifier are:
   
    2.1 Orient images (function Orientar_molar): let to modify the orientation of the images.

    2.2 Calibrate / Measure (funtion microMolar): let to measure and calibrate the images, using a reference scale (1mm)

    2.3 Classify LDC/Hf Recorte (function Recorte) and Classify LDC/Hf Esquema (function Esquema): classifies the "Recortes" according Procustres, Fisher LDA and Hausdorff. Additionaly, it calculate the Van der Meulen indices. 

    2.4 Classify Hf LOO folder Esquemas (function estimar_esquemasH) Classify Hf LOO folder Recortes (funtion estimar_recortesH): classifies the "Esquemas" according Procustres, Fisher LDA and Hausdorff. Additionaly, it calculate the Van der Meulen indices.

    2.5 Manage reference file (Semiperidentales200.mat, Semicentroides200.mat) (function variedades_semi200): build the file .mat of the varities and let to modify it.
