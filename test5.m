clc; clear all;
%% 参数设置
thres_extraction_bw=0.31;
thres_resize=0.2;
imagePath='palmImage/ltest_21.jpg';

%% 手掌提取
src=imread(imagePath);
src=imresize(src,thres_resize);
% src_gray=rgb2gray(src);
% figure('name','原图'),imshow((src)),title('原图');

palm=PalmExtraction(src,thres_extraction_bw);
% figure;
% subplot(1,2,1),imshow(palm);
% palm=imbinarize(rgb2gray(palm),0.25);
% % subplot(1,2,1),imshow(palm);
% palm=palm.*bw_filter(palm,1);
% subplot(1,2,2),imshow(palm);
% figure('name','提取出的手掌'),imshow(palm),title('提取出的手掌');
% figure,imshow(palm.*otusThreshold(palm)),title('otus');
palm2 = imbinarize(rgb2gray(palm),0.34);
palml2 = bwAreaFilter(~palm2,30);
figure,imshow(palm2);
hold on;
%% 找出分割线
[midLeft, midRight] = findSegmentLine(palm2);
plot(midLeft.x, midLeft.y, 'rO');
plot(midRight.x, midRight.y, 'r*');
%% 底部的线
[bottomLeft, bottomRight] = findBottomLine(palm2,midLeft,midRight);
plot(bottomLeft.x, bottomLeft.y, 'rO');
plot(bottomRight.x, bottomRight.y, 'r*');
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
