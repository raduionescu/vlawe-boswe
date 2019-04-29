function [ kernelMartix ] = JSKernelMatrix(histograms)
 
[histSize,numberOfHistograms] = size(histograms);
kernelMartix = eye(numberOfHistograms);

m = min(histograms(find(histograms(:) > 0))) * 0.1;
histograms = histograms' + m;
histograms = histograms ./ (sum(histograms, 2) * ones(1, size(histograms,2)));

for hi = 1:numberOfHistograms
    for hj = (hi+1):numberOfHistograms
        
        meanHist = 0.5 * (histograms(hi,:) + histograms(hj,:));
        JSdivergence = 0.5 * (sum(histograms(hi,:) .* (log2(histograms(hi,:)) - log2(meanHist))) + sum(histograms(hj,:) .* (log2(histograms(hj,:)) - log2(meanHist))));
        
        kernelMartix(hi,hj) = 1 - JSdivergence;
        kernelMartix(hj,hi) = kernelMartix(hi,hj);      
    end
end
end


