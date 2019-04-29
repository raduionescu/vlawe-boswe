%% Load training data
load(sprintf('data/vlawe-%d-centroids-%d-vocab.mat', numWords, numVocabs), 'documents');
histograms = documents.vlawe;
clear documents;

% Power normalization
histograms = sign(histograms) .* (abs(histograms).^0.5);

[PCACoefficients, reducedFeatures] = pca(histograms', 'NumComponents', numPCAComponents, 'Centered', false);
histograms = reducedFeatures';
    
% L2-normalized histograms 
histograms = bsxfun(@times, histograms, 1./sqrt(sum(histograms.^2,1)));

%% Kernel for training and testing
fprintf('Computing linear kernel...\n');
K = single(histograms' * histograms);
save(sprintf('data/K_%d_lin_VLAWE_PCA.mat', numWords), 'K', '-v7.3');

clear K;
