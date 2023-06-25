function[aal_timeseries] = Convert_USCB_To_AAL(uscb_timeseries)

%%%
% Function that converts data in the USCBrain atlas regions to data in the AAL atlas regions
% 
% Lore Flipts
%
% INPUT:
%   uscb_timeseries: N_B*M double matrix. (N_B = #timeseries_uscb, M = #timepoints) 
%
% OUTPUT:
%   uscb_timeseries: N_A*M double matrix. (N_A = #timeseries_aal, M = #timepoints)
%
%%%

no_of_aal_regions = 78;

[~, timepoints_amount] = size(uscb_timeseries);
aal_timeseries = zeros(no_of_aal_regions, timepoints_amount);

for timepoint_i = 1:timepoints_amount
    aal_timepoint = NaN(no_of_aal_regions, 1);
    uscb_timepoint = uscb_timeseries(:,timepoint_i);
    
    aal_timepoint = USCB_To_AAL(uscb_timepoint, aal_timepoint);
    aal_timeseries(:,timepoint_i) = aal_timepoint;
    
end

