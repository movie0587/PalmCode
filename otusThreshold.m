function out = otusThreshold(source);

% source=imread('test.jpg');
thres=graythresh(source)
out=im2bw(source,thres-0.15);%Otus��ֵ���зָ�
% figure;imshow(out),title('Otus��ֵ���зָ�');