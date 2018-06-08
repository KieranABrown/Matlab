    % MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

Zebra = imread('Zebra.jpg'); % Step-1: Load input image
Zebragray = rgb2gray(Zebra); % Step-2: Conversion of input image to grey-scale image

% Creates a new matrix containing the needed sizes.
New_Dimensions = [1668 1836];

% Creates a empty scale variable which will be stored with the relevent information.
Scale = [0 0];

% Gets height and width of gray image.
[Zrow, Zcols] = size(Zebragray);

% Gets the sizes needed for the new images.
Scale(1) = (New_Dimensions(1)/Zrow);
Zrow = Zrow.*Scale(1);
Scale(2) = (New_Dimensions(2)/Zcols);
Zcols = Zcols.*Scale(2);

%Creates a blank copy of the images for storage once the interpolations
%have taken place.
Nearest_Neighbour = uint8(zeros(size(New_Dimensions)));
Bilinear = uint8(zeros(size(New_Dimensions)));
f = zeros(size(Bilinear));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Nearest Neighbour %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Iterates through the image size of the gray image by Zrow and Zcols.
for X = 1: Zrow
    for Y = 1: Zcols
        
        % Rounds each of the values withtin the whilst calculation them for
        % the image using the previous Scale variable storing the scaling value.
        Zgh = round(X/Scale(1));
        Zgw = round(Y/Scale(2));
        
        % Eliminates errors occuring by ensuring that any resulting value
        % from the previous calculation will become 1
        if Zgh == 0 || Zgw == 0
            Zgh = 1;
            Zgw = 1;
        end
        
        % Assigns new pixels to new image after they have been scaled.
        Nearest_Neighbour(X, Y) = Zebragray(Zgh, Zgw);
    end
end

imwrite(Nearest_Neighbour, 'Nearest Interpolation.jpg');%Saves the entire nearest neighbour interpolation as a separate file.
Nearest_Crop = imcrop(Nearest_Neighbour,[280,300,330,400]);% Crops the image to the face of the zebra to show the detail for pixel analysis.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Bilinear %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loop through the image using the rows.
for X = 1: Zrow
    % Loop through the image using the rows.
    for Y = 1: Zcols
        
        % Creates the scale needed for the rows needed in the new image.
        Zgh = X/Scale(1);
        % Creates the scale needed for the columns.
        Zgw = Y/Scale(2);
        
        % Round down to the nearest whole number.
        X1 = floor(Zgh);
        Y1 = floor(Zgw);
        
        % Round up to the nearest whole number.
        X2 = ceil(Zgh);
        Y2 = ceil(Zgw);
        
        % Ensure that each X1 and Y1 value must at least be 1.
        if X1 == 0 || Y1 == 0
            X1 = 1;
            Y1 = 1; 
        end
       
        % Checks that every value is at least a whole number whole number
        XWhole = rem(Zgh,1);
        YWhole = rem(Zgw,1);
        
        % Assign points the value corresponding to the necassary X and
        % Y axis values.
        Q11 = Zebragray(X1,Y1);
        Q12 = Zebragray(X1,Y2);
        Q21 = Zebragray(X2,Y1);
        Q22 = Zebragray(X2,Y2);
        
        % Preform the values on the X axis first
        R1 = Q21 * XWhole + Q11 * (1-XWhole);
        R2 = Q22 * XWhole + Q12 * (1-XWhole);
        
        % Preform the values on the Y axis
        f(X, Y) = R1 * YWhole + R2 * (1-YWhole);
        
        % Assign the new values to the new image.
        Bilinear(X, Y) = f(X, Y);
    end
end
imwrite(Bilinear, 'Bilinear.jpg');%Saves the entire Bilinear image as a separate file.
Bilinear_Crop = imcrop(Bilinear,[280,300,330,400]);% Crops the image to the face of the zebra to show the detail for pixel analysis.

%Displaying
figure, imshow(Zebra), title('Loading input image')
figure, imshow(Zebragray), title('Conversion to gray scale')
figure, imshow(Nearest_Crop), title('Nearest Interpolation')
figure, imshow(Bilinear_Crop), title('Bilinear Interpolation')
