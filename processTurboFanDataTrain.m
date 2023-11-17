function [predictors,responses] = processTurboFanDataTrain(filenamePredictors)
% The function processTurboFanDataTrain extracts the data from
% filenamePredictors and returns the cell arrays predictors and responses
% which contain the predictor and response sequences, respectively. The
% data contains zip-compressed text files with 26 columns of numbers,
% separated by spaces. Each row is a snapshot of data taken during a single
% operational cycle, and each column is a different variable. The columns
% correspond to the following:
%     1:    Unit number
%     2:    Time in cycles
%     3–5:  Operational settings
%     6–26: Sensor measurements 1–17

dataTrain = dlmread(filenamePredictors);

numObservations = max(dataTrain(:,1));

predictors = cell(numObservations,1);
responses = cell(numObservations,1);
for i = 1:numObservations
    idx = dataTrain(:,1) == i;
    
    predictors{i} = dataTrain(idx,3:end)';
    
    timeSteps = dataTrain(idx,2)';
    responses{i} = fliplr(timeSteps);
end

end