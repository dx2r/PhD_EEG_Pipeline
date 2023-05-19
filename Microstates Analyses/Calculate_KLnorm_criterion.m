function [optimal_microstates_amount, KLnorm] = Calculate_KLnorm_criterion(dispersions, maps, microstates_amount_range)

%%%

%%%
[~, amount_of_datapoints] = size(maps);

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

disp(dispersions);
disp(KLnorm);

[~, idx_max] = maxk(KLnorm,2);
optimal_microstates_amount = microstates_amount_range(idx_max(1));
if optimal_microstates_amount == 3
    optimal_microstates_amount = microstates_amount_range(idx_max(2));
end

%optimal_microstates_amount = 4;