function [transition_probabilities_flattened] = Calculate_Transition_Probabilities(data, labels, microstates)

%%%
% Function that ...
% 
% Lore Flipts
%
% INPUT:
%   
%
% OUTPUT:
%   
%
%%%
microstates_amount = size(microstates,2);
transition_probabilities = zeros(microstates_amount);
%[~, timepoints_amount] = size(data);
labels_k = labels(1:end-1);
labels_j = labels(2:end);
for microstate_k = 1:microstates_amount
    for microstate_j = 1:microstates_amount
        transition_probabilities(microstate_k, microstate_j) = sum((labels_k == microstate_k) & (labels_j == microstate_j));
    end
end

transition_probabilities = transition_probabilities ./ sum(transition_probabilities,2);
transition_probabilities_flattened = reshape(transition_probabilities, [1, microstates_amount * microstates_amount]);

end