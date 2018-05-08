function [ output ] = performance(mode, targets, classes)
    C = confusionmat(targets, classes)';    
    N = sum(sum(C));
    PP = C(1, 1) + C(2, 1);
    NN = C(1, 2) + C(2, 2);
    TP = C(1, 1);
    TN = C(2, 2);
    FP = C(1, 2);
    FN = C(2, 1);
    
    switch mode
        case 'ACC'
            output = (TP + TN)/N;
        case 'TER'
            output = (FP + FN)/N;
        % TPR = sens
        case 'sens'
            output = TP/PP;
        case 'spec'
            output = TN/NN;
        % FRR = FPR = 1 - spec
        case 'FRR'
            output = FP/NN; 
        % FAR = FNR = 1 - TPR
        case 'FAR'
            output = FN/PP;
        case 'TPR'
            output = TP/PP;
        case 'FPR'
            output = FP/NN;
        otherwise
            disp('mode not defined');
    end
end