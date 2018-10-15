function rbfW = RBFTrainWeight(numNrn, nSomRows, nSomCols, cVec, dataNorm, lable_train, gMethod, gWidth)

d=zeros(size(dataNorm, 1), numNrn);
for i=1:size(dataNorm, 1)
    xs=repmat(dataNorm(i,:), numNrn, 1);
    d(i,:)=EuclidDist(xs, cVec);
end

Phi=zeros(size(dataNorm, 1),1);
if gMethod=='Gaussian'
    Phi=exp(-d.^2./(2*gWidth^2));

end

d=lable_train;

rbfW=inv(transpose(Phi)*Phi)*transpose(Phi)*d;