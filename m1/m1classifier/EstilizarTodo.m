function imdib=EstilizarTodo(imagen,umbral)
level=graythresh(imagen)+umbral;% +0.16 
BW=imbinarize(uint8(imagen),level);
            BW1=bwmorph(BW,'erode',1);
            BW2=bwmorph(BW1,'thicken',Inf); %obtengo lineas de 1 pixel
 %pero el fondo son 1's y las lineas 0's
            BW3=changem(BW2,1,0);
            BW4=xor(BW3,BW2);%ya tenemos 1's en las lineas y 0's en el fondo
            imdib=bwareaopen(BW4,64,8);% imagen=bwareaopen(imagen,128,8);
% imagen estilizada a lineas de 1 pixel
end