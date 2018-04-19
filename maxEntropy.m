function th = maxEntropy(source);

%һά����ط�
% source = imread('test.jpg');
if ndims(source) == 3
    source = rgb2gray(source);
end
vHist=imhist(source);
[m,n]=size(source);
p=vHist(find(vHist>0))/(m*n);%��ÿһ��Ϊ��ĻҶ�ֵ�ĸ���
Pt=cumsum(p);%�����ѡ��ͬtֵʱ��A����ĸ���
Ht=-cumsum(p.*log(p));%�����ѡ��ͬtֵʱ��A�������
HL=-sum(p.*log(p));%�����ȫͼ����
Yt=log(Pt.*(1-Pt)+eps)+Ht./(Pt+eps)+(HL-Ht)./(1-Pt+eps);%�����ѡ��ͬtֵʱ���б�����ֵ
[a,th]=max(Yt);%th��Ϊ�����ֵ
th=th/255;
% out=(source>th);
% edgeTest(segImg);
% figure,imshow(out);