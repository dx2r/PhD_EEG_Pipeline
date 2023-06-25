function [labels, spatial_correlation] = Microstates_Backfitting(data, microstates, data_type)

%%%
% Function that backfits the microstates to every timepoint by selecting
% the microstate that has the highest spatial correlation to that point
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints) 
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   data_type: string indicating the data type: "sensor" or "source"
%
% OUTPUT:
%   labels: 1*M double matrix (M = #timepoints) containing the labels for every time point
%   spatial_correlation: 1*M double matrix containing the spatial correlation for every time point
%%%

microstates_amount = size(microstates, 2);
[~, timepoints_amount] = size(data);

spatial_correlation = zeros(microstates_amount, timepoints_amount);
for k = 1:microstates_amount
    spatial_correlation(k,:) = Calculate_Spatial_Correlation(data, microstates(:,k), data_type);
end

[~, labels] = max(abs(spatial_correlation), [], 1); 


end