 function Etiquetas = etiquetas(especie)
% Obtención variable Etiquetas a partir estructura fichero base de datos
%  necesario para poder incrementar las especies en la base de datos
%  Semiperidentales200 y poder luego utilizarla para el análisis de molares
%  con el LDC de Fisher sin tener que modificar el código fuente declarando
%  explícitamente las diferentes variedades/especies  contempladas
% % % load Semiperidentales200
% Funcional 2-01-20023
items=size(especie,1);
m=1;
Etiquetas(1)=especie(1);
    for n=1:items
        if strcmp(Etiquetas(m),especie(n))
            continue
        else
            m=m+1;
            Etiquetas(m)=especie(n);
            for k=1:m-1 
                if strcmp(Etiquetas(k),Etiquetas(m))
                    Etiquetas=Etiquetas(1:m-1);
                    m=m-1;
                    break
                else
                    continue
                end
            end  
        end
    end
% 
% clear
end
% return

