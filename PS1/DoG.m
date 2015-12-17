function y = DoG( x, k, sigma )
%input x:vector,sigma:scalar,k:scalar
%output y: DoG of y
%k~=1


if ~exist('sigma','var')
    sigma = 1;
end

if ~exist('k','var')
    k = 1.2
end

if k==1
    error('k is wrong');
end

y = (gaussian(x,k*sigma) - gaussian(x,sigma))/(k*sigma-sigma);

end

function y = gaussian(x, sigma)

y = (1/(sqrt(2*pi)*sigma))*exp(1).^(-x.^2/(2*sigma^2));

end

