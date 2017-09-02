clear;
close all;
clc;
%specify input image here
img = imread('./sample1/cw.jpg');
tic;
[Ic, T] = carv(img, 50, 50); %takes about 100 seconds
disp(toc);%displays estimated time taken
figure;
imshow(Ic);
axis image;