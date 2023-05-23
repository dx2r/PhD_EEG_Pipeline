function [labels, spatial_correlation] = Backfitting(data, microstates, data_type)

%%%

% Function that returns the timeseries from a brainstorm .mat object (source level analysis)
% 

%%%

microstates_amount = size(microstates, 2);
[~, timepoints_amount] = size(data);

spatial_correlation = zeros(microstates_amount, timepoints_amount);
for k = 1:microstates_amount
    spatial_correlation(k,:) = Calculate_Spatial_Correlation(data, microstates(:,k), data_type);
end

[~, labels] = max(abs(spatial_correlation), [], 1); 

%per epoch
% midpoints_between_peak_indices = zeros(1,length(peak_indices)+1);
% [peak_maps peak_indices] = Extract_GFP_peaks();
% midpoints_between_peak_indices(2:end-1) = diff(peak_indices)./2 + peak_indices(1:end-1);
% midpoints_between_peak_indices(end) = peak_indices(end);
% 
% peak_labels = Backfitting(peak_maps, microstates, data_type);
% 
% for n = 1:length(peak_indices)
%     label(midpoints_between_peak_indices(n)+1:midpoints_between_peak_indices(n+1)) = peak_labels(n);
% end


% current_data = data(:,11000:11200);
% 
% time = linspace(1,length(current_data)/200*1000, length(current_data));
% 
% newcolors = [0.9882    0.5608    0.0392; 0.8392    0.0745    0.0745; 0.3922    0.8314    0.0745; 0    0.4471    0.7412];
% 
% figure;
% 
% for k = 1:microstates_amount
%     plot(time, (spatial_correlation(k,11000:11200)).^2, LineWidth=2);
%     xlim([125,550]);
%     colororder(newcolors)
%     xlabel('Time (ms)', FontSize=14)
%     ylabel('|Spatial Correlation|', FontSize=14)
%     hold on
% end
% 
% lgd = legend('Microstate 1', 'Microstate 2', 'Microstate 3', 'Microstate 4');
% lgd.FontSize = 14;
end