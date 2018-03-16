clc; clear all;
%²âÊÔËùÓÐÕÕÆ¬


files = dir('image\*.jpg');
LengthFiles = length(files);

thres_resize=0.2;
length=uint16(thres_resize*360*0.6);
height=uint16(thres_resize*300);
thres_bw=0.31;

identifyCreaseAngleThres=15;

for i = 1:LengthFiles
    img = imresize(imread(strcat('image/',files(i).name)),thres_resize);
    img=PalmExtraction(img,thres_bw);
    figure,imshow(img);
%     if ndims(img)>2
%         img=rgb2gray(img);
%     end
%     
%     %     gaborArray = gabor([13],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',5.0);
%     %     gaborMag = imgaborfilt(img,gaborArray);
%     
%     [row,col]=size(img);
%     %225 240 45 | 330 315 300 135 120 105 90 75
%     % [0 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360]
%     gaborArray = gabor([11],[45 90 130 170 225 240 315],...
%         'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);
%     
%     gaborMag = imgaborfilt(img,gaborArray);
%     palm2=zeros(size(img));
%     
%     for i=1:row
%         for j=1:col
%             palm2(i,j)=min(gaborMag(i,j,:));
%         end
%     end
%     % figure,imshow(palm2);
%     palm2=imbinarize(palm2,0.6);
%     % palm2=bwAreaFilter(~palm2,50);
%     figure,imshow(palm2);
end