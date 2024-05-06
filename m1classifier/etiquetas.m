 function Etiquetas = etiquetas(especie)
% Obtaining variable Etiquetas from database file structure
%  necessary to be able to increase the number of species in the database
%  Semiperidentales200 and can then be used for molar analysis
%  with Fisher's LDC without having to modify the source code by declaring
%  explicitly the different varieties/species concerned
%load Semiperidentales200
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
end
% return

