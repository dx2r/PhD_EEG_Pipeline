function [list_to_files, list_of_names] = Generate_Paths_All_Together(path_to_dataset)

%%%
%
% Function which generates paths to all .mat objects (brainstorm format) in a dataset. 
% This iteration of the function "Generate_Paths_*.m" can be used for datasets where all .mat objects are in a single directory 
% and the name of the .mat file links the file to the participant and moment.
%
% Gert Vanhollebeke (02/12/2021 - 02/12/2021)
%
% INPUT:
%   path_to_dataset: char array containing the full path to where the dataset is located
%
% OUTPUT:
%   list_to_files: N x 1 string matrix containing the paths to each file in the dataset (N = #files in the dataset)
%   list_of_names: N x 1 string matrix containing the name of each file (N = #files in the dataset)
%       the names and paths are linked by their indices.
%
%%%

%Step 0: Tell what is going on
disp("Generating paths to files...");
%Step 1: Generate the directory information
dataset_directory = Natsortfiles(dir(path_to_dataset));
%Step 2: create the name list
list_to_files = "";
list_of_names = "";
for file_i = 3:size(dataset_directory,1)
    list_to_files(file_i - 2) = convertCharsToStrings(strcat(dataset_directory(file_i).folder,"\",dataset_directory(file_i).name));
    list_of_names(file_i - 2) = extractBefore(convertCharsToStrings(dataset_directory(file_i).name),".mat");
end
%transpose for easier use
list_to_files = list_to_files.';
list_of_names = list_of_names.';
end