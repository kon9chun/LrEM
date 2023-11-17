function [predictors,responses] = processTurboFanDataTest(filenamePredictors,filenameResponses)
% The function processTurboFanDataTest extracts the data from filenamePredictors
% and filenameResponses and returns the cell arrays predictors and
% responses, which contain the test predictor and response sequences. In
% filenamePredictors, the time series ends some time prior to system
% failure. The data in filenameResponses provides a vector of true RUL
% values for the test data.

predictors = processTurboFanDataTrain(filenamePredictors);

RULTest = dlmread(filenameResponses);

numObservations = numel(RULTest);

responses = cell(numObservations,1);
for i = 1:numObservations
    X = predictors{i};
    sequenceLength = size(X,2);
    
    rul = RULTest(i);
    responses{i} = rul+sequenceLength-1:-1:rul;
end

end