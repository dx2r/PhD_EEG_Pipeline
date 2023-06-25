function [transition_probabilities_flattened] = Calculate_Transition_Probabilities(data, encoded_labels, microstates)

%%%
% Function that calculates the transition probabilities between all pairs
% of microstates
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints) 
%   encoded_labels: P*1 double matrix indicating microstate segment labels (P = #segments)
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%
% OUTPUT:
%   transition_probabilities_flattened: 1*K^2 double matrix indicating the transition probabilities for each microstate
%
%%%

microstates_amount = size(microstates,2);
transition_probabilities = zeros(microstates_amount);
%[~, timepoints_amount] = size(data);
labels_k = encoded_labels(1:end-1);
labels_j = encoded_labels(2:end);
for microstate_k = 1:microstates_amount
    for microstate_j = 1:microstates_amount
        transition_probabilities(microstate_k, microstate_j) = sum((labels_k == microstate_k) & (labels_j == microstate_j));
    end
end

transition_probabilities = transition_probabilities ./ sum(transition_probabilities,2);

transition_probabilities_flattened = reshape(transition_probabilities', [1, microstates_amount * microstates_amount]);

end