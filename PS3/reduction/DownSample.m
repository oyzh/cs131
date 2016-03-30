function DX = DownSample( X, ratio )
%DownSample Downsample each images in the data by a constant factor
%
%INPUT:
%   X: an M * N matrix, original dataset where each column is a data sample edge length.
%   ratio: downsample ratio
%
%
%OUTPUT:
%   DX: an S * N matrix, downsampled dataset where each column is a reducted data sample
%
%

[M, N] = size(X);
DX = zeros((ceil(sqrt(M) * ratio)^2), N);

% YOUR CODE STARTS HERE
for i=[1:N]
    DX(:,i) = imresize(X(:,i), size(DX,1)/M);
end
% YOUR CODE ENDS HERE

end

