close all;
clear all;
clc;
I = imread('2.jpg');
cform = makecform('srgb2lab');
J = applycform(I,cform);
K=J(:,:,2);
%figure;imshow(K);
L=graythresh(J(:,:,2));
BW1=im2bw(J(:,:,2),L);
%figure;imshow(BW1);
M=graythresh(J(:,:,3));
%figure;imshow(J(:,:,3));
BW2=im2bw(J(:,:,3),M);
figure;imshow(BW2);


% binaryImage=BW2;

binaryImage = bwareaopen(BW2,800);  
figure,imshow(binaryImage);

% % % % % labeledImage = bwlabel(binaryImage);
blobMeasurements = regionprops(binaryImage, BW2, 'all');
% % % % % figure,imshow(labeledImage);
numberOfPeople = size(blobMeasurements, 1)
 imagesc(binaryImage); title('Outlines, from bwboundaries()'); 
 
 %--------------------------------------------
 hold on;
boundaries = bwboundaries(binaryImage);
for k = 1 : numberOfPeople
thisBoundary = boundaries{k};
plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth', 2);
end
% hold off;


imagesc(I);
hold on;
title('Original with bounding boxes');
%fprintf(1,'Blob # x1 x2 y1 y2\n');
for k = 1 : numberOfPeople % Loop through all blobs.
% Find the mean of each blob. (R2008a has a better way where you can pass the original image
% directly into regionprops. The way below works for all versionsincluding earlier versions.)
thisBlobsBox = blobMeasurements(k).BoundingBox; % Get list of pixels in current blob.
x1 = thisBlobsBox(1);
y1 = thisBlobsBox(2);
x2 = x1 + thisBlobsBox(3);
y2 = y1 + thisBlobsBox(4);

   % fprintf(1,'#%d %.1f %.1f %.1f %.1f\n', k, x1, x2, y1, y2);
x = [x1 x2 x2 x1 x1];
y = [y1 y1 y2 y2 y1];
% subplot(3,4,2);
plot(x, y, 'LineWidth', 2);
end
