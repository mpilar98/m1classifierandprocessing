% vdmindicesB.m 
% Van der Meulen indices
% Release 10 dedember 2022
function Indices=vdmindicesB(I0,I,contorno,r,c,puntos,fichero)
global uno cuatro
factor=240;
%%%%%%%% 
F=find(I);
[row, col]=ind2sub([r c],F(1));
[~, xd]=ind2sub([r c],F(end));
 y1=row;
 x1=col;
 %%%%%%%%%%%%%%%%%%%
contoury=contorno(:,2);
contourx=contorno(:,1);
pix=size(contourx,1);
U(1:pix)=contourx(1:end);
V(1:pix)=contoury(1:end);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,indd]=find(V==xd);
ind=floor(mean(indd));
%%%%%%%%%%%%%%%%%%
[row2, col2]=ind2sub([r c],F(end)); 
%%%%%%%%%%  
y2= floor(mean(contourx)); %  image centroid
x2= floor(mean(contoury));
%%%
x4= floor((x2+x1)/2);% x 1/4
x3=floor((2*x2+x1)/3);% x 1/3
ofset=floor((x3-x4)/2);%  1/3 - 1/4 /2
%%%%%%%%%%%%%% 
    figure(uno)
    clf(gcf)
    imshow(imcomplement(I0))
    text(10,10,fichero)
    line([x2 x2],[1 r],'Color','k','LineStyle','-.') 
    hold on
    plot(x2,y2,'bo') % centroid
    hold on
