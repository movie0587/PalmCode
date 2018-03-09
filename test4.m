I0=imread('test.jpg');
I = im2bw(I0,0.22);
se = strel('square',3);
Ie = imerode(I,se);
Iout = I - Ie;
figure;
subplot(1,2,1);
imshow(I);
subplot(1,2,2);
imshow(Iout);