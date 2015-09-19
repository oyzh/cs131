%reads in the unprocessed image, converts to grayscale, and displays it
img = rgb2gray(imread('buoys.jpg'));
imshow(uint8(img));
%%%%%%%% your part (a) filter goes here
edgeDetector = [];

%%%%%%%% your part (b) code here.
%use filter2 to apply the part (a) filter to the image
filtered = [];

%%%%%%% end of part (b)
%displays the filtered image in a new window
figure
imshow(filtered,[]);

%%%%%%%% your part (c) code here. Create a blurring filter and use it to
%%%%%%%% blur the output of part (b)
blurFilter = [];
filteredBlurred = [];

%%%%%%%%%%%% end of part (c)

%displays the blurred image in a new figure
figure
imshow(filteredBlurred,[]);