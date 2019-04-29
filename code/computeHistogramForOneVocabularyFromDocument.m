function histogram = computeHistogramForOneVocabularyFromDocument(vocabulary, doc, numCentroidWords, numBins)
% Compute histogram of super word embeddings for a text document

if isstr(doc)
  if exist(doc, 'file')
    fullPath = doc;
  else
    fullPath = fullfile('data','documents', [docim '.txt']);
  end
  
  doc = csvread(fullPath)';
end

width = size(doc,2);
height= size(doc,1);
[keypoints, descriptors] = computeFeatures(doc);

words = quantizeDescriptors(vocabulary, descriptors);
histogram = computeHistogram(width, height, keypoints, words, numCentroidWords, numBins);
