function th = maxEntropy(source);

%一维最大熵法
% source = imread('test.jpg');
if ndims(source) == 3
    source = rgb2gray(source);
end
vHist=imhist(source);
[m,n]=size(source);
p=vHist(find(vHist>0))/(m*n);%求每一不为零的灰度值的概率
Pt=cumsum(p);%计算出选择不同t值时，A区域的概率
Ht=-cumsum(p.*log(p));%计算出选择不同t值时，A区域的熵
HL=-sum(p.*log(p));%计算出全图的熵
Yt=log(Pt.*(1-Pt)+eps)+Ht./(Pt+eps)+(HL-Ht)./(1-Pt+eps);%计算出选择不同t值时，判别函数的值
[a,th]=max(Yt);%th即为最佳阈值
th=th/255;
% out=(source>th);
% edgeTest(segImg);
% figure,imshow(out);