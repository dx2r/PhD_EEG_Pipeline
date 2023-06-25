function [labels] = Microstate_Backfitting_Alternative(data, microstates, data_type, sample_freq, epoch_length)

%%%

% Function that returns the timeseries from a brainstorm .mat object (source level analysis)
% 

%%%

microstates_amount = size(microstates, 2);
[~, timepoints_amount] = size(data);

%Step 2: calculate for each epoch the corresponding values
epoch_timepoints = sample_freq * epoch_length;
epoch_amount = timepoints_amount/epoch_timepoints;

labels = zeros(1,timepoints_amount);

for current_epoch = 1:epoch_amount
    current_data = data(:,(current_epoch - 1)*epoch_timepoints+1:current_epoch*epoch_timepoints);
    [current_peak_maps, current_peak_indices] = Extract_GFP_Peaks(current_data, sample_freq, epoch_length, data_type);
    current_peak_indices = current_peak_indices + (current_epoch-1) * epoch_timepoints;


    current_midpoints_between_peak_indices = zeros(1,length(current_peak_indices)+1);

    current_midpoints_between_peak_indices(1) = (current_epoch - 1)*epoch_timepoints;
    current_midpoints_between_peak_indices(2:end-1) = floor(diff(current_peak_indices)./2) + current_peak_indices(1:end-1);
    current_midpoints_between_peak_indices(end) = current_epoch*epoch_timepoints;
    
    current_peak_labels = Backfitting(current_peak_maps, microstates, data_type);

    for n = 1:length(current_peak_indices)
        labels(current_midpoints_between_peak_indices(n)+1:current_midpoints_between_peak_indices(n+1)) = current_peak_labels(n);
    end

end

%disp(labels);