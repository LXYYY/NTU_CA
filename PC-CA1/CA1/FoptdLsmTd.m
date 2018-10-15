clear
clc
close all

%establish the desired tranfer function model and sample it using step test
s = tf('s');
Gp = (s+3.5)*exp(-2.5*s) / (((s+1)^3)*((s+2)^2)*(s^2+7*s+10));
Ts=0.1;
Tf=100; 
T=0:Ts:Tf;
yt=step(Gp,T);

%initialize the paramters
A=1;                    %the gain of input step A=1
nPt=30;                 %number of sample points nPt=30
ts=20*Ts;               %time interval between sample points ts=2s
t1=30;                  %start at t1=3s which is after the time delay L
t2=ts/Ts*(nPt-1)+t1;    %end at t2
tvec=t1:ts/Ts:t2;       %tranform t1,ts,t2 into a vector, easier to program
Gamma=yt(tvec,:);       %select the sample points from the vector of overall step test sampling results

%calculate Phi matrix 
Phi=zeros(nPt,3);       
for i=1:nPt
    intgr=0;
    %compute the integral part using trapezoidal integral method
    for k=1:i
        if i==1
            intgr=Gamma(k)*ts+intgr;
        elseif k==1||k==nPt
            intgr=Gamma(k)*ts*0.5+intgr;
        else
            intgr=Gamma(k)*ts+intgr;
        end
    end
    %compose Phi matrix
    Phi(i,1)=-intgr;
    Phi(i,2)=-A;
    Phi(i,3)=tvec(i)*Ts*A;
end

%calculate Theta matrix and get the values of a1,b1,L
Theta=inv((transpose(Phi)*Phi))*transpose(Phi)*Gamma;
a1=Theta(1);
b1=Theta(3);
L=Theta(2)/Theta(3);

%compose the tranfer function of FOPTD model
gs=(b1)/(s+a1)*exp(-L*s);

%draw step response and Nyquist plot to compare
%red curve is the original function, green curve is the identified function
figure(1);
GpNyq=nyquistplot(Gp,'r')
setoptions(GpNyq, 'ShowFullContour', 'off');
hold
gsNyq=nyquistplot(gs,'g')
setoptions(gsNyq, 'ShowFullContour', 'off');
figure(2);
step(Gp,'r');
hold;
step(gs,'g');



