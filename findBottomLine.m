function [one,two] = findBottomLine(img,midLeft,midRight);

[row,col] = size(img);
leftLine = img(midLeft.y:row,midLeft.x);
rightLine = img(midRight.y:row,midRight.x);

left = find(leftLine,1,'last');
right = find(rightLine,1,'last');

if isempty(left) ==1
    endIndex = right+midLeft.y+1;
elseif isempty(right) ==1
    endIndex = left+midLeft.y+1;
else
    endIndex = max(left,right)+midLeft.y+1;
end
one.x = midLeft.x;
one.y = endIndex;
two.x = midRight.x;
two.y = endIndex;