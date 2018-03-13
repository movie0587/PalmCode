clc; clear all;

thres_resize=0.2;
length=uint16(thres_resize*360*0.6);
height=uint16(thres_resize*300*1.1);
thres_bw=0.3;

I = imread('image\rtest_31.jpg');
I=imresize(I,thres_resize);
I=PalmExtraction(I);
figure,imshow(I);
if ndims(I)>2
    I=rgb2gray(I);
end
figure,imshow(I);
% I=medfilt2(I);

gaborArray = gabor([13],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',5.0);

gaborMag = imgaborfilt(I,gaborArray);

for p = 1:1
    palm=gaborMag(:,:,p);
%     palm=adjgamma(palm);%ͼ����ǿ
    palm=imbinarize(palm);
    figure,imshow(palm),title('zengqiang');
%     figure,imshow((gaborMag(:,:,p)));
    theta = gaborArray(p).Orientation;
    lambda = gaborArray(p).Wavelength;
    title(sprintf('Orientation=%d, Wavelength=%d',theta,lambda));
end



% crease=findCrease(imbinarize(gaborMag(:,:,1),thres_bw),length,height);
% [row,col]=size(crease);
% figure,imshow(imbinarize(gaborMag(:,:,1),thres_bw));
% hold on;
% for i=2:row
%     rect = rectangle('Position',[crease(i,1),crease(i,2),length,height]);
%     set(rect,'edgecolor','r');
% end
