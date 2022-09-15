function [power_values] = TF_Relative_Power_Specific_FCorrected(data, sample_freq, bin_width, freq_range_interest, freq_range_whole, gamma)

%%%
% Function which calculates the average relative power of a frequency range of interest the timeseries in the data object. Total frequency range is defined as an argument. 
% NOTE: this function calculates the power values for the whole length of the timeseries, see "TF_Average_Relative_Power" for the average over a longer time series.
% NOTE: this function uses 1/f correction using the "TF_Frequency_Correction" function.
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M=  #timepoints
%   sample_freq: double indicating the sample frequency (Hz)
%   bin_width: double indicating bin width for the power calculation (Hz)
%   freq_range_interest: 1*2 integer indicating the lower and upper bound of the frequency range of interest
%   freq_range_whole: 1*2 integer indicating the lower and upper bound of the frequency range in which the signal is assumed
%   gamma: double indicating the power to which the frequency should be risen to (see "TF_Frequency_Correction" for more information)
%
% OUTPUT:
%   power_values = 1*N double indicating the relative power values throughout time of the specific frequency band throughout time, for each time series 
%
% EXAMPLE: 
%   [power_values] = TF_Relative_Power_Specific_FCorrected(data, 512, 0.5, [0.5 4], [4 8], [13 17], [0.5 40], 1);
%
% Gert Vanhollebeke (15/09/2022)
%
%%%

%Step 0: get information from data file
[timeseries_amount, timepoints_amount] = size(data);
%Step 1: calculate the power spectral density of each time series
[psd_values, freq_values] = pwelch(data.', [], [], freq_range_whole(1):bin_width:freq_range_whole(2), sample_freq); %transpose data for further usage of functions 
%Step 2: correct the psd values for 1/f noise
psd_values = TF_Frequency_Correction(psd_values, freq_values, gamma);
%Step 3: calculate power values
total_pow = sum(psd_values); %total power
specific_pow = sum(psd_values(freq_range_interest(1)/bin_width:freq_range_interest(2)/bin_width,:))./total_pow; %specific relative power
%Step 4: return relative power values
power_values = specific_pow;
end