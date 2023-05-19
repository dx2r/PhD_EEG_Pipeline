function [microstates, global_explained_variance, labels] = K_Means(data, K, data_type, max_iter)

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

[~, microstates] = kmeans(data', K, MaxIter=max_iter);
microstates = microstates';

activations_all_states = (microstates' * data);
[~, labels] = max(activations_all_states.^2);

global_explained_variance = Calculate_Global_Explained_Variance(data, microstates, labels, data_type);

end