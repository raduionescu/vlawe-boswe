function names = getDocumentSetFull(path, fake_path)
% Scan a directory for documents

content = dir(path);
names = {content.name};
ok = regexpi(names, '[0-9]{1,5}', 'start') ;
names = names(~cellfun(@isempty,ok));

[~, index] = sort(str2double(names));
names = names(index);

for i = 1:length(names)
  names{i} = fullfile(fake_path, names{i});
 end
