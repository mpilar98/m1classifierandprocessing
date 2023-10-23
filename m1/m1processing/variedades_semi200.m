%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function variedades_semi200(div)
 % Construye fichero Variedades.mat para biometry_molar_semi
 % version 19-09-2022 en pruebas
 global uno dos cuatro
suma='Semiperidentales200.mat';
opc=0;
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        while opc<8
            opc=miMENU('Concatenando variedades (Semiperidentales200.mat)',...
                '1.- Mostrar fichero de variedades',...
                '2.- Seleccionar fichero inicial',...
                '3.- Añadir muestra primaria',...
                '4.- Guardar fichero de variedades',...
                '5.- Crear fichero de centroides',...
                '6.- Eliminar entrada en el fichero de variedades',...
                '7.- Volver');
            switch opc
            case 1
             try
                load(suma,'X','origen');
             catch 
               continue
             end
                n=size(X,1);
  %%%%%%%%%%%%%%%%%%%%%%%%%%
                figure(cuatro)
                clf(gcf)
                axis([0 200 0 300])
                axis off
                text(50,300,'Variedades reconocidas','Color','k')
                text(108,300,'(','Color','k')
                text(110,300,num2str(div),'Color','k')
                text(120,300,' puntos perimetrales )','Color','k')
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 for k1=1:floor(n/8)
                text(0,n-8*k1,num2str(k1),'FontSize',8,'Color','blue')
                text(4,n-8*k1,origen(k1),'FontSize',8,'Color','blue')
                hold on
                end
                for k2=floor(n/8)+1:floor(2*n/8)
                text(25,n-8*(k2-k1),num2str(k2),'FontSize',8,'Color','blue')
                text(30,n-8*(k2-k1),origen(k2),'FontSize',8,'Color','blue')
                hold on
                end
                for k3=floor(2*n/8)+1:floor(3*n/8)
                text(50,n-8*(k3-k2),num2str(k3),'FontSize',8,'Color','blue')
                text(55,n-8*(k3-k2),origen(k3),'FontSize',8,'Color','blue')
                hold on
                end
                for k4=floor(3*n/8)+1:floor(4*n/8)
                text(75,n-8*(k4-k3),num2str(k4),'FontSize',8,'Color','blue')
                text(80,n-8*(k4-k3),origen(k4),'FontSize',8,'Color','blue')
                hold on
                end
                for k5=floor(4*n/8)+1:floor(5*n/8)
                text(100,n-8*(k5-k4),num2str(k5),'FontSize',8,'Color','blue')
                text(105,n-8*(k5-k4),origen(k5),'FontSize',8,'Color','blue')
                hold on
                end
                for k6=floor(5*n/8)+1:floor(6*n/8)
                text(125,n-8*(k6-k5),num2str(k6),'FontSize',8,'Color','blue')
                text(130,n-8*(k6-k5),origen(k6),'FontSize',8,'Color','blue')
                hold on
                end
                for k7=floor(6*n/8)+1:floor(7*n/8)
                text(150,n-8*(k7-k6),num2str(k7),'FontSize',8,'Color','blue')
                text(155,n-8*(k7-k6),origen(k7),'FontSize',8,'Color','blue')
                hold on
                end
                for k8=floor(7*n/8)+1:n
                text(175,n-8*(k8-k7),num2str(k8),'FontSize',8,'Color','blue')
                text(180,n-8*(k8-k7),origen(k8),'FontSize',8,'Color','blue')
                hold on
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                hold off 
                clear X origen
%%%%%%%%%%%% fin seleccion       
            case 2
                figure(uno)
                axis([1 100 1 30]);
                axis off
                text(5,10,'Selecciona la primera muestra ')
                hold on
                try
                uiload;
                if exist('X','var')==1
                    nm1=size(X,2);% numero de puntos de muestreo
                    origen1=origen';
                    molar1=molar;
                    clear origen molar
                    text(10,20,'Seleccionado fichero variedades de referencia')
                    hold off
                else
                    figure(dos)
                    clf(gcf)
                    axis([1 100 1 30]);
                    axis off
                        text(5,20,'Fichero primario:')
                        text(20,20,char(muestra))
                    hold off
                    X=U;
                    Y=V;
                    n1=size(U,1);
                    nm1=size(U,2);
                    origen1(1:n1)=cellstr(variedad);
                    molar1=molar;
                    clear n1 U V molar muestra variedad
                end
               catch 
                    close all
                    return
                end   
            case 3 %opc
                try
                    uiload;
                catch 
                    opc=0;
                end
                    figure(dos)
                    clf(gcf)
                    axis([1 100 1 30]);
                    axis off
                    text(15,30,'Fichero añadido:')
                    text(25,30,char(muestra))
                    hold off
                     n2=size(U,1);
                     nm2=size(U,2);
                     if nm1==nm2
                        origen2(1:n2)=cellstr(variedad);
                        molar2=molar;
                        X = cat(1,X,U);
                        Y = cat(1,Y,V);
                        origen1=cat(2,origen1,origen2);
                        molar1=cat(2,molar1,molar2);
                        clear n2 U V molar muestra origen2 molar2 variedad
                     else
                        text(30,10,'Descartado: Distinta densidad muestral')
                        break
                     end
            case 4 %opc
             origen=origen1';
             molar=molar1;
            save(char(suma),'X','Y','origen','molar');
            case 5
              Semicentroides200(); 
            case 6
            load(suma,'X','Y','origen','molar')
            n=size(X,1);
               %eliminar registro en fichero de variedades
            instancia=input('Instancia a suprimir: '); 
            %%%%%%%%%%%%%%% depurando entrada número instancia 
             while opc<n+1
                 if instancia==n
                     elim=1;
                 else
                     elim=2;
                 end

                switch elim
                case 1
                    X=X(1:n-1);
                    Y=Y(1:n-1);
                    molar=molar(1:n-1);
                    origen=origen(1:n-1);
                    n=n-1;
                    disp('Instancia ')
                    display(instancia)
                    disp(' suprimida')
                    save('Semiperidentales200.mat','X','Y','origen','molar'); 
                    clear X Y origen molar                  
                case 2       
                    X(instancia:n-1,:)=X(instancia+1:n,:);
                    Y(instancia:n-1,:)=Y(instancia+1:n,:);
                    molar(instancia:n-1)=molar(instancia+1:n);
                    origen(instancia:n-1)=origen(instancia+1:n);
                    X=X(1:n-1,:);
                    Y=Y(1:n-1,:);
                    molar=molar(1:n-1);
                    origen=origen(1:n-1);
                    n=n-1;
                    disp('Instancia ')
                    display(instancia)
                    disp(' suprimida')
                    save('Semiperidentales200.mat','X','Y','origen','molar'); 
                    clear X Y origen molar
                end
             end
         %%%%%%%%%%%%%%% fin depuración
            case 7
            opc=8;
            end
        end
end %variedades_semi200(div)