AmDecp=[3,3,3];

clear s;
s=tf('s');
phim=pi/4;

%get Gs and GR
Gs_=s;
GR=[s 0 0;0 s 0;0 0 s];
for i=1:3
    for j=1:3
        Gs_(i,j)=K(i,j)/(T(i,j)*s+1)^O(i,j);
    end
    GR(i,i)=K(i,i)/(T(i,i)*s+1)^O(i,i);
end

%calculate GI
GI=inv(Gs_)*GR;

%specify L
L_=L.*RART;

for i=1:3
    LR(i,i)=max(L_(i,:));
end

for i=1:3
    for j=1:3
        GI(i,j)=GI(i,j)*exp(-(LR(i,i)-L_(i,j))*s);
    end
    GR(i,i)=GR(i,i)*exp(-LR(i,i)*s);
end

%calculate PID parameters
kpDecp=zeros(3,1);
kiDecp=zeros(3,1);
kdDecp=zeros(3,1);

kpDecp(1)=pi*T(1,1)/(2*AmDecp(1)*LR(1,1)*K(1,1));
kiDecp(1)=pi/(2*AmDecp(1)*LR(1,1)*K(1,1));
kdDecp(1)=0;

for i=2:3
    kpDecp(i)=T(i,i)*pi/(AmDecp(i)*LR(i,i)*K(i,i));
    kiDecp(i)=pi/(2*AmDecp(i)*LR(i,i)*K(i,i));
    kdDecp(i)=pi*T(i,i)^2/(2*AmDecp(i)*LR(i,i)*K(i,i));
end
