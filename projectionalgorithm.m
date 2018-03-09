function [baselinep,CompCodef,Itemp,maskf,L,Lpara,Resf]=projectionalgorithm(newim,newmask,Segmask,meanfingerlength,download)

[indxr,indxc]=find(newmask);
if download 
     border=10;
     thresh=meanfingerlength/2;
     thresh1=90;
else
    border=50;
    thresh=meanfingerlength;
    thresh1=180;
end
begint=min(indxr)+border;
endt=max(indxr)-border;
clear indxc indxr
projim=zeros(1,endt-begint+1);projsegmask=zeros(1,endt-begint+1);
k=0;
windsze=35;
imf=newim;
[CompCode,newim]=FingerprintCompCode(newim,download);
imt=zeros(size(CompCode));
imt(CompCode<3)=1;
imt=imt.*newmask;
for i=begint:endt
    tempindex=find(newmask(i,:));
    k=k+1;
    projimt(k)=sum(imt(i,tempindex),2)./length(tempindex);
%     projimt(k)=projimt(k)+sum(newim(i,tempindex),2)./length(tempindex);
    projim(k)=sum(newim(i,tempindex).*Segmask(i,tempindex),2);
end
Nlength=3;
gaussf=gaussmf([-Nlength:0.1:Nlength],[0.5 0]);
projimtemp=[projim(end:-1:1) projim projim(end:-1:1)];
projimtemp=conv(projimtemp,gaussf,'same');
projim=projimtemp(length(projim)+1:2*length(projim));
projim=(projim-min(projim))/(max(projim)-min(projim));
clear projimtemp;
projimtemp=[projimt(end:-1:1) projimt projimt(end:-1:1)];
projimtemp=conv(projimtemp,gaussf,'same');
projimt=projimtemp(length(projim)+1:2*length(projim));
projimt=(projimt-min(projimt))/(max(projimt)-min(projimt));
projimt=1-projimt;
projim=(projim+projimt)/2;
projim=1-projim;
dilation = ordfilt2(projim, windsze, ones(1,windsze));
minpts= (dilation ==projim) & (projim>mean(projim)+0.2);
minind = find(minpts);
baselinepos=minind+begint;
projimtt=1-projimt;
dilation = ordfilt2(projimtt, windsze, ones(1,windsze));
minpts= (dilation ==projimtt)&(projimtt>mean(projimtt));
maxind = find(minpts);
maxind=maxind+begint;

bi=max([begint min(maxind)]);
ei=min([endt max(maxind)]);
baselineindex=find(baselinepos>=bi&baselinepos<=ei);
baselinepos=baselinepos(baselineindex);


if length(baselinepos)>=3
baselineindex=find(projim(baselinepos-begint)<=mean(projim)-0.2);
baselinepos=baselinepos(baselineindex);
end

if isempty(baselinepos)
   [MAXV,indxbaseline]=max(projim);
   baselinep=begint+indxbaseline;
elseif length(baselinepos)==1
    baselinep=baselinepos;
else
    indxbaselinet=baselinepos-begint;
    dis=abs(baselinepos-begint-thresh);
    sidx=find(dis<thresh1);
    if isempty(sidx)
        [MINV,indxbaseline]=min(projim(indxbaselinet));
        baselinep=baselinepos(indxbaseline);
    else
       projminv=projim(indxbaselinet(sidx));
       sidxp=dis(sidx)/sum(dis(sidx));
       projminv=0.6*projminv+0.4*sidxp;
       [MINV,indxbaseline]=min(projminv);
       baselinep=baselinepos(sidx(indxbaseline));
    end
end

