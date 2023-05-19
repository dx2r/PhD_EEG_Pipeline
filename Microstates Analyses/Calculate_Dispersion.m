function [dispersion] = Calculate_Dispersion(data, microstates, labels)

%%%

%%%

K = size(microstates,2);

cluster_dispersion = zeros(1,K);

for k = 1:K
    idx_k = labels==k;
    maps = data(:,idx_k)./ vecnorm(data(:, idx_k), 2, 1);

    distance_original_maps = sum((data(:,idx_k) - microstates(:,k)).^2, 1);
    distance_opposite_maps = sum((-data(:,idx_k) - microstates(:,k)).^2, 1);

    cluster_dispersion(k) = sum(min(distance_original_maps, distance_opposite_maps));% ./ (2 * sum(idx_k));

end

dispersion = sum(cluster_dispersion);