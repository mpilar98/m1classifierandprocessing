function length=micromanualvdm(I,svdm) 
%%% measurement of images previously calibrated  
global tres
length=0;
factor20=240;
%%%%%%%
                x(1:2)=0.0;
                y(1:2)=0.0;
                figure(tres)
                imshow(I)
                for j1=1:2
                   [x(j1),y(j1)]=ginput2(1);
                   plot(x(j1),y(j1),'r+')
                   text(x(j1)+5,y(j1)+2,int2str(j1))
                   hold on
                end
                line([x(1) x(2)],[y(1) y(2)],'Color','r');
                text((x(1)+ x(2))/2,(y(1)+ y(2))/2,svdm,'Color','r')
                length=norm([x(1),y(1)]-[x(2),y(2)])/factor20;
                text((x(1)+x(2))/2-20,(y(1)+ y(2))/2+20,num2str(length),'Color','m')
                hold on
end