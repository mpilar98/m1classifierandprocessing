function BW7=areasplus(imagen)
% tophological study of the regions in the binary image.
% version 9/01/2022
global uno dos tres cuatro
%%%%%%%%%%%%%%% find regions %%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW6=bwlabel(imagen,4);%4
objetos=max(max(BW6));
map=[0,0,0;jet(objetos)]; %
%%%%%%%%%%% to figure
% % % figure(cuatro)
% % % clf
% % % imshow(BW6+1,map)
% % % hold on
%%%%%%%%%%%%%%%
% % % [B,L,N,A] = bwboundaries(BW6);
% % % figure(cuatro), imshow(BW6); hold on;
% % % colors=['b' 'g' 'r' 'c' 'm' 'y'];
% % % for k=1:length(B)
% % %     boundary = B{k};
% % %     cidx = mod(k,length(colors))+1;
% % %     plot(boundary(:,2), boundary(:,1),...
% % %          colors(cidx),'LineWidth',2);
% % %     %randomize text position for better visibility
% % %     rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
% % %     col = boundary(rndRow,2); row = boundary(rndRow,1);
% % %     h = text(col+1, row-1, num2str(L(row,col)));
% % %     set(h,'Color',colors(cidx),...
% % %         'FontSize',14,'FontWeight','bold');
% % % end

%%%%% find areas and centroids of the regions
area=regionprops(BW6,'Area');
centros=regionprops(BW6,'Centroid');
%
% select the eight major area regions
for i=1:objetos
    celulas(i)=area(i).Area;
end
[celulas,indice]=sort(celulas,'descend');
% ocho=celulas(1:8) % 8 regions with the largest surface area, one of which is the canvas
% corresponding to idex 1
% cc = bwconncomp(imagen); 
% area = regionprops(cc, 'Area'); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% media=mean([area.Area]);
% idx = find([area.Area] > media/2); %500
% BW8 = ismember(labelmatrix(cc), idx);
% figure(uno)
% clf(gcf)
% imshow(BW8)
% hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:objetos
    puntos(j,:)=centros(indice(j)).Centroid;
end
% puntos(1,:)=centros(indice(1)).Centroid; % Largest cell surface area
% puntos(2,:)=centros(indice(2)).Centroid; % 
% puntos(3,:)=centros(indice(3)).Centroid; % 
% puntos(4,:)=centros(indice(4)).Centroid % 
% puntos(5,:)=centros(indice(5)).Centroid % 
% puntos(6,:)=centros(indice(6)).Centroid % 
% plot(puntos(1,1),puntos(1,2),'w+') % image
% plot(puntos(2,1),puntos(2,2),'ro') % cell
% plot(puntos(3,1),puntos(3,2),'go') % cell
% plot(puntos(4,1),puntos(4,2),'bo') % cell
% plot(puntos(5,1),puntos(5,2),'w*') % cell 
% plot(puntos(6,1),puntos(6,2),'m?') % cell 
for k=1:objetos
    text(puntos(k,1),puntos(k,2),int2str(k))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all
% close all
% [B,L,N] = bwboundaries(BW5);
% figure; imshow(BW5); hold on;
% for k=1:length(B),
%     boundary = B{k};
%     if(k > N)
%         plot(boundary(:,2),...
%             boundary(:,1),'g','LineWidth',2);
%     else
%         plot(boundary(:,2),...
%             boundary(:,1),'r','LineWidth',2);
%     end
% end
%%%%%%%%%%%%% Visual representation of the areas to be eliminated
% % % [B,L,N,A] = bwboundaries(BW6);
%%%%%%%%%%%%% I dispense visual representation to improve efficiency.
%%%%%%%%%%%%% when processing folders
% % % figure(cuatro), imshow(BW6); hold off;%on
% % % colors=['b' 'g' 'r' 'c' 'm' 'y'];
% % % for k=1:length(B)
% % %     boundary = B{k};
% % %     cidx = mod(k,length(colors))+1;
% % %     plot(boundary(:,2), boundary(:,1),...
% % %          colors(cidx),'LineWidth',2);
% % %     %randomize text position for better visibility
% % %     rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
% % %     col = boundary(rndRow,2); row = boundary(rndRow,1);
% % %     h = text(col+1, row-1, num2str(L(row,col)));
% % %     set(h,'Color',colors(cidx),...
% % %         'FontSize',14,'FontWeight','bold');
% % % end
%%%%%%%%%%% 
% % % BW4 = bwareafilt(imcomplement(imagen),2,'largest');% the interest regions
% % % BW1 = bwareafilt(imcomplement(imagen),1,'largest');% the remaining framework
% % % BW7=bwperim(and(imcomplement(BW1),BW4),8);%4
% % % pixeles=sum(sum(BW7))
%%%%%%%%%%%%%%%%%% Adaptative loop
for k=1:7
BW4 = bwareafilt(imcomplement(imagen),k,'largest');% the interest regions
BW1 = bwareafilt(imcomplement(imagen),1,'largest');% the remaining framework
BW7=bwperim(and(imcomplement(BW1),BW4),8);%4
pixeles(k)=sum(sum(BW7));
if pixeles(k)>2500
    break
else
    continue;%k=k+1
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % figure(uno)
% % % clf(gcf)
% % % imshow(BW7)%BW7
% % % hold off

%
hold off
end
  

 