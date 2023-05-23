function [sum_neighbouring_labels] = Calculate_Epoch_SumLabels(microstates, labels, window_length, sample_freq, epoch_length)

%%%
% Function that ...
% 
% Lore Flipts
%
% INPUT:
%   
%
% OUTPUT:
%   
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
    current_sum_neighbouring_labels = Calculate_Sum_Labels_Window(microstates, current_labels, window_length);
    %current_smoothed_labels = Smoothing_Algorithm(microstates, current_smoothed_labels, window);
    sum_neighbouring_labels = [sum_neighbouring_labels current_sum_neighbouring_labels];
end

end