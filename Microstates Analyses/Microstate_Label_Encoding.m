function [encoded_labels, encoded_label_lengths] = Microstate_Label_Encoding(labels, sample_freq, epoch_length)

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
[~, timepoints_amount] = size(labels);

%Step 1: build general object to store the data at the gfp peaks
encoded_labels = [];
encoded_label_lengths = [];

%Step 2: calculate for each epoch the corresponding values
epoch_timepoints = sample_freq*epoch_length;
epoch_amount = timepoints_amount/epoch_timepoints;
%disp(strcat("Current participant: ", num2str(epoch_amount), " epochs..."));
for current_epoch = 1:epoch_amount
    current_labels = labels((current_epoch - 1)*epoch_timepoints+1:current_epoch*epoch_timepoints);
    [current_encoded_labels, current_encoded_label_lengths] = Run_Length_Encoding(current_labels);
    encoded_labels = [encoded_labels current_encoded_labels];
    encoded_label_lengths = [encoded_label_lengths current_encoded_label_lengths];
end

end