function [optimal_microstates_amount, KLnorm] = Calculate_KLnorm_criterion(data, dispersions, microstates_amount_range)

%%%
% Function that calculates the cluster dispersion, which is a measure of
% the quality of the clustering
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   dispersions: 1*K double matrix (K = #maximum amount of clusters - 1)
%   microstates_amount_range: double indicating the maximum amount of
%       clusters to test (e.g. 10)
%
% OUTPUT:
%   optimal_microstates_amount: double indicating the amount that coincides
%       with the maximum KLnorm (after 3)
%   KLnorm: double indicating the value of the normalized krzanowski-lai criterion
%%%

[~, amount_of_datapoints] = size(data);
microstates_amount_range = 2:microstates_amount_range;

D = zeros(size(dispersions));
KLnorm = zeros(size(dispersions));

for K = 1:length(D)-1
    D(K) = K ^ (2/amount_of_datapoints) * dispersions(K) - (K + 1) ^ (2/amount_of_datapoints) * dispersions(K+1);
end

for K = 2:length(KLnorm)-1
    if D(K-1) >= 0 && D(K-1) >= D(K)
        KLnorm(K) = (D(K-1) - D(K)) / ((K-1)^(2/amount_of_datapoints) * dispersions(K-1));
    end
end

[~, idx_max] = maxk(KLnorm,2);
optimal_microstates_amount = microstates_amount_range(idx_max(1));
if optimal_microstates_amount == 3
    optimal_microstates_amount = microstates_amount_range(idx_max(2));
end

end