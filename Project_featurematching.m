clear all;
clc
load allfeature;
fcorr=[];Tcorr=[];
for ik=1:length(Featureset)-1
    for jk=ik+2:2:length(Featureset)-1
    feature1=Featureset{ik}.palmfeature;
    feature2=Featureset{jk}.palmfeature;
    featuref1=Featureset{ik}.fingerfeature;
    featuref2=Featureset{jk}.fingerfeature;
    fcorr(end+1,:)=[corr2(feature1,feature2),corr2(featuref1,featuref2)];
    end
end
