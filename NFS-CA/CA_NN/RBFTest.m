function [output, weightedValue]=RBFTest(cVec, rbfW, data_test, gMethod, gWidth)

d=zeros(size(data_test, 1), size(cVec, 1));
for i=1:size(data_test, 1)
    xs=repmat(data_test(i,:), size(cVec,1), 1);
    d(i,:)=EuclidDist(xs,cVec);
end

switch gMethod
    case 'Gaussian'
        Phi=exp(-d.^2./(2*gWidth^2));
end

results=Phi*rbfW;

weightedValue=results;
output=Phi;
