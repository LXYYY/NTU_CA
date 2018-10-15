function d = EuclidDist(x1, x2)

d=zeros(size(x1,1),1);
for i=1:size(x1,1)
    for j=1:size(x1,2)
        d(i)=d(i)+((x1(i,j)-x2(i,j))^2);
    end
end

d=d.^(1/2);