% oficiales.m  
clear
close all
load Semiperidentales200
items=size(origen,1);
k=1;
while k<= items
    opc=char(origen(k));
    switch opc
        case 'allophate'
            origen(k)=cellstr('Allophaiomys');
        case 'cabrerae'
            origen(k)=cellstr('Iberomys cabrerae');
        case 'm_agrestis'
            origen(k)=cellstr('Microtus agrestis');
        case 'm_arvalis'
            origen(k)=cellstr('Microtus arvalis');
        case 'chionomys'
            origen(k)=cellstr('Chionomys nivalis');
        case 'gregalis'
            origen(k)=cellstr('Stenocranius gregalis');
        case 't_lusitanicus'
            origen(k)=cellstr('Terricola lusitanicus');
        case 't_duodecimcostatus'
            origen(k)=cellstr('Terricola duodecimcostatus');
        case 't_pyrenaicus'
            origen(k)=cellstr('Terricola pyrenaicus');
        case 'oeconomus'
            origen(k)=cellstr('Alexandromys oeconomus');
    end
   k=k+1;
end
Nombres=etiquetas(origen);
Nombres
save('Semiperidentales200.mat','X','Y','origen','molar');
return