clc; clear all;
%����������Ƭ


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
    if ndims(img)>2
        img=rgb2gray(img);
    end
    
    %     gaborArray = gabor([13],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',5.0);
    %     gaborMag = imgaborfilt(img,gaborArray);
    
    [row,col]=size(img);
    gaborArray = gabor([11 12 13],[0 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360],...
        'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);
    
    gaborMag = imgaborfilt(img,gaborArray);
    palm2=zeros(size(img));
    
    for i=1:row
        for j=1:col
            palm2(i,j)=min(gaborMag(i,j,:));
        end
    end
    palm=palm2;
%     palm=gaborMag(:,:,1);
    palm=imbinarize(palm);
    palm=bwAreaFilter(palm,50);
    
    crease=findCrease(palm,length,height,5,identifyCreaseAngleThres)
    [row,col]=size(crease);
    figure,imshow(palm);
    hold on;
    for i=2:row
        rect = rectangle('Position',[crease(i,1),crease(i,2),length,height]);
        set(rect,'edgecolor','r');
    end
end