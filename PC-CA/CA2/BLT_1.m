Gcjw=zeros(3,3);
I=eye(3,3);
Lcm=zeros(1,2);

for F=1:0.01:15
    %calculate Kc ti
    for i=1:3
        Kzn(i)=Ku(i)/2.2;
        tzn(i)=2*pi/(1.2*Wu(i));
        Kc(i)=Kzn(i)/F;
        ti(i)=F*tzn(i);
    end
    
    %calculate Gjw Gcjw and Lc
    for k=1:100
        w=pi/100*k;
        s=w*j;
        
        for m=1:3
            for n=1:3
                Gjw(m,n)=K(m,n)/(T(m,n)*s+1)^O(m,n)*exp(-L(m,n)*s);
            end
        end
        
        for i=1:3
            Gcjw(i,i)=Kc(i)*(1+1/(ti(i)*j*w));
        end
        Wjw=-1+det(I+Gjw*Gcjw);
        Lc_=20*log10(abs(Wjw/(1+Wjw)));
        if Lc_<=6
            Lc(k)=20*log10(abs(Wjw/(1+Wjw)));
        end
    end
    Lcm=[Lcm; F max(Lc)];
end

%find the optimal F
[v id]=max(Lcm(:,2));
F=Lcm(id,1)