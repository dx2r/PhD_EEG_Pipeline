%%%
%
% Script which makes a new sensor level analysis file for easy starting of a new analysis. 
%
% Gert Vanhollebeke (28/07/2022 - 28/07/2022)
%
%%%

%%%
% ADJUST HERE
%%%

    %give a name to the analysis you want to run, this name will be given to the new script file
    % example:
    %   new_analysis_name = "AEC - Beta3-ACC-PCC.m";
    
    new_analysis_name = "microstates.m";
    
    %give a location to where the new analysis file should be saved
    % example:
    %   new_analysis_location = "C:\Users\Gert\OneDrive - UGent\Study - EEGRUM\Analyses";
    
    new_analysis_location = "D:\UGent\Burgie\Jaar 4\Thesis\GitHub\PhD_EEG_Pipeline";

%%%
% DO NOT ADJUST UNLESS A FIRST INSTALL OF THE FILES IS DONE
%%%

    %name of the analysis file which you want to use for a new analysis
    % example:
    %   original_analysis_name = "General_Source_Level_Analysis.m";
    
    original_analysis_name = "General_Sensor_Level_Analysis.m";
    
    %location of the analysis file which you want to use for a new analysis
    % example:
    %   original_analysis_location = "C:\Users\Gert\OneDrive - UGent\Documenten\GitHub\PhD_EEG_Pipeline\General Processes";
    
    original_analysis_location = "D:\UGent\Burgie\Jaar 4\Thesis\GitHub\PhD_EEG_Pipeline\General Processes";

%%%
% RUN THE NECESSARY CODE
%%% 

    Start_New_Analysis(original_analysis_name,...
                       original_analysis_location,...
                       new_analysis_name,...
                       new_analysis_location);
