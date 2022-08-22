function [source_timeseries] = Transform_Brainstorm_To_Source_Analysis(link_to_brainstorm_files, link_to_new_map)

%%%
%
% Function which converts the files generated from brainstorm (using the extract scout time series function) into the files needed
% to start a "General_Source_Level_Analysis".
% 
% note: this function uses the following functions:
%   Generate_Paths_All_Together.m
%   Check_Brainregions.m
%
% Gert Vanhollebeke (10/08/2022 - 10/08/2022)
%
% INPUT:
%   link_to_brainstorm_files: char/string array containing the path to the folder where all brainstorm files are located. (the title of the files is reused)
%   link_to_new_map: char/string array containing the path to the folder where all brainstorm files are located
%
% OUTPUT:
%
%%%

%step 0: tell what is going on
disp('Transforming Brainstorm Objects to Sourcelevel Analysis Prepared Files...');
%step 1: loop over all files and check if the allignment of regions is correct, if so, save just the Value object
brainstorm_files_path = Generate_Paths_All_Together(link_to_brainstorm_files); %generate paths
cd(link_to_new_map); %go to the new map, for saving of the new files
for file_i = 1:size(brainstorm_files_path,1) %loop over all files
    %load current file
    current_file = Extract_Object_From_Structure(brainstorm_files_path(file_i));
    %get current name
    current_name = erase(brainstorm_files_path(file_i),strcat(link_to_brainstorm_files,"\")); %delete complete path part
    current_name = extractBefore(current_name,"."); %delete .mat extension
    current_timeseries = current_file.Value; %extract the timeseries
    current_description = current_file.Description;
    %compare the description (cleaned) with the results of the Check_Brainregions function. These should be the same order for the source level analysis to work correctly.
    current_description = extractBefore(current_description," @");
    brainregion_order = Check_Brainregions();
    brainregion_order = cellstr(brainregion_order.Region_Name);
    if(isequal(current_description, brainregion_order))
        disp('allignment correct...');
        source_timeseries = current_timeseries; %rename for self-made convention
        save(strcat(current_name,'.mat'),'source_timeseries');
    else
        error('allignment is not correct, no function is written for this ( sorry ;) ). Contact Gert Vanhollebeke if you cannot figure is out');
    end
    clear source_timeseries;
end



















end