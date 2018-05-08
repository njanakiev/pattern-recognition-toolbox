function [ traindata, testdata ] = randomSampling( data, percentage, mode )

if percentage > 1
    percentage = percentage / 100;
end

if nargin < 3
   mode = 'stratified'; 
end

switch mode
    case 'ordinary'
        disp('Ordinary Sampling...')
        % Simple solution: no knowledge of classes
        traindata.labels = data.labels; 
        testdata.labels = data.labels;

        n       = size(data.x, 1);          % number of data
        myIndex = randperm(n);              % permutation of 1:n             
        trainN  = floor(n*percentage);      % number of data used for training
        myTrain = myIndex(1:trainN);        % data items for training
        myTest  = myIndex(trainN+1:end);    % those for testing

        traindata.x       = data.x(myTrain, :);
        traindata.targets = data.targets(myTrain, :);
        testdata.x        = data.x(myTest, :);
        testdata.targets  = data.targets(myTest, :);
    case 'stratified'
        % stratified sampling solution: chooses a random sample for test
        % and training for each class seperately
        disp('Stratified Sampling...')

        traindata.labels = data.labels;
        testdata.labels  = data.labels;
        traindata.x = [];
        testdata.x  = [];
        traindata.targets = [];
        testdata.targets  = [];

        for target = unique(data.targets)'
            targetX = data.x(data.targets == target, :);
            n = size(targetX, 1);
            index = randperm(n);
            trainN = floor(n*percentage);
            trainIndexes  = index(1:trainN);
            testIndexes   = index(trainN+1:end);

            traindata.x = [traindata.x ; targetX(trainIndexes, :)];
            traindata.targets = [traindata.targets ; target*ones(length(trainIndexes), 1)];
            testdata.x = [testdata.x ; targetX(testIndexes, :)];
            testdata.targets = [testdata.targets ; target*ones(length(testIndexes), 1)];
        end

        trainIndexes = randperm(length(traindata.targets));
        testIndexes  = randperm(length(testdata.targets));

        traindata.x = traindata.x(trainIndexes, :);
        traindata.targets = traindata.targets(trainIndexes);
        testdata.x = testdata.x(testIndexes, :);
        testdata.targets = testdata.targets(testIndexes);
end

end
