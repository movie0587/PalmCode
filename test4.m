clc; clear all;

thres_resize=0.2;
length=uint16(thres_resize*360*0.6);
height=uint16(thres_resize*300);
thres_bw=0.31;
num=25;
identifyCreaseAngleThres=15;

I = imread('image\rtest_41.jpg');
I=imresize(I,thres_resize);
I=PalmExtraction(I,thres_bw);
if ndims(I)>2
    I=rgb2gray(I);
end
% figure,imshow(I);
% I=medfilt2(I);
[row,col]=size(I);
%225 240 45 | 330 315 300 135 120 105 90 75
% [0 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360]
gaborArray = gabor([11],[45 90 130 170 225 240 315],...
    'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);

gaborMag = imgaborfilt(I,gaborArray);
palm2=zeros(size(I));

for i=1:row
    for j=1:col
        palm2(i,j)=min(gaborMag(i,j,:));
    end
end
% figure,imshow(palm2);
palm2=~imbinarize(palm2,0.6);
% palm2=bwAreaFilter(~palm2,50);
figure,imshow(palm2);
% palm2=bwAreaFilter(palm2,10);
% figure,imshow(palm2);
%     figure,imshow(bwAreaFilter(palm2,5)),title(sprintf('bwfilter,arg=%f',i/10));
% figure,imshow(adjgamma(hist_con(palm2)));

% for p = 1:num
%     palm=gaborMag(:,:,p);
% %     palm=adjgamma(palm);%Í¼ÏñÔöÇ¿
%     palm=imbinarize(palm,0.6);
%     figure,imshow(palm);
% %     figure,imshow((gaborMag(:,:,p)));
%     theta = gaborArray(p).Orientation;
%     lambda = gaborArray(p).Wavelength;
%     title(sprintf('Orientation=%d, Wavelength=%d',theta,lambda));
% end

palm=palm2;
% % palm=gaborMag(:,:,1);
% palm=imbinarize(palm);
palm=bwAreaFilter(palm,10);
palm=medfilt2(palm);
% % palm=imerode(palm,strel('line',2,0));
% % figure,imshow(palm);
% % palm=findCrease(palm,length,height,20,1.5);
% % figure,imshow(palm);
%
% crease=findCrease(palm,length,height,5,identifyCreaseAngleThres)
% [row,col]=size(crease);
% figure,imshow(palm);
% hold on;
% for i=2:row
%     rect = rectangle('Position',[crease(i,1),crease(i,2),length,height]);
%     set(rect,'edgecolor','r');
% end
