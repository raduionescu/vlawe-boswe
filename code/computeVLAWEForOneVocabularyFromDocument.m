function vlawe = computeVLAWEForOneVocabularyFromDocument(vocabulary, doc, numCentroidWords)
% Compute spatial VLAD of visual words for an image

if isstr(doc)
  if exist(doc, 'file')
    fullPath = doc;
  else
    fullPath = fullfile('data','documents', [docim '.txt']);
  end
  
  doc = csvread(fullPath)';
end

[~, descriptors] = computeFeatures(doc);

nn = quantizeDescriptors(vocabulary, descriptors);
vlawe = computeVLAWE(nn, vocabulary.centers, descriptors, numCentroidWords);

