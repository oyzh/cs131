function DX = PCA( X, PC )
%PCA Project the dataset along the principal components 
%
%INPUT:
%   X: an M * N matrix, original dataset where each column is a data sample
%   PC: principle component matrix, where each row is a component
%
%OUTPUT:
%   DX: an S * N matrix, projected dataset where each column is a data
%   sample
%

X = double(X);
% YOUR CODE STARTS HERE
DX = PC * X;
% YOUR CODE ENDS HERE

end

