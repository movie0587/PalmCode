clear all;
clc;
% imagepath='D:\wu\personal\毕设\Test_Img\'
% savepath='D:\wu\personal\毕设\featureset\';
imagepath='D:\毕设\Test_Img\'
savepath='D:\毕设\featureset\';

ims = dir([imagepath '*.jpg']);
constant=1;
download=1;
meanlength=420;
wholedata=cell(1,3);

% for i=1:length(ims)
%     fprintf("imageName= "+ims(i).name+"\n");
% end
%%%%%%%%%%%%%%%%%%%%%%%%feature extraction part%%%%%%%%%%%%%%%%%%%%%%%%
partflag=[1 2 3];
for i=1:length(partflag)
    filename=ims(i).name(1:end-4);
    fprintf("filename="+filename+"\n");
    indx=strfind(filename,'_');
    I=imreadbw([imagepath filename(1:end-1) num2str(partflag(i)) '.jpg']);
    mask=zeros(size(I));
    if i==1
        mask(87:501,41:end)=1;%
    elseif i==2
        mask(4:425,29:end)=1;
    else
        mask(11:370,90:end)=1;
    end
    I=I.*mask;
    if download
        I=imresize(I,0.5);
    end
    mask=IterativeThresholding2(I,ones(size(I)));
    I=I.*mask;
    [Segmask1,I1,mask1]=Orientationpartition(I,mask,download);
    [baseline1,CompCode1,Itemp1,mask1,L1,Lpara1,Response1]=projectionalgorithm(I1',mask1',Segmask1',meanlength,download);
    if download
        Lpara1=Lpara1*2;
    end
    if isempty(baseline1)
        wholedata{1,i}.CompCode=[];
        wholedata{1,i}.mask=[];
        wholedata{1,i}.L=[];
        wholedata{1,i}.resp=[];
    else
        wholedata{1,i}.baseline=baseline1;
        wholedata{1,i}.CompCode=CompCode1;%imresize(CompCode.*mask,0.5);
        wholedata{1,i}.resp=Response1;
        wholedata{1,i}.mask=mask1;%imresize(mask,0.5);
        wholedata{1,i}.L=L1;
    end
end
save([savepath filename(1:end-2) '.mat'],'wholedata') ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%