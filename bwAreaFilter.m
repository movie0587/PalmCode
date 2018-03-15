function out = bwAreaFilter(src,minArea);

if ndims(src)==3
    bw=~imbinarize(src);
else
    bw=~src;
end
%% Ãæ»ýÂË²¨
[L, num] = bwlabel(bw);
stats = regionprops(L, 'Area');
Ap = cat(1, stats.Area);
for i = 1 : num
    if Ap(i) < minArea
        bw(L == i) = 0;
    end
end
out = ~bw;