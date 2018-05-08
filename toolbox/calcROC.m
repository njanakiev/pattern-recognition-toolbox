function [ TP, FP ] = testROC( targets, classes )
    len = length(targets);
    add = 1/len;
    TP = zeros(1,len);
    FP = zeros(1,len);
    iTP = 0;
    iFP = 0;
    for i=1:length(targets)
        if (targets(i) == classes(i))
            iTP = iTP + add;
        else
            iFP = iFP + add;
        end
        TP(i) = iTP;
        FP(i) = iFP;
    end
    TP = [0 TP 1];
    FP = [0 FP 1];
end
