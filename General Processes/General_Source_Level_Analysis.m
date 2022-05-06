%%%
%
% General Script that is used to perform Source Level Analyses.
% This is the script in which all variables are defined that will be needed for the further analysis. 
% Only this file should be used for source level analysis. All other functions are wrapped in this script.
%
% NOTE: only one analysis can be done at a time. This is done so each analysis has its own unique analysis file for publication on osf.
% NOTE: Step 8 contains an auditory cue to let you know if a participant has finished, you can delete this.
%
% Gert Vanhollebeke (02/12/2021 - )
%
%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 0: WRITE IN SHORT WHAT YOU ARE GOING TO DO BELOW %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% WRITE HERE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 1: ADJUST VARIABLES HERE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is the part where you adjust the variables to your specific preferences. 
% Check each variable and check if it is correct or not.

    %%%
    % DATA LOCATION VARIABLES
    %%% 

        % don't put a backslash at the end of the path
        % example: 'F:\Study - EEGSTRESS\Dataset\EEG Source Data (130 Regios)'
        location_data_from = ''; %full path to the directory where the data is located.
        location_data_to = ''; %full path to the directory where the new data needs to be stored. 
        location_data_information = ''; %full path to the directory where the dataset information needs to be stored
        location_data_statistics = ''; %full path to the directory where the statistical .csv file needs to be stored.

    %%%
    % MAP NAME VARIABLES
    %%%
    
        %give the name of the map you want the results to be stored in
        % example: pow_results_map_name = 'POWER - DLPFC - Alpha';
        pow_results_map_name = '';
        fc_results_map_name = '';
        dynfc_resuls_map_name = '';
        dyncausal_results_map_name = '';
        graph_results_map_name = '';
        
    %%%
    % FREQUENCY RANGES
    %%%
    
        % give frequency ranges for the known frequency bands in which you are interested
        % example: delta_frequency_range = [0.5 4];
        
        delta_frequency_range = []; % frequency range for the delta frequency band (Hz)
        theta_frequency_range = []; % frequency range for the theta frequency band (Hz)
        alpha_frequency_range = []; % frequency range for the alpha frequency band (Hz)
        beta_frequency_range = []; % frequency range for the beta frequency band (Hz)

    %%%
    % BRAIN REGIONS
    %%%
    
        % selection of the brain regions for which the analysis should be conducted
        % For more information on which brain regions are available and which indices these have, use the function "Check_Brainregions"
        % You can write "Check_Brainregions" in the command window to see all regions
        % This way of working is not efficient, but is done to make sure that the correct brain regions are selected, 
        % so a name (not mandatory) AND a brainregion index should be given.
        %
        % If the analysis needs to be run for specific brain regions, use the following example:
        %   brainregion_amount = 4;
        %   brainregion_indices = {1, ...
        %                          2, ...
        %                          [5 13 18],...
        %                          16};
        %   brainregion_names = ["",...
        %                        "Region_name_I_want",...
        %                        "Always_give_names_when_you_want_to_combine_multiple_regions",...
        %                        "",...];
        %
        % If the analysis needs to be run for the whole brain, use the following as code:
        %   brainregion_amount = 1; %ALWAYS 1!!!
        %   brainregion_indices = {-1};
        %   brainregion_names = ["Whole_Brain"]; %always use underscores when combining multiple words!

        brainregion_amount = 1;
        brainregion_indices = {};
        brainregion_names = [];
        
    %%%
    % EPOCH INFORMATION
    %%%
        
        %define the length of the epochs for which you want the calculations to be done (in seconds)
        % example: epoch_length = 3;
        epoch_length = 3; 

    %%%
    % EEG INFORMATION
    %%%
        
        %define the sampling frequency (in Hz)
        % example: sample_frequency = 512; 
        sample_frequency = 512;

    %%%
    % ANALYSIS INFORMATION
    %%%
        
        %POWER ANALYSIS
        % name of the analysis choice you want
        % possibilities:
        %   "average_relative_power_all" -> get average relative power from the delta, theta, alpha and beta frequency range  
        %   "average_relative_power_specific" -> get average relative power from specific frequency range
        
        analysis_choice_power = "";  
        
        % variable amount of arguments which should be given given the analysis choice
        % for "average_relative_power_all": {bin_width, delta_frequency_range, theta_frequency_range, alpha_frequency_range, beta_frequency_range}
        %   pow_varargin = {0.5, [0.5 4], [4 8], [8 13], [13 30]};
        % for "average_relative_power_specific": {bin_width, frequency_range_of_interest, whole_frequency_range}
        %   pow_varargin = {0.5, [8 13], [0.5 40]};

        pow_varargin = {};
        
        %FUNCTIONAL CONNECTIVITY ANALYSIS
        % name of the analysis choice you want
        % possibilities:
        %   
        
        analysis_choice_fc = "";
        
        fc_varargin = [];
        
        %DYNAMIC FUNCTIONAL CONNECTIVITY ANALYSIS
        
        analysis_choice_dynfc = "";
        
        %DYNAMIC CAUSAL MODELING ANALYSIS
        
        analysis_choice_dyncausal = "";
        
        %GRAPH ANALYSIS ANALYSIS
        % name of the anaysis choice you make
        % possibilities: 
        %   TODO HERE
        
        analysis_choice_graph = "";
        
        gr_bin_or_weight = ""; %"binary" or "weighted"
        
        gr_threshold = [];
        
        gr_undir_or_dir = ""; %"directed" or "undirected"
        
        % variable amount of arguments which should be given given the analysis choice
        % TODO HERE
        
        graph_varargin = {0};
        
    %%%
    % SELECT WHICH ANALYSIS NEED TO BE RUN
    %%%
    
    %if you want the specific analysis, set the variable to 1, if not, set to 0.
    
        %POWER ANALYSIS
        run_analysis_power = 0;
        %FUNCTIONAL CONNECTIVITY ANALYSIS
        run_analysis_fc = 0;
        %DYNAMIC FUNCTIONAL CONNECTIVITY ANALYSIS
        run_analysis_dynfc = 0;
        %DYNAMIC CAUSAL MODELING ANALYSIS
        run_analysis_dyncausal = 0;
        %GRAPH ANALYSIS ANALYSIS
        run_analysis_graph = 0;
        
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

