function [] = Convert_Brainstorm_Scoutfiles_To_MAT(path_from, path_to)

%%%
% 
% Function which convert the scout_files generate by Brainstorm (from the "extract scout time series" function)
% and converts them to a 2d array, with the row structure the same as in the "Check_Brainregions.m" function.
%
% INPUT: 
%   path_from: char/string array -> full path to the map which contains the folders of all data
%   path_to: char/string array -> full path to the map where the 2D .mat files need to be saved
%
% OUTPUT:
%   nothing, this function generates .mat files
%
% Gert Vanhollebeke (10/01/2023)
%
%%%

%generate all paths in the map
all_paths = Generate_Paths_All_Together(path_from);
%delete first two path, these are the "@default_study" and the "@intra" map, which do not contain data
all_paths(1:2) = [];
%get names of all brain regions
brainregion_names = Check_Brainregions;
brainregion_names = brainregion_names.Region_Name;
%for loop to go through all folders
for map_i = 1:size(all_paths,1)
    %generate all paths within the folder
    current_files = Generate_Paths_All_Together(all_paths(map_i));
    %use toggle to see if it is the first 
    toggle = 0;
    %loop over files, only work with files which contain "matrix_scout"
    for file_i = 1:size(current_files,1)
        if(contains(current_files(file_i), "matrix_scout"))
            %matrix scout file, work with this
            %load file
            current_scout_file = load(current_files(file_i));
            %check if it is the first file
            if(toggle == 0)
                %set toggle to 1, so this code is ran only once
                toggle = 1;
                %build empty dataframe with correct size
                all_data = zeros(130, size(current_scout_file.Value,2));
            end
            %get data from scout file
            current_data = current_scout_file.Value;
            %get brainregion names
            current_brainregions = extractBefore(current_scout_file.Description, " @ ");
            %loop over every brainregion name, and get the index of it from the "brainregion_names" array
            for region_i = 1:size(current_brainregions,1)
                index = find(brainregion_names == current_brainregions(region_i));
                %fill data in correct row of the final data array
                all_data(index,:) = current_data(region_i,:);
            end
        else
            %do nothing          
        end
    end
    %get name of the current folder
    current_name = extractAfter(all_paths(map_i),strcat(path_from,"\"));
    %go to the path_to folder
    cd(path_to);
    %save data
    save(current_name,'all_data');
end
disp("Done converting...");
end