function [optimal_microstates_amount, KLnorm] = Calculate_KL_criterion(dispersions, maps, microstates_amount_range)

%%%

%%%
[~, amount_of_datapoints] = size(maps);

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