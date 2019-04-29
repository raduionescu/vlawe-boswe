%% Load training data
load(sprintf('data/boswe-%d-centroids-%d-vocab.mat', numWords, numVocabs), 'documents');
histograms = documents.histograms;
clear documents;

% L2-normalized histograms
histograms = bsxfun(@times, histograms, 1./max(10^-10, sqrt(sum(histograms.^2,1))));

%% Kernel for training and testing
fprintf('Computing linear kernel...\n');
K = single(histograms' * histograms);
save(sprintf('data/K_%d_lin.mat', numWords), 'K', '-v7.3');

clear K;
