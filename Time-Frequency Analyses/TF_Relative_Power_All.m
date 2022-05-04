function [power_values] = TF_Relative_Power_All(data, sample_freq, bin_width, delta_range, theta_range, alpha_range, beta_range)

%%%
% Function which calculates the relative power of the timeseries in the data object. Total frequency range is defined as the lower limit of the delta range and the upper limit of the beta range.
% NOTE: this function calculates the power values for the whole length of the timeseries, see "TF_Average_Relative_Power_All_Frequencybands" for the average over a longer time series.
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M=  #timepoints
%   sample_freq: double indicating the sample frequency (Hz)
%   bin_width: double indicating bin width for the power calculation (Hz)
%   delta_range: 1*2 integer indicating the lower and upper range of the delta band (Hz)
%   theta_range: 1*2 integer indicating the lower and upper range of the theta band (Hz)
%   alpha_range: 1*2 integer indicating the lower and upper range of the alpha band (Hz)
%   beta_range: 1*2 integer indicating the lower and upper range of the beta band (Hz)
%
% OUTPUT:
%   power_values = 4*N double indicating the relative power value of each frequency band, for each time series 
%
% EXAMPLE: 
%   [power_values] = TF_Relative_Power_All(data, 512, 0.5, [0.5 4], [4 8], [8 13], [13 30]);
%
% Gert Vanhollebeke (24/01/2022)
%
%%%

%Step 0: get information from data file
[timeseries_amount, timepoints_amount] = size(data);
%Step 1: calculate the power spectral density of each time series
[psd_values, freq_values] = pwelch(data.', [], [], [bin_width:bin_width:beta_range(2)] , sample_freq); 
%Step 2: calculate the power within each frequency band as well as the total power
total_pow = sum(psd_values); %total power
delta_pow = sum(psd_values(delta_range(1)/bin_width:delta_range(2)/bin_width,:))./total_pow;
theta_pow = sum(psd_values(theta_range(1)/bin_width:theta_range(2)/bin_width,:))./total_pow;
alpha_pow = sum(psd_values(alpha_range(1)/bin_width:alpha_range(2)/bin_width,:))./total_pow;
beta_pow = sum(psd_values(beta_range(1)/bin_width:beta_range(2)/bin_width,:))./total_pow;
%build matrix with the relative powers
power_values = [delta_pow; theta_pow; alpha_pow; beta_pow];
end