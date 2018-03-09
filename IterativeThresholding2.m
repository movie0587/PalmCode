function [mask,binim, thres] = IterativeThresholding2(im, mask);

idx = find(mask>0);

if length(idx)<=0
    binim = zeros(size(im));
    thres = Inf;
    return;
end

imm = im(idx);

%intialization using the mean
thres0 = mean(imm);

% iteratively choosing the threshold
while 1
    b = imm > thres0;
    
    numobj = sum(b);
    numbkg = sum(~b);
    
    if numobj==0 | numbkg==0
        break;
    end
    
    objmean = sum(b .* imm) / numobj;
    bkgmean = sum(~b .* imm) / numbkg;
    
    thres1 = (objmean + bkgmean) / 2;
    
    %     if thres0 == thres1
    if abs(thres0-thres1) < 0.005
        break;
    else
        thres0 = thres1;
    end
end

% return the results
thres = thres0;
binim = im > thres*0.48;%0.855;% ???
Limg2 = bwlabel(logical(binim),8);
stats = regionprops(Limg2, 'Area');
[MAxv,idx] =max([stats.Area]);
mask= ismember(Limg2,idx);%???
% Area=[];
% for snum=1:length(stats)
%         Area(end+1)=stats(snum).Area;
% end
% [sortv,indxsort]=sort(Area,'descend');
% mask=zeros(size(binim));
% mask(Limg2==indxsort(1))=1;
mask = imfill(mask,'holes');
se = strel('disk',11);
mask =imopen(mask,se);
Limg2 = bwlabel(mask,8);
stats = regionprops(Limg2, 'Area');
[MAxv,idx] =max([stats.Area]);
mask= ismember(Limg2,idx);