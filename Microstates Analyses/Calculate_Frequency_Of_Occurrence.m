function [frequency_of_occurrence] = Calculate_Frequency_Of_Occurrence(data, encoded_labels, microstates, sample_freq)

%%%
% Function that calculates the frequency of occurence per second for each microstate
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints) 
%   encoded_labels: P*1 double matrix indicating microstate labels (P = #segments)
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   sample_freq: double indicating the sample frequency (Hz)
%
% OUTPUT:
%   frequency_of_occurrence: 1*K double matrix indicating the frequency of occurrence (Hz) for each microstate
%
%%%

K = size(microstates,2);
frequency_of_occurrence = zeros(1,K);
[~, timepoints_amount] = size(data);
seconds_amount = timepoints_amount ./ sample_freq;

for k = 1:K
    frequency_of_occurrence(k) = sum((encoded_labels == k)) ./ seconds_amount;
end

end