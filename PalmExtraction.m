function out = PalmExtraction(source,thres_bw);

narginchk(1,2);
nargoutchk(0,1);
if nargin<2
    thres_bw=0.31;
end

%% 根据颜色提取手掌
r=source(:,:,1);
g=source(:,:,2);
b=source(:,:,3);
flags=(r>b).*(g>b);
out=im2double(source);
flags=imclose(flags,strel('disk',10));
% flags=imdilate(flags,strel('disk',50));
% flags=imclose(flags,strel('disk',10));
flags=bw_filter(flags,1);
% flags2=imdilate(flags,strel('disk',30));
% for i=[1:3]
%     out(:,:,i)=out(:,:,i).*flags;
% end
out=out.*flags;
% figure,imshow(out);

%% 二值图像去噪函数(提取最大连通域)
bw=imbinarize(rgb2gray(source),thres_bw);
bw_maxArea=bw_filter(bw,1);
bw_maxArea=imdilate(bw_maxArea,strel('square',30));
bw_maxArea=imclose(bw_maxArea,strel('disk',50));
out=out.*bw_maxArea;
% img=imopen(img,strel('disk',10));
%     [row,col]=size(img);
% img=imdilate(img,strel('square',20));
% img=imclose(img,strel('disk',25));
% img=imerode(img,strel('line',10,90));
% img=imclose(img,strel('disk',30));
% figure,imshow(img);
% out=out(:,:,:).*img;
%% otus阈值分割
% flags=otusThreshold(out);
% out=out.*flags;
