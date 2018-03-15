clc; clear all;

thres_resize=0.2;
length=uint16(thres_resize*360*0.6);
height=uint16(thres_resize*300);
thres_bw=0.31;

identifyCreaseAngleThres=15;

I = imread('image\rtest_11.jpg');
I=imresize(I,thres_resize);

palm=PalmExtraction(I,thres_bw);
if ndims(palm)>2
    palm=rgb2gray(palm);
end

[com,response]=FingerprintCompCode(palm);
figure,imshow(imbinarize(response,0.01));
