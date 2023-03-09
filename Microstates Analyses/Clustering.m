function [microstates, variance_explained] = Clustering(data, K, clustering_method, varargin)

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

if(strcmp(clustering_method, "k-means"))
    %tell what is going on
    disp("Regular k-means clustering is selected...");
    additional_info = varargin{1};
    microstates = K_Means(data, K, additional_info{1});
end


if(strcmp(clustering_method, "modified k-means"))
     %tell what is going on
    disp("Modified k-means clustering (Pascual-Marqui) is selected...");
    additional_info = varargin{1};
    [microstates, variance_explained] = Repetitions_Modified_K_Means(data, K, additional_info{1}, additional_info{2});
end

end