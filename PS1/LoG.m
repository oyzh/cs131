function y = LoG( x, sigma )
%input 
% x a vector which is axi
% sigma 
%output
% y LoG of x
if ~exist('sigma', 'var')
    sigma = 1;
end

y = (x.^2-1)/(sqrt(2*pi)*sigma).*exp(1).^(-x.^2/(2*sigma^2));

end

