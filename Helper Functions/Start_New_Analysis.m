function [] = Start_New_Analysis(original_file_name, original_file_location, new_file_name, new_file_location)

%%%
% 
% Function which copies a "General Processes file" to a new map with a new name. It also opens the newly created file.
%
% Gert Vanhollebek (09/05/2022 - 09/05/2022)
%
% INPUT: 
%   original_file_name : string or character array which contains the name of the General Proces file.
%   original_file_location : string or character array which contains the path to the original file
%   new_file_name : string or character array which contains the name for the new script
%   new_file_location : string or character array which contains the path to where the new file needs to be saved
%
% OUTPUT:
%
% example: Start_New_Analyis("General_Source_Level_Analysis.m",...
%                            "C:\Users\Gert\OneDrive - UGent\Documenten\GitHub\PhD_EEG_Pipeline\General Processes",...
%                            "Power - Beta1-ACC-PCC.m",...
%                            "C:\Users\Gert\OneDrive - UGent\Documenten\GitHub\PhD_EEG_Pipeline\Analysis files");
%
%%%

%Step 1: go to the location where the original file is located
cd(original_file_location);
%Step 2: copy the script to the new file location
copyfile(original_file_name,new_file_location);
%Step 3: rename script to new name
cd(new_file_location);
movefile(original_file_name, new_file_name);
%Step 4: open currently created script
open(new_file_name);
end