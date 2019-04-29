function [acc] = SVMTest(trainIdx,testIdx,labels,testLabels,numClasses,Ker,C)
% Load data

K = Ker(trainIdx,trainIdx);
Kx = Ker(testIdx,trainIdx);

% K = Ker(trainIdx,:);
% Kx = Ker(testIdx,:);

clear Ker;
 
% Hel C = 10, PQ C > 100, JS C = 0.1, int C = 100, lin C = 100
  
% Train SVM
fprintf('Training SVM with C=%.4f\n', C);
y = eye(numClasses);
y = 2 * y(labels,:) - 1;

n = size(K, 1);
nx = size(Kx, 1);
yh = [];

for class = 1:numClasses

    binaryTrainLabels = -ones(n,1);
    positiveTrainSamplesIdx = find(labels == class);

    binaryTestLabels = -ones(nx,1);
    positiveTestSamplesIdx = find(testLabels == class);

    if ~isempty(positiveTrainSamplesIdx)

        binaryTrainLabels(positiveTrainSamplesIdx) = 1;
        binaryTestLabels(positiveTestSamplesIdx) = 1;

        model = svmtrain(binaryTrainLabels, [(1:n)' , double(K)], sprintf('-t 4 -c %d -q', C));
        % [w, bias] = trainLinearSVM(double(K'), binaryTrainLabels, C);
        
        [~, ~, d] = svmpredict(binaryTestLabels, [(1:nx)', double(Kx)], model);
        testScores = model.Label(1) * d;
        
        % testScores = Kx * w + bias;
    else
        testScores = -1000 * ones(nx,1);
    end

    % [drop,drop,info] = vl_pr(binaryTestLabels, testScores');
    % fprintf('Test AP for class %d : %.3f\n', class, info.auc);
    yh = [yh, testScores];
end

[~, yh] = max(yh, [], 2);
acc = length(find(yh == testLabels)) / numel(testLabels);
