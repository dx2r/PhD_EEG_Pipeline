function [coverage] = Calculate_Coverage(data, labels, microstates)

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
microstates_amount = size(microstates,2);
coverage = zeros(1,microstates_amount);
[~, timepoints_amount] = size(data);

for microstate_k = 1:microstates_amount
    coverage(microstate_k) = sum((labels == microstate_k)) ./ timepoints_amount;
end

end