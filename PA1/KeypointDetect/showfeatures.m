%/////////////////////////////////////////////////////////////////////////////////////////////
%
% showfeatures - visualize features generated by detect_features
% Usage:  showfeatures(features,img)
%
% Parameters:  
%            
%            img :      original image
%            features:  matrix generated by detect_features
%
% Returns:   nothing, generates figure
%
% Author: 
% Scott Ettinger
% scott.m.ettinger@intel.com
%
% May 2002
%/////////////////////////////////////////////////////////////////////////////////////////////

function [] = showfeatures(features,img,num_flag)

if ~exist('num_flag')
    num_flag = 0;
end

figure(gcf);
imagesc(img)
hold on
colormap gray

for i=1:size(features,1)
    x = features(i,1);
    y = features(i,2);
    sz = features(i,4);
    
    if x>size(img,2)
        x
    end
    
    if features(i,5) > 0        %check edge flag
        
        if num_flag ~= 1
            plot(x,y,'g+');         %draw box around real feature
        else
            text(x,y,sprintf('%d',i),'color','m');
        end
        
        if abs(features(i,7))>1.8
            drawbox(0,sz,x,y,[0 0 1]);
        else
            drawbox(0,sz,x,y,[0 .9 .2]);
        end
    else                        %draw as edge
            
        ang = features(i,6);
        px = [x-sz*cos(ang) x+sz*cos(ang)];
        py = [y-sz*sin(ang) y+sz*sin(ang)];
        plot(px,py,'r');
    end
end

hold off;