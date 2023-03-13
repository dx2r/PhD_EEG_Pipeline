function [data_at_gfp_peaks, indices_gfp_peaks] = Extract_GFP_Peaks(data, sample_freq, epoch_length)

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

%Step 0: get information from data object
[~, timepoints_amount] = size(data);
%Step 1: build general object to store the data at the gfp peaks
indices_gfp_peaks = [];

%Step 2: calculate for each epoch the corresponding values
epoch_timepoints = sample_freq*epoch_length;
epoch_amount = timepoints_amount/epoch_timepoints;
disp(strcat("Current participant: ", num2str(epoch_amount), " epochs..."));
for current_epoch = 1:epoch_amount
    current_data = data(:,(current_epoch - 1)*epoch_timepoints+1:current_epoch*epoch_timepoints);
    current_gfp = Calculate_Sensor_Global_Field_Power(current_data);
    current_gfp_peaks = Find_Global_Field_Power_Peaks(current_gfp);
    
    %Plot_Global_Field_Power(current_data, current_gfp, current_gfp_peaks);
    indices_gfp_peaks = [indices_gfp_peaks current_gfp_peaks + (current_epoch-1) * epoch_timepoints];
end

data_at_gfp_peaks = data(:, indices_gfp_peaks);

end

