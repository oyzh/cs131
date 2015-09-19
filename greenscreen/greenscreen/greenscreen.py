from cv2 import *
import numpy as np

vectorize = False
superman = imread('superman.png')
space = imread('space.png')

characterImg = superman
backgroundImg = space

outputImg = np.zeros(characterImg.shape,'uint8');
height = characterImg.shape[0]
width = characterImg.shape[1]

MINRED,MINGREEN,MINBLUE = 10,100,10
MAXRED,MAXGREEN,MAXBLUE = 160,220,110;

if ~vectorize:
    for y in range(height):
        for x in range(width):
            redMatch = (MINRED <= superman[y][x][2]) and (superman[y][x][2] <= MAXRED)
            greenMatch = (MINGREEN <= superman[y][x][1]) and (superman[y][x][1] <= MAXGREEN)
            blueMatch = (MINBLUE <= superman[y][x][0]) and (superman[y][x][0] <= MAXBLUE)
            match = redMatch and greenMatch and blueMatch
            if match:
                outputImg[y][x] = backgroundImg[y][x]
            else:
                outputImg[y][x] = characterImg[y][x]
    
                    
imshow('r',outputImg)
imwrite('superspaceman.png',outputImg)
waitKey(0)
