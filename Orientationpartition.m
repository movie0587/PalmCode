function [Segmask,newI,newmask]=Orientationpartition(I,mask,download)
 

[rows,cols]=size(I);
[indxr,indxc]=find(mask);
if download 
    thresh=50;
    boder=10;
else
    boder=20;
    thresh=100;
end
bi=min([max(indxc) min(indxc)+thresh]);
ei=max([max(indxc)-thresh bi]);
clear indxr indxc;
% Rectify original image
cline=[];
for i=bi:ei
          s  = regionprops(mask(:,i), 'centroid');
          if isempty(s)|length(s)>1
               cline(end+1)=0;
               continue;
          end
          cline(end+1)=s.Centroid(2);
end
xvalue=[bi:ei];
validvalue=find(cline);
xvalue=xvalue(validvalue);
cline=cline(validvalue);
aa=polyfit(xvalue,cline,1);
fd=polyval(aa,xvalue');
angle=atan(aa(1))*180/pi;
newmask=imrotate(mask,angle, 'crop');
newI=imrotate(I,angle, 'crop');
%求方向场
if download 
    orientim = ridgeorient(newI,1,3,3);
else
    orientim = ridgeorient(newI,2,6,6);
end
[indxr,indxc]=find(newmask);

newindr=[min(indxr)+boder:max(indxr)-boder];
newindc=[min(indxc)+boder:max(indxc)-boder];


orientmask=zeros(rows,cols);
orientmask(newindr,newindc)=1;
se = strel('disk',7);
orientmask =imerode(newmask,se);
orientim=orientim.*orientmask;
Segmask=zeros(rows,cols);

index=find(orientim>1*pi/3&orientim<2*pi/3);
Segmask(index)=1;
Segmask=Segmask.*orientmask;
%%%%%numorient=6; 将方向场划分为6个方向
%     for j=boder:rows-boder
%         for k=boder:cols-boder
%             if orientmask(j,k)==0
%                 continue;
%             end
%            for i=1:numorient
%                 if orientim(j,k)<=pi*(i-1)/numorient
%                     Segmask(j,k)=i;
%                     break;
%                 end
%            end
%         end
%     end
% Segmask=Segmask.*mask;
Segmask=imfill(Segmask,'holes');
% figure;imshow(Segmask,[]);
