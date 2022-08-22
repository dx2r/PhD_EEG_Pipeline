function [power_values] = TF_Average_Log_Absolute_Power_Specific_Frequencyband(data, sample_freq, epoch_length, bin_width, freq_range_interest, freq_range_whole)

%%%
% Function which calculates the natural log of the average absolute power of a frequency range of interest the timeseries in the data object. Total frequency range is defined as an argument. 
% NOTE: This function uses the "TF_Average_Absolute_Power_Specific_Frequencyband.m" function for the calculations
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M=  #timepoints
%   sample_freq: double indicating the sample frequency (Hz)
%   epoch_length: integer indicating the length of each epoch (seconds)
%   bin_width: double indicating bin width for the power calculation (Hz)
%   freq_range_interest: 1*2 integer indicating the lower and upper bound of the frequency range of interest
%   freq_range_whole: 1*2 integer indicating the lower and upper bound of the frequency range in which the signal is assumed
%
% OUTPUT:
%   power_values = 1*N double indicating the natural log of the absolute power value of the frequencyband of interest, for each timeseries
%
% EXAMPLE: 
%   [power_values] = TF_Average_Absolute_Power_Specific(data, 512, 3, 0.5, [13 17], [0.5 40]);
%
% Gert Vanhollebeke (01/08/2022)
%
%%%

%part 0: tell what is going on
disp("Natural log of absolute power is selected...");
%part 1: compute values
power_values = TF_Average_Absolute_Power_Specific_Frequencyband(data, sample_freq, epoch_length, bin_width, freq_range_interest, freq_range_whole);
%part 2: log transform results
power_values = log(power_values);
end