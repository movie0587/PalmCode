I = imread('test.jpg');

I2 = rgb2gray(I);

% figure,imshow(I);
% title('ԭͼ');

figure,imshow(I2);
title('�Ҷ�ͼ');

% %��ȡͼ��Ҷȷ�����Ϣ
% figure,imhist(I2);
% title('�Ҷ���Ϣ');
% 
% % ʹ��imopen�����ͽṹԪ�ض�ͼ�������̬ѧ������
bk = imopen(I2,strel('disk',50));              %disk ��ʾԲ���ͽṹԪ�أ�square��ʾ���ͽṹԪ��
% figure,imshow(bk);
% title('������');
% 
% bg = imclose(I2,strel('square',15));
% figure,imshow(bg);
% title('�ղ���');
% 
% %��I2�м�ȥ����ͼ��
I3 = imsubtract(I2,bk);
figure,imshow(I3);
title('��ȥ����ͼ��');
% 
% %����ͼ��Աȶ�
% I4 = imadjust(I3,stretchlim(I3), [0,1]);
% figure,imshow(I4);
% title('����ͼ��Աȶ�');
% 
% %ͼ���ֵ������
% level = graythresh(I4);
% BW = im2bw(I,level);
% figure,imshow(BW);
% title('��ֵ��ͼ��');
% 
% % I = imread('test.jpg');
% % I2 = rgb2gray(I);
% se=strel('disk',5');
% 
% %����
% fse=imdilate(I2,se);
% figure,imshow(fse)
% title('����')
% 
% %��ʴ
% fes=imerode(I2,se);
% figure,imshow(fes)
% title('��ʴ')
% 
% %��ñ�任��ָԭʼͼ���ȥ�俪�����ͼ��
% f1=imtophat(I2,se);
% figure,imshow(f1);
% title('��ñ�任');
% 
% %��ñ�任��ԭʼͼ���ȥ���������ͼ��
% f2=imbothat(imcomplement(I2),se);               %imcomplement��ͼ�����������
% figure,imshow(f2);
% title('��ñ�任');