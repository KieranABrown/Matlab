% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;

SinCity = imread('SC.png'); % Load the input.
NewSinCity = uint8(zeros(size(SinCity))); % Creates a holder image with the same dimentions as the SinCity. 

% Creates variables with the given values for the program to meet.
A = 80; 
B = 100; 
C = 220; 

% Loop through the rows and cols of the SinCity Image.
for X = 1:size(SinCity,1)
    for Y = 1:size(SinCity,2)
        
         % Gets the value of the current pixel.
         Pixel_Select = SinCity(X, Y);
         
         % Compares the pixel value agains the current parameters of the if
         % statment.         
         if Pixel_Select >= A && Pixel_Select <= B
             New_Pixel = C;
             
         % Otherwise retain the value.        
         else
             New_Pixel = Pixel_Select;
         end
         
         % Replaces the current pixel value with the new one.
         NewSinCity(X, Y) = New_Pixel;
    end
end

% Display the images with a size by side comparison. 
figure;
subplot(1,2,1), imshow(SinCity), title('Original');
subplot(1,2,2), imshow(NewSinCity), title('Altered');
