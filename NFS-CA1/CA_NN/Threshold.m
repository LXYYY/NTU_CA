function rlt  = Threshold(m, thresholdValue)

for i=1:size(m, 1)
    if m(i)>thresholdValue
        rlt(i)=1;
    else
        rlt(i)=-1;
    end
end

rlt=transpose(rlt);