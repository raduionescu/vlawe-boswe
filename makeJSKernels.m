%% Load training data
load(sprintf('data_sep/histograms_%d_stop.mat', numWords), 'documents');
histograms = documents.histograms;
clear documents;

%% Kernel for training
fprintf('Computing JS kernel...\n');
K = single(JSKernelMatrix(histograms));
save(sprintf('data_sep/K_%d_JS_stop.mat', numWords), 'K', '-v7.3');

clear K;