function [scaled_data] = Min_Max_Scaling(data, lower_limit, upper_limit)

%%%
% 
% Function which scales the data (in "data") to the range [lower_limit, upper_limit]
% Formula: x' = lower_limit + ((x - min(data))(upper_limit - lower_limit))/(max(data) - min(data))
%
% INPUT:
%   data: 1 x N integer/double array -> data which needs to be rescaled
%   lower_limit: integer/double -> lower limit to which the data needs to be rescaled
%   upper_limit: integer/double -> upper limit to which the data needs to be rescaled
%
% OUTPUT:
%   scaled_data: 1 x N integer/double array -> rescaled data
% 
% Gert Vanhollebeke (30/01/2023)
%
%%%

%use built-in function "rescale"
scaled_data = rescale(data, lower_limit, upper_limit);
end