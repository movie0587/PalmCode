I = imread('test.jpg');

I2 = rgb2gray(I);

% figure,imshow(I);
% title('原图');

figure,imshow(I2);
title('灰度图');

% %获取图像灰度分配信息
% figure,imhist(I2);
% title('灰度信息');
% 
% % 使用imopen函数和结构元素对图像进行形态学开操作
bk = imopen(I2,strel('disk',50));              %disk 表示圆盘型结构元素，square表示方型结构元素
% figure,imshow(bk);
% title('开操作');
% 
% bg = imclose(I2,strel('square',15));
% figure,imshow(bg);
% title('闭操作');
% 
% %从I2中减去背景图像
I3 = imsubtract(I2,bk);
figure,imshow(I3);
title('减去背景图像');
% 
% %调整图像对比度
% I4 = imadjust(I3,stretchlim(I3), [0,1]);
% figure,imshow(I4);
% title('调整图像对比度');
% 
% %图像二值化处理
% level = graythresh(I4);
% BW = im2bw(I,level);
% figure,imshow(BW);
% title('二值化图像');
% 
% % I = imread('test.jpg');
% % I2 = rgb2gray(I);
% se=strel('disk',5');
% 
% %膨胀
% fse=imdilate(I2,se);
% figure,imshow(fse)
% title('膨胀')
% 
% %腐蚀
% fes=imerode(I2,se);
% figure,imshow(fes)
% title('腐蚀')
% 
% %顶帽变换是指原始图像减去其开运算的图像
% f1=imtophat(I2,se);
% figure,imshow(f1);
% title('顶帽变换');
% 
% %底帽变换是原始图像减去其闭运算后的图像
% f2=imbothat(imcomplement(I2),se);               %imcomplement对图像进行求反运算
% figure,imshow(f2);
% title('底帽变换');