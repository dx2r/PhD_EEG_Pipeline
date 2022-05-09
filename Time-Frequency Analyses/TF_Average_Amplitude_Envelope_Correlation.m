function [AEC_values] = TF_Average_Amplitude_Envelope_Correlation(data, sample_freq, epoch_length, freq_range)

%%%
%
% Function that computes the amplitude envelope correlation (AEC) for long time series data, now with time domain based Ortghonalisation (Stabilized Gram-Schmidt Algorithm). 
% (see the following article for more information: https://doi.org/10.1038/nn.3101)
% note: this function uses "TF_Amplitude_Envelope_Correlation.m" for the AEC computation itself. See this function for more information of the different steps.
%
% Gert Vanhollebeke (09/05/2022 - 09/05/2022)
%
% INPUT:
%   data: NxM matrix (N = #timeseries; M = #timepoints) containing the timeseries.
%   sample_freq: sample frequency (Hz)
%   epoch_length: integer indicating the length of the epochs (seconds)
%   freq_range: 1x2 integer vector containing the frequency range in which amplitude envelope correlation needs to be calculated
%       example: [4 10] 
%
% OUTPUT:
%   AEC_values: N x N double matrix (N = #timeseries) which contains the AEC values. This matrix is symmetric. 
%
% example:
%   AEC_values = TF_Average_Amplitude_Envelope_Correlation(data, 512, 3, [8 13]);
%
%%%

%Step 0: tell what is going on
disp('Calculating the Amplitude Envelope Correlation...');
disp('Starting the epoching procedure...');
%Step 1: get dimensions of the dataset:
[timeseries_amount,timepoints_amount] = size(data);
%Step 2: preparation of variables
epoch_amount = timepoints_amount/(epoch_length*sample_freq); % amount of epochs in the data
epoch_timepoints = sample_freq*epoch_length; %amount of timepoints in a single epoch
AEC_values = zeros(timeseries_amount); %build empty N*N matrix which will contain the final FC matrix
%Step 3: loop over all epochs for individual AEC calculation
for epoch_i = 1:epoch_amount
    %say which epoch is currently calculating
    disp(['Epoch ',num2str(epoch_i),' of ',num2str(epoch_amount),'...']);
    %extract the data for the current epoch
    current_epoch = data(:,((epoch_i - 1)*epoch_timepoints) + 1:((epoch_i - 1)*epoch_timepoints) + epoch_timepoints);
    %compute AEC values for current epoch
    current_AEC_values = TF_Amplitude_Envelope_Correlation(current_epoch, sample_freq, freq_range);
    %add obtained values to the Overarching FC matrix
    AEC_values = AEC_values + current_AEC_values;
end
%obtain average AEC value for each connection
AEC_values = AEC_values./epoch_amount;
disp("Done with calculating...");
end