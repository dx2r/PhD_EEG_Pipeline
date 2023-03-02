function [cov_matrix] = TF_Meancentered_Covariance(timeseries)
%%%
%
% Function which mean-centers the timeseries data and computes the covariance matrix from it.
%
% INPUT:
%   timeseries: N x M double array -> timeseries object (N = channels/brainregion timeseries, M = timepoints)
%
% OUTPUT:
%   cov_matrix: N x N double array -> covariance matrix
%
% EXAMPLE: cov_matrix = TF_Compute_MeanCentered_Covariance_Matrix(timeseries);
%
% Gert Vanhollebeke (13/01/2023)
%
%%%

%step 1: meancenter data (so that the mean is zero)
timeseries = timeseries - mean(timeseries,2);
%step 2: compute covariance matrix
cov_matrix = cov(timeseries.');
end