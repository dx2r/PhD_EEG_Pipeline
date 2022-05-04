%%%
%
% General Script that is used to perform Source Level Analyses.
% This is the script in which all variables are defined that will be needed for the further analysis.
% To use this script correctly, go through all steps and (un)comment each part you do or don't need.
%
% Gert Vanhollebeke (02/12/2021 - )
%
%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 0: WRITE IN SHORT WHAT YOU ARE GOING TO DO BELOW %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Functional connectivity analysis: AEC in the beta range for the project EEGRUM.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 1: ADJUST VARIABLES HERE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is the part where you adjust the variables to your specific preferences. 
% Check each variable and check if it is correct or not.

    %%%
    % LOCATION VARIABLES
    %%% 

        % don't put a backslash at the end of the path
        location_data_from = 'F:\Study - EEGSTRESS\Dataset\EEG Source Data (130 Regios)'; %full path to the directory where the data is located.
        location_data_to = 'F:\Study - EEGSTRESS\Results'; %full path to the directory where the new data needs to be stored. 
        results_map_name = 'Weighted Degree (AEC Alpha 8 - 13)'

    %%%
    % FREQUENCY RANGES
    %%%

        delta_frequency_range = [0.5 4]; % frequency range for the delta frequency band (Hz)
        theta_frequency_range = [4 8]; % frequency range for the theta frequency band (Hz)
        alpha_frequency_range = [8 13]; % frequency range for the alpha frequency band (Hz)
        beta_frequency_range = [14 30]; % frequency range for the beta frequency band (Hz)

    %%%
    % BRAIN REGIONS
    %%%

        region_1 = 9;
        region_1_name = "";
        region_2 = 10;
        region_2_name = "";
        region_3 = 13;
        region_3_name = "";
        region_4 = 14;
        region_4_name = "";
        region_5 = [37 73 75 77 79 81 83];
        region_5_name = "inferior frontal gyrus L";
        region_6 = [38 74 76 78 80 82 84];
        region_6_name = "inferior frontal gyrus R"; 

    %%%
    % EPOCH INFORMATION
    %%%

        epoch_length = 3; %length of the epochs (defined in the preprocessing) in seconds

    %%%
    % EEG INFORMATION
    %%%

        sample_frequency = 512; %sample frequency of the EEG signal

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 2: LOAD IN DATASET %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %load the paths and names of the dataset
    [dataset_files, dataset_names] = Generate_Paths_All_Together(location_data_from);
    %get the size of the current dataset
    dataset_size = size(dataset_names,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 3: POWER CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 4: FUNCTIONAL CONNECTIVITY CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%if you want to run functional connectivity analyses, use the code below to build your personal pipeline.

    %%%
    % SUBSTEP 1: CREATE A RESULTS MAP
    %%%
        
        [AEC_Results_map] = Create_Directory(location_data_to,'AEC Results (beta 14 - 30)');

    %%%
    % SUBSTEP 2: MAIN FOR LOOP
    %%%
    
        %first, write the loop for every participant (use parfor for parallel computing)
        for participant_i = 1:dataset_size 
            %get the name of the current participant
            current_participant_name = dataset_names(participant_i); 
            %Tell what is going on
            disp(current_participant_name);
            %load the timeseries of the current participant
            current_participant_datafile = Extract_Timeseries_From_Structure(dataset_files(participant_i));
            %define the regions which need to be used
            [current_participant_region_timeseries, current_participant_region_names] = Extract_Time_Series_And_Names(current_participant_datafile,...
                                                                                                                      region_1, region_1_name,...
                                                                                                                      region_2, region_2_name,...
                                                                                                                      region_3, region_3_name,...
                                                                                                                      region_4, region_4_name,...
                                                                                                                      region_5, region_5_name,...
                                                                                                                      region_6, region_6_name);
            %run the functional connectivity analysis
            current_participant_beta_AEC_values = TF_calculate_functional_connectivity(current_participant_region_timeseries,...
                                                                                        sample_frequency,...
                                                                                        epoch_length,...
                                                                                        'AEC',...
                                                                                        beta_frequency_range);
            %save the results in the previously defined map
            Save_Results_To_Directory(current_participant_beta_AEC_values,current_participant_name,AEC_Results_map);
        end
        
    %%%
    % SUBSTEP 3: SAVE ADDITIONAL INFORMATION
    %%%
        
        %Save the region names and indices to be able to reproduce the results.
        region_indices = {region_1; region_2; region_3; region_4; region_5; region_6};
        region_names = current_participant_region_names;
        Analysis_Region_Information = table(region_indices,region_names);
        Save_Results_To_Directory(Analysis_Region_Information, 'Analysis_Region_Information',AEC_Results_map);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 5: DYNAMIC FUNCTIONAL CONNECTIVITY CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% As of yet not implemented.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 6: DYNAMIC CAUSAL MODELING CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% As of yet not implemented.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 7: GRAPH ANALYSIS CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% As of yet not implemented.

%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 8: NOTIFICATION %
%%%%%%%%%%%%%%%%%%%%%%%%

    %play a sound when the program is finished
    load handel
    sound(y,Fs)