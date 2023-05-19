function [dispersion] = Calculate_Source_Dispersion(data, microstates, labels)

%%%

%%%

K = size(microstates,2);

for k = 1:K
    idx_k = labels==k;
    distance_maps = sum((data(:,idx_k) - microstates(:,k)).^2, 1);

    cluster_dispersion(k) = sum(distance_maps);% ./ (2 * sum(idx_k));
end
dispersion = sum(cluster_dispersion);

end