function DX = RandomProj( X, R )
%RandomProj Randomly project the image to a lower dimensional space
%
%INPUT:
%   X: an M * N matrix, original dataset where each column is a data sample
%   D: a randomly generated matrix
%
%OUTPUT:
%   DX: an S * N matrix, projected dataset where each column is a data
%   sample
%


% YOUR CODE STARTS HERE
X=double(X);
DX = R*X;
% YOUR CODE ENDS HERE

end

