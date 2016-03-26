function warped_img = ComputeFlowWarpFrame(img0, img1, u0, v0, t)
% Use forward flow warping to compute an interpolated frame.
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
    width = size(img1, 2);
    
    % Use forward warping to estimate the velocities at time t.
    [ut, vt] = WarpFlow(img0, img1, u0, v0, t);
    
    warped_img = zeros(size(img0));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE:                               %
%            Use backward warping to compute the interpolated frame.           %
%                 Store the result in the warped_img variable.                 %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for x=1:height
    for y=1:width
    old_x = uint8(x - t*ut(x,y));
    old_y = uint8(y - t*vt(x,y));
    if InBounds(img0, old_x, old_y)
          warped_img(x,y,:) = img0(old_x,old_y,:);  
    end
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                 END YOUR CODE                                %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    warped_img = uint8(warped_img);
end

function [ut, vt] = WarpFlow(img0, img1, u0, v0, t)
% Use forward warping to transform a flow field.
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
%     which to compute the interpolated flow field. For example,
%     t = 0 corresponds to img0, t = 1 corresponds to img1, and
%     t = 0.5 is equally spaced in time between img0 and img1.
%
% OUTPUTS
% ut - Horizontal component of the warped flow field; this is an array of
%      the same size as u0.
% vt - Vertical component of the warped flow field; this is an array of the
%      same size as v0.

    height = size(img0, 1);
    width = size(img1, 2);

    ut = zeros(size(u0));
    vt = zeros(size(v0));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE:                               %
%            Use forward warping to compute the velocities ut and vt           %
%               using the procedure described in the problem set.              %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
color_difference = -1 * ones(height, width);
for x=1:height
    for y=1:width
        x_hat = x + t*u0(x,y);
        y_hat = y + t*v0(x,y);
		 m = x + uint8(u0(x,y));
		 n = y + uint8(v0(x,y));
		 col_dif = -1;
		 if InBounds(img0,m,n)
			col_dif = abs(img0(x,y)-img1(m,n));
		 end
        for x_hat_hat=[floor(x_hat),ceil(x_hat)]
            for y_hat_hat=[floor(y_hat),ceil(y_hat)]
				if InBounds(img0, x_hat_hat, y_hat_hat)
					if color_difference(x_hat_hat, y_hat_hat) == -1 || color_difference(x_hat_hat, y_hat_hat) > col_dif
						color_difference(x_hat_hat, y_hat_hat) = col_dif;
						ut(x_hat_hat, y_hat_hat) = u0(x,y);
						vt(x_hat_hat, y_hat_hat) = v0(x,y);
					end
				end
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                 END YOUR CODE                                %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    % Use linear interpolation to fill in any unassigned elements of the
    % warped velocities.
    ut = FillInHoles(ut);
    vt = FillInHoles(vt);
end
