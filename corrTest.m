clc; clear all;
sub=imread('image/sub_shi4.png');
test=imread('image/rtest_81.jpg');
sub=imresize(sub,0.1);
test=imresize(test,0.1);

sub_bw=im2bw(sub);
sub_gray=rgb2gray(sub);
test_bw=im2bw(test);
test_gray=rgb2gray(test);

[srcRow, srcCol] = size(test_bw);
[subRow, subCol] = size(sub_bw);
max.corr = -1;

for i = 1:srcRow/2-subRow
    for j = 1:srcCol-subCol
        tmp = test_gray(i:i+subRow-1,j:j+subCol-1);
        corTmp = corr2(sub_gray,tmp);
        if corTmp > max.corr
            max.corr = corTmp;
            max.row = i;
            max.col = j;
        end
    end
end

figure,imshow(test);
hold on;
rect = rectangle('Position',[max.row,max.col,subCol,subRow]);  
set(rect,'edgecolor','r'); 