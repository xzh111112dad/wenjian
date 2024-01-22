%%%%%%%ע�����Ч�����ã�����ͨ�����θ��ơ�
clear
clc
ile=gpuArray(0.0001)%�������GPU��Ҫ����һ��
c1=(randperm(numel(1:139)));%���������
XTrain1=importdata('C:\���Բ���\�ļ�\����\shuju\LSTM\I.mat');%�������ݼ�
YTrain1=importdata('C:\���Բ���\�ļ�\����\shuju\LSTM\IY.mat');%���ݼ���Ӧ�ı�ǩ
XTrain=XTrain1(c1(1:100));%������Һ��ǰ100����Ϊѵ����
YTrain=YTrain1(c1(1:100));%��Ӧ��ǩ

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

miniBatchSize = 27;%�ɱ����

inputSize = 1;
numHiddenUnits = 250;%�ɱ��������Ԫ����
numClasses = 3;%���

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

maxEpochs = 200;%�ɱ������ѵ������
miniBatchSize =27;%�ɱ����

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


XTest=XTrain1(c1(101:139));%���Լ�����
YTest=YTrain1(c1(101:139));%��Ӧ��ǩ
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