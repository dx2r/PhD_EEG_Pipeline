function [gev_tot, gev_k] = Calculate_Global_Explained_Variance(data, microstates, labels, data_type)

%%%
% [1] M. M. Micah, M. De Lucia, D. Brunet, and C. M. Michel, ‘Principles of Topographic Analyses for Electrical Neuroimaging’, 
% in Brain Signal Analysis: Advances in Neuroelectric and Neuromagnetic Methods, 
% T. C. Handy, Ed. The MIT Press, 2009, p. 0. doi: 10.7551/mitpress/9780262013086.003.0002.


%%%

K = size(microstates,2);

if(strcmp(data_type, "sensor"))
    gfp = Calculate_Sensor_Global_Field_Power(data);
elseif(strcmp(data_type, "source"))
    gfp = Calculate_Source_Global_Field_Power(data);
else
    disp('The data type is invalid. Enter either sensor or source as data type.')
end


segmentation = microstates(:,labels);
gev_k = zeros(1,K);

for k = 1:K
    idx_k = labels==k;

    spatial_correlation_k = Calculate_Spatial_Correlation(data(:,idx_k), segmentation(:,idx_k), data_type);

    gev_k(k) = sum((gfp(idx_k) .* spatial_correlation_k).^2) / sum(gfp.^2);

end

gev_tot = sum(gev_k);