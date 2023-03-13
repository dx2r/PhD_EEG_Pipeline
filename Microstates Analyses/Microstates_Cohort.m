function [microstate_label_timeseries, gev_tot, gev_k] = Microstates_Cohort(data, microstates, sample_frequency, epoch_length)

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

% Backfitting
microstate_label_timeseries = Segmentation(data, microstates);
smoothened_microstate_label_timeseries = Temporal_Smoothing(microstates, microstate_label_timeseries, 3, sample_frequency, epoch_length);

% Calculate GEV
%[gev_tot, gev_k] = Calculate_Global_Explained_Variance(data, microstates, microstate_label_timeseries);
[gev_tot, gev_k] = Calculate_Global_Explained_Variance(data, microstates, smoothened_microstate_label_timeseries);

disp(gev_tot);

[encoded_labels, encoded_label_lengths] = Microstate_Label_Encoding(smoothened_microstate_label_timeseries, sample_frequency, epoch_length);
freq_of_occurrence = Calculate_Frequency_Of_Occurrence(data, encoded_labels, microstates, sample_frequency);
disp(freq_of_occurrence);

end