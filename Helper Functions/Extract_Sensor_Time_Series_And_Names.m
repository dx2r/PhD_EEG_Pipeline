function [selected_timeseries, selected_names] = Extract_Sensor_Time_Series_And_Names(varargin)

%%%
%
% Function which extracts the necessary timeseries out of the whole data. Returns those timeseries and their names.
% If a region is defined by multiple electrodes, the function aggragates the timeseries into a single one by taking the first principal component of the timeseries.
%
% Gert Vanhollebeke (28/07/2022 - 28/07/2022)
%
% INPUT:
%   varargin: a varying amount of inputs, but with a certain structure:
%       varargin{1}: N x M matrix (N = #timeseries; M = #timepoints) containing the timeseries.
%       varargin{2,3,4,5,...}: string or array of strings indicating the name(s) of the electrodes from which the timeseries needs to be extracted/aggragated
%
% OUTPUT:
%   selected_timeseries: K x M matrix containing the selected timeseries (K = #electrodes)
%   selected_names: K x 1 character array containing the names of the selected electrodes (K = #electrodes)
%
%%%

%Step 0: Tell what is going on
disp("Extracting Necessary Timeseries...");
%Step 1: check how many regions have been selected
layout_link = varargin(2); %extract the link to the layout file
layout_link = layout_link{:};
%extract dataset
dataset = varargin{1}{1};
varargin = varargin{1}; %remove one layer of cell arrays
electrode_amount = (size(varargin,2) - 1); %-1 because the first argument is the data itself
if(electrode_amount < 1) %throw error if no regions are given
   error("You have not defined any electrodes. Please define the electrodes for which the analysis should be run."); 
end
%Step 2: get the size of the dataset
[timeseries_amount,timepoints_amount] = size(varargin{1});
%Step 3: build the selected dataframe
if(varargin{2} == "All_Electrodes") %check if whole-brain analysis is needed
    disp("All electrode analysis has been selected...");
    selected_timeseries = varargin{1}; %give back the whole dataset
    temp_var = Check_Electrode_Layout(layout_link); 
    selected_names = temp_var(:,1); %give back all region names  
else % only certain regions are selected
    selected_timeseries = zeros(electrode_amount, timepoints_amount); %emtpy structure for the timeseries
    selected_names = "Electrode"; %give random name to make variable
    electrode_list = Check_Electrode_Layout(layout_link);
    electrode_list = electrode_list(:,1);  
    for timeseries_i = 1:electrode_amount
        if(size(varargin{timeseries_i,2},2) ~= 1) %the current region is built from multiple regions in the atlas
            %find all indices of the electrode of the current combined region
            electrode_indices = zeros(1,size(varargin{timeseries_i,2},2));
            %build empty string array for combined name
            current_electrode_combination_name = "";
            for electrode_i = 1:size(varargin{timeseries_i,2},2)
                current_index = Find_Index_Of_Electrode(varargin{timeseries_i,2}(electrode_i),electrode_list);
                electrode_indices(1,electrode_i) = current_index;
                current_name = varargin{timeseries_i,2}(electrode_i);
                current_electrode_combination_name = strcat(current_electrode_combination_name,"_",current_name);
            end
            selected_timeseries(timeseries_i,:) = PCA(dataset(electrode_indices,:),1);
            selected_names(timeseries_i) = current_electrode_combination_name;
        else
            disp("we got somewhere else");
        end
    end
   
    %%%
    %TODO: FIND OUT ERROR IN THE IF LOOP (index exceeds array bounds)
    %%%
    
%     for timeseries_i = 1:electrode_amount
%         if(size(varargin{2*timeseries_i},2) ~= 1) %the current region is built from multiple regions in the atlas
%             selected_timeseries(timeseries_i,:) = PCA(varargin{1}(varargin{2*timeseries_i},:),1); %First PCA of the selected timeseries
%             selected_names(timeseries_i) = varargin{2*timeseries_i + 1}; %name that has been given as the argument
%         else
%             selected_timeseries(timeseries_i,:) = varargin{1}(varargin{2*timeseries_i},:); %selected timeseries
%             if(varargin{2*timeseries_i + 1} == "") %check if no name is given
%                 selected_names(timeseries_i) = {table2cell(brainregion_list(varargin{2*timeseries_i},1))}; %long chain of indexing to obtain the string value itself, not a table element.
%             else
%                 selected_names(timeseries_i) = varargin{2*timeseries_i + 1}; %name that has been given as the argument
%             end
%         end
%     end
%     selected_names = selected_names.'; %transpose for easier use
end