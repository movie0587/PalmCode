I = imread('D:\±ÏÉè\matlabCode\image\rtest_11.jpg');
I=imresize(I,0.2);
I=PalmExtraction(I);

if ndims(I)>2
    I=rgb2gray(I);
end
% figure,imshow(I);

gaborArray = gabor([10 11 12 13 14],[90],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',6.0);

gaborMag = imgaborfilt(I,gaborArray);

for p = 1:5
%     gaborMag(:,:,p)=imerode(gaborMag(:,:,p),strel('line',3,0));
    figure,imshow(imbinarize(gaborMag(:,:,p)));
    theta = gaborArray(p).Orientation;
    lambda = gaborArray(p).Wavelength;
    title(sprintf('Orientation=%d, Wavelength=%d',theta,lambda));
end