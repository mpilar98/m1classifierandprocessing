% vdmindicesB.m procesamiento de perimetros
% de esquemas y recortes individuales previamente calibrados
% Calculo de los indices de Van der Meulen
% Segmentos d,e problemáticos. Errores no descartables
% Versión 6 octubre 2023. Funcional
function Indices=vdmindicesB(I0,I,contorno,r,c,puntos,fichero)
global uno cuatro
factor=240;
%%%%%%%% Bloque cálculo Indices VdM
F=find(I);
[row, col]=ind2sub([r c],F(1));% ápice dental
[~, xd]=ind2sub([r c],F(end));
 y1=row;
 x1=col;
 %%%%%%%%%%%%%%%%%%%contorno sin diezmar%%%%%%%%%%%
contoury=contorno(:,2);
contourx=contorno(:,1);
pix=size(contourx,1);
U(1:pix)=contourx(1:end);
V(1:pix)=contoury(1:end);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,indd]=find(V==xd);% indice del extremo derecho
ind=floor(mean(indd));
%%%%%%%%%%%%%%%%%%
[row2, col2]=ind2sub([r c],F(end)); %extremo posterior
%%%%%%%%%%  Calculo del centroide del perimetro dental 
y2= floor(mean(contourx)); % localización centroide imagen
x2= floor(mean(contoury));
%%%%%%%%%% Calculando ofset
%%% buscando partes de la imagen 
x4= floor((x2+x1)/2);% x 1/4
x3=floor((2*x2+x1)/3);% x 1/3
ofset=floor((x3-x4)/2);%  1/3 - 1/4 /2
%%%%%%%%%%%%%% 
    figure(uno)
    clf(gcf)
    imshow(imcomplement(I0))
    text(10,10,fichero)
    line([x2 x2],[1 r],'Color','k','LineStyle','-.') % linea centroide
    hold on
    plot(x2,y2,'bo') % centroide
    hold on
