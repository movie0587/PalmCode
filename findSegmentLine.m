function [one, two] = findSegmentLine(img);

[row,col] = size(img);

for i = 1:row
    tline = img(i,:);
    t = [diff(find(tline==1)) 2];
    con = diff([0 find(t~=1)]);
    maxLine = max(con);
    
    if maxLine > 300
        index = find(con == maxLine);
        
        t = find(tline==1);
        start = t(diff([-1 t]) > 1);
        startIndex = start(index);
        
        t = find(tline==0);
        endArray = t(diff([-1 t]) > 1);
        endIndex = endArray(index+1);

        one.x = startIndex;
        one.y = i;
        two.x = endIndex;
        two.y = i;
        break;
    end
end


for j = two.x:col
    if sum(img(1:two.y,j)) == 0
        two.x = j;
        break;
    end
end

img2=fliplr(img);
for k = (col-one.x):col
    if sum(img2(1:one.y,k)) == 0
        one.x = col-k;
        break;
    end
end
    