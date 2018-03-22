function flag=identifyCrease(bw,lenRate,angleThres);

if nargin<2
    lenRate=20;
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

% Ap=sort(Ap,'descend');
% index = find(Ap == max(Ap));
flag=0;
for index=1:length(Ap)
    if Lp(index)>lenRate & angle(index)<angleThres & angle(index)>-angleThres
        flag=1;
        break;
    end
end

