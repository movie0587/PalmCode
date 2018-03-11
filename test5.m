clc; clear all;
%% 参数设置
thres_extraction_bw=0.29;
thres_resize=0.2;
imagePath='image/rtest_121.jpg';

%% 手掌提取
src=imread(imagePath);
src=imresize(src,thres_resize);
% src_gray=rgb2gray(src);
% figure('name','原图'),imshow((src)),title('原图');

palm=PalmExtraction(src,thres_extraction_bw);
figure('name','提取出的手掌'),imshow(palm),title('提取出的手掌');

%% Gabor滤波
% palm_gray=rgb2gray(palm);
% figure,imshow(palm_gray),title('palmgray');

% palm_bw=im2bw(palm,0.45);
% figure,imshow(palm_bw),title('palmBW');

%%
% c=corner(rgb2gray(test),10);
% figure,imshow(test);
% hold on;
% plot(c(:,1),c(:,2),'r*');
