function out = otusThreshold(source);

% source=imread('test.jpg');
thres=graythresh(source)
out=im2bw(source,thres-0.15);%Otus阈值进行分割
% figure;imshow(out),title('Otus阈值进行分割');