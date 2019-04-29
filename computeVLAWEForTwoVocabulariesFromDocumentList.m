function vlawe = computeVLAWEForTwoVocabulariesFromDocumentList(posVocabulary, negVocabulary, names, cache, numCentroidWords)
% Compute spatiograms for multiple documents

nargs = nargin;

start = tic;
vlawe = cell(1, numel(names));
parfor i = 1:length(names)
  if exist(names{i}, 'file')
    fullPath = names{i};
  else
    fullPath = fullfile('data','documents',[names{i} '.txt']);
  end
  if nargs > 1
    % try to retrieve from cache
    vlawe{i} = getFromCache(fullPath, cache);
    if ~isempty(vlawe{i}), continue ; end
  end
  fprintf('Extracting VLAWE from %s (time remaining %.2fs)\n', fullPath, (length(names)-i) * toc(start)/i);
  vlawe{i} = computeVLAWEForTwoVocabulariesFromDocument(posVocabulary, negVocabulary, fullPath, numCentroidWords);
  if nargs > 1
    % save to cache
    storeToCache(fullPath, cache, vlawe{i});
  end
end
vlawe = [vlawe{:}];

function vlawe = getFromCache(fullPath, cache)
[~, name] = fileparts(fullPath);
cachePath = fullfile(cache, [name '.mat']);
if exist(cachePath, 'file')
  data = load(cachePath);
  vlawe = data.vlawe;
else
  vlawe = [];
end

function storeToCache(fullPath, cache, vlawe)
[~, name] = fileparts(fullPath);
cachePath = fullfile(cache, [name '.mat']);
vl_xmkdir(cache);
data.vlawe = vlawe;
save(cachePath, '-STRUCT', 'data');