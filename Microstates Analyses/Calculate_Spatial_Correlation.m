function [spatial_correlation] = Calculate_Spatial_Correlation(data, microstate, data_type)

%%%
% Function that calculates the spatial correlation between data points and
%   microstate map
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   microstate: N*1 double matrix 
%   data_type: string indicating the data type: "sensor" or "source"
%
% OUTPUT:
%   spatial_correlation: N*1 double matrix indicating the spatial
%       correlation for each data point with the microstate map
%
%%%

if data_type == "sensor"
    data = data - mean(data, 1);
    microstate = microstate - mean(microstate, 1);
end

norm_data = vecnorm(data, 2, 1);
norm_microstate = vecnorm(microstate, 2, 1);

spatial_correlation = sum(data .* microstate, 1) ./ (norm_data .* norm_microstate);

end