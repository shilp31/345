function [X, P] = kalmanFilter(Y, x_0, P_0, A, Q, H, R)
%KALMANFILTER Filters measurements sequence Y using a Kalman filter. 
%
%Input:
%   Y           [m x N] Measurement sequence
%   x_0         [n x 1] Prior mean
%   P_0         [n x n] Prior covariance
%   A           [n x n] State transition matrix
%   Q           [n x n] Process noise covariance
%   H           [m x n] Measurement model matrix
%   R           [m x m] Measurement noise covariance
%
%Output:
%   x           [n x N] Estimated state vector sequence
%   P           [n x n x N] Filter error convariance
%

%% Parameters
N = size(Y,2);

n = length(x_0);
m = size(Y,1);

%% Data allocation
x = zeros(n,N);
P = zeros(n,n,N);

x(:, 1) = x_0;
P(:, :, 1) = P_0;

for k=2:N+1
    [x_pred, P_pred] = linearPrediction(x(:, k-1), P(:, :, k-1), A, Q);
    [x(:, k), P(:, :, k)] = linearUpdate(x_pred, P_pred, Y(:, k-1), H, R);
end
X = x(:, 2:end);
P = P(:, :, 2:end);
end

