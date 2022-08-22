function [power_values] = TF_Relative_Power_Specific(data, sample_freq, bin_width, freq_range_interest, freq_range_whole)

%%%
% Function which calculates the average relative power of a frequency range of interest the timeseries in the data object. Total frequency range is defined as an argument. 
% NOTE: this function calculates the power values for the whole length of the timeseries, see "TF_Average_Relative_Power" for the average over a longer time series.
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M=  #timepoints
%   sample_freq: double indicating the sample frequency (Hz)
%   bin_width: double indicating bin width for the power calculation (Hz)
%   freq_range_interest: 1*2 integer indicating the lower and upper bound of the frequency range of interest
%   freq_range_whole: 1*2 integer indicating the lower and upper bound of the frequency range in which the signal is assumed
%
% OUTPUT:
%   power_values = 1*N double indicating the relative power values throughout time of the specific frequency band throughout time, for each time series 
%
% EXAMPLE: 
%   [power_values] = TF_Relative_Power_Specific(data, 512, 0.5, [0.5 4], [4 8], [13 17], [0.5 40]);
%
% Gert Vanhollebeke (04/05/2022)
%
%%%

%Step 0: get information from data file
[timeseries_amount, timepoints_amount] = size(data);
%Step 1: calculate the power spectral density of each time series
[psd_values, freq_values] = pwelch(data.', [], [], freq_range_whole(1):bin_width:freq_range_whole(2), sample_freq); %transpose data for further usage of functions 
%Step 2: calculate power values
total_pow = sum(psd_values); %total power
specific_pow = sum(psd_values(freq_range_interest(1)/bin_width:freq_range_interest(2)/bin_width,:))./total_pow; %specific relative power
%Step 3: return relative power values
power_values = specific_pow;
end