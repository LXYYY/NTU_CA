clear
syms b0 b1 b2
syms a0 a1 a2

% a0=1
% a1=1
% a2=1

a=a0+a1*exp(-j)+a2*exp(-j*2)
aa=a0+a1*exp(j)+a2*exp(j*2)

a*aa