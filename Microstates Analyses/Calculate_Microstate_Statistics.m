function [microstate_statistics] = Calculate_Microstate_Statistics(data, labels, microstates, data_type, sample_frequency, epoch_length)

%%%
% Function that calculates the microstate statistics for each microstate,
% including GEV, coverate, frequency of occurrence, duration, and
% transition probabilities
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
%   microstate_statistics: 1*(4*K+K^2) double matrix containing all microstate
%       statistics
%
%%%


% Global Explained Variance
[total_global_explained_variance, global_explained_variance] = Calculate_Global_Explained_Variance(data, microstates, labels, data_type);

% Coverage
coverage = Calculate_Coverage(data, labels, microstates);

% Run-length-encoding
[encoded_labels, encoded_label_lengths] = Microstates_Label_Encoding(labels, sample_frequency, epoch_length);

% Frequency of Occurrence
freq_of_occurrence = Calculate_Frequency_Of_Occurrence(data, encoded_labels, microstates, sample_frequency);

% Duration
duration = Calculate_Duration(data, encoded_labels, encoded_label_lengths, microstates, sample_frequency);

% Transition probabilities
transition_probabilities = Calculate_Transition_Probabilities(data, encoded_labels, microstates);


fprintf("Total GEV: : %.5f \n", total_global_explained_variance);

microstate_statistics = [global_explained_variance freq_of_occurrence duration coverage transition_probabilities];

end