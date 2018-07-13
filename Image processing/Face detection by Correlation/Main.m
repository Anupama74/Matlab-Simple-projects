% Clear command window
clc;

% Clear all the predefined variables
clear all;

% Close all the opened figure windows
close all;


%% Read the Images

% Read a group image
Group = imread('group1.jpg');

% Group = rgb2gray(G);
% Group = imresize(Group,[256,256]);

% Display the Image
figure;
imshow(Group);
title('Group Photo');

% Read a Single Template image
Single = imread('face.jpg');

% Single = rgb2gray(Single);

% Display the Image
figure;
imshow(Single);
title('Single Face');


%% Maching

% Get the mean of the template image pixel values
N = mean(mean(mean(Single)));

% Get the size of the template image
[x,y,z] = size(Single);

% Convert the pixel values to double
Single = double(Single);

% Open a figure window to display the maching
figure;


% Start Comparing
for i = 1:size(Group,1)-x
    for j = 1:size(Group,2)-y
        
        % Convert the pixel values to double
        Temp = double(Group(i:i+x-1,j:j+y-1,:));
        
        % Get the mean of the part of the image pixel values
        M = mean(mean(mean(Temp)));
        
        % Get the difference between the mean values
        if N>M
            T = N-M;
        else
            T = M-N;
        end
        
        % If the mean difference is less than the limit then match found
        if T<0.006
            
            Group(i:i+x-1,j:j+y-1,:) = uint8(Temp.*Single);
            
            imshow(Group);
            title('Mached Image');
            drawnow;
            
        end
        
    end
end
