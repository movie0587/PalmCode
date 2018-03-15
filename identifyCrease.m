function flag=identifyCrease(bw,lenRate,angleThres);

if nargin<2
    lenRate=10;
end
if nargin<3
    angleThres=15;
end
%Ê¶±ðÕÛºÛ
[L, num] = bwlabel(bw);
stats = regionprops(L, 'Area', 'MajorAxisLength', 'MinorAxisLength', 'Orientation');
Ap = cat(1, stats.Area);
Lp1 = cat(1, stats.MajorAxisLength);
Lp2 = cat(1, stats.MinorAxisLength);

angle = cat(1, stats.Orientation);
Lp = Lp1./Lp2;

index = find(Ap == max(Ap));
flag=0;
if Lp(index)>lenRate
    if angle(index)<angleThres & angle(index)>-angleThres
        flag=1;
    end
else
    flag=0;
end


