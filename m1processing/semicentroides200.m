function semicentroides200()
% Building Semicentroides200.mat file for Haussdorf analisys
global dos 
load Semiperidentales200.mat origen X Y
Etiquetas=etiquetas(origen);
%
num=size(X,1);
m=1;
sample=char(origen(1));
n=1;
s=0;
%%%%%%%%%%%%%
 for k=1:num
        M(k,:,:)=[X(k,:)',Y(k,:)'];
 end
    for kk=1:num
        [D(kk),MC(kk,:,:)]=procrustes([M(1,:,1)' M(1,:,2)'],[M(kk,:,1)' M(kk,:,2)']);   
    end
while n<num
    while strcmp(sample,char(origen(n))) 
        m=m+1;
        if m>num
            break
        else
        sample=char(origen(m));
        end
    end
    s=s+1;
    variedad(s)=origen(n);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    XC(s,:)=mean(MC(n:m-1,:,1));% media de cada landmark
    YC(s,:)=mean(MC(n:m-1,:,2));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     if m>num
          break
     else 
        sample=char(origen(m));
        n=m;
     end
end
save('Semicentroides200.mat','XC','YC','variedad');
figure(dos)
clf(gcf)
axis([1 100 1 30]);
axis off
text(10,10,'Semiperimetral Centroids file correctly build','Color','b')
text(10,20,'200 semiperimetral points')
hold off
clear origen X Y XC YC variedad s k kk m n num sample
end