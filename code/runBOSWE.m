%% 0. Setup vl_feat software
setup;

%% 1. Make vocabulary and compute VLAWE embeddings
fprintf('Stage 1: Make vocabularies and compute BOSWE embeddings\n');
clear;

numVocabs = 2;

for numCentroidWords = [500]
    makeVocabulary;
    numBins = 1;
    makeBOSWE;
    
    save(sprintf('./data/boswe-%d-centroids-%d-vocab.mat', numCentroidWords, numVocabs), 'documents', '-v7.3');
    clear;
end

%% 2. Make kernels from document embeddings
fprintf('Stage 2: Make kernels from document embeddings\n');

clear;
numVocabs = 2;
numWords = 500;
numBins = 1;
tic
makeLinearKernels;
toc
tic
makePQKernels;
toc

