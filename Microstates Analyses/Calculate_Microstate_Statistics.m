function [microstate_statistics] = Calculate_Microstate_Statistics(maps, labels, microstates, data_type, sample_frequency, epoch_length)

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


% Global Explained Variance
[gev_tot, gev_k] = Calculate_Global_Explained_Variance(maps, microstates, labels, data_type);

% Coverage
coverage = Calculate_Coverage(maps, labels, microstates);

% Run-length-encoding
[encoded_labels, encoded_label_lengths] = Microstate_Label_Encoding(labels, sample_frequency, epoch_length);

% Frequency of Occurrence
freq_of_occurrence = Calculate_Frequency_Of_Occurrence(maps, encoded_labels, microstates, sample_frequency);

% Duration
duration = Calculate_Duration(maps, encoded_labels, encoded_label_lengths, microstates, sample_frequency);

% Transition probabilities
transition_probabilities = Calculate_Transition_Probabilities(maps, encoded_labels, microstates);


fprintf("Total GEV: : %.5f \n", gev_tot);

microstate_statistics = [gev_k freq_of_occurrence duration coverage transition_probabilities];

end