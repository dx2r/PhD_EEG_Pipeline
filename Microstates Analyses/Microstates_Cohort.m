function [microstate_label_timeseries, values] = Microstates_Cohort(data, microstates, data_type, sample_frequency, epoch_length)

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

% Absolute value for source data
if(strcmp(data_type, "source"))
    maps = abs(maps);
end

% Backfitting
microstate_label_timeseries = Segmentation(data, microstates, data_type);
smoothened_microstate_label_timeseries = Temporal_Smoothing(microstates, microstate_label_timeseries, 2, sample_frequency, epoch_length);
%disp(microstate_label_timeseries(1:100));
%disp(smoothened_microstate_label_timeseries(1:100));

% Calculate GEV
%[gev_tot, gev_k] = Calculate_Global_Explained_Variance(data, microstates, microstate_label_timeseries);
[gev_tot, gev_k] = Calculate_Global_Explained_Variance(data, microstates, smoothened_microstate_label_timeseries, data_type);


coverage = Calculate_Coverage(data, smoothened_microstate_label_timeseries, microstates);
[encoded_labels, encoded_label_lengths] = Microstate_Label_Encoding(smoothened_microstate_label_timeseries, sample_frequency, epoch_length);
freq_of_occurrence = Calculate_Frequency_Of_Occurrence(data, encoded_labels, microstates, sample_frequency);
duration = Calculate_Duration(data, encoded_labels, encoded_label_lengths, microstates, sample_frequency);
transition_probabilities = Calculate_Transition_Probabilities(data, encoded_labels, microstates);

disp("Total GEV: ");
disp(gev_tot);
%disp("GEV: ");
%disp(gev_k);
%disp("Frequency of Occurence: ");
%disp(freq_of_occurrence);
%disp("Duration: ");
%disp(duration);
%disp("Coverage: ");
%disp(coverage);
%disp("Transition Probabilities: ");
%disp(transition_probabilities);

values = [gev_k freq_of_occurrence duration coverage transition_probabilities];

end