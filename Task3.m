% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

%Image Reading
Noisy = rgb2gray(imread('Noisy.png'));

%Filtered Images Containers
AvgFil = uint8(zeros(size(Noisy)));
MedFil = uint8(zeros(size(Noisy)));

%Padding adding an addtional 2 rows or cols to each side.
AvgFilPad = 255*im2double(padarray(Noisy, [2 2]));
MedFilPad = 255*im2double(padarray(Noisy, [2 2]));

%Creates the size needed for looping, only done once as loop sizes will be
%the same.
[SizeRow,SizeCol] = size(AvgFilPad);

% Averaging Filter
for ImgRow = 1:SizeRow %Loops through the image
    for ImgCol = 1:SizeCol
        
        % Begin the image after the padding and ensure boundries cannot be
        % exceeded. Also helps with removing any additional 0's to the
        % image. 
        if (ImgRow > 2 && ImgCol > 2 && ImgRow < SizeRow-1 && ImgCol < SizeCol-1) 
            
            %Creates the matrix needed to preform the Average on.
            AvgMatrix = AvgFilPad (ImgRow-2:ImgRow+2, ImgCol-2:ImgCol+2);
            
            % Uses the mean2 function to preform the averaging calculation
            % upon the matrix.
            Average = mean2(AvgMatrix); 
            
            % Assigns the average matrix to the padded image. 
            AvgFilPad(ImgRow, ImgCol) = Average;
            
        end
    end 
end 

%Median Filter. 
for ImgRow = 1:SizeRow %Loops through the image
    for ImgCol = 1:SizeCol
        % Begin the image after the padding and ensure boundries cannot be exceeded. 
        if (ImgRow > 2 && ImgCol > 2 && ImgRow < SizeRow-1 && ImgCol < SizeCol-1) 
            
            % Creates a matrix to preform the median filter on. 
            MedMatrix = MedFilPad(ImgRow - 2:ImgRow + 2, ImgCol - 2:ImgCol + 2);
            
            % Removes all of the 0's from the matrix so there are no
            % imperfections on the end result image.
            MedMatrix(MedMatrix == 0)= NaN;
            
            % Preforms the median filter on the matrix.
            Median = nanmedian(MedMatrix(:));
            
            % Assigns the values back to the padded image. 
            MedFilPad(ImgRow, ImgCol)= Median; 
            
        end
    end 
end 

% Removes the extra padding previously added from the final image.
AvgFil = uint8(AvgFilPad(3:476,3:756));
MedFil = uint8(MedFilPad(3:476,3:756));

%Outputting
figure, imshow(Noisy), title("Task 3 : Original")
figure, imshow(AvgFil), title("Task 3 : Average")
figure, imshow(MedFil), title("Task 3 : Median")