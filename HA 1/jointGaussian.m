function [mu, Sigma] = jointGaussian(mu_x, sigma2_x, sigma2_r)
%jointGaussian calculates the joint Gaussian density as defined
%in problem 1.3a. 
%
%Input
%   MU_X        Expected value of x
%   SIGMA2_X    Covariance of x
%   SIGMA2_R    Covariance of the noise r
%
%Output
%   MU          Mean of joint density 
%   SIGMA       Covariance of joint density


%Your code here
mu_r = 0;
mu = [mu_x; mu_x+mu_r];
Sigma = [sigma2_x, sigma2_x;
         sigma2_x, sigma2_x+sigma2_r];

end