function BW4 = delineartif(imagen,nivel)
imagen=imsharpen(imagen,'Radius',2,'Amount',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW=im2bw(imagen,nivel);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW2 = imfill(BW,'holes');
BW3=bwperim(BW2,4);
BW4 =255*median_filt(bwareaopen(BW3,100),1,1);
%%%%%%%%%%%%%%%
BW4(1,:)=0;
BW4(:,1)=0;
BW4(end,:)=0;
BW4(:,end)=0;
end

