function headCenters = findHeads( img )
%findHeads Uses skin segmentation together with erosion/dilation to find
%   blobs of skin-colored pixels which are about the right size to be heads.
%   Returns their centers.
%   INPUTS:
%       img - an rgb image
%   OUTPUTS:
%       headCenters - An n x 2 matrix, where n is our estimate of the
%       number of heads. Each row holds the (x,y) coordinates of a head
%       center in the image.

% This defines a default image to use, so you can just hit F5 in the editor
% to test the function
if nargin == 0
    img = imread('heads.jpg');
end

% converts image to YCbCr color space and applies some simple thresholds to
% produce a boolean image which is 1 for skin and 0 for non-skin. The
% result will be far from perfect, as color of one pixel isn't enough, in
% general, to recognize something.
yCbCr=rgb2ycbcr(img);
y = squeeze(yCbCr(:,:,1));
cb = squeeze(yCbCr(:,:,2));
cr = squeeze(yCbCr(:,:,3));
skinInitial = (131 <= cr) & (cr <= 185) & (80 <= cb) & (cb <= 135) & (y<=150);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                     %
%                          YOUR CODE HERE                             %
%                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Makes a circular structuring element. This is like a filter but for
% erosion/dilation. You'll likely want to adjust the radius.
SEdilate = strel('disk',5,0); %the last argument to strel() can remain 0.
SEerode = strel('disk',5,0);

% Now, you can use imdilate and imerode to eliminate noise pixels and join
% skin pixels. This will take some experimentation, and you probably won't
% eliminate all the unwanted blobs.
skin = skinInitial;
skin = imdilate(skin, SEdilate);
skin = imerode(skin, SEerode);




% This will show the original skin segmentation image and your modified
% image below it.
subplot(2, 1, 1);
imshow(maskSkin(img, skinInitial));
title('Initial skin segmentation', 'FontSize', 14);
subplot(2, 1, 2);
imshow(maskSkin(img, skin));
title('Modified skin segmentation', 'FontSize', 14);

% Now, use regionprops() to get statistics on the blobs of skin pixels. 
% For example, the command STATS = regionprops(skin,'Centroid') returns an
% array of structs holding the centers of blobs. The array is size
% length(STATS), and you can get the centroid of the ith blob with 
% c = STATS(i).Centroid
% Note that the centroid is in (x,y) order, not the normal MATLAB matrix
% order. Please return your headCenters in that same (x,y) order.
% Read the doc for regionprops() to find other useful statistics that you
% can use to differentiate the heads from arms, hands, and noise.

STATS = regionprops(skin, 'Centroid');

headCenters = [];
Eccent = regionprops(skin, 'Eccentricity');
eccent = [Eccent.Eccentricity];
Areas = regionprops(skin,'area');
area_val = [Areas.Area];

%orz... area_val should be smaller and we find head by some other
%properties. but for this it work.
idxlist1 = find(area_val > 13000);
idxlist2 = find(eccent > 0.0);
idxlist = intersect(idxlist1, idxlist2);
for i=idxlist
    headCenters = [headCenters;STATS(i).Centroid];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                     %
%                            END YOUR CODE                            %
%                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plots your centers on the original image. For heads.jpg, you should see a
% center inside each head, and nothing else should be labeled as a head.
if ~isempty(headCenters)
    plotCenters(img, headCenters)
end


end

function skinImg = maskSkin(img, skin)
% Uses a skin mask to extract the skin regions from an image.
% INPUTS: img - image from which to extract
%         skin - 2D binary mask of skin locations
%
% OUTPUT: skinImg - Version of img containing only skin pixels.
    mask = ~repmat(skin, [1, 1, 3]);
    skinImg = img;
    skinImg(mask) = 0;
end


function plotCenters(img, headCenters)
% Plots an image and a list of points
% INPUTS: img - image to display
%         headCenters - An n x 2 array, where each row is an (x,y) point
%               which will be plotted on top of the image
    figure;
    hold on;
    imshow(img);
    for center = headCenters'
        if length(center) ~= 2
            error('Wrong format for headCenters. Should be size n x 2.')
        end
        w = 12; %half width
        line([center(1)-w,center(1)+w],[center(2),center(2)],'Color','r','LineWidth',3)
        line([center(1),center(1)],[center(2)-w,center(2)+w],'Color','r','LineWidth',3)
    end
    hold off

end
