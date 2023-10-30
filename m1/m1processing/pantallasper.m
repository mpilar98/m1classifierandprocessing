% pantallasper.m ajuste del entorno grafico para analisis perimetral de imágenes de molares
% inicializa todo el proceso de ajuste y medida
% version 8-01-2022
% colocacion de las pantallas de datos
% inicialización variables y parámetros
global uno dos tres cuatro
%%%%% configuracion pantallas
iptsetpref('ImshowInitialMagnification','fit');
iptsetpref('ImshowBorder','tight');
% tamaño pantalla computer
scrsz = get(0,'ScreenSize');
x0=scrsz(1);
y0=scrsz(2);
w0=scrsz(3);
h0=scrsz(4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pantalla 1/4  , arriba a la izquierda
figure('OuterPosition',[0 h0/2 w0/2 h0/2],'Menubar','none')%w0/3
uno=gcf; 
boca=imread('Arvicola sapidus.jpg');
imshow(boca)
axis off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pantalla 2/4 , arriba a la dcha
figure('OuterPosition',[w0/2 h0/2 w0/2 h0/2],'Menubar','none')
imshow('allophate_ejemplo.tif')
text(100,100,'molar m1','Color','b')
axis off
dos=gcf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Pantalla 3/4 : abajo a la izda
figure('OuterPosition',[0 0 w0/2 h0/2],'Menubar','none')
imshow('recorte.tif')
text(100,100,'Recorte','Color','b')
axis off
tres=gcf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pantalla 4/4 : abajo a la dcha
figure('OuterPosition',[w0/2 0 w0/2 h0/2],'Menubar','none')
cuatro=gcf;
imshow('10.tiff');
text(100,100,'Esquema','Color','b')
axis off
 return