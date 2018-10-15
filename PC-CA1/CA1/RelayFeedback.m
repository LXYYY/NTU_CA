clear
close all
clc

%observed from the relay feedback test waveform
h=1;
L=3.5;
Ku=4*h/(0.076*pi);
wu=2*pi/(32.3525-19.2051);
Kp=0.0875;

%calculate T
T=sqrt((Kp*Ku)^2-1)/wu;

%compose the identified transfer function
s = tf('s');
gs=Kp/(T*s+1)*exp(-L*s)
Gp = (s+3.5)*exp(-2.5*s) / (((s+1)^3)*((s+2)^2)*(s^2+7*s+10));

%draw plots
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