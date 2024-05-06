function crear_tps(m,minpix,molar,fichero,U,V)
%% Formating data for subsequent MorphoJ analisys
n1=m;
div=minpix;
MOLARES=zeros(n1,2*div); 
for hh=1:n1
    for h=1:div
        MOLARES(hh,2*h-1)=U(hh,h);
        MOLARES(hh,2*h)=V(hh,h);
    end
end 
%% Building file "sample.tps"
muestra=[fichero(1:end-4) '.tps'];
fid=fopen(muestra,'w');
for k=1:n1
 fprintf(fid,char(molar(:,k)));
 fprintf(fid,'\t');%\b
 fprintf(fid,'%2.0f\t',k);
 for q=1:2*div-1
     fprintf(fid,'%3.2f\t',MOLARES(k,q));
 end
 fprintf(fid,'%3.2f\n',MOLARES(k,2*div)); 
end
%%%%%%%%%
fclose(fid);
return

