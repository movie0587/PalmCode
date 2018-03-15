function out = findCrease(src,length,height, rate,angleThres);

% ∂®Œª’€∫€Œª÷√
if nargin < 4
    rate = 5;
end
%%
if ndims(src)==3
    bw=~imbinarize(src);
else
    bw=~src;
end
% bw=medfilt2(bw);
[row,col]=size(bw);
row=uint16(row);
col=uint16(col);

%%
out=zeros(1,2);
for i=[1:height:(row-height)/2]
    for j=[1:length:col-length]
        win=bw(i:i+height-1 ,j:j+length-1);
        flag=identifyCrease(win,rate,angleThres);
        if flag == 1
            out=[out; j,i];
        end
    end
end