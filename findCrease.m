function out = findCrease(src,length,height,lenHeightRate);

% ∂®Œª’€∫€Œª÷√
narginchk(3,4);
nargoutchk(0,1);
if nargin<4
    lenHeightRate=0.6;
end
if ndims(src)==3
    bw=~imbinarize(src);
else
    bw=~src;
end
[row,col]=size(src);
row=uint8(row);
col=uint8(col);

out=zeros(1,2);
for i=[1:length:col-1]
    for j=[1:height:row-1]
        win=bw(i:i+height-1 ,j:j+length-1);
        sumRow=max(sum(win, 2));
        sumCol=max(sum(win, 1));
        rate=sumRow/sumCol;
        if rate>2
            figure,imshow(win);
            [i, j, sumRow, sumCol, rate]
            out=[out;j,row-i];
        end
    end
end
out