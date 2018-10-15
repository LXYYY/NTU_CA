clc; 
clear; 
close all;

s=tf('s');
G1=(s+3.5)*exp(-2.5*s)/((s+1)^3*(s+2)^2*(s^2+7*s+10));

nPt=30;
t1=3;
ts=0.5;
t2=t1+(nPt-1)*ts;
output_value=step(G1,3:ts:t2)  %sampling in time domain
d=0;                           %º?À?
y_infinity=output_value(nPt);

M=15;

w=zeros(M,1);
w(1)=0.001;
amp=zeros(M,1);
pha=zeros(M,1);
pha1=zeros(M,1);
aa=zeros(M,2);

for j=1:M
    d=0;
    for k=1:nPt    %sampling 35 points
        if k==1||k==nPt
            d=(output_value(k)-y_infinity)*1/4*cos(w(j)*((k-1)*ts))+d;
        else
            d=(output_value(k)-y_infinity)*1/2*cos(w(j)*((k-1)*ts))+d;
        end
    end
    
    f1=d;
    
    d=0;
    for m=1:nPt   %sampling 35 points
        if m==1||m==nPt
            d=(output_value(m)-y_infinity)*1/4*sin(w(j)*((m-1)*ts))+d;
        else
            d=(output_value(m)-y_infinity)*1/2*sin(w(j)*((m-1)*ts))+d;
        end
    end
    
    f2=d;
    d=0;
    
    G=y_infinity+w(j)*f2+i*w(j)*f1;
    amp(j)=(abs(G))^2
    pha(j)=angle(G)
    
    a=(abs(w(j)))^2*amp(j);
    b=1;  
    aa(j,1)=-a;
    aa(j,2)=b
    
    if j<M
        if j==1
            w(j+1)=w(j)-(pi/9+pha(1))*w(1)/pha(1);
        else
            w(j+1)=w(j)-(j*pi/9+pha(j))*(w(j)-w(j-1))/(pha(j)-pha(j-1))
        end
    end
end

result=inv(aa.'*aa)*aa.'*amp
a1=sqrt(result(1))
b1=sqrt(result(2))


for n=1:M
    pha1(n)=-atan(a1*w(n))-pha(n);
end

l=inv(w.'*w)*w.'*pha1+2.5

% l=(-atan(a1*w(10))-pha(10))/w(10)
G2=b1*exp(-l*s)/(a1*s+1);
step(G1,'r',G2,'g');
% nyquist(G2,{0.001,0.58})
% hold on
% nyquist(G1,{0.001,0.58})


