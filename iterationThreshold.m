function out = iterationThreshold(source);

%����ͼ��,�����лҶ�ת��
% source=imread('test.jpg');
if ndims(source) == 3
    B = rgb2gray(source);
else
    B = source;
end
%��ʼ����ֵ
T=0.5*(double(min(B(:)))+double(max(B(:))));
d=false;
%ͨ�������������ֵ
while~d
    g=B>=T;
    Tn=0.5*(mean(B(g))+mean(B(~g)));
    d=abs(T-Tn)<0.5;
    T=Tn;
end
% ���������ֵ����ͼ��ָ�
level=Tn/255;
out=im2bw(B,level);
% ��ʾ�ָ���
% subplot(121),imshow(A)
% subplot(122),imshow(BW)
% figure,imshow(out);