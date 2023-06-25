function [total_global_explained_variance, individual_global_explained_variance] = Calculate_Global_Explained_Variance(data, microstates, labels, data_type)

%%%
% Function that calculates the global explained variance for a clustering
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   labels: N*1 double matrix indicating microstate labels
%   data_type: string indicating the data type: "sensor" or "source"
%
% OUTPUT:
%   total_global_explained_variance: double indicating total GEV
%   individual_global_explained_variance: 1*K double matrix indicating GEV
%       for each microstate cluster
%
%%%

microstates_amount = size(microstates,2);


global_field_power = Calculate_Global_Field_Power(data, data_type);

microstate_timeseries = microstates(:,labels);
individual_global_explained_variance = zeros(1,microstates_amount);

for label_k = 1:microstates_amount

    spatial_correlation_k = Calculate_Spatial_Correlation(data(:,labels==label_k), microstate_timeseries(:,labels==label_k), data_type);

    individual_global_explained_variance(label_k) = sum((global_field_power(labels==label_k) .* spatial_correlation_k).^2) / sum(global_field_power.^2);

end

total_global_explained_variance = sum(individual_global_explained_variance);