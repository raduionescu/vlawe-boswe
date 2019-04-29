%% 0. Setup vl_feat software
setup;

%% 1. Make vocabulary and compute VLAWE embeddings
fprintf('Stage 1: Make vocabularies and compute VLAWE embeddings\n');
clear;

numVocabs = 1;

for numCentroidWords = [10]
    makeVocabulary;
    makeVLAWE;
    
    save(sprintf('./data/vlawe-%d-centroids-1-vocab.mat', numCentroidWords, numVocabs), 'documents', '-v7.3');
    clear;
end

%% 2. Make kernels from document embeddings
fprintf('Stage 2: Make kernels from document embeddings\n');

clear;
numVocabs = 1;
numWords = 10;
numBins = 1;
tic
makeLinearKernels_VLAWE;
toc

 