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

%%%
% PREPARATION OF MATLAB
%%%

clc; %clear command window
clear all; %clear workspace

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
        location_data_from = "D:\UGent\Burgie\Jaar 4\Thesis\Datasets\Dataset1\EEG Data (Source)\"; %full path to the directory where the data is located.
        location_data_to = "D:\UGent\Burgie\Jaar 4\Thesis\Source Results\Dataset1\"; %full path to the directory where the new data needs to be stored. 
        location_data_information = "D:\UGent\Burgie\Jaar 4\Thesis\Source Results\Dataset1\"; %full path to the directory where the dataset information needs to be stored
        location_data_statistics = "D:\UGent\Burgie\Jaar 4\Thesis\Source Results\Dataset1\"; %full path to the directory where the statistical .csv file needs to be stored.
       
    %%%
    % MAP NAME VARIABLES
    %%%
    
        %give the name of the map you want the results to be stored in
        % example: pow_results_map_name = 'POWER - DLPFC - Alpha';
        pow_results_map_name = 'test';
        fc_results_map_name = '';
        dynfc_resuls_map_name = '';
        dyncausal_results_map_name = '';
        graph_results_map_name = '';
        microstates_clusters_map_name = 'Microstates_4';
        microstates_clusters_file_name = "microstates";
        microstates_results_map_name = 'Statistics_4';
        
        
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


        region_aal_information = "D:\UGent\Burgie\Jaar 4\Thesis\GitHub\PhD_EEG_Pipeline\Extern\aal.mat";
        head_3D_information = "D:\UGent\Burgie\Jaar 4\Thesis\GitHub\PhD_EEG_Pipeline\Extern\inflated.mat";
        brainregion_amount = 1;
        brainregion_indices = {-1};
        brainregion_names = ["Whole_Brain"];
        brainregions_table = Check_Brainregions();

            %%%
    % EPOCH INFORMATION
    %%%
        
        %define the length of the epochs for which you want the calculations to be done (in seconds)
        % example: epoch_length = 3;
        % example: epoch_length = 6.197265625;
        epoch_length = 3; 

    %%%
    % EEG INFORMATION
    %%%
        
        %define the sampling frequency (in Hz)
        % example: sample_frequency = 512; 
        sample_frequency = 512;

    %%%
    % PARTICIPANT INFORMATION
    %%%

        patient_information = "D:\UGent\Burgie\Jaar 4\Thesis\Datasets\Dataset1\Trait_Questionnaires.xlsx";
        

    %%%
    % ANALYSIS INFORMATION
    %%%
        
        %POWER ANALYSIS
        % name of the analysis choice you want
        % possibilities:
        %   "average_relative_power_all" -> get average relative power from the delta, theta, alpha and beta frequency range  
        %   "average_relative_power_specific" -> get average relative power from specific frequency range
        %   "average_absolute_power_specific" -> get average absolute power from specific frequency range
        %   "average_log_absolute_power_specific" -> get log transformed version of average absolute power from specific frequency range
        %   "average_relative_power_specific_fcorrected" -> get relative power for specific frequency range, with 1/f correction
        
        analysis_choice_power = "";  
        
        % variable amount of arguments which should be given given the analysis choice
        % for "average_relative_power_all": {bin_width, delta_frequency_range, theta_frequency_range, alpha_frequency_range, beta_frequency_range}
        %   pow_varargin = {0.5, [0.5 4], [4 8], [8 13], [13 30]};
        % for "average_relative_power_specific": {bin_width, frequency_range_of_interest, whole_frequency_range}
        %   pow_varargin = {0.5, [8 13], [0.5 40]};
        % for "average_absolute_power_specific": {bin_width, frequency_range_of_interest, whole_frequency_range}
        %   pow_varargin = {0.5, [8 13], [0.5 40]};
        % for "average_log_absolute_power_specific": {bin_width, frequency_range_of_interest, whole_frequency_range}
        %   pow_varargin = {0.5, [8 13], [1 40]};
        % for "average_relative_power_specific_fcorrected": {bin_width, frequency_range_of_interest, whole_frequency_range, gamma}
        %   pow_varargin = {0.5, [8 13], [1 40], 1};

        pow_varargin = {};
        
        %FUNCTIONAL CONNECTIVITY ANALYSIS
        % name of the analysis choice you want
        % possibilities:
        %   "amplitude_envelope_correlation": Amplitude Envelope Correlation, adapted version from Hipp et al. (2012) (https://doi.org/10.1038/nn.3101)
        
        analysis_choice_fc = "";
        
        % variable amount of arguments which should be given given the analysis choice
        % for "amplitude_envelope_correlation": {freq_range}
        %   fc_varargin = {[13 20]}
        
        fc_varargin = {};
        
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

                %MICROSTATES CLUSTERING ANALYSIS

        analysis_choice_microstates_clustering = "";
        gr_optimal_k = "";

        %MICROSTATES ANALYSIS

        analysis_choice_microstates = "";
        clustering_algorithm = "modified k-means";
        data_type = "source";

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
        %MICROSTATES CLUSTERING
        run_clustering_microstates = 1;
        %MICROSTATES ANALYSIS
        run_analysis_microstates = 0;
        

        
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
        for participant_i = 1:1:1%dataset_size
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

            current_participant_aal_timeseries = Convert_To_AAL(current_participant_region_timeseries);
            disp(size(current_participant_region_timeseries))
            disp(size(current_participant_aal_timeseries))
            %run the power analysis
            %current_participant_values = TF_Calculate_Power(current_participant_region_timeseries,...
            %                                                                            sample_frequency,...
            %                                                                            epoch_length,...
            %                                                                           analysis_choice_power,...
            %                                                                            pow_varargin);
            
            %save the individual results in the previously defined map
            %Save_Results_To_Directory(current_participant_values,current_participant_name,Power_Results_map);
        end
        
    %%%
    % SUBSTEP 3: BUILD STATISTICAL ANALYSIS FILE
    %%%
        %build a table with all obtained results and save it as a .csv file
        %group_power_results = Generate_Paths_All_Together(strcat(location_data_to,"\",pow_results_map_name));
        %statistical_table = Build_Statistical_Table(group_power_results,...
        %                                            pow_results_map_name,...
        %                                            analysis_choice_power,...
        %                                            brainregion_amount,...
        %                                            brainregion_names);
        %go to destined location
        %cd(location_data_statistics);
        %save table as .csv file in the destined folder
        %writetable(statistical_table, strcat(pow_results_map_name,".csv"));
    
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
        %build a table with all obtained results and save it as a .csv file
        group_fc_results = Generate_Paths_All_Together(strcat(location_data_to,"\",fc_results_map_name));
        statistical_table = Build_Statistical_Table(group_fc_results,...
                                                    fc_results_map_name,...
                                                    analysis_choice_fc,...
                                                    brainregion_amount,...
                                                    brainregion_names);
        %go to destined location
        cd(location_data_statistics);
        %save table as .csv file in the destined folder
        writetable(statistical_table, strcat(fc_results_map_name,".csv"));
        
    
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 8: MICROSTATES CLUSTERING %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(run_clustering_microstates == 1)
    % SUBSTEP 1: CREATE A RESULTS MAP
    %%%
        [Microstates_Clusters_map] = Create_Directory(location_data_to,microstates_clusters_map_name);

    %%%
    % SUBSTEP 2: MAIN FOR LOOP
    %%%
        %first, write the loop for every participant (use parfor for parallel computing)
        all_participants_microstates = [];
        all_participants_gfp_peaks = [];
        all_participants_gfp_indices = [];
        length_peaks = [];
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

            %current_participant_region_timeseries = bandpass(current_participant_region_timeseries, beta_frequency_range, sample_frequency);
            [current_participant_gfp_peaks, current_participant_gfp_indices] = Extract_GFP_Peaks(current_participant_region_timeseries, sample_frequency, epoch_length, data_type);

            all_participants_gfp_peaks = [all_participants_gfp_peaks current_participant_gfp_peaks];

            length_peaks = [length_peaks length(current_participant_gfp_peaks)];
            all_participants_gfp_indices = [all_participants_gfp_indices diff(current_participant_gfp_indices)];

%             
        end
        microstates = Cluster_Microstates(all_participants_gfp_peaks, 10, "modified k-means", "source", {2, 300});
        disp(mean(length_peaks))
        disp(std(length_peaks))
        disp(mean(all_participants_gfp_indices));
        disp(std(all_participants_gfp_indices));

%         [~, strongest_regions_indices] = maxk(microstates,10,1);
%         for i = 1:size(microstates,2)
%             strongest_regions = current_participant_region_names{strongest_regions_indices(:,i),1};
%             disp(strongest_regions);
%         end
%         microstates_aal = Convert_To_AAL(microstates);
%         disp(size(microstates));
%         disp(size(microstates_aal));
%         for i = 1:size(microstates,2)
%             Plot_Source_Topography(microstates_aal(:,i), region_aal_information, head_3D_information);
%         end

        %save the results in the previously defined map
        Save_Results_To_Directory(microstates, microstates_clusters_file_name, Microstates_Clusters_map);
else
    disp('Microstates Clustering not selected...');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 9: MICROSTATES ANALYSIS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(run_analysis_microstates == 1)
    % SUBSTEP 1: CREATE A RESULTS MAP
    %%%
        [Microstates_Results_map] = Create_Directory(location_data_to,microstates_results_map_name);
    %%%    
    % SUBSTEP 2: OPEN MICROSTATES CLUSTERS
    %%%
        microstates_file = Read_File_Directory(location_data_to,microstates_clusters_map_name,microstates_clusters_file_name);
        microstates = Open_Mat_File(microstates_file);
        microstates_amount = size(microstates,2);
        
%         [~, strongest_regions_indices] = maxk(microstates,10,1);
%         for i = 1:size(microstates,2)
%             strongest_regions = brainregions_table{strongest_regions_indices(:,i),1};
%             disp(strongest_regions);
%         end
%         microstates_aal = Convert_To_AAL(microstates);
% 
%         for i = 1:size(microstates,2)
%             Plot_Source_Topography(microstates_aal(:,i), region_aal_information, head_3D_information);
%         end

    %%%
    % SUBSTEP 3: READ PATIENT INFORMATION
    %%%
        [information, participant_ids] = Extract_Rumination_Scores(patient_information);

    %%%
    % SUBSTEP 4: MAIN FOR LOOP
    %%%
        %first, write the loop for every participant (use parfor for parallel computing)

        for participant_i = 1:1:dataset_size
            %get the name of the current participant
            current_participant_name = dataset_names(participant_i); 
            %Tell what is going on (which participant is worked on)
            disp(current_participant_name);
            %Load participant information (rumination score)
            [current_participant_information] = Extract_Participant_Rumination_Scores(information, participant_ids, current_participant_name);
            %load the timeseries of the current participant
            current_participant_datafile = Extract_Timeseries_From_Structure(dataset_files(participant_i));
            %build the complete argument list to be able to extract the specific timeseries
            current_participant_table = Build_Brainregion_Celltable(current_participant_datafile,...
                                                                    brainregion_amount,...
                                                                    brainregion_indices,...
                                                                    brainregion_names);
            %define the regions which need to be used
            [current_participant_region_timeseries, current_participant_region_names] = Extract_Time_Series_And_Names(current_participant_table);

            %Plotting(current_participant_region_timeseries, microstates, sample_frequency,epoch_length, electrode_locations);
            

            [current_participant_microstate_labels, current_participant_values] = ...
                Microstates_Statistics_Participant(current_participant_region_timeseries, microstates, "source", sample_frequency, epoch_length, 8);

            current_participant_values = [current_participant_information current_participant_values];
            %save the results in the previously defined map
            Save_Results_To_Directory(current_participant_values, current_participant_name, Microstates_Results_map);

        end


    %%%
    % SUBSTEP 5: BUILD STATISTICAL ANALYSIS FILE
    %%%
        %build a table with all obtained results and save it as a .csv file
        group_microstates_results = Generate_Paths_All_Together(strcat(location_data_to,"\",microstates_results_map_name));
        statistical_table = Build_Statistical_Table(group_microstates_results,...
                                                    microstates_results_map_name,...
                                                    "microstates",...
                                                    brainregion_amount,...
                                                    brainregion_names,...
                                                    microstates_amount);
        %go to destined location
        cd(location_data_statistics);
        %save table as .csv file in the destined folder
        writetable(statistical_table, strcat(microstates_results_map_name,".csv"));

else
    disp('Microstates Analysis not selected...');
end

%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 10: NOTIFICATION %
%%%%%%%%%%%%%%%%%%%%%%%%

    %play a sound when the program is finished
    load handel
    %sound(y,Fs)
