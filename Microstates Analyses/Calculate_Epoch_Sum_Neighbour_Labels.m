function [sum_neighbour_labels] = Calculate_Epoch_Sum_Neighbour_Labels(microstates, labels, window_length)

% Function that calculates the amount of samples in a window that belong to
% each label
% 
% Lore Flipts
%
% INPUT:
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   labels: 1*M double matrix (M = #timepoints)
%   window_length: double indicating the number of samples on one side of 
%       the sample to include for smoothing
%
% OUTPUT:
%   sum_neighbour_labels: 1*M double matrix (M = #timepoints)
%
%%%

microstates_amount = size(microstates, 2);
padding = zeros(1, window_length);
padded_labels = [padding labels padding];

sum_neighbour_labels = zeros(microstates_amount, length(padded_labels));

for i = window_length+1:length(padded_labels)-window_length
    for k = 1:microstates_amount
        sum_neighbour_labels(k,i) = sum(padded_labels(i-window_length:i+window_length) == k) - sum(padded_labels(i) == k);
    end
end

sum_neighbour_labels = sum_neighbour_labels(:, window_length+1:length(sum_neighbour_labels)-window_length);

end