%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function variedades_semi200(div)
 % Build Variedades.mat database file for biometry_molar_semi()
 % Release 3-01-2023 
 global uno dos tres cuatro
 suma='Semiperidentales200.mat';
 opc=0;
 sp=11;
 fs=8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        while opc<9
            opc=miMENU('Data base management (Semiperidentales200.mat)',...
                '1.- Show Species Data File',...
                '2.- Select previous file',...
                '3.- Add primary sample',...
                '4.- Save Species Data File',...
                '5.- Build Centroids Data File',...
                '6.- Delete item on Species Data File',...
                '7.- Erase an entire Species',...
                '8.- End');
            switch opc
            case 1
             try
                load(suma,'X','origen');
                Etiquetas=etiquetas(origen);
             catch 
               continue
             end
                n=size(X,1);
  %%%%%%%%%%%%%%%%%%%%%%%%%%
                figure(cuatro)
                clf(gcf)
                axis([0 260 0 440])
                axis off
                text(250,15,'Items in data base','Color','r')
                text(240,15,num2str(n),'Color','r')
                text(240,5,num2str(div),'Color','k')
                text(245,5,' semiperimetral points ','Color','k')
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 for k1=1:floor(n/10)%8
                text(1,n-sp*k1,num2str(k1),'FontSize',fs,'Color','blue')
                text(6,n-sp*k1,origen(k1),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                for k2=floor(n/10)+1:floor(2*n/10)
                text(20,n-sp*(k2-k1),num2str(k2),'FontSize',fs,'Color','blue')
                text(25,n-sp*(k2-k1),origen(k2),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                for k3=floor(2*n/10)+1:floor(3*n/10)
                text(40,n-sp*(k3-k2),num2str(k3),'FontSize',fs,'Color','blue')
                text(45,n-sp*(k3-k2),origen(k3),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                for k4=floor(3*n/10)+1:floor(4*n/10)
                text(60,n-sp*(k4-k3),num2str(k4),'FontSize',fs,'Color','blue')
                text(65,n-sp*(k4-k3),origen(k4),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                for k5=floor(4*n/10)+1:floor(5*n/10)
                text(90,n-sp*(k5-k4),num2str(k5),'FontSize',fs,'Color','blue')
                text(95,n-sp*(k5-k4),origen(k5),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                for k6=floor(5*n/10)+1:floor(6*n/10)
                text(120,n-sp*(k6-k5),num2str(k6),'FontSize',fs,'Color','blue')
                text(125,n-sp*(k6-k5),origen(k6),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                for k7=floor(6*n/10)+1:floor(7*n/10)
                text(140,n-sp*(k7-k6),num2str(k7),'FontSize',fs,'Color','blue')
                text(145,n-sp*(k7-k6),origen(k7),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                for k8=floor(7*n/10)+1:floor(8*n/10)
                text(160,n-sp*(k8-k7),num2str(k8),'FontSize',fs,'Color','blue')
                text(165,n-sp*(k8-k7),origen(k8),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                %%%%
                for k9=floor(8*n/10)+1:floor(9*n/10)
                text(180,n-sp*(k9-k8),num2str(k9),'FontSize',fs,'Color','blue')
                text(185,n-sp*(k9-k8),origen(k9),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                %%%
                for k10=floor(9*n/10)+1:n
                text(210,n-sp*(k10-k9),num2str(k10),'FontSize',fs,'Color','blue')
                text(215,n-sp*(k10-k9),origen(k10),'FontSize',fs,'Color','blue','Interpreter','none')
                hold on
                end
                hold off 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                figure(tres)
                clf(gcf)
                axis([0 200 0 100])
                axis off
                text(50,100,'Species in Data Base','Color','k')
                for kk=1:size(Etiquetas,2)
                    text(50,100-4*kk,Etiquetas(kk),'Color','r','Interpreter','none')
                end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                   
                clear X origen
%%%%%%%%%%%% fin seleccion       
            case 2
                figure(uno)
                axis([1 100 1 30]);
                axis off
                text(5,10,'Select the first sample ')
                hold on
                try
                uiload;
                if exist('X','var')==1
                    nm1=size(X,2);
                    origen1=origen';
                    molar1=molar;
                    clear origen molar
                    text(10,20,'Selecting the reference species file')
                    hold off
                else
                    figure(dos)
                    clf(gcf)
                    axis([1 100 1 30]);
                    axis off
                        text(5,20,'Primary file:')
                        text(20,20,char(muestra),'Interpreter','none')
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
                    figure(dos)%
                    clf(gcf)
                    axis([1 100 1 30]);
                    axis off
                    text(15,30,'Added file:')
                    text(25,30,char(muestra),'Interpreter','none')
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
                        text(30,10,'Discarded: Different sampling rate')
                        break
                     end
            case 4 %opc
             origen=origen1';
             molar=molar1;
            save(char(suma),'X','Y','origen','molar');
            case 5
              semicentroides200plus; 
            case 6
            load(suma,'X','Y','origen','molar')
            n=size(X,1);
            instancia = str2double(inputdlg('Deleting item number:','Semiperidentales200',[1 40])); 
            %%%%%%%%%%%%%%% 
             while opc<n+1
                 if instancia==n
                     elim=1;
                 else
                     elim=2;
                 end

                switch elim
                case 1
                    X=X(1:n-1,:);
                    Y=Y(1:n-1,:);
                    molar=molar(1:n-1);
                    origen=origen(1:n-1);
                    n=n-1;
                    disp('Item ')
                    display(instancia)
                    disp(' deleted')
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
                    disp('Item ')
                    display(instancia)
                    disp(' deleted')
                    save('Semiperidentales200.mat','X','Y','origen','molar'); 
                    clear X Y origen molar
                end
             end
         %%%%%%%%%%%%%%% 
                case 7 
                    clear suma X Y origen molar
                    load Semiperidentales200
                    n=size(X,1);
                    especie = inputdlg('Species to erase:','Semiperidentales200',[1 40]);
                    indsup=find(string(origen(1:end,:))==string(especie));
                    quedan=n-size(indsup,1);
                    k3=1;
                    for k2=1:n
                        if find(k2==indsup)
                            continue
                        else
                          molar(k3)=molar(k2); 
                          origen(k3)=origen(k2);
                          X(k3,:)=X(k2,:);
                          Y(k3,:)=Y(k2,:);
                          k3=k3+1;
                        end
                    end
                    molar=molar(1:quedan);
                    origen=origen(1:quedan);
                    X=X(1:quedan,:);
                    Y=Y(1:quedan,:);
                    confirmar=inputdlg('Confirm data deletion: Y/N (Yes/Not)','Semiperidentales200',[1 40],{'N'});
                    if char(confirmar)==or('Y','Yes')
                        save('Semiperidentales200.mat','X','Y','origen','molar');
                    else
                    end
                    clear suma X Y origen molar
                case 8
                    opc=9;
            end
        end 
end %variedades_semi200()