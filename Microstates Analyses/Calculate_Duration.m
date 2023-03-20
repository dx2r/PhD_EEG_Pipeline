function [duration] = Calculate_Duration(data, labels, label_lengths, microstates, sample_freq)

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
duration = zeros(1,microstates_amount);
[~, timepoints_amount] = size(data);
seconds_amount = timepoints_amount ./ sample_freq;

for microstate_k = 1:microstates_amount
    duration(microstate_k) = nanmean(label_lengths(labels == microstate_k)) ./ sample_freq;
end

end