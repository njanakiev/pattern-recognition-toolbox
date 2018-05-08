function [ output ] = minDistClassifier( mode, data, classifier )

switch mode
    case 'train'
        % Find classes and store them
        classification.classes = unique(data.targets);
        n_classes = length(classification.classes);
        
        % For each possible class
        for iClass = 1:n_classes
           idx = find(data.targets == classification.classes(iClass));
           classification.means(iClass, :) = mean(data.x(idx, :));
        end
        output = classification;
        
    case 'evaluate'
        n = size(data.x, 1);
        output = zeros(n, 1);
        
        % For each data item
        for i = 1:n
           d = Inf;
           % For each possible class
           for iClass = 1:length(classifier.classes)
               dNew = norm(data.x(i, :) - classifier.means(iClass, :));
               if dNew < d
                  d = dNew;
                  output(i) = classifier.classes(iClass);
               end
           end
        end
    otherwise 
            disp('minDistClassifier : mode not recognized');
end
end