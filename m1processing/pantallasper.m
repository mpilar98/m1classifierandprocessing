% pantallasper.m 
% Graphical environment adjustment for the perimetral analisys of m1 molars
% Release 8-01-2022
% Initialize variables 
global uno dos tres cuatro
%%%%% Computer Screen configuration
iptsetpref('ImshowInitialMagnification','fit');
iptsetpref('ImshowBorder','tight');
% size of computer screen
scrsz = get(0,'ScreenSize');
x0=scrsz(1);
y0=scrsz(2);
w0=scrsz(3);
h0=scrsz(4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Window 1/4  
figure('OuterPosition',[0 h0/2 w0/2 h0/2],'Menubar','none')%w0/3
uno=gcf; 
boca=imread('Arvicola sapidus.jpg');
imshow(boca)
axis off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Window 2/4 
figure('OuterPosition',[w0/2 h0/2 w0/2 h0/2],'Menubar','none')
imshow('allophate_ejemplo.tif')
text(100,100,'molar m1','Color','b')
axis off
dos=gcf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Window 3/4 
figure('OuterPosition',[0 0 w0/2 h0/2],'Menubar','none')
imshow('recorte.tif')
text(100,100,'Occlusal surface','Color','b')
axis off
tres=gcf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Window 4/4 
figure('OuterPosition',[w0/2 0 w0/2 h0/2],'Menubar','none')
cuatro=gcf;
imshow('10.tiff');
text(100,100,'Drawing','Color','b')
axis off
 return