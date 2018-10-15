function [cVec, clusterId] = SOM(numNrn, nSomRows, nSomCols, dataNorm, itMax) 

% numNrn=20;
% 
% nSomRows=4;
% nSomCols=5;

[numSmp, numDim]=size(dataNorm);
% dataNorm=zeros(numSmp,numDim);
% 
% for j=1:numDim
%     dataNorm(:,j)=(data_train(:,j)-min(data_train(:,j)))/range(data_train(:,j));
% end

cVec=rand(numNrn,numDim);
[o(:,1),o(:,2)]=ind2sub([nSomRows,nSomCols],1:numNrn);

sigma0=1;

eta0=0.1;

for it=1:itMax
    for n=1:numSmp
        dataCur=dataNorm(n,:);
%         dataCur=dataNorm(ceil(rand*size(dataNorm,1)),:);
        SOMTrain(cVec, o, dataCur, eta0, sigma0, it, itMax);
    end
end

clusterId=zeros(numSmp,1);
for i=1:numSmp
    clusterId(i)=SOMCompete(dataNorm(i,:), cVec);
end
