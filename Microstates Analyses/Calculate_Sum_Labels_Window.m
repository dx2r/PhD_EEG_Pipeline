function [sum_neighbouring_labels] = Calculate_Sum_Labels_Window(microstates, labels, window_length)

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

K = size(microstates, 2);
padding = zeros(1, window_length);
padded_labels = [padding labels padding];

sum_neighbouring_labels = zeros(K, length(padded_labels));

for i = window_length+1:length(padded_labels)-window_length
    for k = 1:K
        sum_neighbouring_labels(k,i) = sum(padded_labels(i-window_length:i+window_length) == k) - sum(padded_labels(i) == k);
    end
end

sum_neighbouring_labels = sum_neighbouring_labels(:, window_length+1:length(sum_neighbouring_labels)-window_length);

end