function [labels, spatial_correlation] = Segmentation(data, microstates)

%%%
% [1] M. M. Micah, M. De Lucia, D. Brunet, and C. M. Michel, ‘Principles of Topographic Analyses for Electrical Neuroimaging’, 
% in Brain Signal Analysis: Advances in Neuroelectric and Neuromagnetic Methods, 
% T. C. Handy, Ed. The MIT Press, 2009, p. 0. doi: 10.7551/mitpress/9780262013086.003.0002.

% Function that returns the timeseries from a brainstorm .mat object (source level analysis)
% 
% Gert Vanhollebeke (02/12/2021 - 02/12/2021)
%
% INPUT:
%   path_to_struct: string array containing the full path to the .mat object (generated by "Generate_Paths_All_Together.m")
%
% OUTPUT:
%   timeseries: N x M matrix containing the timeseries of the .mat object (N = #timeserie; M = #timepoints)
%
%%%

microstates_amount = size(microstates, 2);
[~, timepoints_amount] = size(data);

spatial_correlation = zeros(microstates_amount, timepoints_amount);
for k = 1:microstates_amount
    spatial_correlation(k,:) = Calculate_Spatial_Correlation(data, microstates(:,k));
end

[~, labels] = max(abs(spatial_correlation), [], 1);

end