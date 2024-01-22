%%%%%%%注：如果效果不好，可以通过调参改善。
clear
clc
ile=gpuArray(0.0001)%如果带有GPU，要加这一行
c1=(randperm(numel(1:139)));%数据随机化
XTrain1=importdata('C:\电脑材料\文件\毕设\shuju\LSTM\I.mat');%输入数据集
YTrain1=importdata('C:\电脑材料\文件\毕设\shuju\LSTM\IY.mat');%数据集对应的标签
XTrain=XTrain1(c1(1:100));%随机打乱后的前100个作为训练集
YTrain=YTrain1(c1(1:100));%对应标签

% figure
% plot(XTrain{1}')
% xlabel("Time Step")
% title("Training Observation 1")
% numFeatures = size(XTrain{1},1);
% legend("Feature " + string(1:numFeatures),'Location','northeastoutside')

numObservations = numel(XTrain);
for i=1:numObservations
    sequence = XTrain{i};
    sequenceLengths(i) = size(sequence,2);
end

[sequenceLengths,idx] = sort(sequenceLengths);
XTrain = XTrain(idx);
YTrain = YTrain(idx);

% figure
% bar(sequenceLengths)
% ylim([0 30])
% xlabel("Sequence")
% ylabel("Length")
% title("Sorted Data")

miniBatchSize = 27;%可变参数

inputSize = 1;
numHiddenUnits = 250;%可变参数：神经元个数
numClasses = 3;%类别

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

maxEpochs = 200;%可变参数：训练周期
miniBatchSize =27;%可变参数

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',3, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','never', ...
    'Verbose',0, ...
    'Plots','training-progress');

net = trainNetwork(XTrain,YTrain,layers,options);


XTest=XTrain1(c1(101:139));%测试集输入
YTest=YTrain1(c1(101:139));%对应标签
%XTest(1:3)

numObservationsTest = numel(XTest);
for i=1:numObservationsTest
    sequence = XTest{i};
    sequenceLengthsTest(i) = size(sequence,2);
end
[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);

miniBatchSize = 27;
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');

acc = sum(YPred == YTest)./numel(YTest)