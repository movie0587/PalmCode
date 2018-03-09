function out = iterationThreshold(source);

%读入图像,并进行灰度转换
% source=imread('test.jpg');
if ndims(source) == 3
    B = rgb2gray(source);
else
    B = source;
end
%初始化阈值
T=0.5*(double(min(B(:)))+double(max(B(:))));
d=false;
%通过迭代求最佳阈值
while~d
    g=B>=T;
    Tn=0.5*(mean(B(g))+mean(B(~g)));
    d=abs(T-Tn)<0.5;
    T=Tn;
end
% 根据最佳阈值进行图像分割
level=Tn/255;
out=im2bw(B,level);
% 显示分割结果
% subplot(121),imshow(A)
% subplot(122),imshow(BW)
% figure,imshow(out);