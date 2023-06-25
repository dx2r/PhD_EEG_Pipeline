function [duration] = Calculate_Duration(data, encoded_labels, encoded_label_lengths, microstates, sample_freq)

%%%
% Function that calculates the duration in seconds for each microstate
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints) 
%   encoded_labels: P*1 double matrix indicating microstate segment labels (P = #segments)
%   encoded_label_lengths: P*1 double matrix indicating microstate segment label lengths
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   sample_freq: double indicating the sample frequency (Hz)
%
% OUTPUT:
%   duration: 1*K double matrix indicating the duration (s) for each microstate
%
%%%

microstates_amount = size(microstates,2);
duration = zeros(1,microstates_amount);
[~, timepoints_amount] = size(data);
seconds_amount = timepoints_amount ./ sample_freq;

for microstate_k = 1:microstates_amount
    duration(microstate_k) = nanmean(encoded_label_lengths(encoded_labels == microstate_k)) ./ sample_freq;
end

end