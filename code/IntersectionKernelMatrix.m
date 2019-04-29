function [ kernelMartix ] = IntersectionKernelMatrix(histograms)

[histSize,numberOfHistograms] = size(histograms);
kernelMartix = zeros(numberOfHistograms, numberOfHistograms);

for hi = 1:numberOfHistograms
    for hj = hi:numberOfHistograms
        
        kernelMartix(hi,hj) = sum(min(histograms(:,hi), histograms(:,hj)));
        kernelMartix(hj,hi) = kernelMartix(hi,hj);
    end
end
end


