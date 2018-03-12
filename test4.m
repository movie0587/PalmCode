clc; clear all;

zoomRate=0.2;
length=uint8(zoomRate*360);
height=uint8(zoomRate*300);
thres_bw=0.2;

I = imread('D:\����\matlabCode\image\rtest_11.jpg');
I=imresize(I,zoomRate);
I=PalmExtraction(I);

if ndims(I)>2
    I=rgb2gray(I);
end
% figure,imshow(I);
% I=medfilt2(I);

gaborArray = gabor([13],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',7.0);

gaborMag = imgaborfilt(I,gaborArray);

% for p = 1:1
% %     gaborMag(:,:,p)=imdilate(gaborMag(:,:,p),strel('square',3));
%     figure,imshow(imbinarize(gaborMag(:,:,p),thres_bw));
%     theta = gaborArray(p).Orientation;
%     lambda = gaborArray(p).Wavelength;
%     title(sprintf('Orientation=%d, Wavelength=%d',theta,lambda));
% end

figure,imshow(imbinarize(gaborMag(:,:,1),thres_bw));
hold on;

crease=findCrease(imbinarize(gaborMag(:,:,1),thres_bw),length,height);
[row,col]=size(crease);
for i=1:row
    rect = rectangle('Position',[crease(i,1),crease(i,2),length,height]);
    set(rect,'edgecolor','r');
end
    
    
    