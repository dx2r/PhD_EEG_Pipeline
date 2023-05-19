function[aal_timeseries] = Convert_To_AAL(uscb_timeseries)

%%%
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

