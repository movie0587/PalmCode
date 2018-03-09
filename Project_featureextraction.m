clear all;
% clc;
imagepath='E:\Research\Materials during my PhD study_LiuFeng\Codes\DIP-based user authentication\project\ÕÆ_Test_Img\';%'D:\study\3D touchless fingerprint\calibration experiments\newfinger1021\';%D:\study\database\Multiviewimages\newtouchlessimages\image\';
savepath='E:\Research\Materials during my PhD study_LiuFeng\Codes\DIP-based user authentication\project\featureset\';
ims = dir([imagepath '*.jpg']);
imagenum=length(ims); constant=1;

%%%%%%%%%%%%%%%%%%%%%%%%feature extraction part%%%%%%%%%%%%%%%%%%%%%%%%
tempbaseline=[];
samplethumb=double(rgb2gray(imread([imagepath '\sampleimage\middlefinger.jpg'])));
It=downsample(samplethumb,15);
It=downsample(It',15);
It=It(1:end-1,1:end)';
%figure;imshow(It',[]);
samplepalm=double(rgb2gray(imread([imagepath '\sampleimage\palmsample.jpg'])));
Ip=downsample(samplepalm,15);
Ip=downsample(Ip',15);
Ip=Ip';
%figure;imshow(Ip,[]);

for ik=1:imagenum
        filename=ims(ik).name(1:end-4);
        indx=strfind(filename,'_');
%         flags=str2num(filename(indx(2)+1:indx(3)-1));

        I1=imread([imagepath filename '.jpg']);% 216.186.160
        I=double(rgb2gray(I1));
        Id=downsample(I,15);
        Id=downsample(Id',15);
        Id=Id';
        corrmatrixthumb=zeros(size(Id));
        for i=size(It,1)/2:size(Id,1)-size(It,1)/2
            for j=size(It,2)/2:size(Id,2)-size(It,2)/2
                corrmatrixthumb(i,j)=corr2(Id(i-size(It,1)/2+1:i+size(It,1)/2,j-size(It,2)/2+1:j+size(It,2)/2),It);
            end
        end
        [irt,ict]=find(corrmatrixthumb==max(max(corrmatrixthumb)));
        corrmatrixpalm=zeros(size(Id));
        for i=size(Ip,1)/2:size(Id,1)-size(Ip,1)/2
            for j=size(Ip,2)/2:size(Id,2)-size(Ip,2)/2
                corrmatrixpalm(i,j)=corr2(Id(i-size(Ip,1)/2+1:i+size(Ip,1)/2,j-size(Ip,2)/2+1:j+size(Ip,2)/2),Ip);
            end
        end
        [irp,icp]=find(corrmatrixpalm==max(max(corrmatrixpalm)));
  Coordnatematrix(ik,:)=[irt,ict,irp,icp];   
  Featureset{ik}.filename=filename;
  Featureset{ik}.fingerfeature=corrmatrixthumb;
  Featureset{ik}.palmfeature=corrmatrixpalm;
  Featureset{ik}.coordinate= [irt,ict,irp,icp];
 %save allfeature Featureset;  
end
save allfeature Featureset;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%