function [spatial_correlation] = Calculate_Spatial_Correlation(eeg_map, microstate_map, data_type)

%%%


% Function
% 

%
%%%

if data_type == "sensor"
    eeg_map = eeg_map - mean(eeg_map, 1);
    microstate_map = microstate_map - mean(microstate_map, 1);
end

norm_eeg_map = vecnorm(eeg_map, 2, 1);
norm_microstate_map = vecnorm(microstate_map, 2, 1);

spatial_correlation = sum(eeg_map .* microstate_map, 1) ./ (norm_eeg_map .* norm_microstate_map);

end