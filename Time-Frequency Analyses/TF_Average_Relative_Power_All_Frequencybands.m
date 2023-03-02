function [power_values] = TF_Average_Relative_Power_All_Frequencybands(data, sample_freq, epoch_length, bin_width, delta_range, theta_range, alpha_range, beta_range)

%%%
% Function which calculates the average relative power of the timeseries in the data object. Total frequency range is defined as the lower limit of the delta range and the upper limit of the beta range.
% NOTE: This function uses the "TF_Relative_Power_All" function for the individual epoch calculations
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M=  #timepoints
%   sample_freq: double indicating the sample frequency (Hz)
%   epoch_length: integer indicating the length of each epoch (seconds)
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
%   [power_values] = TF_Relative_Power(data, 512, 3, 0.5, [0.5 4], [4 8], [8 13], [13 30]);
%
% Gert Vanhollebeke (24/01/2022)
%
%%%

%Step 0: get information from data object
[timeseries_amount, timepoints_amount] = size(data);
%Step 1: build general object to store the power values in
power_values = zeros(4, timeseries_amount);
%Step 2: calculate for each epoch the corresponding values
epoch_amount = timepoints_amount/(sample_freq*epoch_length);
epoch_timepoints = sample_freq*epoch_length;
disp(strcat("Current participant: ", num2str(epoch_amount), " epochs..."));
for current_epoch = 1:epoch_amount
    disp(strcat("Epoch ", num2str(current_epoch),"..."));
    current_data = data(:,((current_epoch - 1)*epoch_timepoints) + 1:((current_epoch - 1)*epoch_timepoints) + (epoch_length*sample_freq));
    current_powers = TF_Relative_Power_All(current_data, sample_freq, bin_width, delta_range, theta_range, alpha_range, beta_range);    
    power_values = power_values + current_powers;
end
%Step 3: divide the relative powers by the amount of epochs
power_values = power_values./epoch_amount;
end

