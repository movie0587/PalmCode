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
for i = 1:LengthFiles
    img = imresize(imread(strcat('palmImage/',files(i).name)),thres_resize);
    img=PalmExtraction(img,thres_bw);
    %     imwrite(img,strcat('GaborResult/',files(i).name));
    %     figure,imshow(img);
    if ndims(img)>2
        img=rgb2gray(img);
    end
    
    palm2 = imbinarize(img,0.34);
    palml2 = bwAreaFilter(~palm2,30);
    figure,imshow(palm2),title(files(i).name);
    hold on;
    %% 分割线
    [midLeft, midRight] = findSegmentLine(palm2);
    plot(midLeft.x, midLeft.y, 'rO');
    plot(midRight.x, midRight.y, 'r*');
    %% 底线
    [bottomLeft, bottomRight] = findBottomLine(palm2,midLeft,midRight);
    plot(bottomLeft.x, bottomLeft.y, 'rO');
    plot(bottomRight.x, bottomRight.y, 'r*');
    %     gaborArray = gabor([13],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',5.0);
    %     gaborMag = imgaborfilt(img,gaborArray);
    
    %% 线检测算法
    %     bw = edge(img,'Sobel','both');
    %     bw = edge(img,'Prewitt','both');
    %     bw = edge(img,'Roberts',0.022,'both');
    %     bw = edge(img,'log',0.0025);
    %     bw = edge(img,'zerocross',0.0022);
    %     bw = edge(img,'Canny',0.17);
    %     bw = edge(img,'approxcanny',0.15);
    %
    %     palm2=img&bw;
    %     imwrite(palm2,strcat('approxcanny/',files(i).name));
    %% Gabor
    %     [row,col]=size(img);
    %     gaborArray = gabor([11],[0 45 90],...
    %         'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);
    %
    %     gaborMag = imgaborfilt(img,gaborArray);
    %     palm2=zeros(size(img));
    %
    %     for indexRow=1:row
    %         for indexCol=1:col
    %             palm2(indexRow,indexCol)=min(gaborMag(indexRow,indexCol,:));
    %         end
    %     end
    %     % figure,imshow(palm2);
    %     palm2=imbinarize(palm2,0.31);
    % %     palm2=imerode(palm2,strel('line',3,90));
    %     palm2=bwAreaFilter(palm2,20);
    %     figure,imshow(palm2);
    %     imwrite(palm2,strcat('GaborResult/',files(i).name));
    %% 找出折痕
    %     crease=findCrease(palm2,length,height,5,identifyCreaseAngleThres)
    %     [row,col]=size(crease);
    %     figure,imshow(palm2),title(files(i).name);
    %     hold on;
    %     for i=2:row
    %         rect = rectangle('Position',[crease(i,1),crease(i,2),length,height]);
    %         set(rect,'edgecolor','r');
    %     end
end