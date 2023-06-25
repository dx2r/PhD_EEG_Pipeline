function [microstates, global_explained_variance, labels] = Microstates_Clustering_K_Means(data, microstates_amount, data_type, max_iter)

%%%
% Function that performs regular k-means clustering
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   microstates_amount: double indicating the amount of clusters/microstates
%   data_type: string indicating the data type: "sensor" or "source"
%   max_iter: maximum amount of iterations before stopping the algorithm
%
% OUTPUT:
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   global_explained variance: double indicating GEV at the end of clustering
%   labels: N*1 double matrix indicating microstate labels
%
%%%

% use matlab function kmeans for clustering with distance metric correlation
[~, microstates] = kmeans(data', microstates_amount, MaxIter=max_iter, distance="correlation");
microstates = microstates';

activations_all_states = (microstates' * data);
[~, labels] = max(activations_all_states.^2);

global_explained_variance = Calculate_Global_Explained_Variance(data, microstates, labels, data_type);

end