clc; clear all;
%测试所有照片


files = dir('palmImage\*.jpg');
LengthFiles = length(files);

thres_resize=0.2;
length=uint16(thres_resize*300*0.9);
height=uint16(thres_resize*300);
thres_bw=0.31; 

identifyCreaseAngleThres=15;

%%
for fileIndex = 1:LengthFiles
    img = imresize(imread(strcat('palmImage/',files(fileIndex).name)),thres_resize);
    img=PalmExtraction(img,thres_bw);
    %     imwrite(img,strcat('GaborResult/',files(fileIndex).name));
    %     figure,imshow(img);
    if ndims(img)>2
        img=rgb2gray(img);
    end
    
    palm2 = imbinarize(img,0.25);
    palm_gray = img;
    %     palm2 = bwAreaFilter(palm2,30);
    %     figure,imshow(palm2),title(files(fileIndex).name);
    %     hold on;
    %% 进一步提取ROI
    %中间分割线
    [midLeft, midRight] = findSegmentLine(palm2);
    %     plot(midLeft.x, midLeft.y, 'rO');
    %     plot(midRight.x, midRight.y, 'r*');
    % 底线
    [bottomLeft, bottomRight] = findBottomLine(palm2,midLeft,midRight);
    %     plot(bottomLeft.x, bottomLeft.y, 'rO');
    %     plot(bottomRight.x, bottomRight.y, 'r*');
    % 顶部的线
    [topLeft, topRight] = findTopLine(palm2,midLeft,midRight);
    %     plot(topLeft.x, topLeft.y, 'rO');
    %     plot(topRight.x, topRight.y, 'r*');
    
    %     gaborArray = gabor([13],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',5.0);
    %     gaborMag = imgaborfilt(img,gaborArray);
    
    %%
    palm_gray_finger = palm_gray(topLeft.y:midLeft.y,midLeft.x:midRight.x);
    palm_gray_main = palm_gray(midLeft.y:bottomLeft.y,midLeft.x:midRight.x);
    
    %% 线检测算法
    %手指
%         bw = edge(palm_gray_finger,'Sobel',0.027,'both');
%         bw = edge(palm_gray_finger,'Prewitt',0.023,'both');
%         bw = edge(palm_gray_finger,'Roberts',0.023,'both');
%         bw = edge(palm_gray_finger,'log',0.0025);
%         bw = edge(palm_gray_finger,'zerocross',0.0022);
%         bw = edge(palm_gray_finger,'Canny',0.17);
    %     bw = edge(palm_gray_finger,'approxcanny',0.15);
    %
%     palm_finger_edge=palm_gray_finger&bw;
%     imwrite(palm_finger_edge,strcat('edgeTest/canny/finger_',files(fileIndex).name));
    
    %手掌
%     bw = edge(palm_gray_main,'Sobel',0.027,'both');
%         bw = edge(palm_gray_main,'Prewitt',0.023,'both');
%         bw = edge(palm_gray_main,'Roberts',0.023,'both');
%         bw = edge(palm_gray_main,'log',0.0025);
%         bw = edge(palm_gray_main,'zerocross',0.0022);
%         bw = edge(palm_gray_main,'Canny',0.17);
    %     bw = edge(palm_gray_main,'approxcanny',0.15);
%     palm_main_edge=palm_gray_main&bw;
%     imwrite(palm_main_edge,strcat('edgeTest/canny/main_',files(fileIndex).name));
    %% Gabor滤波
    %手指部分
%     figure,imshow(palm_gray_finger);
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
%     level = graythresh(palm_finger_gabor);
    palm_finger_gabor_bw = imbinarize(palm_finger_gabor,0.36);
    palm_finger_gabor_bw = bwAreaFilter(palm_finger_gabor_bw,15);
%     figure,imshow(palm_finger_gabor_bw),title(files(fileIndex).name);
    imwrite(~palm_finger_gabor_bw,strcat('finalResult/otus/palm_',files(fileIndex).name));
    
    %手掌部分
%     figure,imshow(palm_gray_main);
    [row1,col1] = size(palm_gray_main);
    palm_main_gabor = zeros(size(palm_gray_main));
    
    gaborArray = gabor([11],[0 45 60 90 135 330],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);
    gaborMag = imgaborfilt(palm_gray_main,gaborArray);
    
    for i=1:row1
        for j=1:col1
            palm_main_gabor(i,j)=min(gaborMag(i,j,:));
        end
    end
    % figure,imshow(palm_main_gabor);
    level = graythresh(palm_main_gabor);
    palm_main_gabor_bw = imbinarize(palm_main_gabor,level-0.03);
    palm_main_gabor_bw = bwAreaFilter(palm_main_gabor_bw,30);
%     figure,imshow(palm_main_gabor_bw),title(files(fileIndex).name);
	imwrite(~palm_main_gabor_bw,strcat('finalResult/otus/main_',files(fileIndex).name));
    %% 找出折痕
    %     crease=findCrease(palm2,length,height,5,identifyCreaseAngleThres)
    %     [row,col]=size(crease);
    %     figure,imshow(palm2),title(files(fileIndex).name);
    %     hold on;
    %     for i=2:row
    %         rect = rectangle('Position',[crease(i,1),crease(i,2),length,height]);
    %         set(rect,'edgecolor','r');
    %     end
end