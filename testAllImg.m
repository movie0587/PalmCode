clc; clear all;
%测试所有照片
bw_thres=0.31;
files = dir('image\*.jpg');
LengthFiles = length(files);
for i = 1:LengthFiles
    img = imresize(imread(strcat('image/',files(i).name)),0.2);
    palm=PalmExtraction(img,bw_thres);
    figure,imshow(palm),title(files(i).name);
    %自己写图像处理函数 ImgProc(Img);
end