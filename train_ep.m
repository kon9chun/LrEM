clear;
clc;

Rsn=12.5e-6;
Rsp=8e-6;

epssn=0.471;
epssp=0.297;

Ln=100e-6;
Lp=183e-6;
A=1;
F=96485.33289;

I=-17.5*[ones(3590,1)];
Jn=I*Rsn/3/epssn/F/A/Ln;
Jp=-I*Rsp/3/epssp/F/A/Lp;
t=1:length(I);

load comsol_data\cep_load.txt;
cep=cep_load(:,2)-1000;

pxdata{1,1}=[Jp';t];
pydata{1,1}=cep';

layers=[
    sequenceInputLayer(2)
    lstmLayer(50,'OutputMode','sequence')
    fullyConnectedLayer(25)
    fullyConnectedLayer(1)
    regressionLayer];

maxEpochs = 500;
miniBatchSize = 1;

options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'InitialLearnRate',0.01, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Plots','training-progress',...
    'Verbose',0);

[net_ep,info_ep]= trainNetwork(pxdata,pydata,layers,options);
Ypredn=predict(net_ep,[Jp';t]);

figure(2);
clf;
hold on;
plot(Ypredn,'b',LineWidth=1.5);
plot(cep','r',LineWidth=1.5);
