function out = denoise(source);

% test=imread('image/test.jpg');
% figure,imshow(test);title("ԭͼ");
if ndims(source) == 3
    I = rgb2gray(source);
else
    I = source;
end

Ig = imnoise(I,'poisson');
s = GetStrelList();
e = ErodeList(Ig, s);
f = GetRateList(Ig, e);
out = GetRemoveResult(f, e);
% figure,imshow(out, []); title('����ȥ��ͼ��');