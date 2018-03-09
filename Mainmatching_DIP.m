%% main function for multiview touchless fingerprint image matching
clear all;
clc;
% imagepath='D:\study_t\3D_touchless_fingerprint\calibration_experiments\Multiviewtouchlessfingerimage\';
featurepath='D:\±œ…Ë\featureset\';
ims = dir([featurepath '*.mat']);
download=1;
 if download
       threshmatch=25;
 else
       threshmatch=50;
 end
 
 featureT=load([featurepath '10_R.mat']);

for ik=1:length(ims)
     featureG=load([featurepath ims(ik).name]);
    
     [Wholedata,selectflag2,selectflag1,corr]=partselectionnew(featureT,featureG);
     [Dist,Match_p,dist1,dist2]=match_partselectionnew(Wholedata,selectflag2,selectflag1,threshmatch);
     Distall=Dist(1);
      fprintf('dissimilarity matchscore is  %.3f \n',Distall) ; 
end