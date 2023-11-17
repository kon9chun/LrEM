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

load comsol_data\load\dcsen_load.txt;
load comsol_data\load\dcsep_load.txt;

dcsen=dcsen_load(:,2);
dcsep=dcsep_load(:,2);

pxdata{1,1}=[Jn';t];
pydata{1,1}=dcsen';

layers=[
    sequenceInputLayer(2)
    lstmLayer(1024,'OutputMode','sequence')
    fullyConnectedLayer(128)
    fullyConnectedLayer(1)
    regressionLayer];

maxEpochs = 500;
miniBatchSize = 1;

options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'InitialLearnRate',0.005, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Plots','training-progress',...
    'Verbose',0);

[net_sn,info_sn]= trainNetwork(pxdata,pydata,layers,options);
Ypredn=predict(net_sn,[Jn';t]);

figure(1);
clf;
hold on;
plot(Ypredn,'b',LineWidth=1.5);
plot(dcsen','r',LineWidth=1.5);
