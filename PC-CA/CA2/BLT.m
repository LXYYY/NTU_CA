%relay experiment results
h=1;

a(1)=-0.0202;
a(3)=0.43;
a(2)=-1.2;
Pu(1)=18.2552-15.4154;
Pu(3)=16.6099-13.2757;
Pu(2)=101.5974-61.2889;

Wu=zeros(3,1);
Ku=zeros(3,1);
for i=1:3
    Wu(i)=2*pi/Pu(i);
    Ku(i)=4*h/(pi*a(i));
end

syms s;

Gjw=zeros(3,3);

Kzn=zeros(3,1);
tzn=zeros(3,1);
tdzn=zeros(3,1);
Kc=zeros(3,1);
ti=zeros(3,1);
td=zeros(3,1);
F=0;
Fd=0;

%calculate optimal F
BLT_1

%calculate optimal Fd
BLT_2

%get the pid parameters  
for i=1:3
    kpBlt(i)=Kc(i);
    kiBlt(i)=Kc(i)/ti(i);
    kdBlt(i)=Kc(i)*td(i);
end

