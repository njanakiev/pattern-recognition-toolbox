function [ output ] = SVMClassifier(mode, data, classifier)

switch mode
    case 'train'
        % Training the svm with completely default behaviour
        % 'rbf' --> Kernel übergeben, basiert auf Gauss-Funktion
        svmstruct = svmtrain(data.x, data.targets, ...
                       'kernel_function', 'rbf', ...
                       'rbf_sigma', 0.25, ...
                       'showplot', true);
        %svmstruct = svmtrain(data.x, data.target, ...
        %               'kernel_function', 'polynomial', ...
        %               'polyorder', 6, 'showplot', true);
        output = svmstruct;
    case 'evaluate'
        output = svmclassify(classifier, data.x, 'showplot', false);
        
    otherwise 
        disp('NNClassifier : mode not recognized');
end