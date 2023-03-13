function [microstates, microstate_label_timeseries, gev_tot, gev_k] = Microstates_Individual(data, sample_frequency, epoch_length, K, clustering_method, varargin)

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

% Get EEG maps at GFP peaks
[maps_at_gfp_peaks, ~] = Extract_GFP_Peaks(data, sample_frequency, epoch_length);

% Perform clustering (k-means or modified k-means)
microstates = Clustering(maps_at_gfp_peaks, K, clustering_method, varargin{1});

% Backfitting
microstate_label_timeseries = Segmentation(data, microstates);
smoothened_microstate_label_timeseries = Temporal_Smoothing(microstates, microstate_label_timeseries, 3, sample_frequency, epoch_length);

% Calculate GEV
[gev_tot, gev_k] = Calculate_Global_Explained_Variance(data, microstates, microstate_label_timeseries);
gev_smooth = Calculate_Global_Explained_Variance(data, microstates, smoothened_microstate_label_timeseries);

end