function BW7=areas(imagen)
% estudio topológico de las regiones en la imagen binaria.
%
global cuatro
%%%%%%%%%%%%%%% encontrar regiones %%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW6=bwlabel(imagen,4);
objetos=max(max(BW6));
map=[0,0,0;jet(objetos)]; %
figure(cuatro)
clf
imshow(BW6+1,map)
hold on
%%%%% encontrar areas y centroides de las regiones
area=regionprops(BW6,'Area');
centros=regionprops(BW6,'Centroid');
% seleccionar las ocho regiones de mayor area
for i=1:objetos
    celulas(i)=area(i).Area;
end
[~,indice]=sort(celulas,'descend');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:objetos
    puntos(j,:)=centros(indice(j)).Centroid;
end 
for k=1:objetos
    text(puntos(k,1),puntos(k,2),int2str(k))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[B,L,~,~] = bwboundaries(BW6);
figure(cuatro), imshow(BW6); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
for k=1:length(B)
    boundary = B{k};
    cidx = mod(k,length(colors))+1;
    plot(boundary(:,2), boundary(:,1),...
         colors(cidx),'LineWidth',2);
    rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
    col = boundary(rndRow,2); row = boundary(rndRow,1);
    h = text(col+1, row-1, num2str(L(row,col)));
    set(h,'Color',colors(cidx),...
        'FontSize',14,'FontWeight','bold');
end
%%%%%%%%%%%%%%%%%% Bucle adaptativo
for k=1:7
BW4 = bwareafilt(imcomplement(imagen),k,'largest');% las regiones de interés
BW1 = bwareafilt(imcomplement(imagen),1,'largest');% el marco restante
BW7=bwperim(and(imcomplement(BW1),BW4),8);%4
pixeles(k)=sum(sum(BW7));
if pixeles(k)>2500
    break
else
    continue;
end
end
hold off
end
  

 