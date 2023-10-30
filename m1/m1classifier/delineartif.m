function BW4 = delineartif(imagen,nivel)
% abre nueva imagen a procesar y realiza su esquematizado en lineas de 1 pixel
% BW2 es la imagen con 0's en las lineas y 1's al fondo
% BW4 es la imagen con 1's en las lineas y 0,s en el fondo
imagen=imsharpen(imagen,'Radius',2,'Amount',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW=im2bw(imagen,nivel);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW2 = imfill(BW,'holes');%%%
BW3=bwperim(BW2,4);%4
BW4 = median_filt(bwareaopen(BW3,100),1,1);
%%%%%%%%%%%%%%%
BW4(1,:)=0;
BW4(:,1)=0;
BW4(end,:)=0;
BW4(:,end)=0;
end