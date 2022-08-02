function [power_values] = TF_Average_Absolute_Power_Specific_Frequencyband(data, sample_freq, epoch_length, bin_width, freq_range_interest, freq_range_whole)

%%%
% Function which calculates the average absolute power of a frequency range of interest the timeseries in the data object. Total frequency range is defined as an argument. 
% NOTE: This function uses the "TF_Absolute_Power_Specific" function for the individual epoch calculations
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
%   power_values = 1*N double indicating the absolute power value of the frequencyband of interest, for each timeseries
%
% EXAMPLE: 
%   [power_values] = TF_Average_Absolute_Power_Specific(data, 512, 3, 0.5, [13 17], [0.5 40]);
%
% Gert Vanhollebeke (01/08/2022)
%
%%%

%Step 0: get information from data object
[timeseries_amount, timepoints_amount] = size(data);
%Step 1: build general object to store the power values in
power_values = zeros(1, timeseries_amount);
%Step 2: calculate for each epoch the corresponding values
epoch_amount = timepoints_amount/(sample_freq*epoch_length);
disp(strcat("Current participant: ", num2str(epoch_amount), " epochs..."));
for current_epoch = 1:epoch_amount
    disp(strcat("Epoch ", num2str(current_epoch),"..."));
    current_data = data(:,(current_epoch - 1) + 1:(current_epoch - 1) + (epoch_length*sample_freq));
    current_powers = TF_Absolute_Power_Specific(current_data, sample_freq, bin_width, freq_range_interest, freq_range_whole);    
    power_values = power_values + current_powers;
end
%Step 3: divide the relative powers by the amount of epochs
power_values = power_values./epoch_amount;
end

