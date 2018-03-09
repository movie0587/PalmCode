I = imread('image/rtest_81.jpg'); % ����ͼ��
figure; 
subplot(1, 3, 1); imshow(I); title('ԭͼ��', 'FontWeight', 'Bold');
I1 = rgb2hsv(I); % RGBת����HSV�ռ�
h = I1(:, :, 2); % S��
bw = im2bw(h, graythresh(h)); % ��ֵ��
bw = ~bw; % ȡ��
bw1 = imfill(bw, 'holes'); % ����
bw1 = imopen(bw1, strel('disk', 5)); % ͼ�񿪲���
bw1 = bwareaopen(bw1, 2000); % ����˲�
subplot(1, 3, 2); imshow(bw1); title('��ֵͼ��', 'FontWeight', 'Bold');
bw2 = cat(3, bw1, bw1, bw1); % ����ģ��
I2 = I .* uint8(bw2); % ���
subplot(1, 3, 3); imshow(I2); title('�ָ�ͼ��', 'FontWeight', 'Bold');