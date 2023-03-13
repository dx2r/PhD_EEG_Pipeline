function [microstates] = Microstates_Individual(data, sample_frequency, epoch_length, K, clustering_method, varargin)

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

end