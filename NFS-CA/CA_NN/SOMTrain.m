function w = SOMTrain(w, o, x, eta0, sigma0, it, itMax)

winId=SOMCompete(x, w);

t1=itMax;
t2=itMax/log10(sigma0);

etaN=eta0*exp(-it/t1);
sigmaN=sigma0*exp(-it/t2);

for i=1:size(w,1)
    h=exp(-sum((o(i,:)-o(winId,:)).^2)/(2*sigmaN^2));
    dw=etaN*h*(x-w(i,:));
    w(i,:)=w(i,:)+dw;
end
