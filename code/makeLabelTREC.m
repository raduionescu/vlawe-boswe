names = [getDocumentSet('F:\Research\BoWE\trec\data\bowe\training'), getDocumentSet('F:\Research\BoWE\trec\data\bowe\test')];

train = names(1:5452);
test = names(5453:5952);

trainLabels = getTRECLabels(train);
testLabels = getTRECLabels(test);

allLabels = [trainLabels testLabels]';
save(sprintf('trec_labels.mat'), 'allLabels');