function [Dist,x,y] = HammingDist(LBPA, LBPB, MaskA, MaskB, DISPLACE,Numorient)
% Author Denis
% Date Feb 19, 2007
% compute the LBP distance for two images, with the translation on
% left-right and down-up, here the distance is based on Hamming Distance
% para@input    LBPA: the LBP of image A
%               LBPB: the LBP of image B
%               MaskA: the mask of image A
%               MAskB: the mask of image B
%               DISPLACE: the displace for left-right and up-down
%               translation range
% Here the LBP is 59 uniform LBP histogram
% para@out      Dist: the distance computed using LBP data

if nargin<5
    DISPLACE =25;
    Numorient=12;
elseif nargin<6
    Numorient=12;
end

siz = size(LBPB);
LBPBExtend = zeros(siz(1)+2*DISPLACE,siz(2)+2*DISPLACE);
MaskBExtend = zeros(siz(1)+2*DISPLACE,siz(2)+2*DISPLACE);

LBPBExtend(DISPLACE+1:siz(1)+DISPLACE,DISPLACE+1:siz(2)+DISPLACE) = LBPB;
MaskBExtend(DISPLACE+1:siz(1)+DISPLACE,DISPLACE+1:siz(2)+DISPLACE) = MaskB;

Dist = prod(siz)*Numorient;
for i=-DISPLACE:DISPLACE
    for j=-DISPLACE:DISPLACE
        LBPAExtend = zeros(siz(1)+2*DISPLACE,siz(2)+2*DISPLACE);
        MaskAExtend = zeros(siz(1)+2*DISPLACE,siz(2)+2*DISPLACE);
        LBPAExtend(DISPLACE+1+i:siz(1)+DISPLACE+i,DISPLACE+1+j:siz(2)+DISPLACE+j) = LBPA;
        MaskAExtend(DISPLACE+1+i:siz(1)+DISPLACE+i,DISPLACE+1+j:siz(2)+DISPLACE+j) = MaskA;
        SameMat = min(Numorient-abs(LBPAExtend-LBPBExtend),abs(LBPAExtend-LBPBExtend));                
        Mask = MaskAExtend&MaskBExtend;
        TempDist = sum(SameMat(Mask))/sum(Mask(:));
        if TempDist<Dist
            Dist=TempDist;
            x=i;y=j;            
        end
%         sprintf('%d,%d,%d,%d',i,j,sum(SameMat(Mask)),sum(Mask(:)));
    end
end