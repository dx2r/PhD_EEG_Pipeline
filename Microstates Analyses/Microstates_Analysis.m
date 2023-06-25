function [smoothened_label_timeseries, microstate_statistics] = Microstates_Analysis(data, microstates, data_type, sample_frequency, epoch_length, window_length)

%%%
% Function that performs the total microstate analysis pipeline, including
% backfitting, smoothing, and calculating statistics
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints)  
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   data_type: string indicating the data type: "sensor" or "source"
%   sample_freq: double indicating the sample frequency (Hz)
%   epoch_length: double indicating the epoch length (s)
%   window_length: double indicating the number of samples on one side of 
%       the sample to include for smoothing
%
% OUTPUT:
%   smoothened_label_timeseries: 1*M double matrix (M = #timepoints)
%       containing the labels for every time point, temporally smoothed
%   microstate_statistics: 1*T double matrix containing the microstate GEV,
%       frequency of occurrence, duration, coverage, and transition
%       probabilities
%
%%%


% Absolute value for source data
if(strcmp(data_type, "source"))
    data = abs(data);
end

% Average re-reference data
if(strcmp(data_type, "sensor"))
    data = data - mean(data,1);
end

% Backfitting
label_timeseries = Microstates_Backfitting(data, microstates, data_type);


% Temporal smoothing
smoothened_label_timeseries = Microstates_Temporal_Smoothing(data, label_timeseries, microstates, window_length, data_type, sample_frequency, epoch_length);


% Calculate microstate statistics
microstate_statistics = Calculate_Microstate_Statistics(data, smoothened_label_timeseries, microstates, data_type, sample_frequency, epoch_length);

end