function [coverage] = Calculate_Coverage(data, labels, microstates)

%%%
% Function that calculates the coverage for each microstate
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints) 
%   labels: N*1 double matrix indicating microstate labels
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%
% OUTPUT:
%   coverage: 1*K double matrix indicating the coverage for each microstate
%
%%%
microstates_amount = size(microstates,2);
coverage = zeros(1,microstates_amount);
[~, timepoints_amount] = size(data);

for microstate_k = 1:microstates_amount
    coverage(microstate_k) = sum((labels == microstate_k)) ./ timepoints_amount;
end

end