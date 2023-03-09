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

[~, microstates] = kmeans(transpose(data), K, display='iter', MaxIter=max_iter);
microstates = microstates';
end