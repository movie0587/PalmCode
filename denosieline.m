function [newdata]=denosieline(data,thresh)

dataindx=find(data);
if isempty(dataindx)
    newdata=data;
    return;
end
datanew=data(dataindx);
dis=datanew(2:end)-datanew(1:end-1);
indxdis=find(abs(dis)<thresh);
indxdis=dataindx(indxdis);
tempmask=zeros(1,length(data));
tempmask(indxdis)=1;
thresh1=min([40 round(length(datanew)/3)]);
baseindx=round(median(indxdis));
fc=max([min(indxdis) baseindx-thresh1+1]);
lc=min([max(indxdis) baseindx+thresh1-1]);
tempmask(fc:lc)=1;
tempmask=bwlabel(tempmask);
stats = regionprops(tempmask, 'Area');
[MAxv,idxt] =max([stats.Area]);
tempmask= ismember(tempmask,idxt);
fc= find(tempmask,1,'first');
lc= find(tempmask,1,'last');
tempmask1=zeros(1,length(tempmask));
fc=max([fc-3 3]);
lc=min([lc-3 length(tempmask)-3]);
tempmask1(1,fc:lc)=1;
newdata=data.*tempmask1;
clear tempmask MAxv idxt dis indxdis;