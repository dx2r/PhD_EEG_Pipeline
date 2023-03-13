function [microstates] = Cluster_Microstates(microstates_individual, K, clustering_method, varargin)

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

% Perform clustering (k-means or modified k-means)
microstates = Clustering(microstates_individual, K, clustering_method, varargin{1});

end