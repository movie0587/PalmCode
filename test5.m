clc; clear all;

bw_thres=0.29;

test=imread('image/rtest_121.jpg');
test=imresize(test,0.5);
test_gray=rgb2gray(test);
figure,subplot(1,2,1),imshow(test),title('src');

%% ÌáÈ¡ÊÖÕÆ
r=test(:,:,1);
g=test(:,:,2);
b=test(:,:,3);
flags=(r>b).*(g>b);
test=im2double(test);
ett(:,:,:)=test(:,:,:).*flags;
% figure,imshow(extraction);

bw=im2bw(ett,bw_thres);
% rode = imerode(bw,strel('square',55));%¸¯Ê´
% figure,imshow(rode),title('rode');
[L num]=bwlabel(bw);
% figure,imshow(L),title('L');

img=maxLianTongYu(bw);
subplot(1,2,2),imshow(img),title('extraction');

img=im2double(img);
test(:,:,:)=test(:,:,:).*img;
% edgeTest(test);


%%
% c=corner(rgb2gray(test),10);
% figure,imshow(test);
% hold on;
% plot(c(:,1),c(:,2),'r*');
