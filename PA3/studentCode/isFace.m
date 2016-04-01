function isFace = isFace( img )
% Decides if a given image is a human face
%   INPUT:
%       img - a grayscale image, size 120 x 100
%   OUTPUT:
%       isFace - should be true if the image is a human face, false if not.

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                     %
    %                       YOUR PART 4 CODE HERE                         %
    %                                                                     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Design your own method to decide if the image is a human face
    isFace = false;
    [rawFaceMatrix, imageOwner, imgHeight, imgWidth] = readInFaces();
    meanFace = zeros(size(rawFaceMatrix,1),1);
    meanFace = sum(rawFaceMatrix, 2) / size(rawFaceMatrix, 2);
    A = zeros(size(rawFaceMatrix));
    A = rawFaceMatrix - repmat(meanFace, 1, size(rawFaceMatrix, 2));
    
    normImg = img(:) - meanFace;
    
    %first get the dist of A, then assume some threshold.
    mean_threshold = ;
    pca_threashold = ;
    lda_threashold = ;
    
    dist_mean = sum(normImg.^2);
    
    numComponentsToKeep = 20;
    prinComponents = [];
    weightCols = [];
    indexOfClosestMatch = 0;
    
    [prinComponents, weightCols] = doPCA(A, numComponentsToKeep);
    weightTest = [normImg' * prinComponents]';
    [minDist1, indexOfClosestMatch] = indexOfClosestColumn(weightCols, weightTest);
        
    [prinComponents, weightCols] = fisherfaces(A,imageOwner,numComponentsToKeep);
    weightTest = [normImg' * prinComponents]';
    [minDist2, indexOfClosestMatch] = indexOfClosestColumn(weightCols, weightTest);
        
    if dist_mean < mean_threshold
        if minDist1 < pca_threshold
            if minDist2 < lda_threshold
                isFace = true;
            end
        end
    end
    
    
        
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                     %
    %                            END YOUR CODE                            %
    %                                                                     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
end

function [minDist, indexOfClosest] = indexOfClosestColumn(A, testColumn)
        dist = pdist2(A', testColumn');
        minDist = min(dist);
        indexOfClosest = find(dist == minDist, 1);
end
