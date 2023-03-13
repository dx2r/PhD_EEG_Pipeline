function microstates = K_Means(data, K, max_iter)

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
end