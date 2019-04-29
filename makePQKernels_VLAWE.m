%% Load training data
load(sprintf('data/vlawe-%d-centroids-%d-vocab.mat', numWords, numVocabs), 'documents');
histograms = documents.vlawe;
clear documents;

%% Kernel for training and testing
histograms = double(histograms);

fprintf('Computing PQ kernel...\n');
K = pqk(histograms);

% L-2 normalized
KNorm = diag(K);
KNorm = KNorm + ~KNorm; % eliminate zeros
KNorm = sqrt(KNorm);

K = single(K ./ (KNorm * KNorm'));

save(sprintf('data/K_%d_PQ_VLAWE.mat', numWords), 'K', '-v7.3');

clear K;
