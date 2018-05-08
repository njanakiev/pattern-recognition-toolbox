function [trainData, testData] = crossValidation(data, kFolds)

n_elements = length(data.x(:,1));
if kFolds > n_elements
    kFolds = n_elements;
end
nTestElements = floor(n_elements/kFolds);

trainData = cell(1, kFolds);
testData  = cell(1, kFolds);
for i = 1:kFolds
    lowTest = (i - 1) * nTestElements + 1;
    highTest = lowTest + nTestElements - 1;
    
    % crop testData
    tmpData.x = data.x(lowTest:highTest, :);
    tmpData.targets = data.targets(lowTest:highTest, :);
    tmpData.labels = data.labels;
    testData{i} = tmpData;
    
    % delete testData from data and save as trainData
    tmpData = data;
    tmpData.x(lowTest:highTest, :) = [];
    tmpData.targets(lowTest:highTest, :) = [];
    trainData{i} = tmpData;
end
end