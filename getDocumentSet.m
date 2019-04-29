function names = getDocumentSet(path)
% Scan a directory for documents

content = dir(path);
names = {content.name};
% ok = regexpi(names, '.*\.(txt)$', 'start') ;
ok = regexpi(names, '[0-9]{1,5}', 'start') ;
names = names(~cellfun(@isempty,ok));

for i = 1:length(names)
  names{i} = fullfile(path,names{i});
end
