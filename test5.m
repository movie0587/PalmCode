clc; clear all;
%% ��������
thres_extraction_bw=0.31;
thres_resize=0.2;
imagePath='palmImage/ltest_71.jpg';

%% ������ȡ
src=imread(imagePath);
src=imresize(src,thres_resize);
% src_gray=rgb2gray(src);
% figure('name','ԭͼ'),imshow((src)),title('ԭͼ');

palm=PalmExtraction(src,thres_extraction_bw);
% figure;
% subplot(1,2,1),imshow(palm);
% palm=imbinarize(rgb2gray(palm),0.25);
% % subplot(1,2,1),imshow(palm);
% palm=palm.*bw_filter(palm,1);
% subplot(1,2,2),imshow(palm);
% figure('name','��ȡ��������'),imshow(palm),title('��ȡ��������');
% figure,imshow(palm.*otusThreshold(palm)),title('otus');
palm2 = imbinarize(rgb2gray(palm),0.34);
palml2 = bwAreaFilter(~palm2,30);
figure,imshow(palm2);
hold on;
%% �ҳ��ָ���
[one, two] = findSegmentLine(palm2);
plot(one.x, one.y, 'rO');
plot(two.x, two.y, 'r*');
%% Gabor�˲�
% palm_gray=rgb2gray(palm);
% figure,imshow(palm_gray),title('palmgray');

% palm_bw=im2bw(palm,0.45);
% figure,imshow(palm_bw),title('palmBW');

%%
% c=corner(rgb2gray(test),10);
% figure,imshow(test);
% hold on;
% plot(c(:,1),c(:,2),'r*');
