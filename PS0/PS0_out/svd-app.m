%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%author: Zhenhuan Ouyang , Zhejiang University
%%course: Feifei Li Computer Vision
%%date  : 2015/09/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = double(rgb2gray(imread('flower.bmp')));

[U,S,V] = svd(img);

US = U*S;
VT = V';

comimg = zeros(size(img));

for i = 1:100
 temp = US(:,i)*VT(i,:)
 if i < 10
  figure
  imwrite(uint8(temp));
 end
end

comimg = US(:,1:10)*VT(1:10,:); 
imwrite(uint8(comimg),'ten.bmp');
comimg = comimg + US(:,11:50)*VT(11:50,:);
imwrite(uint8(comimg),'fifty.bmp');
comimg = comimg + US(:,51:100)*VT(51:100,:);
imwrite(uint8(comimg),'fifty.bmp');
