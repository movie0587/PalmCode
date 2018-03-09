clc; clear all; close all;
% I = checkerboard(50,3,3);
I=imreadbw('image/ltest_11.jpg');
% I=maxEntropy(I);
h = fspecial('gaussian',[5 1],1.5);
harris(I,0.05,0.01,h);
