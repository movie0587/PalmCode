clc;clear all;

thres_resize=0.2;
fileName = ['ltest_11','ltest_21','ltest_31','ltest_41','ltest_51','ltest_61','ltest_71',...
    'rtest_11','rtest_21','rtest_31','rtest_41','rtest_51','rtest_61','rtest_71'];
templateDir = 'Template/';
% testDir = 'finalResult/otus/';
testDir = 'edgeTest/zerocross/';

files = dir(testDir);
lengthFiles = length(files);
RTarray=size(14);
RFarray=size(14);

for fileIndex = 3:lengthFiles
    imageName = files(fileIndex).name;
    
    test = imread(strcat(testDir,imageName));
    template = imresize(imread(strcat(templateDir,imageName)),thres_resize);
    
    testWhitePoints = whitePixels(test);
    templateWhitePoints = whitePixels(template);
    matchPoints = 0;
    
    len = length(testWhitePoints);
    for i = 1:len
        p = [testWhitePoints(i,1),testWhitePoints(i,2)];
        dis = minDistance(p,templateWhitePoints);
        if dis < 70
            matchPoints=matchPoints+1;
        end
    end
    
    rateTrue = matchPoints/length(templateWhitePoints);
    RTarray(fileIndex-2)=rateTrue;
    RTresult = sprintf('%s = %f',imageName,rateTrue);
    
    disMatchPoints = abs(length(testWhitePoints) - length(templateWhitePoints));
    rateFalse = disMatchPoints/length(testWhitePoints);
    RFarray(fileIndex-2)=rateFalse;
    RFresult = sprintf('%s = %f',imageName,rateFalse);
end
RTarray
sprintf('RT均值 = %f, RT方差 = %f',mean(RTarray),var(RTarray))

RFarray
sprintf('RF均值 = %f, RF方差 = %f',mean(RFarray),var(RFarray))
