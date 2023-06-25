function [optimal_microstates_amount, KLnorm] = Calculate_KL_criterion(data, dispersions, microstates_amount_range)

%%%
% Function that calculates the krzanowski lai criterion, based on formula
% from EEGlab 
%  A. T. Poulsen, A. Pedroni, N. Langer, and L. K. Hansen, “Microstate EEGlab toolbox: An
%  introductory guide," Mar. 2018, pages: 289850 Section: New Results. [Online]. Available: https://www.biorxiv.org/content/10.1101/289850v1
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

D = zeros(size(dispersions));
KL = zeros(size(dispersions));

for K = 2:length(D)
    D(K) = (K-1) ^ (2/amount_of_datapoints) * dispersions(K-1) - (K) ^ (2/amount_of_datapoints) * dispersions(K);
end

for K = 2:length(KL)-1
    if D(K-1) >= D(K)
        KL(K) = abs(D(K)/D(K+1));
    end
end
disp(dispersions);
disp(KL);

[~, idx_max] = max(KL);
optimal_microstates_amount = microstates_amount_range(idx_max);