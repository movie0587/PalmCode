test = imread('cat.jpg');
test_gray=rgb2gray(test);
level = graythresh(test_gray);
% figure,imshow(test_gray);
test=imbinarize(test_gray,level);
figure,imshow(test);
