function outImage = removebackground(sourceImage);

T2=graythresh(sourceImage)
outImage=im2bw(sourceImage,T2-0.05);%Otus��ֵ���зָ�
figure;imshow(outImage),title('Otus��ֵ���зָ�');