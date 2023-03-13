function [microstates, labels, global_explained_variance] = Repetitions_Modified_K_Means(data, K, n_repetitions, max_iter)

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

global_explained_variance = 0;

for i = 1:n_repetitions
    [microstates_new, labels_new, new_global_explained_variance] = Modified_K_Means(data, K, max_iter);
    if new_global_explained_variance > global_explained_variance
        global_explained_variance = new_global_explained_variance;
        microstates = microstates_new;
        labels = labels_new;
        %MSE = MSE_new;
    end
end
end