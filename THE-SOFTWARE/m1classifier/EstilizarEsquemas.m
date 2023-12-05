function imdib=EstilizarEsquemas(imagen)
umbral=graythresh(imagen)+0.35;
if umbral>=0.95 
    umbral=0.9;
else
end
BW=bwmorph(median_filt(im2bw(imagen,umbral),1,1),'hbreak');
BW1=bwmorph(BW,'thicken',Inf);
BW2=changem(BW1,1,0);
BW3=xor(BW2,BW1);
BW4=bwmorph(BW3,'fill');
BW5=bwmorph(BW4,'clean');
imdib=bwareaopen(BW5,50,8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imagen estilizada a lineas de 1 pixel
end