% [ordv,ordindx]=sort(projim(indxbaselinet),'descend');
% selidx=min([3 length(ordindx)]);
% dis=abs(baselinepos(ordindx(selidx)-thresh);
% [MINV,indxbaseline]=min(dis);
% baselinep=baselinepos(sidx(indxbaseline));
if download
    thresh=50;
else
    thresh=100;
end
if download
    threshwhole=50;
    threshpad=5;
else
    threshwhole=80;
    threshpad=10;
end
[indxr,indxc]=find(newmask);
sizef=max([baselinep-threshwhole min(indxr)]);
sizel=min([baselinep+threshwhole max(indxr)]);
clear indxr indxc;
Itemp=imf(sizef:sizel,:);
Resf=newim(sizef:sizel,:);
CompCodef=CompCode(sizef:sizel,:);
maskf=logical(Itemp);
maskf(:,1:threshpad)=0;
maskf(:,end-threshpad+1:end)=0;
se = strel('disk',5);
maskf =imerode(maskf,se);
CompCodef=CompCodef.*maskf;
Itemp=Itemp.*maskf;
Resf=Resf.*maskf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[indxr,indxc]=find(newmask);
begint=min(indxr);
endt=max(indxr);
L=[];
   for t=begint:endt
        indx1=find(newmask(t,:));
        if isempty(indx1)
            continue;
        end
        L(1,end+1)=length(indx1);
        L(2,end)=t;
        clear indx1;
   end
L(1,:)=denosieline(L(1,:),6);
indxl=find(L(1,:));
L=L(:,indxl);
meanL=mean(L(1,:));
[Ul,Ulindx]=unique(L(1,:));num=[];
for i=1:length(Ul)
    indx=find(L(1,:)==Ul(i));
    num(end+1)=length(indx);
end
[Maxnum,indx]=max(num);
MaxL=Ul(indx);
MedL=median(L(1,:));
MaxH=baselinep-L(2,Ulindx(1));
[minv,indext]=min(abs(L(1,:)-median(L(1,:))));
MedH=mean(baselinep-L(1,indext));
Lpara=[meanL;MaxL;MedL;MaxH;MedH];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function [baselinep,CompCodef,Itemp,maskf,L,Lpara]=projectionalgorithm(newim,newmask,Segmask,meanfingerlength,download)
% 
% [indxr,indxc]=find(newmask);
% if download 
%      border=10;
%      thresh=meanfingerlength/2;
%      thresh1=100;
% else
%     border=50;
%     thresh=meanfingerlength;
%     thresh1=200;
% end
% begint=min(indxr)+border;
% endt=max(indxr)-border;
% clear indxc indxr
% projim=zeros(1,endt-begint+1);projsegmask=zeros(1,endt-begint+1);
% k=0;
% windsze=35;
% imf=newim;
% [CompCode,newim]=FingerprintCompCode(newim,download);
% for i=begint:endt
%     tempindex=find(newmask(i,:));
%     k=k+1;
%     projimt(k)=sum(newim(i,tempindex),2)./length(tempindex);
%     projim(k)=sum(newim(i,tempindex).*Segmask(i,tempindex),2);
% end
% Nlength=3;
% gaussf=gaussmf([-Nlength:0.1:Nlength],[0.5 0]);
% projimtemp=[projim(end:-1:1) projim projim(end:-1:1)];
% projimtemp=conv(projimtemp,gaussf,'same');
% projim=projimtemp(length(projim)+1:2*length(projim));
% projim=(projim-min(projim))/(max(projim)-min(projim));
% clear projimtemp;
% projimtemp=[projimt(end:-1:1) projimt projimt(end:-1:1)];
% projimtemp=conv(projimtemp,gaussf,'same');
% projimt=projimtemp(length(projim)+1:2*length(projim));
% projimt=(projimt-min(projimt))/(max(projimt)-min(projimt));
% projim=(projim+projimt)/2;
% projimt=1-projim;
% dilation = ordfilt2(projimt, windsze, ones(1,windsze));
% minpts= (dilation ==projimt) & (projimt>mean(projimt));
% minind = find(minpts);
% baselinepos=minind+begint;
% dilation = ordfilt2(projim, windsze, ones(1,windsze));
% minpts= (dilation ==projim)&(projim>mean(projim));
% maxind = find(minpts);
% maxind=maxind+begint;
% 
% bi=max([begint min(maxind)]);
% ei=min([endt max(maxind)]);
% baselineindex=find(baselinepos>=bi&baselinepos<=ei);
% baselinepos=baselinepos(baselineindex);
% if length(baselinepos)>=3
% baselineindex=find(projim(baselinepos-begint)<=mean(projim)-0.2);
% baselinepos=baselinepos(baselineindex);
% end
% 
% if length(baselinepos)==1
%     baselinep=baselinepos;
% else
%     indxbaselinet=baselinepos-begint;
%     dis=abs(baselinepos-thresh);
%     sidx=find(dis<thresh1);
%     if isempty(sidx)
%         [MINV,indxbaseline]=min(projim(indxbaselinet));
%         baselinep=baselinepos(indxbaseline);
%     else
%        projminv=projim(indxbaselinet(sidx));
%        [MINV,indxbaseline]=min(projminv);
%        baselinep=baselinepos(sidx(indxbaseline));
%     end
% end
% % [ordv,ordindx]=sort(projim(indxbaselinet),'descend');
% % selidx=min([3 length(ordindx)]);
% % dis=abs(baselinepos(ordindx(selidx)-thresh);
% % [MINV,indxbaseline]=min(dis);
% % baselinep=baselinepos(sidx(indxbaseline));
% if download
%     thresh=50;
% else
%     thresh=100;
% end
% if download
%     threshwhole=50;
%     threshpad=8;
% else
%     threshwhole=80;
%     threshpad=16;
% end
% [indxr,indxc]=find(newmask);
% sizef=max([baselinep-threshwhole min(indxr)]);
% sizel=min([baselinep+threshwhole max(indxr)]);
% clear indxr indxc;
% Itemp=imf(sizef:sizel,:);
% CompCodef=CompCode(sizef:sizel,:);
% maskf=logical(Itemp);
% maskf(:,1:threshpad)=0;
% maskf(:,end-threshpad+1:end)=0;
% se = strel('disk',7);
% maskf =imerode(maskf,se);
% CompCodef=CompCodef.*maskf;
% Itemp=Itemp.*maskf;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [indxr,indxc]=find(newmask);
% begint=min(indxr);
% endt=max(indxr);
% L=[];
%    for t=begint:endt
%         indx1=find(newmask(t,:));
%         if isempty(indx1)
%             continue;
%         end
%         L(1,end+1)=length(indx1);
%         L(2,end)=t;
%         clear indx1;
%    end
% L(1,:)=denosieline(L(1,:),6);
% indxl=find(L(1,:));
% L=L(:,indxl);
% meanL=mean(L(1,:));
% [Ul,Ulindx]=unique(L(1,:));num=[];
% for i=1:length(Ul)
%     indx=find(L(1,:)==Ul(i));
%     num(end+1)=length(indx);
% end
% [Maxnum,indx]=max(num);
% MaxL=Ul(indx);
% MedL=median(L(1,:));
% MaxH=baselinep-L(2,Ulindx(1));
% [minv,indext]=min(abs(L(1,:)-median(L(1,:))));
% MedH=mean(baselinep-L(1,indext));
% Lpara=[meanL;MaxL;MedL;MaxH;MedH];
% 
% 
% % function [baselinep,mask,im]=projectionalgorithm(newim,newmask,meanfingerlength,download)
% % [indxr,indxc]=find(newmask);
% % if download 
% %     border=60;
% %     windsze=35;
% %     thresh=meanfingerlength/2;
% %     thresh1=70;
% %     thresh2=80;
% % else
% %     border=100;
% %     windsze=45;
% %     thresh=meanfingerlength;
% %     thresh1=140;
% %     thresh2=40;
% % end
% % begint=min(indxr)+border.*2;
% % endt=max(indxr)-border;
% % clear indxc indxr
% % projim=zeros(1,endt-begint+1);
% % k=0;
% % for i=begint:endt
% %     tempindex=find(newmask(i,:));
% %     k=k+1;
% %     projim(k)=sum(newim(i,tempindex),2)./length(tempindex);
% % end
% % Nlength=3;
% % gaussf=gaussmf([-Nlength:0.1:Nlength],[0.45 0]);
% % projimtemp=[projim(end:-1:1) projim projim(end:-1:1)];
% % projimtemp=conv(projimtemp,gaussf,'same');
% % projim=projimtemp(length(projim)+1:2*length(projim));
% % projimt=max(projim)-projim;
% % 
% % dilation = ordfilt2(projimt, windsze, ones(1,windsze));
% % minpts= (dilation ==projimt) ;%& (projimt>mean(projimt));
% % minind = find(minpts);
% % baselinepos=minind+begint;
% % dilation = ordfilt2(projim, windsze, ones(1,windsze));
% % minpts= (dilation ==projim); %& (projim>mean(projim));
% % maxind = find(minpts);
% % maxind=maxind+begint;
% % if isempty(maxind)|isempty(baselinepos)
% %     mask=newmask;
% %     im=newim;
% %     baselinep=endt-begint-thresh;
% %     return;
% % end
% % 
% % lengthL=endt-begint+3.*border;
% %   
% % bi=min([begint median(maxind)]);
% % if download 
% %    ei=max([endt-lengthL+400 max(maxind) max(baselinepos)]);
% % else
% %     ei=max([endt-lengthL+200 max(maxind) max(baselinepos)]);
% % end
% % 
% % baselineindex=find(baselinepos>=bi&baselinepos<=ei);
% % if isempty(baselineindex)
% %     mask=newmask';
% %     im=newim';
% %     baselinep=endt-thresh+border;
% %     return;
% % end
% % dis=abs(baselinepos(baselineindex)-begint+2*border-meanfingerlength);
% % if isempty(dis)||isempty(find(dis<thresh2))
% %     mask=newmask';
% %     im=newim';
% %     baselinep=endt-thresh+border;
% %     return;
% % end
% % indxf=find(dis<thresh2);
% % if length(indxf)>=3
% %     indxf=find(dis<thresh2-15);
% % end
% % baselinep=round(median(baselinepos(indxf)));
% % 
% % mask=zeros(size(newim'));
% % fi=max([begint baselinep-thresh1]);
% % li=min([endt baselinep+thresh1]);
% % mask(:,fi:li)=1;
% % im=zeros(size(newim'));
% % im(:,fi:li)=newim(fi:li,:)';
% 
% 
% % function [baselinep,mask,im]=projectionalgorithm(newim,I,newmask,meanfingerlength,download)
% % [indxr,indxc]=find(newmask);
% % if download 
% %     border=60;
% %     windsze=35;
% %     thresh=meanfingerlength/2;
% %     thresh1=70;
% % else
% %     border=100;
% %     windsze=45;
% %     thresh=meanfingerlength;
% %     thresh1=140;
% % end
% % begint=min(indxr)+border.*2;
% % endt=max(indxr)-border;
% % clear indxc indxr
% % projim=zeros(1,endt-begint+1);
% % k=0;
% % for i=begint:endt
% %     tempindex=find(newmask(i,:));
% %     k=k+1;
% %     projim(k)=sum(newim(i,tempindex),2)./length(tempindex);
% % end
% % Nlength=3;
% % gaussf=gaussmf([-Nlength:0.1:Nlength],[0.45 0]);
% % projimtemp=[projim(end:-1:1) projim projim(end:-1:1)];
% % projimtemp=conv(projimtemp,gaussf,'same');
% % projim=projimtemp(length(projim)+1:2*length(projim));
% % projimt=max(projim)-projim;
% % 
% % dilation = ordfilt2(projimt, windsze, ones(1,windsze));
% % minpts= (dilation ==projimt) ;%& (projimt>mean(projimt));
% % minind = find(minpts);
% % baselinepos=minind+begint;
% % dilation = ordfilt2(projim, windsze, ones(1,windsze));
% % minpts= (dilation ==projim); %& (projim>mean(projim));
% % maxind = find(minpts);
% % maxind=maxind+begint;
% % Segmask=Orientationpartition(I,logical(I),0);
% % if isempty(maxind)|isempty(baselinepos)
% %     mask=newmask;
% %     im=newim;
% %     baselinep=endt-begint-thresh;
% %     return;
% % end
% % 
% % lengthL=endt-begint+3.*border;
% %   
% % bi=max([begint min(maxind)]);
% % ei=max([endt-lengthL+400 max(maxind)]);
% % 
% % baselineindex=find(baselinepos>=bi&baselinepos<=ei);
% % if isempty(baselineindex)
% %     mask=newmask';
% %     im=newim';
% %     baselinep=endt-thresh+border;
% %     return;
% % end
% % dis=abs(baselinepos(baselineindex)-begint+2*border-meanfingerlength);
% % if isempty(dis)||isempty(find(dis<80))
% %     mask=newmask';
% %     im=newim';
% %     baselinep=endt-thresh+border;
% %     return;
% % end
% % indxf=find(dis<80);
% % if length(indxf)>=3
% %     indxf=find(dis<60);
% % end
% % baselinep=round(median(baselinepos(indxf)));
% % 
% % mask=zeros(size(newim'));
% % fi=max([begint baselinep-thresh1]);
% % li=min([endt baselinep+thresh1]);
% % mask(:,fi:li)=1;
% % im=zeros(size(newim'));
% % im(:,fi:li)=newim(fi:li,:)';