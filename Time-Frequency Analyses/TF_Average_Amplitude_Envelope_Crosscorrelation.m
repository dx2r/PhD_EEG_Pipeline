function [corr_value_ratio_dist, max_corr_lag_dist, mean_lag, lag_significance] = TF_Average_Amplitude_Envelope_Crosscorrelation(data, sample_freq, epoch_length, freq_range, max_delay)

%%%
%
% Function which computes the Amplitude Envelope Crosscorrelation (AEcC) for long time series data. 
% This function uses "TF_Amplitude_Envelope_CrossCorrelation" for the computation itself. See this function for more information.
%
% Gert Vanhollebeke (01/06/2022 - 01/06/2022)
%
% INPUT:
%   data: 2xM double array (M = #timepoints) containing the two timeseries for which AEcC should be computed.
%   sample_freq: sampling frequency (unit: Hz)
%   epoch_length: double indicating length of epochs (unit: seconds)
%   freq_range: 1x2 integer array indicating the range for which AEcC should be computed.
%   max_delay: maximum delay in which the crosscorrelation should be 
%   
% OUTPUT:
%   corr_value_ratio_dist: 1xN double array containing the ratios of the maximum correlation to the zero lag correlation for each epoch separately.
%   max_corr_lag_dist: 1xN double array containing the maximum lags (unit: millisecond) for each epoch separately.
%
%%%

%Step 0: Tell what is going on
disp("Calculating Amplitude Envelope Cross Correlation...");
disp("Starting Epoching Procedure...");
%Step 1: obtain necessary information and objects
[timeseries_amount,timepoints_amount] = size(data);
%Step 2: preparation of variables
epoch_amount = timepoints_amount/(epoch_length*sample_freq); % amount of epochs in the data
epoch_timepoints = sample_freq*epoch_length; %amount of timepoints in a single epoch
%create output objects
corr_value_ratio_dist = zeros(1,epoch_amount);
max_corr_lag_dist = zeros(1,epoch_amount);
%Step 3: compute AEcC
for epoch_i = 1:epoch_amount
    %say which epoch is currently calculating
    disp(['Epoch ',num2str(epoch_i),' of ',num2str(epoch_amount),'...']);
    %extract the data for the current epoch
    current_epoch = data(:,((epoch_i - 1)*epoch_timepoints) + 1:((epoch_i - 1)*epoch_timepoints) + epoch_timepoints);
    %compute AEcC values for current epoch
    [current_corr_value_ratio, current_max_corr_lag] = TF_Amplitude_Envelope_CrossCorrelation(current_epoch, sample_freq, freq_range, max_delay);
    corr_value_ratio_dist(1, epoch_i) = current_corr_value_ratio;
    max_corr_lag_dist(1, epoch_i) = current_max_corr_lag;    
end
mean_lag = mean(max_corr_lag_dist);
%check if lag distribution median is significantly different from zero
lag_significance = signrank(max_corr_lag_dist);
disp("Done Calculating...");
end