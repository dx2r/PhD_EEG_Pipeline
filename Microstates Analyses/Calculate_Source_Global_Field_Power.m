function [gfp_values] = Calculate_Source_Global_Field_Power(data)

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
[number_of_regions, ~] = size(data);
data_squared = data .^2;
gfp_values = sqrt(1/(number_of_regions - 1) .* sum(data_squared,1));

end