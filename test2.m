I=imreadbw('test.jpg');
figure,imshow(I);
title("原图");

h=fspecial('sobel')
I8=filter2(h,I);
figure,imshow(I8);
title('二维滤波');

% I9=medfilt2(I);
% figure,imshow(I9);
% title('中值滤波');

I2=edge(I20,'sobel');
figure,imshow(I2);
title('sobel');

I3=edge(I20,'prewitt');
figure,imshow(I3);
title('prewitt');

I4=edge(I20,'roberts');
figure,imshow(I4);
title('roberts');

I5=edge(I20,'log');
figure,imshow(I5);
title('log');

I6=edge(I20,'zerocross');
figure,imshow(I6);
title('zerocross');

I7=edge(I20,'canny');
figure,imshow(I7);
title('canny');
