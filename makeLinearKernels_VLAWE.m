%% Load training data
load(sprintf('data/vlawe-%d-centroids-%d-vocab.mat', numWords, numVocabs), 'documents');
histograms = documents.vlawe;
clear documents;

% L2-normalized histograms
% histograms = sign(histograms) .* (abs(histograms).^0.5);
histograms = bsxfun(@times, histograms, 1./max(10^-10, sqrt(sum(histograms.^2,1))));

%% Kernel for training and testing
fprintf('Computing linear kernel...\n');
K = single(histograms' * histograms);
save(sprintf('data/K_%d_lin_VLAWE.mat', numWords), 'K', '-v7.3');

clear K;
