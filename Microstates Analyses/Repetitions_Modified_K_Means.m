function [microstates, global_explained_variance, labels] = Repetitions_Modified_K_Means(data, K, data_type, n_repetitions, max_iter)

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

for repetition_i = 1:n_repetitions
    disp(strcat("Starting repetition ", num2str(repetition_i), "/", num2str(n_repetitions), " of modified k-means algorithm..."));
    [microstates_new, labels_new, global_explained_variance_new] = Modified_K_Means(data, K, data_type, max_iter);
    if global_explained_variance_new > global_explained_variance
        global_explained_variance = global_explained_variance_new;
        microstates = microstates_new;
        labels = labels_new;
    end
    fprintf('GEV: %.4f \n \n', global_explained_variance_new);
end
end