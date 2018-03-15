global i j;
i=1;
j=1;
while i < (row-height)/2
    while j < col-length
        win=bw(i:i+height-1 ,j:j+length-1);
        flag=identifyCrease(win,rate);
        if flag == 1
            out=[out; j,i];
        end
        j=j+1;
    end
    i=i+1;
end