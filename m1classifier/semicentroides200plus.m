% function semicentroides200plus() changed to script
% preparation of file Semicentroides200.mat for Haussdorf analysis
% from the data base of the varieties randomly increased
% Create a table. Sort by species and then create Centroids
% global dos % Needed if this was a function
clear suma X Y origen molar
load Semiperidentales200.mat origen molar X Y
% Etiquetas=etiquetas(origen);%Not needed
Tabla=table(origen,X,Y);
Tabla=sortrows(Tabla,'origen');
U=Tabla.X;
V=Tabla.Y;
especie=Tabla.origen;
%
num=size(X,1);
m=0;
sample=char(especie(1));
n=1;
s=1;
%%%%%%%%%%%%%
 for k=1:num
        M(k,:,:)=[U(k,:)',V(k,:)'];
 end
    for kk=1:num
        [D(kk),MC(kk,:,:)]=procrustes([M(1,:,1)' M(1,:,2)'],[M(kk,:,1)' M(kk,:,2)']);   
    end
while n<num
    while strcmp(sample,char(especie(n)))
         m=m+1;
        if m>num
            break
        else
         sample=char(especie(m));
         m=m+1;
        end
    end
%     s=s+1;
    variedad(s)=especie(n);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    XC(s,:)=mean(MC(n:m-1,:,1));% mean of each landmark
    YC(s,:)=mean(MC(n:m-1,:,2));
      s=s+1;%%%?
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     if m>num
          break
     else 
        sample=especie(m);
        n=m;
     end
end
save('Semicentroides200.mat','XC','YC','variedad');
figure(dos)
clf(gcf)
axis([1 100 1 30]);
axis off
text(10,10,'Building Centroids File of Species in database OK','Color','b')
text(10,20,'200 semiperimetral points')
hold off
clear origen X Y XC YC variedad s k kk m n num sample
return