test=zeros(500,500);
gaborArray = gabor([11],[80 90 100],'SpatialFrequencyBandwidth',1.5,'SpatialAspectRatio',3.5);
gaborMag = imgaborfilt(test,gaborArray);
figure,imshow(test);