% --------------------------------------------------------
% Demo: Template Matching using Correlation Coefficients
% By Yue Wu (Rex)
% Department of Electrical and Computer Engineering
% Tufts University
% Medford, MA
% 08/30/2010
% --------------------------------------------------------

clear all
close all

%% Prepare the image for analysis
F = imread('prashant.jpg'); % read in coins image
T = imread('img3.jpg'); % read in template image
%% display frame and template
figure, subplot(121),imshow(F),title('Actual Image');
subplot(122),imshow(T),title('Template');
%% correlation matching
[corrScore, boundingBox] = corrMatching(F,T);
%% show results
figure,imagesc(abs(corrScore)),axis image, axis off, colorbar, 
title('Corr Measurement Space')

bY = [boundingBox(1),boundingBox(1)+boundingBox(3),boundingBox(1)+boundingBox(3),boundingBox(1),boundingBox(1)];
bX = [boundingBox(2),boundingBox(2),boundingBox(2)+boundingBox(4),boundingBox(2)+boundingBox(4),boundingBox(2)];
figure,imshow(F),line(bX,bY),title('Detected Area');