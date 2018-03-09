function [pFilter,pFilterI] = CC_GaborFilterYue(fSigma, f2Delta, fAngle, g_iFilterSize)
% Author Denis
% Date Jan 26, 2008
% Here try to implement Yue Feng's FillGaborFilterAngle function
% @IN   fSigma, Sigma for Gabor filter
%       f2Delta, Delta for Gabor filter
%       ang, Gabor orientation
%       filtersize, the Gabor filter size
% @OUT  pFilter, Gabor filter, real part, DC remove
%       pFilterI, Gabor filter, image part

if nargin<1
    fSigma = 5.2;
end
if nargin<2
    f2Delta = 3.2;
end
if nargin<3
    fAngle = 0 ;
end
if nargin<4
    g_iFilterSize = 31;
end
g_iHalfFilterSize = floor(g_iFilterSize/2);
PI=pi;
ln2_2 = sqrt(2*log(2));
fK = ln2_2 * (f2Delta+1) / (f2Delta-1);
fW0 = fK / fSigma;
fFactor1 = fW0 / (sqrt(2*PI) * fK);
fFactor2 = -(fW0*fW0)/(8*fK*fK);
fSin = sin(fAngle);
fCos = cos(fAngle);
for i=0:g_iFilterSize-1
    x = i-g_iHalfFilterSize;
    for j=0:g_iFilterSize-1
        y = j-g_iHalfFilterSize;
        x1 = x*fCos + y*fSin;
        y1 = y*fCos - x*fSin;
        fTemp = fFactor1 * exp(fFactor2*(4*x1*x1+y1*y1));
        pFilter(j*g_iFilterSize+i+1) = fTemp * cos(fW0*x*fCos+fW0*y*fSin);
        pFilterI(j*g_iFilterSize+i+1) = fTemp * sin(fW0*x*fCos+fW0*y*fSin);
    end
end
pFilter = pFilter-mean(pFilter);
% void FillGaborFilterAngle(double fSigma, double f2Delta, double fAngle, double* pFilter)
% {
% 	const double _2ln2 = sqrt(2*log(2));
% 
% 	double fK = _2ln2 * (f2Delta+1) / (f2Delta-1);
% 	double fW0 = fK / fSigma;
% 
% 	double fFactor1 = -fW0 / (sqrt(2*PI) * fK);
% 
% 	double fFactor2 = -(fW0*fW0)/(8*fK*fK);
% 
% 	double fSin = sin(fAngle);
% 	double fCos = cos(fAngle);
% 	double fTemp;
% 	double x, y, x1, y1;
% 	double fSum = 0;
% 	int i, j;
% 
% 	for (i=0; i<g_iFilterSize; i++){
% 		x = i-g_iHalfFilterSize;
% 		for (j=0; j<g_iFilterSize; j++){
% 			y = j-g_iHalfFilterSize;
% 			x1 = x*fCos + y*fSin;
% 			y1 = y*fCos - x*fSin;
% 			fTemp = fFactor1 * exp(fFactor2*(4*x1*x1+y1*y1));
% 			pFilter[i*g_iFilterSize+j] = fTemp * cos(fW0*x*fCos+fW0*y*fSin);			
% 			fSum += pFilter[i*g_iFilterSize+j];			
% 		}
% 	}
% 
% 	double fMean = fSum / g_iFilterSize / g_iFilterSize;
% 	for(i=0; i<g_iFilterSize; i++)
% 		for (j=0; j<g_iFilterSize; j++)
% 			pFilter[i*g_iFilterSize+j] -= fMean;
% }