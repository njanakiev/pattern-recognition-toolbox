function [ output ] = NNClassifier(mode, data, classifier, hiddenLayers)

    if nargin < 3
        hiddenLayers = 10;
    end
    
    switch mode
        case 'train'
            net = feedforwardnet(hiddenLayers, 'trainlm');
            net.trainParam.lr = 0.1; % Lernrate
            net.trainParam.epochs = 300; % Abbruchkriterium Anzahl der Epochen
            %net.trainParam.min_grad = 1.0000e-006; % Abbruchkriterium minimaler Gradient
            net.trainParam.time = Inf; % Abbruchkriterium Zeit
            %net.trainParam.showWindow = true;    % Soll Trainingsverlauf angezeigt werden?
            net.trainParam.show = 1; % Nach wieiviel Epochen angezeigt werden soll
            net.trainParam.showCommandLine = true;
            net = train(net, data.x', TargetMapper(data.targets)');
            output = net;
        case 'evaluate'
            output = sim(classifier, data.x')';
            % Je nach Transferfunktion gibt das Netz kontinuirliche Werte oder Klassenwerte zurück
            output = output > 0.5;
            output = double(output);
            
        otherwise 
            disp('NNClassifier : mode not recognized');
    end
end
