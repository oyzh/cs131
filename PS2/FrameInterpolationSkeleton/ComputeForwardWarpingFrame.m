function img = ComputeForwardWarpingFrame(img0, img1, u0, v0, t)
% Use forward warping to compute an interpolated frame.
%
% INPUTS
% img0 - Array of size h x w x 3 containing pixel data for the starting
%        frame.
% img1 - Array of the same size as img0 containing pixel data for the
%        ending frame.
% u0 - Horizontal component of the optical flow from img0 to img1. In
%      particular, an array of size h x w where u0(y, x) is the horizontal
%      component of the optical flow at the pixel img0(y, x, :).
% v0 - Vertical component of the optical flow from img0 to img1. In
%      particular, an array of size h x w where v0(y, x) is the vertical
%      component of the optical flow at the pixel img0(y, x, :).
% t - Parameter in the range [0, 1] giving the point in time at
%     which to compute the interpolated frame. For example, 
%     t = 0 corresponds to img0, t = 1 corresponds to img1, and
%     t = 0.5 is equally spaced in time between img0 and img1.
%
% OUTPUTS
% img - Array of size h x w x 3 containing pixel data for the interpolated
% frame.

    height = size(img0, 1);
    width = size(img0, 2);
    img = NaN(size(img0));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE:                               %
%            Use forward warping to compute the interpolated frame;            %
%               store the interpolated image in the img variable.              %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%because of the index is also not integer, so there may be some interpolate
%too
for x=1:height
    for y=1:width
        x_new = uint8(x+t*u0(x,y));
        y_new = uint8(y+t*v0(x,y));
        if x_new <= height && x_new > 0
            if y_new <= width && y_new > 0
                img(x_new, y_new,:) = img0(x,y,:);
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                 END YOUR CODE                                %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if any(size(img) ~= [height width 3])
        % If you get this error, it's probably because you wrote to index 
        % (end+1), which causes MATLAB to expand an array. Don't do that.
        error('image is wrong size.') 
    end

    % Use linear interpolation to fill in any holes in the interpolated
    % image.
    for c = 1:size(img, 3)
        img(:, :, c) = FillInHoles(img(:, :, c));
    end
    
    % Convert the interpolated image to uint8 for visualization.
    img = uint8(img);
end