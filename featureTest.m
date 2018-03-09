clear;close all
src= imread('image/rtest_11.jpg');

gray=denoise(src);
% gray=rgb2gray(src);
% gray=maxEntropy(gray);
gray = im2double(gray);
%����ͼ�񣬼�������ʱ��
gray = imresize(gray, 0.2);

%����X�����Y������ݶȼ���ƽ��
X=imfilter(gray,[-1 0 1]);
X2=X.^2;
Y=imfilter(gray,[-1 0 1]');
Y2=Y.^2;
XY=X.*Y;

%���ɸ�˹����ˣ���X2��Y2��XY����ƽ��
h=fspecial('gaussian',[5 1],1.5);
w=h*h';
A=imfilter(X2,w);
B=imfilter(Y2,w);
C=imfilter(XY,w);

%kһ��ȡֵ0.04-0.06
k=0.04;
RMax=0;
size=size(gray);
height=size(1);
width=size(2);
R=zeros(height,width);
for h=1:height
    for w=1:width
        %����M����
        M=[A(h,w) C(h,w);C(h,w) B(h,w)];
        %����R�����ж��Ƿ��Ǳ�Ե
        R(h,w)=det(M) - k*(trace(M))^2;
        %���R�����ֵ��֮������ȷ���жϽǵ����ֵ
        if(R(h,w)>RMax)
            RMax=R(h,w);
        end
    end
end

%��Q*RMax��Ϊ��ֵ���ж�һ�����ǲ��ǽǵ�
Q=0.01;
R_corner=(R>=(Q*RMax)).*R;

%Ѱ��3x3�����ڵ����ֵ��ֻ��һ��������8�������Ǹ����������ʱ������Ϊ�õ��ǽǵ�
fun = @(x) max(x(:));
R_localMax = nlfilter(R,[3 3],fun);

%Ѱ�Ҽ�����ǵ���ֵ��������8�����������ֵ��ĵ���Ϊ�ǵ�
%ע�⣺��Ҫ�޳���Ե��
[row,col]=find(R_localMax(2:height-1,2:width-1)==R_corner(2:height-1,2:width-1));

%������ȡ���Ľǵ�
figure('name','Result');
subplot(1,2,1),imshow(gray),title('my-Harris'),
hold on
plot(col,row, 'b*'),
hold off

%��matlab�Դ���edge������ȡHarris�ǵ㣬�Ա�Ч��
C = corner(gray,30);
subplot(1,2,2),imshow(gray),title('matlab-conner'),
hold on
plot(C(:,1), C(:,2), 'r*');
hold off