function minDis = minDistance(point,points,num);

narginchk(2,3);
if nargin < 3
    num = length(points);
end
minDis = 666;

for i = 1:num
%     dis = pdist([point;[points(i,1),points(i,2)]],'euclidean');
    dis = (point(1)-points(i,1))*(point(1)-points(i,1)) + (point(2)-points(i,2))*(point(2)-points(i,2));
    if dis < minDis
        minDis = dis;
        if dis ==0
            break;
        end
    end
end