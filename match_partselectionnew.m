function [Dist,Match_p,dist1,dist2]=match_partselectionnew(Wholedata,selectflag2,selectflag1,threshmatch)      

 Distt=[];
 dist1t=[];
 dist2t=[];
 Match_pt=[];
 Distl=[];
  Distc=[];
   Distr=[];
%  uniflag1=unique(selectflag1);
%  uniflag2=unique(selectflag2);
%  for i=1:length(uniflag1)
%      Wholedata{uniflag1(i)}.L1=gaussprocess(Wholedata{uniflag1(i)}.L1);
%  end
%  for i=1:length(uniflag2)
%      Wholedata{uniflag2(i)}.L2=gaussprocess(Wholedata{uniflag2(i)}.L2);
%  end
for i=1:length(selectflag2)
  sf1=selectflag1(i);
  sf2=selectflag2(i);
  s2  = regionprops(Wholedata{sf2}.mask2, 'centroid');
  s1  = regionprops(Wholedata{sf1}.mask1, 'centroid');
  dis=s2.Centroid(2:-1:1)-s1.Centroid(2:-1:1);
  CompCode1= icp_CorrectImage(Wholedata{sf1}.CompCode1,[1 0;0 1],dis');
  Distt(end+1)= HammingDist(Wholedata{sf2}.CompCode2,Wholedata{sf1}.CompCode1,Wholedata{sf2}.mask2,Wholedata{sf1}.mask1,threshmatch);
 [R, t, corr, data2, dist] = icpnew2D(Wholedata{sf1}.L1,Wholedata{sf2}.L2,threshmatch);
 [R1, t1, corr1, data22, dist11] = icpnew2D(Wholedata{sf1}.L1,data2,3);
% [R1, t1, corr1, data22, dist11] = icpnew2D(Wholedata{sf1}.L1,Wholedata{sf2}.L2,0.55);
 Match_pt(end+1)=length(corr1)/max([length(Wholedata{sf1}.L1) length(Wholedata{sf2}.L2)]);
 dist1t(end+1)=max([mean(dist11) abs(t(1))+abs(atan(-R(2)/R(1))*180/pi)]);
 dist2t(end+1)=mean(dist);
 if sf1==1&&sf2==1
   Distl=Distt(end);Match_pl=Match_pt(end);dist1l=dist1t(end);dist2l=dist2t(end);
 end
 if sf1==3&&sf2==3
   Distc=Distt(end);Match_pc=Match_pt(end);dist1c=dist1t(end);dist2c=dist2t(end);
 end
  if sf1==2&&sf2==2
   Distr=Distt(end);Match_pr=Match_pt(end);dist1r=dist1t(end);dist2r=dist2t(end);
 end
end

Dists=min(Distt);
Match_ps=max(Match_pt);
dist1s=min(dist1t);
dist2s=min(dist2t);



if isempty(Distl)
  sf1=1;
  sf2=1;
  s2  = regionprops(Wholedata{sf2}.mask2, 'centroid');
  s1  = regionprops(Wholedata{sf1}.mask1, 'centroid');
  dis=s2.Centroid(2:-1:1)-s1.Centroid(2:-1:1);
  CompCode1= icp_CorrectImage(Wholedata{sf1}.CompCode1,[1 0;0 1],dis');
  Distl= HammingDist(Wholedata{sf2}.CompCode2,Wholedata{sf1}.CompCode1,Wholedata{sf2}.mask2,Wholedata{sf1}.mask1,threshmatch);
 [R, t, corr, data2, dist] = icpnew2D(Wholedata{sf1}.L1,Wholedata{sf2}.L2,threshmatch);
 [R1, t1, corr1, data22, dist11] = icpnew2D(Wholedata{sf1}.L1,data2,3);
 Match_pl=length(corr1)/max([length(Wholedata{sf1}.L1) length(Wholedata{sf2}.L2)]);
 dist1l=max([mean(dist11) abs(t(1))+abs(atan(-R(2)/R(1))*180/pi)]);
 dist2l=mean(dist);
end

if isempty(Distc)
  sf1=3;
  sf2=3;
  s2  = regionprops(Wholedata{sf2}.mask2, 'centroid');
  s1  = regionprops(Wholedata{sf1}.mask1, 'centroid');
  dis=s2.Centroid(2:-1:1)-s1.Centroid(2:-1:1);
  CompCode1= icp_CorrectImage(Wholedata{sf1}.CompCode1,[1 0;0 1],dis');
  Distc= HammingDist(Wholedata{sf2}.CompCode2,Wholedata{sf1}.CompCode1,Wholedata{sf2}.mask2,Wholedata{sf1}.mask1,threshmatch);
 [R, t, corr, data2, dist] = icpnew2D(Wholedata{sf1}.L1,Wholedata{sf2}.L2,threshmatch);
 [R1, t1, corr1, data22, dist11] = icpnew2D(Wholedata{sf1}.L1,data2,3);
 Match_pc=length(corr1)/max([length(Wholedata{sf1}.L1) length(Wholedata{sf2}.L2)]);
 dist1c=max([mean(dist11) abs(t(1))+abs(atan(-R(2)/R(1))*180/pi)]);
 dist2c=mean(dist);
end

if isempty(Distr)
  sf1=2;
  sf2=2;
  s2  = regionprops(Wholedata{sf2}.mask2, 'centroid');
  s1  = regionprops(Wholedata{sf1}.mask1, 'centroid');
  dis=s2.Centroid(2:-1:1)-s1.Centroid(2:-1:1);
  CompCode1= icp_CorrectImage(Wholedata{sf1}.CompCode1,[1 0;0 1],dis');
  Distr= HammingDist(Wholedata{sf2}.CompCode2,Wholedata{sf1}.CompCode1,Wholedata{sf2}.mask2,Wholedata{sf1}.mask1,threshmatch);
 [R, t, corr, data2, dist] = icpnew2D(Wholedata{sf1}.L1,Wholedata{sf2}.L2,threshmatch);
 [R1, t1, corr1, data22, dist11] = icpnew2D(Wholedata{sf1}.L1,data2,3);
  Match_pr=length(corr1)/max([length(Wholedata{sf1}.L1) length(Wholedata{sf2}.L2)]);
 dist1r=max([mean(dist11) abs(t(1))+abs(atan(-R(2)/R(1))*180/pi)]);
 dist2r=mean(dist);
end

Dist=[Dists;Distl;Distc;Distr];
Match_p=[Match_ps;Match_pl;Match_pc;Match_pr];
dist1=[dist1s;dist1l;dist1c;dist1r];
dist2=[dist2s;dist2l;dist2c;dist2r];
