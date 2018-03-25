clc; clear all;
%����������Ƭ


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
    %     palm2 = bwAreaFilter(palm2,30);
    %     figure,imshow(palm2),title(files(fileIndex).name);
    %     hold on;
    %% ��һ����ȡROI
    %�м�ָ���
    [midLeft, midRight] = findSegmentLine(palm2);
    %     plot(midLeft.x, midLeft.y, 'rO');
    %     plot(midRight.x, midRight.y, 'r*');
    % ����
    [bottomLeft, bottomRight] = findBottomLine(palm2,midLeft,midRight);
    %     plot(bottomLeft.x, bottomLeft.y, 'rO');
    %     plot(bottomRight.x, bottomRight.y, 'r*');
    % ��������
    [topLeft, topRight] = findTopLine(palm2,midLeft,midRight);
    %     plot(topLeft.x, topLeft.y, 'rO');
    %     plot(topRight.x, topRight.y, 'r*');
    
    %     gaborArray = gabor([13],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',5.0);
    %     gaborMag = imgaborfilt(img,gaborArray);
    
    %% �߼���㷨
    %     bw = edge(img,'Sobel','both');
    %     bw = edge(img,'Prewitt','both');
    %     bw = edge(img,'Roberts',0.022,'both');
    %     bw = edge(img,'log',0.0025);
    %     bw = edge(img,'zerocross',0.0022);
    %     bw = edge(img,'Canny',0.17);
    %     bw = edge(img,'approxcanny',0.15);
    %
    %     palm2=img&bw;
    %     imwrite(palm2,strcat('approxcanny/',files(fileIndex).name));
    %% Gabor�˲�
    %��ָ����
    palm_gray = img;
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
%     figure,imshow(palm_finger_gabor_bw),title(files(fileIndex).name);
    imwrite(palm_finger_gabor,strcat('finalResult/palm_',files(fileIndex).name));
    
    %���Ʋ���
    palm_gray_main = palm_gray(midLeft.y:bottomLeft.y,midLeft.x:midRight.x);
    % figure,imshow(palm_gray_main);
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
    palm_main_gabor_bw = imbinarize(palm_main_gabor,0.57);
    palm_main_gabor_bw = bwAreaFilter(palm_main_gabor_bw,30);
%     figure,imshow(palm_main_gabor_bw),title(files(fileIndex).name);
	imwrite(palm_main_gabor,strcat('finalResult/main_',files(fileIndex).name));
    %% �ҳ��ۺ�
    %     crease=findCrease(palm2,length,height,5,identifyCreaseAngleThres)
    %     [row,col]=size(crease);
    %     figure,imshow(palm2),title(files(fileIndex).name);
    %     hold on;
    %     for i=2:row
    %         rect = rectangle('Position',[crease(i,1),crease(i,2),length,height]);
    %         set(rect,'edgecolor','r');
    %     end
end