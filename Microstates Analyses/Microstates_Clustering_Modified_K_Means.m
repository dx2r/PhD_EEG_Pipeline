function [microstates, labels, global_explained_variance] = Microstates_Clustering_Modified_K_Means(data, microstates_amount, data_type, max_iter)

%%%
% Function that performs modified k-means clustering based on the algorithm described by Pascual-Marqui in : 
% Pascual-Marqui RD, Michel CM, Lehmann D. Segmentation of brain electrical activity into microstates: model estimation and validation. 
%   IEEE Trans Biomed Eng. 1995 Jul;42(7):658-65. doi: 10.1109/10.391164. PMID: 7622149.
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   microstates_amount: double indicating the amount of clusters/microstates
%   data_type: string indicating the data type: "sensor" or "source"
%   max_iter: maximum amount of iterations before stopping the algorithm
%
% OUTPUT:
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   global_explained variance: double indicating GEV at the end of clustering
%   labels: N*1 double matrix indicating microstate labels
%
%%%

% Initialization
convergence_criterium = 1e-6;
global_explained_variance = 0;

% Choose K maps as initial microstate centroids
initial_map_indices = randperm(size(data,2), microstates_amount);
microstates = data(:, initial_map_indices);
microstates = microstates ./ vecnorm(microstates, 2, 1); % normalize


% Start iteration scheme
for iter = 1:max_iter

    old_global_explained_variance = global_explained_variance;

    % Calculate how well maps and microstates align (= activation) and label accordingly
    activations = (microstates' * data);
    [~, labels] = max(activations.^2); 
    
    % Calculate new centroids
    for microstate_k = 1:microstates_amount
        data_microstate_k = data(:, labels==microstate_k);
        S_k = data_microstate_k * data_microstate_k';
        [eigenvectors,eigenvalues] = eig(S_k,'vector');
        [~, idx_max_eigenvalue] = max(abs(eigenvalues));
        microstates(:, microstate_k) = eigenvectors(:,idx_max_eigenvalue);
        microstates(:, microstate_k) = microstates(:, microstate_k) ./ vecnorm(microstates(:, microstate_k), 2, 1); % normalize microstates
    end

    % Calculate new GEV
    global_explained_variance = Calculate_Global_Explained_Variance(data, microstates, labels, data_type);
    
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
activations_all_states = (microstates' * data);
[~, labels] = max(activations_all_states.^2);

% Create activation vector
activations = zeros(size(activations_all_states));
for n = 1:length(labels)
    activations(labels(n),n) = activations_all_states(labels(n),n);
end

end