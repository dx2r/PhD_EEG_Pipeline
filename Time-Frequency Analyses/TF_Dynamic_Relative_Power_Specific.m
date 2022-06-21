function [power_values] = TF_Dynamic_Relative_Power_Specific(data, sample_freq, bin_width, freq_range_interest, freq_range_whole, window_width, shift_resolution)

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
%   window_width: double indicating the window width in which the power values need to be calculated (unit: seconds)
%   shift_resolution: double indicating the timeshift which should be taken between each computation (unit: seconds)
%
% OUTPUT:
%   power_values = M*N double indicating the relative power values throughout time of the specific frequency band throughout time, for each time series 
%
% EXAMPLE: 
%   [power_values] = TF_Relative_Power_Specific(data, 512, 0.5, [0.5 4], [4 8], [13 17], [0.5 40], 1, 1/sample_freq);
%
% Gert Vanhollebeke (04/05/2022)
%
%%%