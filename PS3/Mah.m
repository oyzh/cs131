function distance = Mah( x, y ,SIGMA )
% calulate two point's Mahalanobis distances.
% formula: Dist(x, y, SIGMA) = (x - y)T*SIGMA*(x - y)
% x, y: two n-dimensioanl points (column vector).
% SIGMA: n * n matrix.
% distance: Mahalanobis distances.

distance = (x - y)' * SIGMA * (x - y);


end

