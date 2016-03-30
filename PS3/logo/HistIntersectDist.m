function D = HistIntersectDist( I1, I2, nbins)
%HistIntersectDist
%   Compute the histogram intersection measure for the two given image
%   patches.
%
%Input:
%   I1: image patch 1
%   I2: image patch 2
%   nbins: number of bins for histograms
%
%Output:
%   D: Histogram intersection measure (a real number)
%
    if nargin == 2,
        nbins = 20;
    end
    
	D = 0;
    % YOUR CODE STARTS HERE
    hist1 = Histogram(I1, nbins);
    hist2 = Histogram(I2, nbins);
    index = hist1 < hist2;
    D = sum(hist1(find(index == 1))) + sum(hist2(find(index ==0)));
    % YOUR CODE ENDS HERE
end