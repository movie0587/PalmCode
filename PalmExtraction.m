function out = PalmExtraction(source,thres_bw);

narginchk(1,2);
nargoutchk(0,1);
if nargin<2
    thres_bw=0.29;
end

%% 根据颜色提取手掌
r=source(:,:,1);
g=source(:,:,2);
b=source(:,:,3);
[row,~,~]=size(source);
flags=(r>b).*(g>b);
out=im2double(source);
flags=imclose(flags,strel('disk',10));
% flags(1:row/2,:)=imdilate(flags(1:row/2,:),strel('disk',50));
% flags=imclose(flags,strel('disk',10));
flags=maxLianTongYu(flags);
% flags2=imdilate(flags,strel('disk',30));
out(:,:,:)=out(:,:,:).*flags;
% figure,imshow(extraction);
%% 根据最大连通域进一步提取
bw=im2bw(out,thres_bw);
img=maxLianTongYu(bw);
img=im2double(img);
% img=imopen(img,strel('disk',10));
%     [row,col]=size(img);
img=imdilate(img,strel('square',40));
% img=imclose(img,strel('disk',25));
% img=imerode(img,strel('line',10,90));
% img=imclose(img,strel('disk',30));
% figure,imshow(img);
out=out(:,:,:).*img;
% figure,imshow(source),title('extraction_Palm');