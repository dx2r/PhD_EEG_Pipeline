function [maps_at_gfp_peaks, indices_gfp_peaks] = Extract_Global_Field_Power_Peak_Maps(data, sample_freq, epoch_length, data_type)

%%%
% Function which extracts topography/source maps at the peaks of the global
% field power
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints) 
%   sample_freq: double indicating the sample frequency (Hz)
%   epoch_length: double indicating the epoch length (s)
%   data_type: string indicating the data type (sensor or source)
%
% OUTPUT:
%   maps_at_gfp_peaks: N*P double matrix containing the maps at peaks of
%       the global field power (N = #timeseries, P = #gfp peaks) 
%   indices_gfp_peaks: 1*P double matrix containing the indices of global
%       field power peaks
%
%%%


%Step 0: get information from data object
[~, timepoints_amount] = size(data);
%Step 1: build general object to store the data at the gfp peaks
indices_gfp_peaks = [];

%Step 2: calculate for each epoch the corresponding values
epoch_timepoints = sample_freq*epoch_length;
epoch_amount = timepoints_amount/epoch_timepoints;
%disp(strcat("Current participant: ", num2str(epoch_amount), " epochs..."));
for current_epoch = 1:epoch_amount
    current_data = data(:,(current_epoch - 1)*epoch_timepoints+1:current_epoch*epoch_timepoints);

    %calculate global field power for current data
    current_gfp = Calculate_Global_Field_Power(current_data, data_type);
    %extract indices of gfp peaks for current data
    current_gfp_peaks = Extract_Global_Field_Power_Peaks(current_gfp);
    %concatenate all gfp peak indices
    indices_gfp_peaks = [indices_gfp_peaks current_gfp_peaks + (current_epoch-1) * epoch_timepoints];
end

%extract all maps at gfp peak indices
maps_at_gfp_peaks = data(:, indices_gfp_peaks);

end

