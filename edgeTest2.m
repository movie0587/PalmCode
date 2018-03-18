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

bw1 = edge(palm,'Sobel','both');
bw2 = edge(palm,'Prewitt','both');
bw3 = edge(palm,'Roberts',0.022,'both');
bw4 = edge(palm,'log',0.0025);
bw5 = edge(palm,'zerocross',0.0022);
bw6 = edge(palm,'Canny',0.17);
bw7 = edge(palm,'approxcanny',0.15);

figure,imshow(palm&bw1);
figure,imshow(palm&bw2);
figure,imshow(palm&bw3);
figure,imshow(palm&bw4);
figure,imshow(palm&bw5);
figure,imshow(palm&bw6);
figure,imshow(palm&bw7);

% edgeTest(palm);
