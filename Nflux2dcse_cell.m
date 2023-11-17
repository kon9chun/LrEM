function [Y,Xf,Af] = Nflux2dcse_cell(X,~,~)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Auto-generated by MATLAB, 11-Mar-2023 11:14:02.
%
% [Y] = myNeuralNetworkFunction(X,~,~) takes these arguments:
%
%   X = 1xTS cell, 1 inputs over TS timesteps
%   Each X{1,ts} = Qx2 matrix, input #1 at timestep ts.
%
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = Qx1 matrix, output #1 at timestep ts.
%
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [1;-3.20903604995314e-05];
x1_step1.gain = [0.00133422281521014;62637.1975872827];
x1_step1.ymin = -1;

% Layer 1
b1 = [-0.9443702742479549439;0.95635424948572156367;-2.9303767820694837098;-22.502994302498066759;-0.064709553774675285243;-9.9583540523569880065;3.4747833190075185783;-0.36498676932603341116;-0.93212386535610458616;1.1168740844334590356];
IW1_1 = [-1.7061159212838432619 0.14342617756236406001;-0.5586848149095806626 0.22028878873390608795;-3.4163553192362901001 0.24192737074631431859;-20.58791840855370836 -0.31966840347227848396;0.98957799207851837586 -0.11407740921455147842;-10.791892490914364089 0.1201471831507973792;-10.819742539774775736 6.3595389695964072985;-0.54200109323725220722 0.0017427123010530689694;-0.48100670731703348837 -0.21328775874520419786;1.3866135423888568123 0.21255792148986787926];

% Layer 2
b2 = 4.4581307159817518126;
LW2_1 = [3.23216313516583309 4.6856879950359822118 1.207153041008586225 9.6734040936474023908 -6.3404565332447271331 0.22801901986273226397 0.00022071868644918865294 -21.805179638935776154 4.9489085436720827715 1.408053074226248258];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 0.000974666993264841;
y1_step1.xoffset = -2045.06285027636;

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(X);
if ~isCellX
    X = {X};
end

% Dimensions
TS = size(X,2); % timesteps
if ~isempty(X)
    Q = size(X{1},1); % samples/series
else
    Q = 0;
end

% Allocate Outputs
Y = cell(1,TS);

% Time loop
for ts=1:TS
    
    % Input 1
    X{1,ts} = X{1,ts}';
    Xp1 = mapminmax_apply(X{1,ts},x1_step1);
    
    % Layer 1
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);
    
    % Layer 2
    a2 = repmat(b2,1,Q) + LW2_1*a1;
    
    % Output 1
    Y{1,ts} = mapminmax_reverse(a2,y1_step1);
    Y{1,ts} = Y{1,ts}';
end

% Final Delay States
Xf = cell(1,0);
Af = cell(2,0);

% Format Output Arguments
if ~isCellX
    Y = cell2mat(Y);
end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end