if(run_analysis_power == 1)
    %%%
    % SUBSTEP 1: CREATE A RESULTS MAP
    %%%
        [Power_Results_map] = Create_Directory(location_data_to,pow_results_map_name);
    %%%
    % SUBSTEP 2: MAIN FOR LOOP
    %%%
        %first, write the loop for every participant (use parfor for parallel computing)
        for participant_i = 1:1:dataset_size
            %get the name of the current participant
            current_participant_name = dataset_names(participant_i); 
            %Tell what is going on (which participant is worked on)
            disp(current_participant_name);
            %load the timeseries of the current participant
            current_participant_datafile = Extract_Timeseries_From_Structure(dataset_files(participant_i));                    
            %build the complete argument list to be able to extract the specific timeseries
            current_participant_table = Build_Brainregion_Celltable(current_participant_datafile,...
                                                                    brainregion_amount,...
                                                                    brainregion_indices,...
                                                                    brainregion_names);
            %extract only the specific timeseries on which the calculations need to be performed on
            [current_participant_region_timeseries, current_participant_region_names] = Extract_Time_Series_And_Names(current_participant_table);
            %run the power analysis
            current_participant_values = TF_Calculate_Power(current_participant_region_timeseries,...
                                                                                        sample_frequency,...
                                                                                        epoch_length,...
                                                                                        analysis_choice_power,...
                                                                                        pow_varargin);
            
            %save the individual results in the previously defined map
            Save_Results_To_Directory(current_participant_values,current_participant_name,Power_Results_map);
        end
        
    %%%
    % SUBSTEP 3: BUILD STATISTICAL ANALYSIS FILE
    %%%
        %build a table with all obtained results and save it as a .csv file
        group_power_results = Generate_Paths_All_Together(strcat(location_data_to,"\",pow_results_map_name));
        statistical_table = Build_Statistical_Table(group_power_results,...
                                                    pow_results_map_name,...
                                                    analysis_choice_power,...
                                                    brainregion_amount,...
                                                    brainregion_names);
        %go to destined location
        cd(location_data_statistics);
        %save table as .csv file in the destined folder
        writetable(statistical_table, strcat(pow_results_map_name,".csv"));
    
else
    disp('Power Analysis not selected...');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 4: FUNCTIONAL CONNECTIVITY CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(run_analysis_fc == 1)
    %%%
    % SUBSTEP 1: CREATE A RESULTS MAP
    %%%
        [FC_Results_map] = Create_Directory(location_data_to,fc_results_map_name);
    %%%
    % SUBSTEP 2: MAIN FOR LOOP
    %%%
        %first, write the loop for every participant (use parfor for parallel computing)
        for participant_i = 1:1:dataset_size
            %get the name of the current participant
            current_participant_name = dataset_names(participant_i); 
            %Tell what is going on (which participant is worked on)
            disp(current_participant_name);
            %load the timeseries of the current participant
            current_participant_datafile = Extract_Timeseries_From_Structure(dataset_files(participant_i));
            %build the complete argument list to be able to extract the specific timeseries
            current_participant_table = Build_Brainregion_Celltable(current_participant_datafile,...
                                                                    brainregion_amount,...
                                                                    brainregion_indices,...
                                                                    brainregion_names);
            %define the regions which need to be used
            [current_participant_region_timeseries, current_participant_region_names] = Extract_Time_Series_And_Names(current_participant_table);
            %run the functional connectivity analysis
            current_participant_values = TF_Calculate_Functional_Connectivity(current_participant_region_timeseries,...
                                                                                        sample_frequency,...
                                                                                        epoch_length,...
                                                                                        analysis_choice_fc,...
                                                                                        fc_varargin);
            
            %save the results in the previously defined map
            Save_Results_To_Directory(current_participant_values,current_participant_name,FC_Results_map);
        end
        
    %%%
    % SUBSTEP 3: BUILD STATISTICAL ANALYSIS FILE
    %%%
%         %build a table with all obtained results and save it as a .csv file
%         group_fc_results = Generate_Paths_All_Together(strcat(location_data_to,"\",fc_results_map_name));
%         statistical_table = Build_Statistical_Table(group_fc_results,...
%                                                     fc_results_map_name,...
%                                                     analysis_choice_fc,...
%                                                     brainregion_amount,...
%                                                     brainregion_names);
%         %go to destined location
%         cd(location_data_statistics);
%         %save table as .csv file in the destined folder
%         writetable(statistical_table, strcat(pow_results_map_name,".csv"));
%         
    %%%
    % SUBSTEP 3: SAVE ADDITIONAL INFORMATION
    %%%       
        %Save the region names and indices to be able to reproduce the results.
        region_indices = {region_1; region_2; region_3; region_4; region_5; region_6};
        region_names = current_participant_region_names;
        Analysis_Region_Information = table(region_indices,region_names);
        Save_Results_To_Directory(Analysis_Region_Information, 'Analysis_Region_Information',location_data_information);

else
    disp('Functional Connectivity Analysis not selected...');
end
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 5: DYNAMIC FUNCTIONAL CONNECTIVITY CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(run_analysis_dyncausal == 1)
    % As of yet not implemented.
else
    disp('Dynamic Functional Connectivity Analysis not selected...');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 6: DYNAMIC CAUSAL MODELING CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(run_analysis_dynfc == 1)
    % As of yet not implemented.
else
    disp('Dynamic Causal Modeling Analysis not selected...');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 7: GRAPH ANALYSIS CALCULATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(run_analysis_graph == 1)
    %%%
    % SUBSTEP 1: CREATE A RESULTS MAP
    %%%
        [Graph_Results_map] = Create_Directory(location_data_to,graph_results_map_name);
    %%%
    % SUBSTEP 2: MAIN FOR LOOP
    %%%
        %first, write the loop for every participant (use parfor for parallel computing)
        for participant_i = 1:1:dataset_size 
            %get the name of the current participant
            current_participant_name = dataset_names(participant_i); 
            %Tell what is going on (which participant is worked on)
            disp(current_participant_name);
            %load the timeseries of the current participant
            current_participant_datafile = Extract_Object_From_Structure(dataset_files(participant_i));           
            %run the graph analysis
            current_participant_values = TF_calculate_graph(current_participant_datafile,...
                                                            gr_bin_or_weight,...
                                                            gr_threshold,...
                                                            gr_undir_or_dir,...
                                                            analysis_choice_graph,...
                                                            graph_varargin);
            %save the results in the previously defined map
            Save_Results_To_Directory(current_participant_values,current_participant_name,Graph_Results_map);
        end
        
    %%%
    % SUBSTEP 3: SAVE ADDITIONAL INFORMATION
    %%%       
        
else
    disp('Graph Analysis not selected...');
end

%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 8: NOTIFICATION %
%%%%%%%%%%%%%%%%%%%%%%%%

    %play a sound when the program is finished
    load handel
    sound(y,Fs)