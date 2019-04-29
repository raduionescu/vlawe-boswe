if numVocabs == 1
    %% One vocabulary per data set
    % Sentiment Analyis - e.g. Movie Review Polarity dataset
    posDocuments.names = getDocumentSet('./data/glove/pos');
    negDocuments.names = getDocumentSet('./data/glove/neg');

    documents.names = [posDocuments.names, negDocuments.names];

    vocabulary = computeVocabularyFromDocumentList(documents.names, numCentroidWords);

    save(sprintf('data/vocabulary_%d.mat', numCentroidWords), 'vocabulary');

elseif numVocabs == 2
    
    %% One vocabulary per class
    % Sentiment Analyis - e.g. Movie Review Polarity dataset
    posDocuments.names = getDocumentSet('./data/glove/pos');
    negDocuments.names = getDocumentSet('./data/glove/neg');

    posVocabulary = computeVocabularyFromDocumentList(posDocuments.names, numCentroidWords);
    negVocabulary = computeVocabularyFromDocumentList(negDocuments.names, numCentroidWords);

    save(sprintf('data/posVocabulary_%d.mat', numCentroidWords), 'posVocabulary');
    save(sprintf('data/negVocabulary_%d.mat', numCentroidWords), 'negVocabulary');
end