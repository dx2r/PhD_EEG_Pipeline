function [microstates, variance_explained] = Repetitions_Modified_K_Means(data, K, n_repetitions, max_iter)

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

variance_explained = 0;

for i = 1:n_repetitions
    [microstates_new, variance_explained_new] = Modified_K_Means(data, K, max_iter);
    disp(i);
    disp(variance_explained_new);
    if variance_explained_new > variance_explained
        variance_explained = variance_explained_new;
        microstates = microstates_new;
        %MSE = MSE_new;
    end
end
disp(variance_explained);
end