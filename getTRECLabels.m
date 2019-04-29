function [ labels ] = getTRECLabels( names )
    labels = [];
    for i = 1:length(names)
        splitPath = strsplit(names{i}, '\');
        fileName = splitPath{end};

        fileNameSplit = strsplit(fileName, '-');
        class = fileNameSplit{end - 1};

        if strcmp(class, 'abbr')
            classCode = 1;
        elseif strcmp(class, 'desc')
            classCode = 2;   
        elseif strcmp(class, 'enty')
            classCode = 3;  
        elseif strcmp(class, 'hum')
            classCode = 4;  
        elseif strcmp(class, 'loc')
            classCode = 5;  
        elseif strcmp(class, 'num')
            classCode = 6;  
        end

        labels = [labels classCode];
    end
end

