function  [CompCode,Responset]=FingerprintCompCode(Gray,download,FilterFlag,DisRange)
% Author Denis
% Date May 11, 2008
% Implement Palmprint Recognition Using CompCode
if nargin<2
    download = 0;
end
if nargin<3
    FilterFlag = 2;
end
if nargin<4
    DisRange = 4;
end
if download
    FilterSize =37;
else
    FilterSize =49;
end
Orient_num=12;
switch FilterFlag
    case 1 % Adams
        for i=1:Orient_num
            Gr{i} = CC_GaborFilter(5.5, (i-1)*pi/Orient_num,FilterSize);
            Gr{i} = reshape(Gr{i},FilterSize,FilterSize);
        end
        DatFile = sprintf('data\\CompCode_Adams');
        ScoreFile = sprintf('data\\CompCode_Adams_Dis%d',DisRange);
    case 2
        Sigma = 6.2;%5.2;
        Delta = 4.8;%3.2;
        for i=1:Orient_num
            [Gr{i},Gi{i}]= CC_GaborFilterYue(Sigma,Delta,(i-1)*pi/Orient_num,FilterSize);
            Gr{i}= reshape(Gr{i},FilterSize,FilterSize);
            Gi{i}= reshape(Gi{i},FilterSize,FilterSize);
            Gc{i} = Gr{i}+j*Gi{i};
%             Gr{i} = Gr{i}*(-1);
        end
%         DatFile = sprintf('data\\CompCode_Yue_%2.1f_%2.1f.mat',Sigma,Delta);
%         ScoreFile = sprintf('data\\CompCode_Yue_%2.1f_%2.1f_Dis%d.mat',Sigma,Delta,DisRange);
end
% tic

  for or=1:Orient_num
        ResponseTemp = conv2(Gray,Gr{or},'same');%'valid');%
%         ResponseTemp1 = conv2(Gray,Gc{or},'valid');
%         ResponseTemp2 = conv2(ResponseTemp1,Gc{or},'valid');
%             ResponseTemp2  = ResponseTemp2(18:128-17,18:128-17);
        siz = size(ResponseTemp);
%             ResponseTemp = imfilter(Gray,Gr{or});
%             ResponseTemp = imfilter(Gray,Gr{or},'circular');
        Response(or,:) = reshape(ResponseTemp,prod(size(ResponseTemp)),1);
   end
   [minRes,idx] = min(Response);
   idx = reshape(idx,siz);
% %    idx = idx(1:3:end,1:3:end);
  Responset=reshape(minRes,siz);
   CompCode=idx;
%    thresh=(FilterSize-1)/2;
%    idxmask=zeros(size(idx));
%    idxmask(thresh+1:end-thresh,thresh+1:end-thresh)=1;
%    idx=idx.*idxmask;
%    idx(find(idx==0))=Orient_num/2;
%   CompCode=zeros(size(Gray));
%    CompCode(thresh+1:end-thresh,thresh+1:end-thresh)= idx; 
%    toc