%caculate the index matrix
for i=1:3
    for j=1:3
        X(i,j)=abs(RNGA(i,j)/RNGA(i,i));
        if X(i,j)>1
            X(i,j)=1/X(i,j);
        end
    end
end

eps=0.1;
for i=1:3
    for j=1:3
        if X(i,j)<eps
            G0(i,j)=0;
        else
            G0(i,j)=X(i,j);
        end
    end
end

AmSprs=ones(3)*4;
kpSprs=zeros(3,3);
kiSprs=zeros(3,3);
kdSprs=zeros(3,3);

%calculate PID parameters for each ETFs
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
        
        if G0(i,j)~=0
            if O(i,j)==1
                kpSprs(j,i)=pi*Tij/(2*AmSprs(i,j)*Lij*kij);
                kiSprs(j,i)=pi/(2*AmSprs(i,j)*Lij*kij);
                kdSprs(j,i)=0;
            elseif O(i,j)==2
                if kij==K(i,j)
                     kij=kij*sign(RGA(i,j));
                end
                kpSprs(j,i)=pi*Zeta(i,j)/(AmSprs(i,j)*wn(i,j)*Lij*kij);
                kiSprs(j,i)=pi/(2*AmSprs(i,j)*Lij*kij);
                kdSprs(j,i)=pi/(2*AmSprs(i,j)*wn(i,j)^2*Lij*kij);
            end
        end
    end
end


