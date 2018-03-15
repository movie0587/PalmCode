clc; clear all;

thres_resize=0.2;
length=uint16(thres_resize*360*0.6);
height=uint16(thres_resize*300);
thres_bw=0.31;

identifyCreaseAngleThres=15;

I = imread('image\rtest_11.jpg');
I=imresize(I,thres_resize);
I=PalmExtraction(I,thres_bw);
if ndims(I)>2
    I=rgb2gray(I);
end
% figure,imshow(I);
% I=medfilt2(I);

gaborArray = gabor([13],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',5.0);

gaborMag = imgaborfilt(I,gaborArray);

% for p = 1:1
%     palm=gaborMag(:,:,p);
% %     palm=adjgamma(palm);%Í¼ÏñÔöÇ¿
%     palm=imbinarize(palm);
%     figure,imshow(palm),title('zengqiang');
% %     figure,imshow((gaborMag(:,:,p)));
%     theta = gaborArray(p).Orientation;
%     lambda = gaborArray(p).Wavelength;
%     title(sprintf('Orientation=%d, Wavelength=%d',theta,lambda));
% end

palm=gaborMag(:,:,1);
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
