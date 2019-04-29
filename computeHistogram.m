function histogram = computeHistogram(width, height, keypoints, words, numWords, numBins)
% Compute a spatial histogram of visual words

numSpatialX = numBins;
numSpatialY = numBins;

for i = 1:length(numSpatialX)
  binsx = vl_binsearch(linspace(1,width,numSpatialX(i)+1), keypoints(1,:));
  binsy = vl_binsearch(linspace(1,height,numSpatialY(i)+1), keypoints(2,:));
  bins = sub2ind([numSpatialY(i), numSpatialX(i), numWords], binsy, binsx, words);
  htile = zeros(numSpatialY(i) * numSpatialX(i) * numWords, 1);
  htile = vl_binsum(htile, ones(size(bins)), bins);
  htiles{i} = single(htile / sum(htile));
end

histogram = cat(1,htiles{:});

%% presence histogram
% histogram = single(histogram > 0);

%% L1-normalized
% histogram = single(histogram / sum(histogram));

%% unnormalized
histogram = single(histogram);