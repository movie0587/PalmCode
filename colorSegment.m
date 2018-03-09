I = imread('image/rtest_81.jpg'); % 载入图像
figure; 
subplot(1, 3, 1); imshow(I); title('原图像', 'FontWeight', 'Bold');
I1 = rgb2hsv(I); % RGB转换到HSV空间
h = I1(:, :, 2); % S层
bw = im2bw(h, graythresh(h)); % 二值化
bw = ~bw; % 取反
bw1 = imfill(bw, 'holes'); % 补洞
bw1 = imopen(bw1, strel('disk', 5)); % 图像开操作
bw1 = bwareaopen(bw1, 2000); % 面积滤波
subplot(1, 3, 2); imshow(bw1); title('二值图像', 'FontWeight', 'Bold');
bw2 = cat(3, bw1, bw1, bw1); % 构造模板
I2 = I .* uint8(bw2); % 点乘
subplot(1, 3, 3); imshow(I2); title('分割图像', 'FontWeight', 'Bold');