function vocabulary = computeVocabularyFromDocumentList(names, numCentroidWords)
% Compute a vocabulary of super word vectors

numFeatures = 240000;

descriptors = cell(1,numel(names));
parfor i = 1:numel(names)
  if exist(names{i}, 'file')
    fullPath = names{i} ;
  else
    fullPath = fullfile('data','documents',[names{i}]) ;
  end
  fprintf('Extracting features from %s\n', fullPath) ;
  
  d = csvread(fullPath)';
  descriptors{i} = vl_colsubset(d, round(numFeatures / numel(names)), 'uniform');
end

% Cluster the word embeddings into super word embeddings by using k-means
% Compute a KD-tree to index word embeddings.

fprintf('Computing super word vectors and kdtree\n');
descriptors = single([descriptors{:}]);

vocabulary.centers = vl_kmeans(descriptors, numCentroidWords, 'verbose', 'algorithm', 'elkan');
vocabulary.kdtree = vl_kdtreebuild(vocabulary.centers);
