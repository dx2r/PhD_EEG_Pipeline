function [sum_neighbouring_labels] = Calculate_Sum_Neighbour_Labels(microstates, labels, window_length, sample_freq, epoch_length)

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
%   sample_freq: double indicating the sample frequency (Hz)
%   epoch_length: double indicating the epoch length (s)
%
% OUTPUT:
%   sum_neighbour_labels: 1*M double matrix (M = #timepoints)
%
%%%

%Step 0: get information from data object
[~, timepoints_amount] = size(labels);

%Step 1: build general object to store the data at the gfp peaks
sum_neighbouring_labels = [];

%Step 2: calculate for each epoch the corresponding values
epoch_timepoints = sample_freq*epoch_length;
epoch_amount = timepoints_amount/epoch_timepoints;
%disp(strcat("Current participant: ", num2str(epoch_amount), " epochs..."));
for current_epoch = 1:epoch_amount
    current_labels = labels((current_epoch - 1)*epoch_timepoints+1:current_epoch*epoch_timepoints);
    current_sum_neighbouring_labels = Calculate_Epoch_Sum_Neighbour_Labels(microstates, current_labels, window_length);
    sum_neighbouring_labels = [sum_neighbouring_labels current_sum_neighbouring_labels];
end

end