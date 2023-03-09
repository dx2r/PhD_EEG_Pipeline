function [indices_gfp_peaks] = Extract_GFP_Peaks_Indices(data, sample_freq, epoch_length)

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
[timeseries_amount, timepoints_amount] = size(data);
%Step 1: build general object to store the data at the gfp peaks
data_at_gfp_peaks = [];
indices_gfp_peaks = [];
%Step 2: calculate for each epoch the corresponding values
timepoints_epoch_amount = sample_freq*epoch_length;
epoch_amount = timepoints_amount/timepoints_epoch_amount;
disp(strcat("Current participant: ", num2str(epoch_amount), " epochs..."));
for current_epoch = 1:epoch_amount
    disp(strcat("Epoch ", num2str(current_epoch),"..."));
    %current_data = data(:,(current_epoch - 1) + 1:(current_epoch - 1) + (epoch_length*sample_freq));
    current_data = data(:,(current_epoch - 1)*timepoints_epoch_amount+1:current_epoch*timepoints_epoch_amount);
    current_gfp = Calculate_Sensor_Global_Field_Power(current_data);
    current_gfp_peaks = Find_Global_Field_Power_Peaks(current_gfp);
    
    %Plot_Global_Field_Power(current_data, current_gfp, current_gfp_peaks);
    current_data_at_gfp_peaks = current_data(:,current_gfp_peaks);
    data_at_gfp_peaks = [data_at_gfp_peaks current_data_at_gfp_peaks];
    indices_gfp_peaks = [indices_gfp_peaks current_gfp_peaks + (current_epoch-1) * timepoints_epoch_amount];
end

data_at_gfp_indices = data(:, indices_gfp_peaks);

end