%%%%%%% Buscar y pintar picos mínimos locales semiperimetro superior
TF1min=islocalmax(U(1:ind),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'last');
% locs1=find(TF1min);
plot(V,U,V(TF1min),U(TF1min),'r^')
% nmin1=sum(TF1min);% numero minimos locales en semiperimetro superior
%%%%%%%% Buscar y pintar máximos locales en semiperimetro superior
TF1max = islocalmin(U(1:ind),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs2=find(TF1max);
plot(V,U,V(TF1max),U(TF1max),'b*')
nmax1=sum(TF1max);% numero de maximos en perimetro superior
%%%%%% Calculo puntos perimetro superior necesarios para VdM
plot(V(locs2(nmax1-2)), U(locs2(nmax1-2)),'r*')
hold on
T4=[V(locs2(nmax1-3)) U(locs2(nmax1-3))];
plot(V(locs2(nmax1-3)), U(locs2(nmax1-3)),'r*')
hold on
T5=[V(locs2(nmax1-4)) U(locs2(nmax1-4))];
%plot(V(locs2(nmax1-4)), U(locs2(nmax1-4)),'g*') 
hold on
%%%%%%%% En perimetro inferior %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% El extremo derecho de la imagen es row2 col2, con indice ind
% El extremo izquierdo final es x1,y1 con indice ini = puntos
%%%%%%%% Buscar y pintar mínimos locales en semiperimetro inferior
TF2min=islocalmax(U(ind:puntos),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'first');
locs4=find(TF2min);
nmin2=sum(TF2min);
%%%%%%%
 plot(V(ind+locs4),U(ind+locs4),'r^') % minimos semiper inf
 hold on
%%%%%%%%%%% Nombrando minimos locales necesarios para calculos
%%%%%% En el semiperimetro inferior los indices cuentan al revés 
b3=[V(ind+locs4(3)) U(ind+locs4(3))];
plot(V(ind+locs4(3)), U(ind+locs4(3)),'*r')
hold on
%%%%%%%% Buscar y pintar máximos locales en semiperimetro inferior
TF2max=islocalmin(U(ind:puntos),'MinProminence',3,'MinSeparation',ofset,'FlatSelection', 'last');
locs5=find(TF2max);
 %%%%%%%% Minimo local b4 en semiperim inferior
if nmin2>4
    b4=[V(ind+locs4(4)) U(ind+locs4(4))];
    plot(V(ind+locs4(4)),U(ind+locs4(4)),'*b')
    hold on
 else
     b4=[V(ind+locs4(end)) U(ind+locs4(end))];
     S7=[V(ind+locs5(3):ind+locs4(4))',U(ind+locs5(3):ind+locs4(4))'];
     plot(V(ind+locs4(end)),U(ind+locs4(end)),'*b') 
 end
%%%%%%%%%%% Maximo local B4 em semiperim inferior
 B4=[V(ind+locs5(end)) U(ind+locs5(end))];
 plot(V(ind+locs5(end)),U(ind+locs5(end)),'*r')
 hold on
%%%%%%%%% Mínimo local t3 en semiperimetro superior
%     t3=[V(locs1(nmin1-2)) U(locs1(nmin1-2))];
%%%%%%%% Minimo local 
%%%%%%%%% Calculo de segmentos molares
%%%% Segmento S3 entre T4 y T3 
S3=[V(locs2(nmax1-3):locs2(nmax1-2))', U(locs2(nmax1-3):locs2(nmax1-2))'];
plot(V(locs2(nmax1-3):locs2(nmax1-2)),U(locs2(nmax1-3):locs2(nmax1-2)),'y.')
%%%% Segmento S2 entre b2 y b3
S2=[V(ind+locs4(2):ind+locs4(3))',U(ind+locs4(2):ind+locs4(3))'];
plot(V(ind+locs4(2):ind+locs4(3)),U(ind+locs4(2):ind+locs4(3)),'y.')
%%%% Segmento S5 entre T5 y T4
S5=[V(locs2(nmax1-4):locs2(nmax1-3))',U(locs2(nmax1-4):locs2(nmax1-3))'];
plot(V(locs2(nmax1-4):locs2(nmax1-3)), U(locs2(nmax1-4):locs2(nmax1-3)),'g.')
%%%% Segmento S1 entre P1+ofset y T5 OK
S1=[V(ofset:locs2(nmax1-4))', U(ofset:locs2(nmax1-4))'];
plot(V(ofset:locs2(nmax1-4)),U(ofset:locs2(nmax1-4)),'r.')
%%%% Segmento S4 entre B3 y b4
% % % S4=[V(ind+locs5(3):ind+locs4(end))',U(ind+locs5(3):ind+locs4(end))'];%
% % % plot(V(ind+locs5(3):ind+locs4(end)), U(ind+locs5(3):ind+locs4(end)),'r.')%
%%%%  Segmento S6 entre b3 y min(end-1) 
S6=[V(ind+locs4(3):ind+locs4(4))',U(ind+locs4(3):ind+locs4(4))'];
plot(V(ind+locs4(3):ind+locs4(4)),U(ind+locs4(3):ind+locs4(4)),'g.')
%%%%%%%%%%% Calculando distancias mínimas entre segmentos
if nmin2>4   
    [d,P1,~]=mindist(S1,B4);% para calcular d 
    line([V(P1+ofset) B4(1)],[U(P1+ofset) B4(2)],'Color','g')
    text(0.5*(V(P1+ofset)+B4(1))+10,0.5*(U(P1+ofset)+B4(2)+20),'d','Color','g')%-10,+20?
    %%%%% Calculo e
    e=norm([T5(1),T5(2)]-[b4(1),b4(2)])/factor;
    line([b4(1) T5(1)],[b4(2) T5(2)],'Color','c')
    text(0.5*(b4(1)+T5(1))-10,0.5*(b4(2)+T5(2))+20,'e','Color','c')
else
    [d,P1,Q1]=mindist(S1,S6);% para calcular d 
    line([V(P1+ofset) V(Q1+ind+locs4(3))],[U(P1+ofset) U(Q1+ind+locs4(3))],'Color','g')
    text(0.5*(V(P1+ofset)+V(Q1+ind+locs4(3)))+20,0.5*(U(P1+ofset)+U(Q1+ind+locs4(3))),'d','Color','g')
    %%%% Calculo e
    [e,Q7]=maxdist(T5,S7);
    line([V(locs5(3)+ind+Q7) T5(1)],[U(locs5(3)+ind+Q7) T5(2)],'Color','c')
    text(0.5*(V(locs5(3)+ind+Q7)+T5(1))-10,0.5*(U(locs5(3)+ind+Q7)+T5(2))+20,'e','Color','c')
end
%%%%%%%Calculo b
[b,P2,Q2]=mindist(S5,S6);% para calcular b 
line([V(P2+locs2(nmax1-4)) V(Q2+ind+locs4(3))],[U(P2+locs2(nmax1-4)) U(Q2+ind+locs4(3))],'Color','r')
text(0.5*(V(P2+locs2(nmax1-4))+V(Q2+ind+locs4(3)))-10,0.5*(U(P2+locs2(nmax1-4))+U(Q2+ind+locs4(3)))+10,'b','Color','r')
%%%%%%%%%%Calculo c
[c,P3,Q3]=mindist(S3,S6);% para calcular c ; P3 es de S3
line([V(P3+locs2(nmax1-3)) V(Q3+ind+locs4(3))],[U(P3+locs2(nmax1-3)) U(Q3+ind+locs4(3))],'Color','r')
c1=[V(P3+locs2(nmax1-3)),U(P3+locs2(nmax1-3))];%Punto extremo de c
c2=[V(Q3+ind+locs4(3)),U(Q3+ind+locs4(3))];%Punto extremo de c
text(0.5*(V(P3+locs2(nmax1-3))+V(Q3+ind+locs4(3)))-20,0.5*(U(P3+locs2(nmax1-3))+U(Q3+ind+locs4(3)))+10,'c','Color','m')
Plali=[V(P3+locs2(nmax1-3)) U(P3+locs2(nmax1-3))];%?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Calculando indices VdM
L=norm([x1,y1]-[col2,row2])/factor;
W=norm(T4-b3)/factor;%Los extremos de W son pues T4 y b3 
%%%%%%%% sección abandonada. Se explica más abajo
% % La0=norm(b3-Plali)/factor; %%%
% % Li0=norm(T4-Plali)/factor; %%%
%%%%% Calculo ajustado de La y Li
%%% Puntos de W: T4,b3
%%% Puntos de c: [V(P3+locs2(nmax1-3)),U(P3+locs2(nmax1-3))],[V(Q3+ind+locs4(3)),U(Q3+ind+locs4(3))]
%%% Representación puntos extremos c
% text(V(P3+locs2(nmax1-3)),U(P3+locs2(nmax1-3)),'o','Color','b') %% punto derecho
% text(V(Q3+ind+locs4(3)),U(Q3+ind+locs4(3)),'o','Color','m') %% punto izquierdo
%%% Puntos segmento c
adc=V(P3+locs2(nmax1-3)); % abscisa derecha c
odc=U(P3+locs2(nmax1-3)); % ordenada  "
aic=V(Q3+ind+locs4(3)); % abscisa izquierda c
oic=U(Q3+ind+locs4(3)); % ordenada  "
%%%%%%%%%%% Puntos extremos segmento W:
adW=b3(1);
aiW=T4(1);
odW=b3(2);
oiW=T4(2);
%%%% esta es una sección abandonada por cambio de criterio para calcular
%%%% Li,La
% angulos entre c y W
% Gamma=atan((oic-odc)/(adc-aic));
% Omega=pi-atan((odW-oiW)/(adW-aiW));
% Alfa=Omega-Gamma;
% Li=Li0*sin(Alfa);
% La=La0*sin(Alfa);
% Alfa=180*(Omega-Gamma)/pi % en grados
%%% Otra posibilidad de cálculo mediante Pendiente segmento c
% mc=(U(Q3+ind+locs4(3))-U(P3+locs2(nmax1-3)))/(c*factor)
%%% Definición segmento c ampliado
%%% Punto Superior segmento ampliado
% % % % cs=[V(P3+locs2(nmax1-3))+20,-mc*(V(P3+locs2(nmax1-3))-V(Q3+ind+locs4(3)))+U(P3+locs2(nmax1-3))];%%%OK
% % % % plot(round(cs(1)),round(cs(2)),'ko')
% % % % hold on
% % % % %%% Punto inferior segmento ampliado
% % % % ci=[V(Q3+ind+locs4(3))-20,mc*(V(P3+locs2(nmax1-3))-V(Q3+ind+locs4(3)))+U(Q3+ind+locs4(3))] %%% ok
% % % % plot(round(ci(1)),round(ci(2)),'ko')
% % % % hold on
%%%%%%%% Fin definicion segmento c ampliado. No lo voy a usar
%%%%%%%%%%%%%%%% calcular a 
[~,P4,Q4]=mindist(S3,S2);%
%%%%%%%% Segmento previo para a
line([V(P4+locs2(nmax1-3)) V(Q4+ind+locs4(2))],[U(P4+locs2(nmax1-3)) U(Q4+ind+locs4(2))],'Color','k')
%%%%%%%% Segmento a
a=norm([x1,y1]-[V(P4+locs2(nmax1-3)),U(P4+locs2(nmax1-3))])/factor;
line([V(P4+locs2(nmax1-3)) x1],[U(P4+locs2(nmax1-3)) y1],'LineStyle','--','Color','r')
text(0.7*(V(P4+locs2(nmax1-3))),U(P4+locs2(nmax1-3))-10,'a','Color','r')
%%%%%%%%%%% Eje longitudinal :
line([x1 col2],[y1 row2],'Color','b','LineStyle',':')
text(0.75*col2,row2-10,'L','Color','b')
%%%%%%%%%%%%%%%%% Segmento W
line([b3(1) T4(1)],[b3(2) T4(2)],'Color','b')%W
plot(T4(1),T4(2),'b^')% punto superior de W
plot(b3(1),b3(2),'b^')% punto inferior de W
plot(c1(1),c1(2),'b^')% punto derecho de c
% plot(c2(1),c2(2),'b^')% punto izdo de c, no se usa para calcular La,Li
line([T4(1),c1(1)],[T4(2),c1(2)],'LineStyle','--','Color','blue') % Li
text(adc,(oiW+odc)/2,'Li','Color','b')
line([b3(1),c1(1)],[b3(2),c1(2)],'LineStyle','--','Color','blue') % La
text(adW,(odW+odc)/2,'La','Color','b')
text(b3(1)-40,0.8*b3(2),'W','Color','b')
hold on
Li=norm([T4(1),T4(2)]-[c1(1),c1(2)])/factor;%
La=norm([c1(1),c1(2)]-[b3(1),b3(2)])/factor;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
% %%%%%%%Relaciones morfométricas
AL=100*a/L;
BW=100*b/W;
CW=100*c/W;
DW=100*d/W;
EW=100*e/W;
Simetry=100*La/Li;% 
%%%%%%%%%%%%%%%%%%%%%%
figure(cuatro)
clf(gcf)
axis([1 100 1 200])
axis off
text(15,200,'Indices de Van der Meulen')
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
text(12,40,'Simetría:')
text(25,40,num2str(Simetry,3))
%%%%%%%%%%%%%%%%%%%%%%%%%%%
text(12,20,fichero)
hold off
%%%%%%%%%%%%% Corrección indices
ci=0;
segmento=' ';
while ci<8
    ci=masMENUvdm('Medir manualmente',...
        '1.- a',...
        '2.- b',...
        '3.- c',...
        '4.- d',...
        '5.- e',...
        '6.- otro',...
        '7.- Volver');
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
% clear x1 y1 b3 T4 b4 B4 t5 T5 L W row2 col2 fichero imagen imagenbis ind locs2 locs1 locs4 locs5 U V X Y
% clear TF1max TF1min TF2max TF2min T3 F S1 S2 S3 S4 S5 S6 S7 P1 P2 P3 P4 Q1 Q2 Q3 Q4 B1 B2 B3 t3 I0 I
end
%
% function [dmin,P,Q]=mindist(P1,P2)
% esta función calcula la distancia mínima entre segmentos en mmm
% y los puntos más próximos entre ambos 
% factor=240;
% k1=size(P1,1);
% k2=size(P2,1);
% dist=zeros(k1,k2);
% dref=5;
% for p=1:k1
%     for q=1:k2
%         dist(p,q)=norm([P1(p,1) P1(p,2)]-[P2(q,1) P2(q,2)])/factor;
%         if dist(p,q) < dref 
%             dmin=dist(p,q);
%             P=p;
%             Q=q;
%             dref=dmin;
%         else
%             continue
%         end
%             
%     end
%   end
% end
%%%%%%%%%%%%%%%%%%%%%
% function [dmax,Q]=maxdist(P1,S2)
% % esta función calcula la distancia máxima entre un punto y un segmento de curva
% % y el punto de la curva en cuestión 
% % version 12-01-2022
% factor=240;
% k2=size(S2,1);
% dist=zeros(k2);
% dref=2/factor;
%     for q=1:k2
%         dist(q)=norm([P1(1) P1(2)]-[S2(q,1) S2(q,2)])/factor;
%         if dist(q) > dref 
%             dmax=dist(q);
%             Q=q;
%             dref=dmax;
%         else
%         end           
%     end
% end