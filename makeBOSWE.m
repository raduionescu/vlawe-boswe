% Data Preparation
if numVocabs == 1
    %% One vocabulary per data set
    % Sentiment Analyis - e.g. Movie Review Polarity dataset
    posDocuments.names = getDocumentSet('./data/glove/pos');
    negDocuments.names = getDocumentSet('./data/glove/neg');
    
    documents.names = [posDocuments.names, negDocuments.names];
    
    load(sprintf('data/vocabulary_%d.mat', numCentroidWords), 'vocabulary');
    
    % Compute BOSWE embeddings for dataset
    documents.histograms = computeHistogramsForOneVocabularyFromDocumentList(posVocabulary, negVocabulary, documents.names, sprintf('data/cache_%d_%dx%d', numCentroidWords, numBins, numBins), numCentroidWords, numBins);

elseif numVocabs == 2

    %% One vocabulary per class
    % Sentiment Analyis - e.g. Movie Review Polarity dataset
    posDocuments.names = getDocumentSet('./data/glove/pos');
    negDocuments.names = getDocumentSet('./data/glove/neg');

    documents.names = [posDocuments.names negDocuments.names];

    load(sprintf('data/posVocabulary_%d.mat', numCentroidWords), 'posVocabulary');
    load(sprintf('data/negVocabulary_%d.mat', numCentroidWords), 'negVocabulary');

    % Compute BOSWE embeddings for dataset
    documents.histograms = computeHistogramsForTwoVocabulariesFromDocumentList(posVocabulary, negVocabulary, documents.names, sprintf('data/cache_%d_%dx%d', numCentroidWords, numBins, numBins), numCentroidWords, numBins);
end