function histograms = computeHistogramsForOneVocabularyFromDocumentList(vocabulary, names, cache, numCentroidWords, numBins)
% Compute BOSWE representations for multiple documents

nargs = nargin;

start = tic;
histograms = cell(1, numel(names));
parfor i = 1:length(names)
  if exist(names{i}, 'file')
    fullPath = names{i};
  else
    fullPath = fullfile('data','documents',[names{i} '.txt']);
  end
  if nargs > 1
    % try to retrieve from cache
    histograms{i} = getFromCache(fullPath, cache);
    if ~isempty(histograms{i}), continue ; end
  end
  fprintf('Extracting histogram from %s (time remaining %.2fs)\n', fullPath, (length(names)-i) * toc(start)/i);
  histograms{i} = computeHistogramForOneVocabularyFromDocument(vocabulary, fullPath, numCentroidWords, numBins);
  if nargs > 1
    % save to cache
    storeToCache(fullPath, cache, histograms{i});
  end
end
histograms = [histograms{:}];

function histogram = getFromCache(fullPath, cache)
[~, name] = fileparts(fullPath);
cachePath = fullfile(cache, [name '.mat']);
if exist(cachePath, 'file')
  data = load(cachePath) ;
  histogram = data.histogram;
else
  histogram = [];
end

function storeToCache(fullPath, cache, histogram)
[~, name] = fileparts(fullPath);
cachePath = fullfile(cache, [name '.mat']);
vl_xmkdir(cache);
data.histogram = histogram;
save(cachePath, '-STRUCT', 'data');