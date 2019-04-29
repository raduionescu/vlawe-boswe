function vlawe = computeVLAWE(nn, centroids, words, numCentroidWords)

% Create assignment matrix
assignments = zeros(numCentroidWords, numel(nn), 'single');
assignments(sub2ind(size(assignments), nn, 1:numel(nn))) = 1;

% Encode using VLAD
vlawe = vl_vlad(single(words), centroids, assignments);

vlawe = double(vlawe);
