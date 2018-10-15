clear 
close all
clc

GsInit
BLT
ETFDecentralized
ETFDecoupling
ETFSparse

clear s;
s=tf('s');

KdCoef=100;

for i=1:3
    for j=1:3
        Gs(i,j)=K(i,j)/(T(i,j)*s+1)^O(i,j)*exp(-L(i,j)*s);
    end
end

