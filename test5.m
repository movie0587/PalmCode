clc; clear all;
%% ��������
thres_extraction_bw=0.31;
thres_resize=0.2;
imagePath='palmImage/rtest_71.jpg';

%% ������ȡ
src=imread(imagePath);
src_resize=imresize(src,thres_resize);
% src_gray=rgb2gray(src);
% figure('name','ԭͼ'),imshow((src)),title('ԭͼ');

palm=PalmExtraction(src_resize,thres_extraction_bw);
% figure,imshow(palm);
% figure;
% subplot(1,2,1),imshow(palm);
% palm=imbinarize(rgb2gray(palm),0.25);
% % subplot(1,2,1),imshow(palm);
% palm=palm.*bw_filter(palm,1);
% subplot(1,2,2),imshow(palm); 
% figure('name','��ȡ��������'),imshow(palm),title('��ȡ��������');
% figure,imshow(palm.*otusThreshold(palm)),title('otus');
%% ��һ����ȡROI���ֳ���ָ��������������Ʋ���
palm_bw = imbinarize(rgb2gray(palm),0.25);
% palm2 = bwAreaFilter(palm_bw,20);
% figure,imshow(~palm_bw);
% hold on;

% �м�ָ���
[midLeft, midRight] = findSegmentLine(palm_bw);
% plot(midLeft.x, midLeft.y, 'rO');
% plot(midRight.x, midRight.y, 'r*');
% �ײ�����
[bottomLeft, bottomRight] = findBottomLine(palm_bw,midLeft,midRight);
% plot(bottomLeft.x, bottomLeft.y, 'rO');
% plot(bottomRight.x, bottomRight.y, 'r*');
% ��������
[topLeft, topRight] = findTopLine(palm_bw,midLeft,midRight);
% plot(topLeft.x, topLeft.y, 'rO');
% plot(topRight.x, topRight.y, 'r*');

% ������������
% line([midLeft.x midRight.x],[midLeft.y midRight.y],'Color','red','LineWidth',3.0);
% line([bottomLeft.x bottomRight.x],[bottomLeft.y bottomRight.y],'Color','red','LineWidth',3.0);
% line([topLeft.x topRight.x],[topLeft.y topRight.y],'Color','red','LineWidth',3.0);
% line([topLeft.x midLeft.x],[topLeft.y midLeft.y],'Color','red','LineWidth',3.0);
% line([topRight.x midRight.x],[topRight.y midRight.y],'Color','red','LineWidth',3.0);
% line([bottomLeft.x midLeft.x],[bottomLeft.y midLeft.y],'Color','red','LineWidth',3.0);
% line([bottomRight.x midRight.x],[bottomRight.y midRight.y],'Color','red','LineWidth',3.0);
%% Gabor�˲�
%��ָ����
palm_gray = rgb2gray(palm);
palm_gray_finger = palm_gray(topLeft.y:midLeft.y,midLeft.x:midRight.x);
% figure,imshow(palm_gray_finger);
[row,col] = size(palm_gray_finger);
palm_finger_gabor = zeros(size(palm_gray_finger));

gaborArray = gabor([11],[80 90 100],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);
gaborMag = imgaborfilt(palm_gray_finger,gaborArray);

for i=1:row
    for j=1:col
        palm_finger_gabor(i,j)=min(gaborMag(i,j,:));
    end
end
% figure,imshow(palm_finger_gabor);
palm_finger_gabor_bw = imbinarize(palm_finger_gabor,0.32);
palm_finger_gabor_bw = bwAreaFilter(palm_finger_gabor_bw,15);
figure,imshow(~palm_finger_gabor_bw);

%���Ʋ���
%ȡԭͼ
% src_gray = rgb2gray(src);
% rate = uint16(1/thres_resize);
% palm_gray_main = src_gray(midLeft.y*rate:bottomLeft.y*rate,midLeft.x*rate:midRight.x*rate);
% palm_gray_main = imresize(palm_gray_main,0.1);
% figure,imshow(palm_gray_main);

palm_gray_main = palm_gray(midLeft.y:bottomLeft.y,midLeft.x:midRight.x);
% figure,imshow(palm_gray_main);
[row1,col1] = size(palm_gray_main);
palm_main_gabor = zeros(size(palm_gray_main));

num=150;

gaborArray = gabor([11],[0 45 60 90 135 330],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);
gaborMag = imgaborfilt(palm_gray_main,gaborArray);

% for p = 1:num
%     palm=gaborMag(:,:,p);
% %     palm=adjgamma(palm);%ͼ����ǿ
% %     palm=imbinarize(palm,0.6);
%     figure,imshow(palm);
%     theta = gaborArray(p).Orientation;
%     lambda = gaborArray(p).Wavelength;
%     bandWidth = gaborArray(p).SpatialFrequencyBandwidth;
%     ratio = gaborArray(p).SpatialAspectRatio;
%     title(sprintf('Orientation=%d, Wavelength=%f, bandWidth=%f, ratio=%f',...
%         theta,lambda,bandWidth,ratio));
% end

for i=1:row1
    for j=1:col1
        palm_main_gabor(i,j)=min(gaborMag(i,j,:));
    end
end
% figure,imshow(palm_main_gabor);
level = graythresh(palm_main_gabor);
palm_main_gabor_bw = imbinarize(palm_main_gabor,level);
palm_main_gabor_bw = bwAreaFilter(palm_main_gabor_bw,10);
figure,imshow(~palm_main_gabor_bw);
%%
% c=corner(rgb2gray(test),10);
% figure,imshow(test);
% hold on;
% plot(c(:,1),c(:,2),'r*');
