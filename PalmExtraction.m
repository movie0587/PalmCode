function out = PalmExtraction(source,thres_bw);

narginchk(1,2);
nargoutchk(0,1);
if nargin<2
    thres_bw=0.29;
end

%% ������ɫ��ȡ����
r=source(:,:,1);
g=source(:,:,2);
b=source(:,:,3);
flags=(r>b).*(g>b);
out=im2double(source);
out(:,:,:)=out(:,:,:).*flags;
% figure,imshow(extraction);
%% ���������ͨ���һ����ȡ
bw=im2bw(out,thres_bw);
[L num]=bwlabel(bw,4);
img=maxLianTongYu(bw);
img=im2double(img);
% img=imerode(img,strel('disk',20));
% img=imdilate(img,strel('disk',10));
% img=imdilate(img,strel('disk',40));
img=imopen(img,strel('disk',10));
img=imdilate(img,strel('disk',40));
% img=imclose(img,strel('disk',25));
% img=imerode(img,strel('line',10,90));
% img=imclose(img,strel('disk',10));
out=out(:,:,:).*img;
% figure,imshow(source),title('extraction_Palm');