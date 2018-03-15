clc; clear all;

thres_resize=0.2;
length=uint16(thres_resize*360*0.6);
height=uint16(thres_resize*300);
thres_bw=0.31;
num=25;
identifyCreaseAngleThres=15;

I = imread('image\rtest_11.jpg');
I=imresize(I,thres_resize);
I=PalmExtraction(I,thres_bw);
if ndims(I)>2
    I=rgb2gray(I);
end
% figure,imshow(I);
% I=medfilt2(I);
[row,col]=size(I);
% [0 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360]
gaborArray = gabor([11 12 13],[0 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360],...
    'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);

gaborMag = imgaborfilt(I,gaborArray);
palm2=zeros(size(I));

for i=1:row
    for j=1:col
        palm2(i,j)=min(gaborMag(i,j,:));
    end
end
% figure,imshow(palm2);
% figure,imshow(imbinarize(palm2));
% figure,imshow(adjgamma(hist_con(palm2)));

% for p = 1:num
%     palm=gaborMag(:,:,p);
% %     palm=adjgamma(palm);%ͼ����ǿ
%     palm=imbinarize(palm,0.5);
%     figure,imshow(palm),title('zengqiang');
% %     figure,imshow((gaborMag(:,:,p)));
%     theta = gaborArray(p).Orientation;
%     lambda = gaborArray(p).Wavelength;
%     title(sprintf('Orientation=%d, Wavelength=%d',theta,lambda));
% end

palm=palm2;
% palm=gaborMag(:,:,1);
palm=imbinarize(palm);
palm=bwAreaFilter(palm,50);
% palm=imerode(palm,strel('line',2,0));
% figure,imshow(palm);
% palm=findCrease(palm,length,height,20,1.5);
% figure,imshow(palm);

crease=findCrease(palm,length,height,5,identifyCreaseAngleThres)
[row,col]=size(crease);
figure,imshow(palm);
hold on;
for i=2:row
    rect = rectangle('Position',[crease(i,1),crease(i,2),length,height]);
    set(rect,'edgecolor','r');
end
