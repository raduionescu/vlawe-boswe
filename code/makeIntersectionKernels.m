%% Load training data
load(sprintf('data/boswe-%d-centroids-%d-vocab.mat', numWords, numVocabs), 'documents');
histograms = documents.histograms;
clear documents;

% L1-normalized histograms
histograms = bsxfun(@times, histograms, 1./max(10^-10,sum(histograms,1)));

%% Kernel for training and testing
fprintf('Computing intersection kernel...\n');
K = IntersectionKernelMatrix(histograms);
save(sprintf('data/K_%d_int.mat', numWords), 'K', '-v7.3');

clear K;