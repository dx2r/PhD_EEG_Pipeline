function [statistical_table] = Build_Statistical_Table(path_to_result_files, result_map, analysis_type, brainregion_amount, brainregion_names)

%%%
%
% Function which builds the statistical table for the further statistical analyses.
%
% Gert Vanhollebeke (05/05/2022 - )
% 
% INPUT: 
%   paths_to_result_files: N*1 string array which contains the paths to all individual result files (obtained from "Generate_Paths_All_Together.m"
%   result_map_name: string which contains the map name where the current results are 
%   analysis_type: string containing the analysis type which has been chosen
%   brainregion_amount: integer indicating how many brain regions were included in the current analysis
%
% OUTPUT:
%   statistical_table: Table object which contains the information needed for the statistical analysis
%
%%%

%tell what is going on
disp("Building Statistical Table...");
%Step 1: check which analysis has been done

%%%
% AVERAGE RELATIVE POWER SPECIFIC
%%%

if(strcmp(analysis_type,"average_relative_power_specific"))
    %tell what is going on
    disp("Analysis Type: Average Relative Power Of A Specific Frequency Range...");
    %build an empty array for all results
    result_table = zeros(size(path_to_result_files,1), brainregion_amount);
    %build empty cell array for the participant names
    participant_names = cell([size(path_to_result_files,1),1]);
    %build the variablenames cell array for the final table
    column_names = cell(1,brainregion_amount + 1);
    column_names(1,1) = cellstr("Participant_Name");
    column_names(1,2:end) = cellstr(brainregion_names);
    %loop over all results
    for result_i = 1:size(path_to_result_files,1)
        %get current result
        current_result = Extract_Object_From_Structure(path_to_result_files(result_i));
        %extract name from path file
        current_name = extractAfter(path_to_result_files(result_i),result_map);
        current_name = extractBetween(current_name,"\",".mat");
        %put name and result in corresponding array
        participant_names(result_i,1) = cellstr(current_name);
        result_table(result_i,:) = current_result;
    end
    %built final table
    result_table = num2cell(result_table); %double array to cell array
    statistical_table = [participant_names, result_table]; %combine both cell arrays
    statistical_table = cell2table(statistical_table); %convert cell array to table
    statistical_table.Properties.VariableNames = column_names; %add names to the table          
end

%%%
% AMPLITUDE ENVELOPE CORRELATION
%%%

if(strcmp(analysis_type,"amplitude_envelope_correlation"))
    %tell what is going on
    disp("Analysis Type: Amplitude Envelope Correlation...");
    %build an empty array for all results
    result_table = zeros(size(path_to_result_files,1), (brainregion_amount*(brainregion_amount-1))/2 );
    %build empty cell array for the participant names
    participant_names = cell([size(path_to_result_files,1),1]);
    %build the variablenames cell array for the final table
    column_names = cell(1,1 + (brainregion_amount*(brainregion_amount-1))/2);
    column_names(1,1) = cellstr("Participant_Name");
    column_names(1,2:end) = Convert_Brainregion_Names_To_FC_Compatible(brainregion_names,"undirectional");
    %loop over all results
    for result_i = 1:size(path_to_result_files,1)
        %get current result
        current_result = Extract_Object_From_Structure(path_to_result_files(result_i));
        %extract name from path file
        current_name = extractAfter(path_to_result_files(result_i),result_map);
        current_name = extractBetween(current_name,"\",".mat");
        %put name and result in corresponding array
        participant_names(result_i,1) = cellstr(current_name);
        result_table(result_i,:) = Convert_Undirected_FC_Matrix_To_Line(current_result);
    end
    %built final table
    result_table = num2cell(result_table); %double array to cell array
    statistical_table = [participant_names, result_table]; %combine both cell arrays
    statistical_table = cell2table(statistical_table); %convert cell array to table
    statistical_table.Properties.VariableNames = column_names; %add names to the table          
end

end