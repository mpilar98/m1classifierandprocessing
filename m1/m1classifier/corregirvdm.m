function corregirvdm(a,b,c,d,e,L,W,La,Li,fichero)
%  Función para corregir indices de VdM mal calculados
global cuatro
% factor=240;% imágenes previamente calibradas
% %%%%%%%Relaciones morfométricas
AL=100*a/L;
BW=100*b/W;
CW=100*c/W;
DW=100*d/W;
EW=100*e/W;
Simetry=100*La/Li;% 
%%%%%%%%%%% reset valores indices vdm en figura 4
figure(cuatro)
clf(gcf)
axis([1 100 1 200])
axis off
%%%%%%%%%
text(15,200,'Van der Meulen indices')
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
 text(12,20,fichero,'Interpreter','none')
hold off
end

