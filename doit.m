close all;
load('alldata.mat');
data = alldata.traintest;

addpath('toolbox');

% fit to interval: normalize the data to the interval [-20 -10]
intervalDat = scaleInterval(data, [-1 1]);

plotData(intervalDat);
title('Interval');

% arctan: shrink each dimension with arc-tan-function to [-1 1] intervall
arcTanData = scaleArcTan(data);

plotData(arcTanData);
title('Interval - arc-tan-function');

% z-score: use z-score transformation
zScoreData = scaleZScore(data);

plotData(zScoreData);
title('Interval - z-Score-function');

% function for principal component analysis (PCA
dimReduct = 2;  
[transData, transParam] = calcPrincipalComponents(arcTanData, dimReduct);
plotData(transData); %empty figure when n>3 (how to plot 4 dimensions???)
title('PCA');

[trainData testData] = randomSampling(transData, 0.7); %use 70% for trainingdata, 30% for test

% plot training and testdata
plotData(trainData);
title('Train data');
plotData(testData);
title('Test data');

% minimum distance classifier with functionality 'train'
classifier = minDistClassifier('train', trainData);

% minimum distance classifier with functionality 'evaluate'
testData.classes = minDistClassifier('evaluate', testData, classifier);

% analyse classification rates with the confusion plot
plotconfusion(testData.targets',testData.classes');  % works in MatLab 2012b only

% minimum error classifier with functionality 'train'
classifier = minErrorClassifier('train', trainData);

% minimum error classifier with functionality 'evaluate'
testData.classes = minErrorClassifier('evaluate', testData, classifier);

% analyse classification rates with the confusion plot
plotconfusion(testData.targets',testData.classes');  % works in MatLab 2012b only

%ranges = min(transData.x);
%ranges(2,:) = max(transData.x);
%ranges=ranges';
ranges = minmax(evalData.x');  % works in MatLab 2012b only

[X,Y] = meshgrid(linspace(ranges(1,1), ranges(1,2), 100), linspace(ranges(2,1), ranges(2,2), 100));
meshdat.x(:,1) = X(:);
meshdat.x(:,2) = Y(:);
meshdat.classes = minErrorClassifier('evaluate', meshdat, classifier);

plotDataClass(testData, meshdat);
title('Classification Surface - Bayes Minimum Error Classifier');


% ---------- %
% EVALUATION %
% ---------- %

data = alldata.evaluation;

% arctan: shrink each dimension with arc-tan-function to [-1 1] intervall
arcTanData = scaleArcTan(data);

plotData(arcTanData);
title('Interval - arc-tan-function');

fprintf('Variance for evaluation data set:\n');
% function for principal component analysis (PCA)
dimReduct = 2;  
[evalData, evalParam] = calcPrincipalComponents(arcTanData, dimReduct);
plotData(evalData);
title('PCA');

% minimum error classifier with functionality 'evaluate'
evalData.classes = minErrorClassifier('evaluate', evalData, classifier);

% analyse classification rates with the confusion plot
plotconfusion(evalData.targets',evalData.classes');  % works in MatLab 2012b only

% calculate confusion matrix
calcConfusion(evalData.targets',evalData.classes');

%ranges = min(transData.x);
%ranges(2,:) = max(transData.x);
%ranges=ranges';
ranges = minmax(evalData.x');  % works in MatLab 2012b only      

[X,Y] = meshgrid(linspace(ranges(1,1), ranges(1,2), 100), linspace(ranges(2,1), ranges(2,2), 100));
meshdat.x(:,1) = X(:);
meshdat.x(:,2) = Y(:);
meshdat.classes = minErrorClassifier('evaluate',meshdat, classifier);

plotDataClass(evalData,meshdat);
title('Classification Surface - Bayes Minimum Error Classifier');
