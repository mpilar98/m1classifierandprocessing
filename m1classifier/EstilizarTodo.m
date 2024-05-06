function imdib=EstilizarTodo(imagen,umbral)
level=graythresh(imagen)+umbral;
BW=imbinarize(uint8(imagen),level);
            BW1=bwmorph(BW,'erode',1);
            BW2=bwmorph(BW1,'thicken',Inf); 
            BW3=changem(BW2,1,0);
            BW4=xor(BW3,BW2);
            imdib=bwareaopen(BW4,64,8);% imagen=bwareaopen(imagen,128,8);
end