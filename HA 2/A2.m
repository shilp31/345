clc;  clear;  close all; 
rng(1) %seed = 1 for reproducability
%% Scenario 1 : Kalman Filter and properties 

% prior(given)
x_0 = 2;
P_0 = 8;

% noise covariance(given)
Q = 1.5;    %motion
R = 3;      %measurement

% model dynamics(given)
A = 1;
H = 1;

%%%%%%%%%%%%%%%%%%%%%%%% a - Generate state sequence & measurement sequence %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 35; %length of sequence, given
X = genLinearStateSequence(x_0, P_0, A, Q, N);  %state sequence
Y = genLinearMeasurementSequence(X, H, R);      %state measurements

figure('Position',[300  300  600  400]);
hold on;
plot(0:N, X);
plot(1:N, Y);
xlabel('N')
legend('state sequence','state measurements')
grid on;
print('Q1_result1.eps','-depsc')

%%%%%%%%%%%%%%%%%%%%%%%% b - Kalman filter estimate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X_filter, P] = kalmanFilter(Y, x_0, P_0, A, Q, H, R);  %Kalman filter output
sigma = sqrt(reshape(P, 1, 35));
figure('Position',[300  300  600  400]);
hold on;
plot(0:N, X);
plot(1:N, Y);
plot(1:N, X_filter);
plot(1:N, X_filter+3*sigma, '--');
plot(1:N, X_filter-3*sigma, '--');
xlabel('N')
legend('state sequence','state measurements', 'Kalman filter output', 'Kalman filter output + 3\sigma', 'Kalman filter output - 3\sigma')
grid on;
print('Q1_result2.eps','-depsc')

% Define time instances
time_instances = [1, 2, 4, 30];

figure('Position',[300  300  600  400]);
for i = 1:length(time_instances)
    k = time_instances(i);
    error = X(:, k) - X_filter(:, k); % Error at time instance k
    
    subplot(length(time_instances), 1, i);
    hold on;
    x_values = linspace(min(error), max(error), 100);
    plot(x_values, normpdf(x_values, 0, sqrt(P(k))), 'r', 'LineWidth', 2); % Plot Gaussian density
    histogram(error, 'Normalization', 'pdf'); % Plot error histogram
    
    xlabel(sprintf('Error at k=%d', k));
    ylabel('Density');
    legend('Error Histogram', 'Gaussian Density');
    title(sprintf('Error Density at k=%d', k));
    grid on;
    
    % Adjust y-axis limits for better visibility of Gaussian density
    ylim([0, max(normpdf(x_values, 0, sqrt(P(k)))) * 1.2]);
end

%%%%%%%%%%%%%%%%%%%%%%%% c - Incorrect prior %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_0_err = 12;
[X_filter_err, P_err] = kalmanFilter(Y, x_0_err, P_0, A, Q, H, R);  %Kalman filter output with wrong prior

figure('Position',[300  300  600  400]);
hold on;
plot(1:N, X_filter);
plot(1:N, X_filter_err, '--');
xlabel('N')
legend('True KF estimate','KF estimate with wrong prior')
grid on;
print('Q1_result3.eps','-depsc')

%%%%%%%%%%%%%%%%%%%%%%%% d - Plotting distributions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







%% How to prepare and save a nice figure
% figure('Position',[300  300  600  400]); % The size of the figure can be changed with the last two values of the position vector.
% plot(x,y) ;
% xlabel('Function input x') % Set x-axis label
% ylabel('Function output y') % Set y-axis label
% legend('y = 3x+2','Location','southeast') % Dont forget to add a legend. You can change its location by changing 'southeast'.
% xlim([-12 12]) % Adjust the xaxis if needed.
% ylim([-30 35]) % Adjust the yaxis if needed.
% grid on ; % Grids almost for all cases should be on
% print('Q1_result1.eps','-depsc') ; % Always save it as an .eps file so that it looks nice on your report!

%% How to export your source code as .txt file. 
% filename = fullfile('mainExample.m');  % You should change "mainExample.m" with the name of your source file!
% copyfile(filename,'mainExample.txt','f') % Here, 'mainExample.txt' is the output. You should upload the 'main.txt' (or whatever you name it). 



