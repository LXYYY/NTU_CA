
AmDec=ones(3,1)*4;

for i=1:3
    for j=1:3
        
        if abs(RGA(i,j))<1
            kij=K(i,j)/RGA(i,j);
        else
            kij=K(i,j);
        end
        if RART(i,j)>1
            Zeta(i,j)=Zeta(i,j)/RART(i,j);
            Tij=T(i,j)*RART(i,j);
            Lij=L(i,j)*RART(i,j);
        else
            Tij=T(i,j);
            Lij=L(i,j);
        end
        
        if i==j
            if O(i,j)==1
                kpDec(i)=pi*Tij/(2*AmDec(i)*Lij*kij);
                kiDec(i)=pi/(2*AmDec(i)*Lij*kij);
                kdDec(i)=0;
            elseif O(i,j)==2
                if kij==K(i,j)
                     kij=kij*sign(RGA(i,j));
                end
                kpDec(i)=pi*Zeta(i,j)/(AmDec(i)*wn(i,j)*Lij*kij);
                kiDec(i)=pi/(2*AmDec(i)*Lij*kij);
                kdDec(i)=pi/(2*AmDec(i)*wn(i,j)^2*Lij*kij);
            end
        end
    end
end


