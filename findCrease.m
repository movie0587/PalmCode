function out = findCrease(src,length,height);

% ¶¨Î»ÕÛºÛÎ»ÖÃ
narginchk(3,4);
nargoutchk(0,1);

if ndims(src)==3
    bw=~imbinarize(src);
else
    bw=~src;
end
bw=medfilt2(bw);
[row,col]=size(src);
row=uint16(row);
col=uint16(col);

out=zeros(1,2);
for i=[1:height:(row-height)/2]
    for j=[1:length:col-length]
        win=bw(i:i+height-1 ,j:j+length-1);
        sumRow=max(sum(win, 2));
        sumCol=max(sum(win, 1));
        rate=sumRow/sumCol;
        if rate>1.2
%             figure,imshow(win);
            [i, j, sumRow, sumCol, rate]
            out=[out;j,i];
        end
    end
end
out