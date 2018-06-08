% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;

% Reads in the image. 
Starfish = imread('Starfish.jpg');

% Creates a blank area for the end result. 
Stars = zeros(362,438);

% Converts the read in image to Gray.
Starfish_Gray = rgb2gray(Starfish);

% Creates a histogram of the image at a high contrast.
Star_Hist = histeq(Starfish_Gray);

% Preform Median filter.
Noise_Reduced = medfilt2(Star_Hist);

% Convert to Binary image and reverse the colour scheme with a base level of sensitivity.
Binary_Image = imcomplement(imbinarize(Noise_Reduced));

% Clears up the elements within the binary image. 
Elements = strel('disk',2);
Binary_Image = imerode(Binary_Image,Elements);

% Fills in the holes left over. 
Binary_Image = imfill(Binary_Image, 'holes');

% Find the connected objects within the Binary_Image
ConnectedObjects = bwconncomp(Binary_Image);

% Works out the area for each of the props detected within the image. 
ObjectStats = regionprops(ConnectedObjects, 'Area', 'Perimeter');

% Assigns each of the props a label
itemlabel = labelmatrix(ConnectedObjects); 

% Removes any noise from the image where the boundaries are:
% Area value is in between 500 and 1500
% and the Perimeter is between 255 and 400
ObjRemoved = ismember(itemlabel, find([ObjectStats.Area] >= 500 & [ObjectStats.Area] <= 1500 & [ObjectStats.Perimeter] >= 255 & [ObjectStats.Perimeter] <= 400));

% Assigns each of the remaining props a label
[L, ObjectsNum] = bwlabel(ObjRemoved);

% Works out both the area and perimeter of the found objects
stats = regionprops(L, 'Area', 'Perimeter');

% Iterates through the number of images found. 
for Counter = 1:ObjectsNum
    
    % Gets the Area of each of the objects.
    area = stats(Counter).Area;
    
    % Gets the Perimeter of each of the objects.
    perimeter = stats(Counter).Perimeter;
    
    % Preforms the equations to detect the roundness of the object.
    Roundness = 4 * pi * area/perimeter^2;
    
    % Looks for the maximum and minimum values of the starfish
    if (Roundness >= 0.13 && Roundness <= 0.17)
        
        % Stores the new detected starfish.
        Stars = Stars | (L == Counter);
    end
end

%Outputting
figure, imshow(Starfish), title("Task 4 : Original")
figure, imshow(Noise_Reduced), title("Task 4 : Noise Reduced")
figure, imshow(Binary_Image), title("Task 4 : Binary Image")
figure, imshow(ObjRemoved), title("Task 4 : Objects Removed")
figure, imshow(Stars), title("Task 4 : Stars Found")
