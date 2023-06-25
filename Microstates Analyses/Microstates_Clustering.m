function [optimal_microstates] = Microstates_Clustering(data, microstates_amount_range, clustering_method, data_type, varargin)

%%%
% Function that performs entire microstate clustering pipeline
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   microstates_amount_range: double indicating the maximum amount of
%       clusters to test (e.g. 10)
%   clustering_method: string indicating the method of clustering:
%       "k-means" or "modified k-means"
%   data_type: string indicating the data type: "sensor" or "source"
%   varargin: extra arguments for clustering
%       {repetitions_amount, max_iter} 
%
% OUTPUT:
%   optimal_microstates: N*K double matrix (N = #timeseries, K = #optimal amount of microstates) 
%
%%%


disp("Starting clustering...")

%Step 0: preprocessing
%absolute value for source data
if(strcmp(data_type, "source"))
    data = abs(data);
end
%average re-reference for sensor data
if(strcmp(data_type, "sensor"))
    data = data - mean(data,1);
end

%Step 1: get information from data object
[regions_amount, ~] = size(data);

%Step 2: build general object to store the data
global_explained_variance = zeros(microstates_amount_range,1);
dispersion = zeros(microstates_amount_range,1);
source_dispersion = zeros(microstates_amount_range,1);
microstates = zeros(regions_amount, microstates_amount_range, microstates_amount_range);

%Step 3: run clustering for different amounts of microstates
for microstates_amount = 2:microstates_amount_range
    disp(strcat("Testing ", num2str(microstates_amount), "/", num2str(microstates_amount_range), " number of clusters..."));

    %run clustering for certain microstates amount
    [microstates_k, global_explained_variance_k, labels_k] = Microstates_Clustering_Repetitions(data, microstates_amount, clustering_method, data_type, varargin{1});
    global_explained_variance(microstates_amount) = global_explained_variance_k;
    dispersion(microstates_amount) = Calculate_Dispersion(data, microstates_k, labels_k);
    microstates(:,1:microstates_amount,microstates_amount) = microstates_k;
end


global_explained_variance = global_explained_variance(2:end);
dispersion = dispersion(2:end);

optimal_microstates_amount = Calculate_KLnorm_criterion(data, dispersion, microstates_amount_range);
optimal_microstates = microstates(:,1:optimal_microstates_amount,optimal_microstates_amount);
optimal_global_explained_variance = global_explained_variance(optimal_microstates_amount);

fprintf("Optimal number of clusters: %d \n", optimal_microstates_amount);

end