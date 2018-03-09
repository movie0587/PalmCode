 %%%%part selection according width para
 function [testdata,selectflag2,selectflag1,fcorr]=partselectionnew(fileT,fileG)

 
 Size=[]; testdata=cell(1,3);
 for i=1:length(fileT.wholedata)
   if isempty(fileT.wholedata{1,i}.baseline)
      Size(end+1)=0;
      testdata{1,i}.L2=[];
   else
       testdata{1,i}.L2=fileT.wholedata{1,i}.L;
       Size(end+1)=size(fileT.wholedata{1,i}.CompCode,1);
   end
   if isempty(fileG.wholedata{1,i}.baseline)
     Size(end+1)=0;
     testdata{1,i}.L1=[];
   else
     testdata{1,i}.L1=fileG.wholedata{1,i}.L;
     Size(end+1)=size(fileG.wholedata{1,i}.CompCode,1);
   end
 end
 
 
 finalsizeh=floor(min(Size(find(Size)))/2)-1;
 for i=1:length(fileT.wholedata)
     if size(fileT.wholedata{1,i}.CompCode,1)>=2*(finalsizeh+1)
         centerp=floor(size(fileT.wholedata{1,i}.CompCode,1)/2);
         testdata{1,i}.CompCode2=fileT.wholedata{1,i}.CompCode(centerp-finalsizeh:centerp+finalsizeh,:);
        testdata{1,i}.mask2=fileT.wholedata{1,i}.mask(centerp-finalsizeh:centerp+finalsizeh,:);
        testdata{1,i}.resp2=fileT.wholedata{1,i}.resp(centerp-finalsizeh:centerp+finalsizeh,:);
     end
          if size(fileG.wholedata{1,i}.CompCode,1)>=2*(finalsizeh+1)
         centerp=floor(size(fileG.wholedata{1,i}.CompCode,1)/2);
        testdata{1,i}.CompCode1=fileG.wholedata{1,i}.CompCode(centerp-finalsizeh:centerp+finalsizeh,:);
        testdata{1,i}.mask1=fileG.wholedata{1,i}.mask(centerp-finalsizeh:centerp+finalsizeh,:);
        testdata{1,i}.resp1=fileG.wholedata{1,i}.resp(centerp-finalsizeh:centerp+finalsizeh,:);
          end   
 end

 corr=zeros(3,3);
  for i=1:3
         s1  = regionprops(testdata{i}.mask1, 'centroid');
     for j=1:3
         s2  = regionprops(testdata{j}.mask2, 'centroid');  
         dis=s2.Centroid(2:-1:1)-s1.Centroid(2:-1:1);
         Resptemp=icp_CorrectImage(testdata{i}.resp1,[1 0;0 1],dis');
         corr(i,j)=sum(sum(Resptemp.*testdata{j}.resp2))/sqrt(sum(sum(Resptemp.*Resptemp)))/sqrt(sum(sum(testdata{j}.resp2.*testdata{j}.resp2)));
     end
 end 
 
 
[selectflag2,selectflag1]=find(corr>0.55&corr>mean(corr(:))-0.05);
if isempty(selectflag2)
    [selectflag2,selectflag1]=find(corr==max(corr(:)));
end
if max(corr(:))<0.35
    selectflag2=3;selectflag1=3;
end
indxt=find(corr>mean(corr(:)));
fcorr=[max(corr(:)) mean(corr(:)) mean(corr(indxt)) corr(1,1) corr(3,3)  corr(2,2)];


clear indxt;