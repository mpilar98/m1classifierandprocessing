function BW4 = delineartif(imagen,nivel)
% open new image to process and makes its outline in 1 pixel lines
% BW2 is the image with 0's in the lines and 1's in the background
% BW4 is the image with 1's in the lines and 0,s in the background
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