function [] = Convert_EDF_to_MATLAB(path_from, path_to, dataset_mapname, channel_order_mapname)

%%%
% 
% Function which convert .edf files to .mat files (2d arrays) 
% and computes a "channel_order" cell array which contains the names of each electrode
%
% INPUT: 
%   path_from: string/char array -> full path to the map where all .edf files are located
%   path_to: string/char array -> full path to where the dataset and channel order maps need to be created
%   dataset_mapname: string/charr array -> name for the map where all .mat files need to be saved to
%   channel_order_mapname: string/char array -> name for the map where the cell array containing the electrode names is stored
%
% OUTPUT: 
%   This function does not return anything, it generates two maps: 
%       "dataset_mapname" which contains all datafiles of the dataset
%       "channel_order_mapname" which contains the channel_order file
%
% Gert Vanhollebeke (03/01/2023)
%
%%%

%generate paths to every file in the map
all_paths = Generate_Paths_All_Together(path_from);
%build empty maps with specified names
cd(path_to);
mkdir(dataset_mapname);
mkdir(channel_order_mapname);
%loop over every file
for file_i = 1:size(all_paths,1) %loop over every file
    %Extract data
    [header, data] = edfread(all_paths(file_i));
    %%%
    % HEADER
    %%%
    %from the header, extract the "label" variable, this contains the name of each electrode
    current_label = header.label;
    %delete the last entry in the label, this is the "EDFAnnotations" label and is of no interest
    current_label(end) = []; 
    %save the label (only if it is the first file), otherwise check if the label conforms to the first label
    if(file_i == 1)
        %goto map
        cd(strcat(path_to, '\', channel_order_mapname));
        %rename label
        label_order = current_label; 
        %save label
        save("Channel_Order.mat",'label_order');
        %build variable to compare future recordings with
        general_label_order = label_order; 
    else
        if(isequal(current_label, general_label_order))
            %do nothing, label is correct
        else
            %get name of current file and print out
            current_name = extractAfter(all_paths(file_i),strcat(path_from,"\"));
            current_name = extractBefore(current_name,".edf");
            disp(current_name);
            %throw exception
            throw("Current label order is different than original label order, check what is wrong.");
        end
    end
    %%%
    % DATA
    %%%
    %delete last row of data, this is the "EDFAnnotations" line, which is of no interest
    data(end,:) = [];
    %get the name of the current datafile
    current_name = extractAfter(all_paths(file_i),strcat(path_from,"\"));
    current_name = extractBefore(current_name,".edf");
    %save the datafile
    %go to location
    cd(strcat(path_to,'\',dataset_mapname));
    %save file
    save(current_name,'data');
end
end