
function D = median_filt( I,origy,origx)
SE=[1 1;1 1];
[R,C]=size(I); %assumes 1-band image
[SER,SEC]=size(SE);
N=sum(sum(SE>=0));
A=-ones(R+SER-1,C+SEC-1,N);
n=1;
for j=1:SER
    for i=1:SEC
        if SE(j,i)>=0
            A(j:(R+j-1),i:(C+i-1),n)=I;
            n=n+1;
        end
    end   
end
A=shiftdim(median(shiftdim(A,2)),1);
D=A(origy:(R+origy-1),origx:(C+origx-1));
return

