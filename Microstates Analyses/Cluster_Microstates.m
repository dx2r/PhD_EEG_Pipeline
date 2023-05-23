function [optimal_microstates, optimal_microstates_amount] = Cluster_Microstates(maps, microstates_amount, clustering_method, data_type, varargin)

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


% Perform clustering (k-means or modified k-means)
disp("Starting clustering...")

% % Absolute value for source data
% if(strcmp(data_type, "source"))
%     maps = abs(maps)./ vecnorm(maps, 2, 1);
% end

% Absolute value for source data
if(strcmp(data_type, "source"))
    maps = abs(maps);
end

% Average re-reference data
if(strcmp(data_type, "sensor"))
    maps = maps - mean(maps,1);
end

gev = zeros(microstates_amount,1);
dispersion = zeros(microstates_amount,1);
source_dispersion = zeros(microstates_amount,1);
[regions_amount, ~] = size(maps);
microstates = zeros(regions_amount, microstates_amount, microstates_amount);

for k = 7%2:microstates_amount
    disp(strcat("Testing ", num2str(k), "/", num2str(microstates_amount), " number of clusters..."));
    [microstates_k, gev_k, labels_k] = Clustering(maps, k, clustering_method, data_type, varargin{1});
    gev(k) = gev_k;
    dispersion(k) = Calculate_Dispersion(maps, microstates_k, labels_k);
    source_dispersion(k) = Calculate_Source_Dispersion(maps, microstates_k, labels_k);
    microstates(:,1:k,k) = microstates_k;
end

microstates_amount_range = 2:microstates_amount;
gev = gev(2:end);
dispersion = dispersion(2:end);
%save("dispersion_d2.mat", "dispersion")

optimal_microstates_amount = 7;
%[optimal_microstates_amount, klnorm] = Calculate_KLnorm_criterion(dispersion, maps, microstates_amount_range);
%save("klnorm_d2.mat", "klnorm")

%optimal_microstates_amount = Kneedle_Algorithm(gev, microstates_amount_range, microstates_amount_range) ;
optimal_microstates = microstates(:,1:optimal_microstates_amount,optimal_microstates_amount);
optimal_gev = gev(optimal_microstates_amount);

fprintf("Optimal number of clusters: %d \n", optimal_microstates_amount);

end