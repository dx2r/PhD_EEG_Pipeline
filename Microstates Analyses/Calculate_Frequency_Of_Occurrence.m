function [freq_of_occurrence] = Calculate_Frequency_Of_Occurrence(data, labels, microstates, sample_freq)

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
K = size(microstates,2);
freq_of_occurrence = zeros(1,K);
[~, timepoints_amount] = size(data);
seconds_amount = timepoints_amount ./ sample_freq;

for k = 1:K
    freq_of_occurrence(k) = sum((labels == k)) ./ seconds_amount;
end

end