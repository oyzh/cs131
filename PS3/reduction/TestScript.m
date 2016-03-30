%% Clean up
clear all; close all; clc;

%% Load data
load('Test.mat');
load('Train.mat');


%% Three dimensionality reduction methods


%% Image downsample
% ReductionMethod = @(x)DownSample(x, 0.8);

%% Random projection
D = 576; %% reduced dimension

%% Generate the random matrix
R = randn(D, size(X,1));
R = R ./ repmat(sqrt(sum(R.^2, 2)), 1, size(X,1));
ReductionMethod = @(x)RandomProj(x, R);

%% PCA
% load('component.mat');
% D =36; %% reduced dimension
% C = U(1:D, :); %% choose the first D principle components 
% ReductionMethod = @(x)PCA(x, C);


%% Dimension reduction
for i = 1 : length(Train),
    Train{i} = ReductionMethod(Train{i});
end
X = ReductionMethod(X);


%% KNN
K = 30; %% K-nearest neighbor
Classification = KNN(Train, X, K);
fprintf('Classification accuracy: %f\n', sum(Classification==Y) / length(Y) );