% Data Preparation
if numVocabs == 1

    %% One vocabulary per data set
    % Sentiment Analyis - e.g. Movie Review Polarity dataset
    posDocuments.names = getDocumentSet('./data/glove/pos');
    negDocuments.names = getDocumentSet('./data/glove/neg');

    documents.names = [posDocuments.names, negDocuments.names];

    load(sprintf('data/vocabulary_%d.mat', numCentroidWords), 'vocabulary');

    % Compute VLAWE embeddings for dataset
    documents.vlawe = computeVLAWEForOneVocabularyFromDocumentList(vocabulary, documents.names, sprintf('data/cache_%d', numCentroidWords), numCentroidWords);

elseif numVocabs == 2

    %% One vocabulary per class
    % Sentiment Analyis - e.g. Movie Review Polarity dataset
    posDocuments.names = getDocumentSet('./data/glove/pos');
    negDocuments.names = getDocumentSet('./data/glove/neg');

    documents.names = [posDocuments.names negDocuments.names];
    
    load(sprintf('data/posVocabulary_%d.mat', numCentroidWords), 'posVocabulary');
    load(sprintf('data/negVocabulary_%d.mat', numCentroidWords), 'negVocabulary');
    
    % Compute VLAWE embeddings for dataset
    documents.vlawe = computeVLAWEForTwoVocabulariesFromDocumentList(posVocabulary, negVocabulary, documents.names, sprintf('data/cache_%d', numCentroidWords), numCentroidWords);

end