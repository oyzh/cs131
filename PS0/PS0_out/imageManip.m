%reads in the image, converts it to grayscale, and converts the intensities
%from uint8 integers to doubles. (Brightness must be in 'double' format for
%computations, or else MATLAB will do integer math, which we don't want.)
dark = double(rgb2gray(imread('u2dark.png')));

%%%%%% Your part (a) code here: calculate statistics
averagepixel = mean(mean(dark));
maxpixel = max(max(dark));
minpixel = min(min(dark));

%%%%%% Your part (b) code here: apply offset and scaling

offset = -minpixel;
offset = repmat(offset,size(dark));

factor = 255 / (maxpixel - minpixel);

fixedimg = [];
fixedimg = (dark + offset) * factor;
fixedimg = uint8(fixedimg);
%displays the image
imshow(fixedimg);

imwrite(fixedimg,'fixedimg.png');

%%%%%% Your part (c) code here: apply the formula to increase contrast,
% and display the image
contrasted = [];
offset2 = repmat(128,size(dark));
contrasted = 2*(fixedimg-128) + 128;
contrasted = uint8(contrasted);
imshow(contrasted);
imwrite(contrasted,'contrasted.png');