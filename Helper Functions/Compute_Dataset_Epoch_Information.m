function [epoch_table] = Compute_Dataset_Epoch_Information(path, sample_freq, epoch_length)

%%%
%
% Function which returns a table containing how many epochs each file in a dataset has
%
% INPUT:
%   path: string/character array -> full path to the map where the dataset is contained
%   sample_freq: integer -> sampling frequency (Hz)
%   epoch_length: double -> length of each epoch (seconds)
%
% OUTPUT:
%   epoch_table: table -> table containg two columns: name (name of each recording) & epoch_amount (amount of epochs in each recording)
%%%

%get paths to all files
all_paths = Generate_Paths_All_Together(path);
%create empty table of certain size
name = strings(size(all_paths,1),1);
epoch_amount = zeros(size(all_paths,1),1);
for file_i = 1:size(all_paths,1)
    %load file
    current_file = Extract_Object_From_Structure(all_paths(file_i));
    %extract name
    current_name = extractAfter(all_paths(file_i), strcat(path,"\"));
    current_name = extractBefore(current_name,".mat");
    %extract epoch amount
    current_epoch_amount = size(current_file,2)/(sample_freq*epoch_length);
    %save data
    name(file_i,1) = current_name;
    epoch_amount(file_i,1) = current_epoch_amount;  
end
%build table
epoch_table = table(name, epoch_amount);
disp("Epoch Table Built...");
end