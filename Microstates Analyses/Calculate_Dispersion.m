function [dispersion] = Calculate_Dispersion(data, microstates, labels)

%%%
% Function that calculates the cluster dispersion, which is a measure of
% the quality of the clustering
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   microstates_amount: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   labels: N*1 double matrix indicating microstate labels
%
% OUTPUT:
%   dispersion: double indicating the total dispersion across all clusters
%
%%%

microstates_amount = size(microstates,2);

cluster_dispersion = zeros(1,microstates_amount);

for label_k = 1:microstates_amount

    distance_original_maps = sum((data(:,labels==label_k)./ vecnorm(data(:, labels==label_k), 2, 1) - microstates(:,label_k)./ vecnorm(microstates(:, label_k), 2, 1)).^2, 1);
    distance_opposite_maps = sum((-(data(:,labels==label_k)./ vecnorm(data(:, labels==label_k), 2, 1)) - microstates(:,label_k)./ vecnorm(microstates(:, label_k), 2, 1)).^2, 1);

    cluster_dispersion(label_k) = sum(min(distance_original_maps, distance_opposite_maps));

end

dispersion = sum(cluster_dispersion);