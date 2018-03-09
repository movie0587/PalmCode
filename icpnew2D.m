function [R, t, corr, data2, dist] = icpnew2D(data1, data2, tol)
% [R, t, corr, data2] = icp(data1, data2, tol)
%
% This is an implementation of the Iterative Closest Point (ICP) algorithm.
% The function takes two data sets and registers data2 with data1. It is
% assumed that data1 and data2 are in approximation registration. The code
% iterates till no more correspondences can be found.
%
% Arguments: data1 - 2 x n matrix of the x, y  coordinates of data set 1
%            data2 - 2 x m matrix of the x, y  coordinates of data set 2
%            tol   - the tolerance distance for establishing closest point
%                     correspondences
%
% Returns: R - 2 x 2 accumulative rotation matrix used to register data2
%          t - 2 x 1 accumulative translation vector used to register data2
%          corr - p x 2 matrix of the index no.s of the corresponding points of
%                 data1 and data2
%          data2 -2 x m matrix of the registered data2 
%

c1 = 0;
c2 = 1;
R = eye(2);
t = zeros(2,1);
% tempdata=data1';
% tri = delaunay(data1(1,:),data1(2,:));

tri = delaunayn(data1');
while c2 > c1    
    c1 = c2;
    [corr, D] = dsearchn(data1', tri, data2');
    corr(:,2) = [1 : length(corr)]'; %corr的第二列 = 1到n，corr的每一行对应一对最近点对的序号
    ii = find(D > tol);
    corr(ii,:) = [];
    if ~isempty(corr)
    [R1, t1] = reg(data1, data2, corr);
    data2 = R1*data2;
    data2 = [data2(1,:)+t1(1); data2(2,:)+t1(2)];
    R = R1*R;
    t = R1*t + t1;   
    end
    c2 = length(corr);      
end
dist = D;
%-----------------------------------------------------------------
function [R1, t1] = reg(data1, data2, corr)
n = length(corr); 
M = data1(:,corr(:,1)); 
mm = mean(M,2); %按行取平均，即取某一行的平均
S = data2(:,corr(:,2));
ms = mean(S,2); 
Sshifted = [S(1,:)-ms(1); S(2,:)-ms(2)];
Mshifted = [M(1,:)-mm(1); M(2,:)-mm(2)];
K = Sshifted*Mshifted';
K = K/n;
[U A V] = svd(K);
R1 = V*U';
if det(R1)<0
    B = eye(2);
    B(2,2) = det(V*U');
    R1 = V*B*U';
end
t1 = mm - R1*ms;