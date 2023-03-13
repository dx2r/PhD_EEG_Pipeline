function [smoothed_labels] = Smoothing_Algorithm(microstates, labels, window)

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
padding = zeros(1, window);
padded_labels = [padding labels padding];

sum_neighbouring_labels = zeros(K, length(padded_labels));

for i = window+1:length(padded_labels)-window
    for k = 1:K
        sum_neighbouring_labels(k,i) = sum(padded_labels(i-window:i+window) == k);
    end
end

sum_neighbouring_labels = sum_neighbouring_labels(:, window+1:length(sum_neighbouring_labels)-window);
[~, smoothed_labels] = max(sum_neighbouring_labels, [], 1);

end