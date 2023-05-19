function [] = Plotting(data, microstates, sample_frequency, epoch_length, channel_info)

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

% Get EEG maps at GFP peaks
%[maps_at_gfp_peaks, ~] = Extract_GFP_Peaks(data, sample_frequency, epoch_length);
current_data = data(:,650:750);
gfp = Calculate_Sensor_Global_Field_Power(current_data);
gfp_peaks = Find_Global_Field_Power_Peaks(gfp);
Plot_Global_Field_Power(current_data, gfp, gfp_peaks, sample_frequency);

i = 12;
%Plot_Sensor_Topography(current_data(:,gfp_peaks(i)), channel_info, false);
%disp('peak')
%disp(gfp_peaks(i)/sample_frequency*1000);

% Backfitting
microstate_label_timeseries = Segmentation(data, microstates);
smoothened_microstate_label_timeseries = Temporal_Smoothing(microstates, microstate_label_timeseries, 3, sample_frequency, epoch_length);
disp(smoothened_microstate_label_timeseries(650:750));
% Calculate GEV
%[gev_tot, gev_k] = Calculate_Global_Explained_Variance(data, microstates, microstate_label_timeseries);
%gev_smooth = Calculate_Global_Explained_Variance(data, microstates, smoothened_microstate_label_timeseries);

end