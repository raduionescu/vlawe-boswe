%% 3. Train and test model
setup;

kernels = {'lin_VLAWE', 'PQ'};
weights = [0.5, 0.5];

numWords = [10, 500];
% numBins = [1];
numClasses = 2;
numFolds = 10;

Ker = 0;

for k = 1:numel(kernels)

    load(sprintf('data/K_%d_%s.mat', numWords(k), kernels{k}), 'K');
    Ker = Ker + weights(k) * K;
end

Ker = exp(-1.5 * (1-Ker));
Ker = Ker * Ker';

allLabels = [ones(1,1000), 2 * ones(1,1000)]';

rng(1)
cvIdx = crossvalind('Kfold',2000,numFolds);
% save cvIdx cvIdx;
% load cvIdx cvIdx;

CVals = [0.1 0.5 1 2 5 10];
numCVals = numel(CVals);

acc = zeros(numel(CVals),numFolds);
    
for fold = 1:numFolds

    for i = 1:numCVals 

        C = CVals(i);
        trainIdx = find(cvIdx ~= fold);
        testIdx = find(cvIdx == fold);

        labels = allLabels(trainIdx);
        testLabels = allLabels(testIdx);

        acc(i,fold) = SVMTest(trainIdx,testIdx,labels,testLabels,numClasses,Ker,C);

        fprintf('Fold %d accuracy for C=%.3f: %.4f\n', fold, C, acc(i,fold));
    end
end
    
fprintf('---------------------------------------------\n');
fprintf('Global Accuracies:\n');
fprintf('---------------------------------------------\n');
mean(acc,2)
