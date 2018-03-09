function edgeTest(sourceImage);

if ndims(sourceImage)==3
    sourceImage=rgb2gray(sourceImage);
end

bw1 = edge(sourceImage,'log',0.003,2.25);
bw2 = edge(sourceImage,'prewitt');
bw3 = edge(sourceImage,'roberts');
bw4 = edge(sourceImage,'log');
bw5 = edge(sourceImage,'canny');

subplot(3,2,1); imshow(sourceImage); title('a');
subplot(3,2,2); imshow(bw1); title('sobel');
subplot(3,2,3); imshow(bw2); title('prewitt');
subplot(3,2,4); imshow(bw3); title('roberts');
subplot(3,2,5); imshow(bw4); title('log');
subplot(3,2,6); imshow(bw5); title('canny');