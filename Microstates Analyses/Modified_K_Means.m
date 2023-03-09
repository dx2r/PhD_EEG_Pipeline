function [microstates, variance_explained] = Modified_K_Means(data, K, max_iter)

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

% Initialization
[channels, samples] = size(data);
squared_sum_data = sum(data.^2, 'all');
variance_data = squared_sum_data / (samples * (channels - 1));

initial_map_indices = randperm(samples, K);
microstates = data(:, initial_map_indices);
microstates = microstates ./ vecnorm(microstates, 2, 1); % normalize

%iter = 0;
variance_microstates = 0;
convergence_criterium = 1e-6;

for iter = 1:max_iter
    old_variance_microstates = variance_microstates;
    activations = (microstates' * data);
    [~, labels] = max(activations.^2); 
    for k = 1:K
        data_microstate_k = data(:, labels==k);
        S_k = data_microstate_k * data_microstate_k';
        [eigenvectors,eigenvalues] = eig(S_k,'vector');
        [~, idx_max_eigenvalue] = max(abs(eigenvalues));
        microstates(:, k) = eigenvectors(:,idx_max_eigenvalue);
        microstates(:, k) = microstates(:, k) ./ vecnorm(microstates(:, k), 2, 1);
    end
    variance_microstates = (squared_sum_data - sum(sum(microstates(:,labels).*data).^2)) / (samples * (channels - 1));
    if abs(variance_microstates - old_variance_microstates) <= convergence_criterium * variance_microstates
        disp(iter);
        break
    end
end

variance_explained = 1 - variance_microstates/variance_data;
activations_all_states = (microstates' * data);

[~, labels] = max(activations_all_states.^2);
activations = zeros(size(activations_all_states));
for n = 1:length(labels)
    activations(labels(n),n) = activations_all_states(labels(n),n);
end

%MSE = mean(mean((data - microstates * activations).^2));

end