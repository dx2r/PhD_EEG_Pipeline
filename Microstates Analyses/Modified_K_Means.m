function [microstates, labels, global_explained_variance] = Modified_K_Means(maps, number_of_clusters_K, data_type, max_iter)

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
convergence_criterium = 1e-6;
global_explained_variance = 0;

% Choose K maps as initial microstate centroids
initial_map_indices = randperm(samples, number_of_clusters_K);
microstates = maps(:, initial_map_indices);
microstates = microstates ./ vecnorm(microstates, 2, 1); % normalize


% Start iteration scheme
for iter = 1:max_iter

    old_global_explained_variance = global_explained_variance;

    % Calculate how well maps and microstates align (= activation) and
    % label accordingly
    activations = (microstates' * maps);
    [~, labels] = max(activations.^2); 
    
    % Calculate new centroids
    for k = 1:number_of_clusters_Ks
        data_microstate_k = maps(:, labels==k);
        S_k = data_microstate_k * data_microstate_k';
        [eigenvectors,eigenvalues] = eig(S_k,'vector');
        [~, idx_max_eigenvalue] = max(abs(eigenvalues));
        microstates(:, k) = eigenvectors(:,idx_max_eigenvalue);
        microstates(:, k) = microstates(:, k) ./ vecnorm(microstates(:, k), 2, 1); % normalize microstates
    end

    % Calculate new GEV
    global_explained_variance = Calculate_Global_Explained_Variance(maps, microstates, labels, data_type);
    
    % Check convergence
    if abs(global_explained_variance - old_global_explained_variance) <= convergence_criterium * global_explained_variance
        convergence_iter = iter;
        disp(strcat("Convergence of modified k-means in ", num2str(convergence_iter), "/", num2str(max_iter), " iterations"));
        break
    end
end

% Absolute value for source data
if(strcmp(data_type, "source"))
    microstates = abs(microstates);
end

% Calculate final labels
activations_all_states = (microstates' * maps);
[~, labels] = max(activations_all_states.^2);

% Create activation vector
activations = zeros(size(activations_all_states));
for n = 1:length(labels)
    activations(labels(n),n) = activations_all_states(labels(n),n);
end

end