%%%%%%% 
TF1min=islocalmax(U(1:ind),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'last');
plot(V,U,V(TF1min),U(TF1min),'r^')
%%%%%%%% 
TF1max = islocalmin(U(1:ind),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs2=find(TF1max);
plot(V,U,V(TF1max),U(TF1max),'b*')
nmax1=sum(TF1max);
%%%%%% 
plot(V(locs2(nmax1-2)), U(locs2(nmax1-2)),'r*')
hold on
T4=[V(locs2(nmax1-3)) U(locs2(nmax1-3))];
plot(V(locs2(nmax1-3)), U(locs2(nmax1-3)),'r*')
hold on
T5=[V(locs2(nmax1-4)) U(locs2(nmax1-4))];
plot(V(locs2(nmax1-4)), U(locs2(nmax1-4)),'g*') 
hold on
%%%%%%%% 
TF2min=islocalmax(U(ind:puntos),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs4=find(TF2min);
nmin2=sum(TF2min);
%%%%%%%
 plot(V(ind+locs4),U(ind+locs4),'r^') 
 hold on
%%%%%%%%%%% 
b3=[V(ind+locs4(3)) U(ind+locs4(3))];
plot(V(ind+locs4(3)), U(ind+locs4(3)),'*r')
hold on
%%%%%%%% 
TF2max=islocalmin(U(ind:puntos),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'last');
locs5=find(TF2max);
 %%%%%%%%
if nmin2>4
    b4=[V(ind+locs4(4)) U(ind+locs4(4))];
    plot(V(ind+locs4(4)),U(ind+locs4(4)),'*b')
    hold on
 else
     b4=[V(ind+locs4(end)) U(ind+locs4(end))];
     S7=[V(ind+locs5(3):ind+locs4(4))',U(ind+locs5(3):ind+locs4(4))'];
    plot(V(ind+locs4(end)),U(ind+locs4(end)),'*b') 
 end
%%%%%%%%%%% 
 B4=[V(ind+locs5(end)) U(ind+locs5(end))];
 plot(V(ind+locs5(end)),U(ind+locs5(end)),'*r')
 hold on
%%%%%%%%% 
S3=[V(locs2(nmax1-3):locs2(nmax1-2))', U(locs2(nmax1-3):locs2(nmax1-2))'];
plot(V(locs2(nmax1-3):locs2(nmax1-2)),U(locs2(nmax1-3):locs2(nmax1-2)),'y.')
%%%% 
S2=[V(ind+locs4(2):ind+locs4(3))',U(ind+locs4(2):ind+locs4(3))'];
plot(V(ind+locs4(2):ind+locs4(3)),U(ind+locs4(2):ind+locs4(3)),'y.')
%%%% 
S5=[V(locs2(nmax1-4):locs2(nmax1-3))',U(locs2(nmax1-4):locs2(nmax1-3))'];
plot(V(locs2(nmax1-4):locs2(nmax1-3)), U(locs2(nmax1-4):locs2(nmax1-3)),'g.')
%%%% 
S1=[V(ofset:locs2(nmax1-4))', U(ofset:locs2(nmax1-4))'];
plot(V(ofset:locs2(nmax1-4)),U(ofset:locs2(nmax1-4)),'r.')
%%%% 
S6=[V(ind+locs4(3):ind+locs4(4))',U(ind+locs4(3):ind+locs4(4))'];
plot(V(ind+locs4(3):ind+locs4(4)),U(ind+locs4(3):ind+locs4(4)),'g.')
%%%%%%%%%%%
if nmin2>4   
    [d,P1,~]=mindist(S1,B4);
    line([V(P1+ofset) B4(1)],[U(P1+ofset) B4(2)],'Color','g')
    text(0.5*(V(P1+ofset)+B4(1))+10,0.5*(U(P1+ofset)+B4(2)+20),'d','Color','g')%-10,+20?
    %%%%% 
    e=norm([T5(1),T5(2)]-[B4(1),B4(2)])/factor;
    line([b4(1) T5(1)],[b4(2) T5(2)],'Color','c')
    text(0.5*(b4(1)+T5(1))-10,0.5*(b4(2)+T5(2))+20,'e','Color','c')
else
    [d,P1,Q1]=mindist(S1,S6);% para calcular d 
    line([V(P1+ofset) V(Q1+ind+locs4(3))],[U(P1+ofset) U(Q1+ind+locs4(3))],'Color','g')
    text(0.5*(V(P1+ofset)+V(Q1+ind+locs4(3)))+20,0.5*(U(P1+ofset)+U(Q1+ind+locs4(3))),'d','Color','g')
    %%%% 
    [e,Q7]=maxdist(T5,S7);
    line([V(locs5(3)+ind+Q7) T5(1)],[U(locs5(3)+ind+Q7) T5(2)],'Color','c')
    text(0.5*(V(locs5(3)+ind+Q7)+T5(1))-10,0.5*(U(locs5(3)+ind+Q7)+T5(2))+20,'e','Color','c')
end
%%%%%%%
[b,P2,Q2]=mindist(S5,S6);
line([V(P2+locs2(nmax1-4)) V(Q2+ind+locs4(3))],[U(P2+locs2(nmax1-4)) U(Q2+ind+locs4(3))],'Color','r')
text(0.5*(V(P2+locs2(nmax1-4))+V(Q2+ind+locs4(3)))-10,0.5*(U(P2+locs2(nmax1-4))+U(Q2+ind+locs4(3)))+10,'b','Color','r')
%%%%%%%%%%
[c,P3,Q3]=mindist(S3,S6);
line([V(P3+locs2(nmax1-3)) V(Q3+ind+locs4(3))],[U(P3+locs2(nmax1-3)) U(Q3+ind+locs4(3))],'Color','r')
text(0.5*(V(P3+locs2(nmax1-3))+V(Q3+ind+locs4(3)))-20,0.5*(U(P3+locs2(nmax1-3))+U(Q3+ind+locs4(3)))+10,'c','Color','m')
Plali=[V(P3+locs2(nmax1-3)) U(P3+locs2(nmax1-3))];
%%%%%%% VdM indices
L=norm([x1,y1]-[col2,row2])/factor;
W=norm(T4-b3)/factor;
La=norm(b3-Plali)/factor;
Li=norm(T4-Plali)/factor;
%%%%%%%%%%%%%%%% 
[~,P4,Q4]=mindist(S3,S2);%
%%%%%%%% 
line([V(P4+locs2(nmax1-3)) V(Q4+ind+locs4(2))],[U(P4+locs2(nmax1-3)) U(Q4+ind+locs4(2))],'Color','y')
%%%%%%%%
a=norm([x1,y1]-[V(P4+locs2(nmax1-3)),U(P4+locs2(nmax1-3))])/factor;
line([V(P4+locs2(nmax1-3)) x1],[U(P4+locs2(nmax1-3)) y1],'LineStyle','--','Color','r')
text(0.7*(V(P4+locs2(nmax1-3))),U(P4+locs2(nmax1-3))-10,'a','Color','r')
%%%%%%%%%%% 
line([x1 col2],[y1 row2],'Color','b','LineStyle',':')
text(0.75*col2,row2-10,'L','Color','b')
%%%%%%%%%%%%%%%%% 
line([b3(1) T4(1)],[b3(2) T4(2)],'Color','b')
text(b3(1)-10,0.9*b3(2),'W','Color','b')
hold on
% %%%%%%%
AL=100*a/L;
BW=100*b/W;
CW=100*c/W;
DW=100*d/W;
EW=100*e/W;
Simetry=100*La/Li;
%%%%%%%%%%%%%%%%%%%%%%
figure(cuatro)
clf(gcf)
axis([1 100 1 200])
axis off
text(15,200,'Van der Meulen Indices')
%%%%%%% longitud L
text(12,190,'L : ')
text(20,190,num2str(L,3))
text(30,190,'mm','Color','b');
%%%%%%%% anchura W
text(12,180,'W : ')
text(20,180,num2str(W,3))
text(30,180,'mm','Color','b')
%%%%%%%%% segmento e
text(12,170,'e : ')
text(20,170,num2str(e,3))
text(30,170,'mm','Color','c')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,160,'d : ')
text(20,160,num2str(d,3))
text(30,160,'mm','Color','g')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,150,'b : ')
text(20,150,num2str(b,3))
text(30,150,'mm','Color','r')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,140,'c : ')
text(20,140,num2str(c,3))
text(30,140,'mm','Color','m')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,130,'a : ')
text(20,130,num2str(a,3))
text(30,130,'mm','Color','r')
%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,120,'La : ')
text(20,120,num2str(La,3))
text(30,120,'mm','Color','b')
%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,110,'Li : ')
text(20,110,num2str(Li,3))
text(30,110,'mm','Color','b')
%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,90,'A/L : ')
text(25,90,num2str(AL,3))
%%%%%
text(12,80,'B/W : ')
text(25,80,num2str(BW,3))
%%%%%%%%%%%
text(12,70,'C/W : ')
text(25,70,num2str(CW,3))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,60,'D/W : ')
text(25,60,num2str(DW,3))
%%%%%%%%%%%%%%%%%%%%
text(12,50,'E/W : ')
text(25,50,num2str(EW,3))
%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,40,'Simetry:')
text(25,40,num2str(Simetry,3))
%%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,20,fichero,'Interpreter','none')
hold off
%%%%%%%%%%%%% 
ci=0;
segmento=' ';
while ci<8
    ci=masMENUvdm('Manual measurement',...
        '1.- a',...
        '2.- b',...
        '3.- c',...
        '4.- d',...
        '5.- e',...
        '6.- other',...
        '7.- End');
     switch ci
        case 1
            segmento=' a';
            a=micromanualvdm(I0,segmento);
            corregirvdm(a,b,c,d,e,L,W,La,Li,fichero);            
        case 2
            segmento=' b';
            b=micromanualvdm(I0,segmento);
            corregirvdm(a,b,c,d,e,L,W,La,Li,fichero);
        case 3
            segmento=' c';
            c=micromanualvdm(I0,segmento);
            corregirvdm(a,b,c,d,e,L,W,La,Li,fichero);
        case 4
            segmento=' d';
            d=micromanualvdm(I0,segmento); 
            corregirvdm(a,b,c,d,e,L,W,La,Li,fichero);
        case 5
            segmento=' e';
            e=micromanualvdm(I0,segmento);
            corregirvdm(a,b,c,d,e,L,W,La,Li,fichero);
        case 6
            segmento=' X';
            [~]=micromanualvdm(I0,segmento);
        case 7
            break
     end    
end          
%%%%%%%%%%%%%%%%%%%%%%
Indices=[L W e d b c a La Li];
end
