function [correct_image] = icp_CorrectImage(im, R, t)
correct_image = zeros(size(im));%zeros(128,128);
M = [];
% for j = 1:size(im,2)
%     for i = 1:size(im,1)
%         M = [M; i j];
%     end
% end
% save M M
% load M.mat
[i,j]=meshgrid(1:size(im,2),1:size(im,1));
M=[j(:) i(:)];
M = M';
M = R*M;
M = [M(1,:)+t(1); M(2,:)+t(2)];
M = (floor(M))';

for j = 1:size(im,2)
    for i = 1:size(im,1)
        newi = M(i+(j-1)*size(im,1), 1);
        newj = M(i+(j-1)*size(im,1), 2);
        if(newi>0 & newi<size(im,1)+1 & newj>0 & newj<size(im,2)+1)
            correct_image(newi,newj) = im(i,j);
        end
    end
end
temp = medfilt2(correct_image); 
Ind = find(correct_image == 0);
correct_image(Ind) = temp(Ind); 
% angle = atan( R(2,1)/R(1,1) ) * 180 / pi;
% correct_image=imrotate(im2, angle, 'crop');
% correct_image=uint8(correct_image);
% correct_image=correct_image';
% imwrite(correct_image,'D:\3DPalmDB\DB386\innerErrorSub2DCorrect\Sub2D_II_4_9.bmp');