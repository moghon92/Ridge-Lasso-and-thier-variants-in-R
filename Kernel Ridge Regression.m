%%
clc
clear all
load Peaks.mat

y=Y(:); %vectorize y

% create X
X = (1:100);
X=X(:);
bwd = 1; %bandwidth
kernel1 = exp(-dist(X').^2 ./ bwd); % 1D gaussian kernel

K = kron(kernel1,kernel1); %2D gaussian kernel
lambda = 1.1;

%calc alpha
alpha = (K + lambda * eye(size(K))) \ y;

% calc pred_y
y_hat_flat  = K*alpha;
y_hat = reshape(y_hat_flat,[100,100]);

figure
subplot(1,2,1);
imagesc(Y)
title("Original")

subplot(1,2,2);
imagesc(y_hat)
title("Predicted")

standard_deviation = std(y-y_hat_flat);
fprintf('\n The standard_deviation of error is %0.4f\n', standard_deviation);

MSE = sum((y-y_hat_flat).^2)/10000;
fprintf('\n The mean-squared error is %0.4f\n', MSE);

