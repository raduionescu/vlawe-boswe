function histogram = computeHistogramForTwoVocabulariesFromDocument(posVocabulary, negVocabulary, doc, numCentroidWords, numBins)
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

posWords = quantizeDescriptors(posVocabulary, descriptors);
posHistogram = computeHistogram(width, height, keypoints, posWords, numCentroidWords, numBins);

negWords = quantizeDescriptors(negVocabulary, descriptors);
negHistogram = computeHistogram(width, height, keypoints, negWords, numCentroidWords, numBins);

histogram = [posHistogram; negHistogram];
