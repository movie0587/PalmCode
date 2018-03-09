function outImage = removebackground(sourceImage);

T2=graythresh(sourceImage)
outImage=im2bw(sourceImage,T2-0.05);%Otus阈值进行分割
figure;imshow(outImage),title('Otus阈值进行分割');