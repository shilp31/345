function Y = genLinearMeasurementSequence(X, H, R)
%GENLINEARMEASUREMENTSEQUENCE generates a sequence of observations of the state 
% sequence X using a linear measurement model. Measurement noise is assumed to be 
% zero mean and Gaussian.
%
%Input:
%   X           [n x N+1] State vector sequence. The k:th state vector is X(:,k+1)
%   H           [m x n] Measurement matrix
%   R           [m x m] Measurement noise covariance
%
%Output:
%   Y           [m x N] Measurement sequence
%

% your code here
[m, n] = size(H);
N = size(X, 2)-1;
Y = zeros(m, N);
for k=1:N
    r_k = mvnrnd(zeros(m, 1), R)';
    Y(:, k) = H*X(:, k+1) + r_k;
end
end