close all; clear; clc;

%% 1c

mu = [0; 10];
Sigma = [0.3 0;
         0   8];
A = [1 0.5;
     0 1];

q_xy = sigmaEllipse2D(mu, Sigma, 3, 100);

[z_mu, z_Sigma] = affineGaussianTransform(mu, Sigma, A, [0; 0]);
z_xy = sigmaEllipse2D(z_mu, z_Sigma, 3, 100);

plot(q_xy(1,:), q_xy(2,:), 'linewidth', 2);
hold on;
grid on;
plot(mu(1), mu(2), '*');
plot(z_xy(1,:), z_xy(2,:), 'linewidth', 2);
plot(z_mu(1), z_mu(2), '*');
legend('3\sigma - curve for q', 'mean q', '3\sigma - curve for z', 'mean z');
xlabel('q_1');
ylabel('q_2');
axis equal;

%% 2
% 2a

x_mu = 0;
x_Sigma = 2;
N = 5000; % Number of samples

[z_mu_a, z_Sigma_a] = affineGaussianTransform(x_mu, x_Sigma, 3, 0);
s_a = mvnrnd(z_mu_a, z_Sigma_a, N);
[z_mu_n, z_Sigma_n] = approxGaussianTransform(x_mu, x_Sigma, @(x) 3*x, N);
s_n = mvnrnd(z_mu_n, z_Sigma_n, N);

figure()
x_values = -15:1:15;
subplot(2, 1, 1)
histogram(s_a, 30, 'Normalization', 'pdf')
hold on
plot(x_values, normpdf(x_values, z_mu_a, sqrt(z_Sigma_a)))
title('Original Gaussian')
subplot(2, 1, 2)
histogram(s_n, 30, 'Normalization', 'pdf')
hold on
plot(x_values, normpdf(x_values, z_mu_n, sqrt(z_Sigma_n)))
title('Numerical Gaussian Approximation')

% 2b 
[mu_2b, Sigma_2b] = approxGaussianTransform(x_mu, x_Sigma, @(x) x.^3, N);
s_2b = mvnrnd(mu_2b, Sigma_2b, N);

figure()
x_values_2b = -15:1:15;
histogram(x_values_2b, 50, 'Normalization','pdf')
hold on 
plot(x_values_2b,normpdf(x_values_2b, mu_2b, sqrt(Sigma_2b)))
title('Gaussian approximation of non-linear transformation')


%%
filename = fullfile('HA1.m');  % You should change "mainExample.m" with the name of your source file!
copyfile(filename,'HA1.txt','f') % Here, 'mainExample.txt' is the output. You should upload the 'main.txt' (or whatever you name it). 