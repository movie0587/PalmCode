clc; clear all;
%% ��������
thres_extraction_bw=0.29;
thres_resize=0.5;
imagePath='image/rtest_101.jpg';

%% 
src=imread(imagePath);
src=imresize(src,thres_resize);
% src_gray=rgb2gray(src);
figure('name','ԭͼ'),imshow(src),title('ԭͼ');

palm=PalmExtraction(src,thres_extraction_bw);
figure('name','��ȡ��������'),imshow(palm),title('��ȡ��������');

% palm_gray=rgb2gray(palm);
% figure,imshow(palm_gray),title('palmgray');

% palm_bw=im2bw(palm,0.45);
% figure,imshow(palm_bw),title('palmBW');

%%
% c=corner(rgb2gray(test),10);
% figure,imshow(test);
% hold on;
% plot(c(:,1),c(:,2),'r*');
