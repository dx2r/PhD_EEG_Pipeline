function [microstates, global_explained_variance, labels] = Microstates_Clustering_Repetitions(data, microstates_amount, clustering_method, data_type, varargin)

%%%
% Function that performs microstate clustering repetitions for the
% specified clustering method
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   microstates_amount: double indicating the amount of clusters/microstates
%   clustering_method: string indicating the method of clustering:
%       "k-means" or "modified k-means"
%   data_type: string indicating the data type: "sensor" or "source"
%   varargin: extra arguments for clustering
%       {repetitions_amount, max_iter}
%        
% OUTPUT:
%   microstates: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   global_explained variance: double indicating GEV at the end of clustering
%   labels: N*1 double matrix indicating microstate labels
%%%

global_explained_variance = 0;
additional_info = varargin{1};
repetitions_amount = additional_info{1};
max_iter = additional_info{2};

if(strcmp(clustering_method, "k-means"))
    disp("Regular k-means clustering is selected...");

    for repetition_i = 1:repetitions_amount
    disp(strcat("Starting repetition ", num2str(repetition_i), "/", num2str(repetitions_amount), " of clustering algorithm..."));
    [microstates_new, labels_new, global_explained_variance_new] = Microstates_Clustering_K_Means(data, microstates_amount, data_type, max_iter);
    if global_explained_variance_new > global_explained_variance
        global_explained_variance = global_explained_variance_new;
        microstates = microstates_new;
        labels = labels_new;
    end
    fprintf('GEV: %.4f \n \n', global_explained_variance_new);
    end
end


if(strcmp(clustering_method, "modified k-means"))
     %tell what is going on
    disp("Modified k-means clustering (Pascual-Marqui) is selected...");

    for repetition_i = 1:repetitions_amount
    disp(strcat("Starting repetition ", num2str(repetition_i), "/", num2str(repetitions_amount), " of clustering algorithm..."));
    [microstates_new, labels_new, global_explained_variance_new] = Microstates_Clustering_Modified_K_Means(data, microstates_amount, data_type, max_iter);
    if global_explained_variance_new > global_explained_variance
        global_explained_variance = global_explained_variance_new;
        microstates = microstates_new;
        labels = labels_new;
    end
    fprintf('GEV: %.4f \n \n', global_explained_variance_new);
    end
end



end