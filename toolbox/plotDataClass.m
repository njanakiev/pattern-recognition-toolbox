function plotDataClass(mode, data, classifier)
    
    if size(data.x, 2) ~= 2
        disp('dimensions not valid');
        return;
    end
    % show the classification boundary 
    ranges = min(data.x);
    ranges(2,:) = max(data.x);
    ranges = ranges';
    
    [X,Y] = meshgrid(linspace(ranges(1,1), ranges(1,2), 100), linspace(ranges(2,1), ranges(2,2), 100));
    meshData.x(:,1) = X(:);
    meshData.x(:,2) = Y(:);
    switch mode
        case 'minDist'
            meshData.classes = minDistClassifier('evaluate', meshData, classifier);
            titleText = 'Classification Surface - Minimum Distance Classifier';
        case 'minError'
            meshData.classes = minErrorClassifier('evaluate', meshData, classifier);
            titleText = 'Classification Surface - Minimum Error Classifier';
        case 'NN'
            meshData.classes = TargetUnmapper(NNClassifier('evaluate', meshData, classifier));
            titleText = 'Classification Surface - Neural Network Classifier';
        case 'SVM'
            meshData.classes = SVMClassifier('evaluate', meshData, classifier);
            titleText = 'Classification Surface - SVM Classifier';
        otherwise
            disp('mode not recognized');
    end
            
    X = unique(meshData.x(:,1));
    Y = unique(meshData.x(:,2));
    Z = zeros(length(X));
    maximum = max(meshData.classes);
    for i=1:length(X)
        for j=1:length(X)
            Z(j,i) = meshData.classes((i-1)*length(X)+j);
        end
    end
    
    figure();
    mesh(X,Y,Z);
    hold on   
    scatter3(data.x(:,1), data.x(:,2),...
        data.targets + maximum + 1, [],...
        data.targets, 'filled',...
        'LineWidth', 1);
    axis([min(X) max(X) min(Y) max(Y)]);
    view(2);
    title(titleText);
    
end