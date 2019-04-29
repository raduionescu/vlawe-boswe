function [keypoints,descriptors] = computeFeatures(doc)
[num_feat, num_words] = size(doc);

keypoints = [ones(1,num_words);ones(1,num_words)];
descriptors = single(doc);
