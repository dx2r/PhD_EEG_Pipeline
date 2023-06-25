function [global_field_power] = Calculate_Global_Field_Power(data, data_type)

%%%
% Function that calculates the global field power for every time point
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints) 
%   data_type: string indicating the data type (sensor or source) 
%
% OUTPUT:
%   global_field_power: 1*M double matrix. (M = #timepoints)
%
%%%

[number_of_regions, ~] = size(data);
data_squared = data .^2;

if(strcmp(data_type, "sensor"))
    global_field_power = std(data, 0, 1);

elseif(strcmp(data_type, "source"))
    global_field_power = sqrt(1/(number_of_regions - 1) .* sum(data_squared,1));

else
    disp('The data type is invalid. Enter either sensor or source as data type.')
end

end