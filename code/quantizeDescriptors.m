function nn = quantizeDescriptors(vocabulary, descriptors)
% Quantize a visual descriptor to get a visual word

nn = vl_kdtreequery(vocabulary.kdtree, vocabulary.centers, descriptors, 'MaxComparisons', 15);

