function [one,two] = findTopLine(img,midLeft,midRight);

[row,col] = size(img);
left = midLeft.x;
right = midRight.x;
topLine = 0;
for i = 1:midLeft.y
    s = sum(img(i,left:right));
    if s > 10
        topLine = i;
        break;
    end
end

one.x = left;
one.y = topLine;
two.x = right;
two.y = topLine;