function points = whitePixels(image);

[row,col] = size(image);
points = [];

for i = 1:row
    for j = 1:col
        if image(i,j) == 1
            points = [points;[i,j]];
        end
    end
end