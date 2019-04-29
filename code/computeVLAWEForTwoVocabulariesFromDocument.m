function vlawe = computeVLAWEForTwoVocabulariesFromDocument(posVocabulary, negVocabulary, doc, numCentroidWords)
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

nnPos = quantizeDescriptors(posVocabulary, descriptors);
posVlawe = computeVLAWE(nnPos, posVocabulary.centers, descriptors, numCentroidWords);

nnNeg = quantizeDescriptors(negVocabulary, descriptors);
negVlawe = computeVLAWE(nnNeg, negVocabulary.centers, descriptors, numCentroidWords);

vlawe = [posVlawe; negVlawe];
