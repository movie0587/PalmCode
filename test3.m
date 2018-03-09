% I1=imread('test.jpg');
% I2=imread('test2.jpg');
I=imread('test.jpg');

% figure,imshow(imadd(I1,I2));
% figure,imshow(imsubtract(I1,I2));
% figure,imshow(immultiply(I1,I2));
% figure,imshow(imdivide(I1,I2));

% figure,imshow(I2);
bw=im2bw(I,0.45);
figure,imshow(bw);
% h = fspecial('gaussian',[5 5],2);
% harris(bw,0.06,0.01,h);

% Y=fftn(I);
% Y1=fft2(bw);
% figure,imshow(Y1);

% D=dct2(bw);
% figure,imshow(D);

% imhist(I);
% h=adapthisteq(I);
% figure,imshow(h);

% m=medfilt2(bw,[10,10]);
% figure,imshow(m);

% w=wiener2(bw,[5,5]);
% figure,imshow(w);