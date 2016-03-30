function Label = KNN ( Data, Test, K )
%KNN k nearest neighbor algorithm using Euclidean distances
%   
%   Data: a cell array of size 1 * [num. of classes] which contains data instances from each class,
%   
%   Test: a matrix of size M * N where each column is a data point. 
%
%   K: the number of nearest neighbors.
%
%

    if (size(Data{1}, 1) ~= size(Test, 1)),
        error('Data dimensions do not agree!');
    end
    
    
    DMatrix = double(cell2mat(Data));
    DMatrix = DMatrix ./ repmat(sqrt(sum(DMatrix.^2)), size(DMatrix, 1), 1);
    
    L = size(DMatrix, 2);
    N = size(Test, 2);
    C = size(Data{1}, 2);
    Label = zeros(N, 1);
    
    for i = 1 : N,
        sample = double(Test(:,i));
        sample = sample ./ sqrt(sum(sample.^2));
        [~, idx] = sort(sum((DMatrix - repmat(sample, 1, L)).^2));
        idx = ceil(idx(1:K) ./ C);
        Label(i) = mode(idx);
    end


end

