function [ output ] = minErrorClassifier( mode, data, classifier )

switch mode
    case 'train'
        output.classes=unique(data.targets)';        
        for iClass = 1:length(output.classes)
            idx = find(data.targets == output.classes(iClass));
            output.means(iClass, :) = mean(data.x(idx, :));
            output.cov(:, :, iClass) = cov(data.x(idx, :));
            output.prior(iClass) = length(idx);
        end
        output.prior=output.prior./sum(output.prior);
    case 'evaluate'
        n  = size(data.x, 1);
        dims = size(data.x, 2); % num of dimensions
        
        g = zeros(n, size(classifier.prior, 2));
        for iClass = 1:size(classifier.prior, 2)
            logPiDetCov = -log((2*pi)^(dims/2)*sqrt(det(classifier.cov(:,:,iClass))));
            invCov = inv(classifier.cov(:, :, iClass));
            logPrior = log(classifier.prior(iClass));
            for i = 1:n
                diff = data.x(i, :) - classifier.means(iClass, :);
                g(i, iClass) = logPiDetCov - 0.5*diff*invCov*diff' + logPrior;
            end
        end
        
        % Decision rule
        output = zeros(n, 1);
        for i = 1:n
            output(i) = classifier.classes(g(i, :) == max(g(i, :)));
        end
    otherwise
        disp('minErrorClassifier : mode not recognized');
end
end